global virtual with sharing class myCustom_ccLogicUserLogin extends ccrz.ccLogicUserLogin {
     
    global virtual override Map<String, Object> prepReturn(Map<String, Object> inputData) {
         
        // Call the default CCRZ prepReturn to load the default values
        Map<String, Object> returnData = super.prepReturn(inputData);
 
        // Add the start url from the inputData
        returnData.put(ccrz.ccApiUser.LOGIN_START_URL, inputData.get(ccrz.ccApiUser.LOGIN_START_URL));
 
        // Return the customized returnData
        return returnData;
    }
}