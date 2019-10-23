import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { ActivatedRoute, Router } from '../../../../node_modules/@angular/router';
import { AngularFireStorage } from '../../../../node_modules/@angular/fire/storage';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';
import { HttpClient } from '../../../../node_modules/@angular/common/http';
import { first, tap, finalize } from '../../../../node_modules/rxjs/operators';


@Component({
  selector: 'app-create-item',
  templateUrl: './create-item.component.html',
  styleUrls: ['./create-item.component.sass']
})
export class CreateItemComponent implements OnInit {

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
    itemDescription: new FormControl(''),
    itemPrice: new FormControl(0),
    itemQuantity: new FormControl(0),
    itemImage: new FormControl(''),
    itemCode: new FormControl('')
  });

  constructor(private storage: AngularFireStorage, private cloud: AngularFireFunctions, private route: ActivatedRoute, private firestore: AngularFirestore, private router: Router, private http: HttpClient) {}

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
        this.itemForm.setValue({
          itemName: item.message.name,
          itemDescription: item.message.description,
          itemPrice: item.message.price,
          itemQuantity: item.message.quantity,
          itemImage: item.message.image,
          itemCode: item.message.code
        });
        this.loading = false;
      });
    } else {
      this.createItemFunction = this.cloud.httpsCallable("createItem");
    }
  }

  onFileChange(item) {
    console.log(item);
    if(item.target.files && item.target.files.length && item.target.files[0].type == "image/png") {
      this.file = item.target.files[0];
    } else {
      item.srcElement.value = null;
      this.validForm = false;
      this.errMessage = "Only PNG images are allowed."
    }
  }

  async registerItem() {
    this.message = "Creating item..."
    this.loading = true;
    if (this.itemForm.valid) {
      let formValues = this.itemForm.value;
      try {
        let resp = await this.createItemFunction({
          name: formValues["itemName"],
          description: formValues["itemDescription"],
          price: formValues["itemPrice"],
          quantity: formValues["itemQuantity"],
          image: formValues["itemImage"],
          code: formValues["itemCode"]
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
        this.loading = false;
        this.validForm = false;
        this.message = e.message;
      }
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

  deleteItem() {
    this.confirmDeleteModal = false;
    this.message = "Deleting item...";
    this.loading = true;  
    this.firestore.collection("Items").doc(this.itemId).delete().then(() => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "Item successfully deleted. You will be redirected to the marketplace.";
      setTimeout(() => {
        this.router.navigate(["/marketplace_dashboard"])
      }, 2000);
    }).catch(() => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "There was an error deleting this item. Please try again."
    });
  }

  editItem() {
    this.message = "Updating item information...";
    this.loading = true;
    let formValues = this.itemForm.value;
    this.editItemFunction({
      eventId: this.itemId,
      name: formValues["itemName"],
      description: formValues["itemDescription"],
      price: formValues["itemPrice"],
      quantity: formValues["itemQuantity"],
      image: formValues["itemImage"],
      code: formValues["itemCode"]
    }).toPromise().then(resp => {
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

}
