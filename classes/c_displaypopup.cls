global class c_displaypopup {
 @RemoteAction
    global static String createEditCase(String a) 
    {
        return a;
    }
    /*
    global static ccrz.cc_RemoteActionResult createEditCase(final ccrz.cc_RemoteActionContext ctx) 
    {
        ccrz.cc_RemoteActionResult res = ccrz.cc_CallContext.init(ctx); 
        try 
        { 
             res.success = true;
        }
        catch(Exception e)
        {
            res.data = e;
            res.success = false;
        } finally {
            ccrz.ccLog.close(res);
        }

        return res;
    }
    */
  
}