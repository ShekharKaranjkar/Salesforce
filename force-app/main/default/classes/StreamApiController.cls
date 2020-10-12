public class StreamApiController {
 
    @AuraEnabled
    public static String getSessionId() {
        return UserInfo.getSessionId();
    }
}