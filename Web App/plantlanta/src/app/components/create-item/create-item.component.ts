import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, FormControlName } from '../../../../node_modules/@angular/forms';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { ActivatedRoute, Router } from '../../../../node_modules/@angular/router';
import { AngularFireStorage } from '../../../../node_modules/@angular/fire/storage';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';
import { HttpClient } from '../../../../node_modules/@angular/common/http';

@Component({
  selector: 'app-create-item',
  templateUrl: './create-item.component.html',
  styleUrls: ['./create-item.component.sass']
})
export class CreateItemComponent implements OnInit {

  item;

  validForm = true;
  message = "";
  itemCreated = false;

  createItemFunction;
  getItemFunction;
  deleteItemFunction;
  editItemFunction;

  itemId = "";
  isEdit = false;
  loading = false;

  submitting = false;
  requestSent = false;
  errMessage = '';

  confirmDeleteModal = false;
  successDeleteModal = false;
  successDeleteModalMessage = "";
  editModal = false;
  editModalMessage = "";

  file: File;

  itemForm = new FormGroup({
    itemName: new FormControl(''),
    itemBrand: new FormControl(''),
    itemDescription: new FormControl(''),
    itemPrice: new FormControl(0),
    itemQuantity: new FormControl(0),
    itemImage: new FormControl(''),
    itemCodes: new FormControl('')
  });

  constructor(private storage: AngularFireStorage, private cloud: AngularFireFunctions, private route: ActivatedRoute,
     private firestore: AngularFirestore, private router: Router, private http: HttpClient) {}

  ngOnInit() {
    this.itemId = this.route.snapshot.paramMap.get("itemId");
    if (this.itemId != null) {
      this.deleteItemFunction = this.cloud.httpsCallable("deleteItem");
      this.editItemFunction = this.cloud.httpsCallable("editItem");
      this.message = "Loading item..."
      this.loading = true;
      this.isEdit = true;
      this.getItemFunction = this.cloud.httpsCallable("getItem");
      this.getItemFunction({EventID: this.itemId}).toPromise().then(item => {
        this.item = item.message;
        let finalCodes = "";
        for (let i = 0;i < item.message.codes.length-1;i++) {
          finalCodes += item.message.codes[i] + "\n";
        }
        finalCodes += item.message.codes[item.message.codes.length-1];
        item.message.codes = finalCodes;
        this.itemForm.setValue({
          itemName: item.message.name,
          itemBrand: item.message.brand,
          itemDescription: item.message.description,
          itemPrice: item.message.price,
          itemQuantity: item.message.quantity,
          itemImage: item.message.image,
          itemCodes: item.message.codes
        });
        this.loading = false;
      });
    } else {
      this.createItemFunction = this.cloud.httpsCallable("createItem");
    }
  }

  onFileChange(item) {
    if(item.target.files && item.target.files.length && item.target.files[0].type == "image/png") {
      this.file = item.target.files[0];
    } else {
      this.validForm = false;
      this.errMessage = "Only PNG images are allowed."
    }
  }

  checkCodesQuantity() {
    let formValues = this.itemForm.value;
    if(formValues["itemQuantity"] == formValues["itemCodes"].split(/\r|\n/).length) {
      this.createItem()
    } else {}
      this.validForm = false;
      this.errMessage = "Item quantity must be the same to number of codes entered.";
    }

    checkEdit() {
      let formValues = this.itemForm.value;
      if(formValues["itemQuantity"] == formValues["itemCodes"].split(/\r|\n/).length) {
        this.editItem()
      } else {
        this.validForm = false;
        this.errMessage = "Item quantity must be the same to number of codes entered.";
      }
    }

  createItem() {
    this.message = "Creating item..."
    this.loading = true;
    if (this.itemForm.valid) {
      let formValues = this.itemForm.value;
      const path = "Item_Images/" + formValues["itemName"]
      let upload = this.storage.upload(path, this.file);
      this.submitting = true;
      let percentChange = upload.percentageChanges().subscribe(percent => this.message = "Uploading Item... " + Math.round(percent) + "%");
      upload.then(async snapshot => {
        percentChange.unsubscribe();
        try {
          let resp = await this.createItemFunction({
            name: formValues["itemName"],
            brand: formValues["itemBrand"],
            description: formValues["itemDescription"],
            price: formValues["itemPrice"],
            quantity: formValues["itemQuantity"],
            image: await snapshot.ref.getDownloadURL(),
            codes: formValues["itemCodes"].split(/\r|\n/)
          }).toPromise();
          if (!resp.status) {
            this.loading = false;
            this.validForm = false;
            this.message = resp.message;
          } else {
            this.loading = false;
            this.itemCreated = true;
            this.itemForm.reset();
          }
        } catch(e) {
          this.validForm = false;
          this.errMessage = e.error.message;
          this.submitting = false;
          this.storage.ref(path).delete();
        }
      }).catch(error => {
        this.validForm = false;
        this.errMessage = error.message,
        this.submitting = false;
      })
    } else if (this.itemForm.invalid) {
      this.loading = false;
      this.validForm = false;
      this.message = "All fields are required to create an item. Please fill them out.";
    }
  }

  closeItemCreatedModal() {
    this.itemCreated = false;
  }

  closeEditModal() {
    this.editModal = false;
  }

  closeSuccessDeleteModal() {
    this.successDeleteModal = false;
  }

  toggleConfirmDeleteModal() {
    this.confirmDeleteModal = !this.confirmDeleteModal;
  }

  editItem() {
    this.message = "Updating item information...";
    this.loading = true;
    let formValues = this.itemForm.value;
    const path = "Item_Images/" + formValues["itemName"];
    let updateInfo = {
        itemId: this.itemId,
        name: formValues["itemName"],
        brand: formValues["itemBrand"],
        description: formValues["itemDescription"],
        price: formValues["itemPrice"],
        quantity: formValues["itemQuantity"],
        image: "",
        codes: formValues["itemCodes"].split(/\r|\n/)
    }
    let input: any = document.getElementById("fileInput");
    if (input.files.length == 0) {
      updateInfo.image = this.item.image;
      this.callEditItem(updateInfo);
    } else {
      let upload = this.storage.upload(path, this.file);
      this.submitting = true;
      upload.then(async snapshot => {
        updateInfo.image = await snapshot.ref.getDownloadURL();
        this.callEditItem(updateInfo);
      })
    }
  }

  callEditItem(updateInfo) {
    this.editItemFunction(updateInfo).toPromise().then(resp => {
      if (resp.status) {
        this.editModal = true;
        this.loading = false;
        this.editModalMessage = "Item successfully updated."
      } else {
        this.editModal = true;
        this.loading = false;
        this.editModalMessage = resp.message;
      }
    }).catch(e => {
      this.editModal = true;
      this.loading = false;
      this.editModalMessage = "There was an error updating this item. Please try again."
    });
  }

  deleteItem() {
    let formValues = this.itemForm.value;
    this.confirmDeleteModal = false;
    this.message = "Deleting item...";
    this.loading = true;
    const path = "Item_Images/" + formValues["itemName"];
    this.firestore.collection("Items").doc(this.itemId).delete().then(() => {
      this.storage.ref(path).delete().toPromise().then(() => {
        this.successDeleteModal = true;
        this.loading = false;
        this.successDeleteModalMessage = "Item successfully deleted. You will be redirected to the marketplace.";
        setTimeout(() => {
          this.router.navigate(["/marketplace_dashboard"])
        }, 2000);
      });
    }).catch(() => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "There was an error deleting this item. Please try again."
    });
  }
}
