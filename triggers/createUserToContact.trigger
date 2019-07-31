trigger createUserToContact on Contact (after update) {
    
    List<User> userList = new List<User>();
    User u = new User();
    Map<Id,Profile> profileIds = new Map<id,profile>([SELECT Id,UserLicenseId FROM Profile where UserLicenseId  in (SELECT Id FROM UserLicense where name ='Customer Community Plus')]);
    List<user> standardProfileUsers = [select id, ContactId from user where profileId in:profileIds.Keyset()];
    
    for (Contact ctc : trigger.new ){
        system.debug(ctc.Id);
        for (User us : standardProfileUsers){
            if(us.ContactId == ctc.Id){
                u.Id = us.Id;
                u.ContactId = ctc.Id;
                u.FirstName = ctc.FirstName;
                u.LastName = ctc.LastName;
                u.MobilePhone = ctc.MobilePhone;
                u.Phone = ctc.Phone;
                u.Email = ctc.Email;
                userList.add(u);
            }
        }
    }
    
    
    update userList;
/*
    List <User> newUser1 = new List<User>();//list to perfrom DML outside of loop
    //set to contain only ESS_User__c = true contacts
    set<Id> setContactIds = new set<Id>();
    for(Contact con : Trigger.new)
    {
      //  if (con.ESS_User__c == TRUE){
            setContactIds.add(con.Id);
      //  }
    }
    //set to store contactId to user record
    set<Id> setExistingUserContactId = new set<Id>();
    for(User objUser: [Select Id, ContactId from User WHERE ContactId IN:setContactIds ])
    {
        setExistingUserContactId.add(objUser.ContactId);
    }
    for(Contact con : Trigger.new)
    {
        //check contact Id already exist in set or not
       if(!setExistingUserContactId.contains(con.Id))
        {
         User newUser = new User( 
                    CommunityNickname = con.FirstName + con.LastName.substring(0,3),
                    ContactId = con.id,
                    Department = con.Department,
                    Email = con.Email,
                    EmailEncodingKey = 'ISO-8859-1',
                    FirstName = con.FirstName,
                    IsActive = TRUE,     
                    LastName = con.LastName,
                   
                    ReceivesInfoEmails= TRUE,
                    Username = con.Email,
                  UserRoleId = '00E6E000001ScYs'
            );
            newUser1.add(newUser);  
        }
    }
  insert newUser1;*/
}