public class PopulateNumberofAccount {
    
    public static void processReq(){        
        List<Id> accountId = new List<Id>();
        List<Contact> contactList = [Select AccountId From Contact];
        for ( Contact iter : contactList ) { 
            accountId.add(iter.AccountId);
        }
        
        Map<Id, Integer> noofContactsMap = new Map<Id, Integer>();
        for ( String item : accountId){
            if (noofContactsMap.containsKey(item)) {                
                noofContactsMap.put(item, noofContactsMap.get(item) + 1);
            } else {                
                noofContactsMap.put(item, 1);
            }
        }
        
        Map<Id, Account> IdAccountMap = new Map<Id, Account>();
        String query = 'Select Id From Account where Id '+setToString(noofContactsMap.keySet());
        List<Account> AccountList = Database.query(query);
        for ( Account iter : AccountList ) { 
            IdAccountMap.put(iter.Id, iter);
        }
        
        List<Account> updatedAccounts = new List<Account>();        
        for (Id accId : noofContactsMap.keySet()) {
            Account updatedAccount = IdAccountMap.get(accId);            
            updatedAccount.Number_of_Contacts__c = noofContactsMap.get(accId);
            updatedAccounts.add(updatedAccount);
        }
        
        List<Database.SaveResult> updateResults = Database.update(updatedAccounts, false);        
        for (Database.SaveResult result : updateResults) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error updating Account: ' + error.getMessage());
                }
            }
        }
        
    }
    
    public static String setToString(Set<Id> strSet)
    {
        List<Id> strList = new List<Id>();
        strList.addAll(strSet);
        String whereclauseStr = 'in (\''+String.join(strList,'\',\'')+'\')';
        return whereclauseStr;
    }
    
    
    
   
}