import { LightningElement, wire } from 'lwc';
import getRecentAccounts from '@salesforce/apex/AccountController.getRecentAccounts';

export default class RecentAccounts extends LightningElement {
    accounts;

    @wire(getRecentAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error loading accounts', error);
        }
    }
}