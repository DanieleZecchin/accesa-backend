trigger C_updateContactTrigger on User (before update) {
    List<Contact> ctcList = new List<Contact>();
    Contact ctc = new Contact();
    Map<Id,Profile> profileIds = new Map<id,profile>([SELECT Id,UserLicenseId FROM Profile where UserLicenseId  in (SELECT Id FROM UserLicense where name ='Customer Community Plus')]);
    List<user> standardProfileUsers = [select id from user where profileId in:profileIds.Keyset()];
    
    for (User u : trigger.new ){
        system.debug(u.Id);
        for (User us : standardProfileUsers){
            if(us.Id == u.Id){
                system.debug('begin if');
                ctc.Id = u.ContactId;
                ctc.FirstName = u.FirstName;
                ctc.LastName = u.LastName;
                ctc.MobilePhone = u.MobilePhone;
                ctc.Email = u.Email;
                ctcList.add(ctc);
            }
        }
    }
    
    
    update ctcList;
    
}