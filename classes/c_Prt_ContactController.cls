global class c_Prt_ContactController {
    public String mobilePhone {get; set;}
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public User u {get; set;}
    //public List<Map<String, Object>> userList {get; set;}
    
    global c_Prt_ContactController(){
        List<Contact> user = [SELECT FirstName, LastName, Email, MobilePhone, Phone FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id =: UserInfo.getUserId())];
        mobilePhone = user[0].MobilePhone;
        firstName = user[0].FirstName;
        lastName = user[0].LastName;
        email = user[0].Email;
    }
    
    //@RemoteAction
    global pagereference editContact(){
        system.debug('start edit contact');
        List<Contact> contacts = [SELECT Id, FirstName, LastName, MobilePhone, Email FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id =: UserInfo.getUserId())];
        List<Contact> updateContacts = new List<Contact>();
        Contact con = contacts[0];
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Email = email;
        con.MobilePhone = mobilephone;
        
        updateContacts.add(con);
        update updateContacts;
        return null;
    }
    
    @RemoteAction
    global static Object editMembersCompany(final ccrz.cc_RemoteActionContext ctx, String sfid,  String firstName, String secondName, String phone, String email, String mobile, String role,Boolean isChecked) {
	 Contact details= new Contact();
     Map<String,Object> inputData = new Map<String,Object> {
            ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
            ccrz.ccAPIContact.ACCOUNTID =>ccrz.cc_CallContext.currAccountId
                };	
    try {

      details = [SELECT firstName,lastName, Phone, email, prt_ECOM__c, prt_ECOMSecurityLevel__c,MobilePhone, prt_MainContact__c FROM Contact WHERE Id =: sfid ];
      details.firstName=firstName;
      details.lastName=secondName;
      details.Phone=phone;
      details.email=email;
      details.prt_ECOMSecurityLevel__c=role;
      details.prt_MainContact__c=isChecked;
      details.MobilePhone=mobile;    
      update details;
  		return details;
    	} catch(DmlException e) {
     return 'An unexpected error has occurred: ' + e.getMessage();
	}
                   
       
    }
    
     @RemoteAction
    global static Object createEditCase(final ccrz.cc_RemoteActionContext ctx, String firstName, String secondName, String phone, String email, String mobile, String role,Boolean isChecked){
    ccrz.cc_RemoteActionResult res = ccrz.cc_CallContext.init(ctx); 
    
        try {
            Account Acc =  [select id from account where id=: ccrz.cc_CallContext.currAccountId];
            Contact NewContact = new Contact (
			FirstName = firstName, 
			LastName = secondName,
			AccountId = Acc.Id, 
            Phone = phone,
            MobilePhone = mobile,    
			Email = email,
            prt_Status__c='A',
            prt_ECOM__c=true,    
            prt_ECOMSecurityLevel__c=role,
            prt_MainContact__c=isChecked
			);
            insert NewContact;
	     
            User usr = new User(LastName = secondName,
                   FirstName=firstName,
                   Alias = 'firstn',
                  ContactId = NewContact.id,
                  Email = email,
                   Username = email,
                   ProfileId = '00e6E000000QVgx',
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'IT',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'IT'
                   );
		/*Database.DMLOptions dlo=new Database.DMLOptions();
		dlo.EmailHeader.triggerUserEmail =true;
		dlo.EmailHeader.triggerAutoResponseEmail=true;
		usr.setOptions(dlo);
       	*/
        insert  usr;
        res.data = NewContact.Id;
        res.success = true;
        return res;
		}
        
         catch(Exception e)
        {
        res.data = e.getMessage();
        res.success = false;
        return res;     
        }
        
    }
     
    
}