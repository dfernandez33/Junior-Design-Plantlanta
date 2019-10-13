import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { ActivatedRoute, Router } from '../../../../node_modules/@angular/router';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';


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

  confirmDeleteModal = false;

  successDeleteModal = false;
  successDeleteModalMessage = "";

  editModal = false;
  editModalMessage = "";

  itemForm = new FormGroup({
    itemImage: new FormControl(''),
    itemName: new FormControl(''),
    eventDescription: new FormControl(''),
    itemPrice: new FormControl(0),
    itemQuantity: new FormControl(0)
  });

  constructor(private cloud: AngularFireFunctions, private route: ActivatedRoute, private firestore: AngularFirestore, private router: Router) {}

  ngOnInit() {
    this.itemId = this.route.snapshot.paramMap.get("itemId");
    if (this.itemId != null) {
      this.deleteItemFunction = this.cloud.httpsCallable("deleteItem");
      this.editItemFunction = this.cloud.httpsCallable("editItem");

      this.message = "Loading item..."
      this.loading = true;
      this.isEdit = true;
      this.getItemFunction = this.cloud.httpsCallable("getEvent");
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
}
