global with sharing class c_Prt_ContactController {
    public String mobilePhone {get; set;}
    //public List<Map<String, Object>> userList {get; set;}
    
    global c_Prt_ContactController(){
        List<Contact> user = [SELECT MobilePhone FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id =: UserInfo.getUserId())];
        mobilePhone = user[0].MobilePhone;
    }
    
    @RemoteAction
    global static String editMembers(map<string,Object> inputmap) {
        Map<String,Object> inputData = new Map<String,Object> {
            ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccAPIContact.ACCOUNTID =>ccrz.cc_CallContext.currAccountId,
                ccrz.ccApiUser.USER_REGISTER_JSON=> '{"userFirstName":"text","alias":"fcrotti",userLastName":"textdsa2","userPhone":"111111111","emailAddress":"text4@gf.it"}'
                };	
                    return 'entrato';
    }
    
    /*global static void revokeMember(map<string,Object> inputmap){
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