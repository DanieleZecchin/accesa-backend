public with sharing class c_AccountMembers
{
    public  List<Map<String, Object>> contactList {get; set;}
    public  List<Contact> contacts {get; set;}
    public String userId {get; set;}
    public String userName {get; set;}
    //public List<Map<String, Object>> userList {get; set;}
    
    
    public c_AccountMembers (){
        
        contactList = new List<Map<String, Object>>();
        contacts = new List<Contact>();
        User userDetails = new User();
       Contact details= new Contact();
        Map<String,Object> inputData = new Map<String,Object> {
            ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccAPIContact.ACCOUNTID =>ccrz.cc_CallContext.currAccountId
                };      
                    Map<String, Object> outputData = ccrz.ccAPIContact.fetch(inputData);
        
        if (outputData.get(ccrz.ccAPIContact.CONTACTS) != null) {
            contactList = (List<Map<String, Object>>) outputData.get(ccrz.ccAPIContact.CONTACTS);
            system.debug(contactList);
        }
        for (Map<String, Object> contactmap : contactList) {
            String MapName=JSON.serialize(contactmap.get('firstName')).replace('"','');
            String Mapcontid=JSON.serialize(contactmap.get('sfid')).replace('"',''); 
            String MapLast=JSON.serialize(contactmap.get('lastName')).replace('"','');
            String Mapemail=JSON.serialize(contactmap.get('email')).replace('"','');
            String MapPhone=JSON.serialize(contactmap.get('phone')).replace('"','');
            details = [SELECT prt_ECOM__c, prt_ECOMSecurityLevel__c, prt_MainContact__c,prt_Status__c FROM Contact WHERE Id =: Mapcontid ];
            //userDetails = [SELECT Id, Username FROM User WHERE ContactId =: Mapcontid];
            //userId = userDetails.Id;
            //userName = userDetails.Username;
            if((details.prt_Status__c=='A') && (details.prt_ECOM__c)){
             String rolefunc= functionMap(details.prt_ECOMSecurityLevel__c);
            Contact a = new Contact(Id=Mapcontid, FirstName=MapName,lastName=MapLast,phone=MapPhone, email=Mapemail, prt_Function__c=rolefunc, prt_MainContact__c=details.prt_MainContact__c );
            contacts.add(a);
            }
        }
    }
        
        public  String functionMap(String role){
            switch on role {
                when '1' {
                    return 'Amministratore';
                }	
                when '2' {		
                    return 'assistente'  ;
                }
                when '3' {		
                    return 'proprietario' ;
                }
                when else {		  
                   return  '';  
                }
                
            }
               
    }
    
    /*@RemoteAction
    public static void revokeMember(){
        
List<Map<String, Object>> userList = null;
Map<String,Object> inputData = new Map<String,Object> {
ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
ccrz.ccAPIUser.USER_Id =>ccrz.cc_CallContext.currUserId
};      
Map<String, Object> outputData = ccrz.ccAPIUser.fetch(inputData);

if (outputData.get(ccrz.ccAPIUser.USERLIST) != null) {
userList = (List<Map<String, Object>>) outputData.get(ccrz.ccAPIUser.USERLIST);
system.debug(userList);
}

Map<String, Object> userMap = userList[0];
String userId=JSON.serialize(userMap.get('sfid')).replace('"','');

List<User> updatedUser = [SELECT IsActive FROM User WHERE Id =: userId];
updatedUser[0].IsActive = false;
update updatedUser;

    }*/
}