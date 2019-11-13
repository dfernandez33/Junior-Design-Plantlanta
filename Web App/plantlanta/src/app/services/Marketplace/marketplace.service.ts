import { Injectable } from '@angular/core';
import { AngularFirestore, DocumentChangeAction } from '../../../../node_modules/@angular/fire/firestore';
import { Observable } from '../../../../node_modules/rxjs';
import { MarketplaceItem } from '../../interfaces/marketplace-item';

@Injectable({
  providedIn: 'root'
})
export class MarketplaceService {

  constructor(private firestore: AngularFirestore) { }

  public getItems() {
    return this.firestore.collection("Items").get();
  }
}
