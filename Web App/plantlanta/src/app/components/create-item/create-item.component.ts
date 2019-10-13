import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
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
    itemImage: new FormControl(''),
    itemName: new FormControl(''),
    eventDescription: new FormControl(''),
    itemPrice: new FormControl(0),
    itemQuantity: new FormControl(0)
  });

  constructor(private storage: AngularFireStorage, private cloud: AngularFireFunctions, private route: ActivatedRoute, private firestore: AngularFirestore, private router: Router) {}

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
          itemImage: item.message.image,
          itemName: item.message.name,
          itemDescription: item.message.description,
          itemPrice: item.message.price,
          itemQuantity: item.message.quantity
        });
        this.loading = false;
      });
    } else {
      this.createItemFunction = this.cloud.httpsCallable("createItem");
    }
  }

  // onFileChange(item) {
  //   if(item.target.files && item.target.files.length && event.target.files[0].type == "application/pdf") {
  //     this.file = event.target.files[0];
  //   } else {
  //     event.srcElement.value = null;
  //     this.validForm = false;
  //     this.errMessage = "Only PDF files are allowed."
  //   }
  // }

  async registerItem() {
    this.message = "Creating item..."
    this.loading = true;
    if (this.itemForm.valid) {
      let formValues = this.itemForm.value;
      try {
        let resp = await this.createItemFunction({
          image: formValues["itemImage"],
          name: formValues["itemName"],
          description: formValues["itemDescription"],
          price: formValues["itemPrice"],
          quantity: formValues["itemQuantity"]
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
      this.validForm = false;
      this.message = "All fields are required to create an item. Please fill them out.";
    }
  }

  closeEventCreatedModal() {
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

  deleteEvent() {
    this.confirmDeleteModal = false;
    this.message = "Deleting item...";
    this.loading = true;  
    this.firestore.collection("Items").doc(this.itemId).delete().then(() => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "Item successfully deleted. You will be redirected to the marketplace.";
      setTimeout(() => {
        this.router.navigate(["/event_dashboard"])
      }, 2000);
    }).catch(() => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "There was an error deleting this item. Please try again."
    });
  }

  editEvent() {
    this.message = "Updating item information...";
    this.loading = true;
    let formValues = this.itemForm.value;
    this.editItemFunction({
      eventId: this.itemId,
      image: formValues["itemImage"],
      name: formValues["itemName"],
      description: formValues["itemDescription"],
      price: formValues["itemPrice"],
      quantity: formValues["itemQuantity"]
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
