public class c_Prt_UpdateUser {
    
    public static void updateUser (map<string,Object> inputmap){
        List<Map<String, Object>> userList = null;
        List<User> users = null;
        Map<String,Object> inputData = new Map<String,Object> {
            ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccAPIUser.USER_DATA_MAP => inputmap
                };      
                    Map<String, Object> outputData = ccrz.ccAPIUser.updateProfileData(inputData);
    }
}