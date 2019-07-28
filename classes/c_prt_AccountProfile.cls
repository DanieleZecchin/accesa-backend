public class c_prt_AccountProfile {
    public List<Map<String, Object>> accountList {get; set;}
    public List<Account> accounts {get; set;}
    /*public String firstname {get; set;}
    public String lastname {get; set;}*/
    public List<User> userOwner {get; set;}
    public Integer present {get; set;}
    
    public c_prt_AccountProfile (){
        
        accountList = new List<Map<String, Object>>();
        Map<String, Object> accountMap = new Map<String, Object>();
        accounts = new List<Account>();
        Account details = new Account();
        Map<String,Object> inputData = new Map<String,Object> {
            ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccAPIAccount.ID =>ccrz.cc_CallContext.effAccountId
                };      
                    Map<String, Object> outputData = ccrz.ccAPIAccount.fetch(inputData);
        if (outputData.get(ccrz.ccAPIAccount.ACCOUNTS) != null) {
            accountList = (List<Map<String, Object>>) outputData.get(ccrz.ccAPIAccount.ACCOUNTS);
            system.debug(accountList);
        }
        accountMap = accountList[0];
        //for (Map<String, Object> accountMap : accountList) {
            system.debug(accountMap);
            String mapname=JSON.serialize(accountMap.get('sfdcName')).replace('"','');
            String Mapaccid=JSON.serialize(accountMap.get('sfid')).replace('"','');
            String MapPhone=JSON.serialize(accountMap.get('phone')).replace('"','');
            String bcity=JSON.serialize(accountMap.get('billingCity')).replace('"','');
            String bposcode=JSON.serialize(accountMap.get('billingPostalCode')).replace('"','');
            String bstate=JSON.serialize(accountMap.get('billingState')).replace('"','');
            String bstreet=JSON.serialize(accountMap.get('billingStreet')).replace('"','');
            String bcountry=JSON.serialize(accountMap.get('billingCountry')).replace('"','');
            String scity=JSON.serialize(accountMap.get('shippingCity')).replace('"','');
            String sposcode=JSON.serialize(accountMap.get('shippingPostalCode')).replace('"','');
            String sstate=JSON.serialize(accountMap.get('shippingState')).replace('"','');
            String sstreet=JSON.serialize(accountMap.get('shippingStreet')).replace('"','');
            String scountry=JSON.serialize(accountMap.get('shippingCountry')).replace('"','');
        	String ownerid=JSON.serialize(accountMap.get('ownerId')).replace('"','');
        	system.debug(ownerid);
                    
            userOwner = [SELECT FirstName, LastName FROM User WHERE Id =: ownerid];
        system.debug(userOwner);
        if (userOwner.size() > 0){
            present = 1;
        }
        else{
            present = 0;
        }
            /*for (Contact con : userOwner){
                firstname = con.FirstName;
                lastName = con.LastName;
            }*/
            details = [SELECT prt_Email__c FROM Account WHERE Id =: Mapaccid LIMIT 1];
            Account a = new Account(Name=MapName,phone=MapPhone, prt_Email__c=details.prt_Email__c, 
                                    BillingCity=bcity, billingpostalcode=bposcode, billingstate=bstate, 
                                    billingstreet=bstreet, billingcountry=bcountry, shippingcity=scity, 
                                    shippingpostalcode=sposcode, shippingstate=sstate, shippingstreet=sstreet, 
                                    shippingcountry=scountry);
            system.debug(details);
            accounts.add(a);
            
            
        //}
    }
}