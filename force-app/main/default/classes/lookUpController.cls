public class lookUpController {
    @AuraEnabled
    public static List < contact > fetchContact(String searchKeyWord) {
        String searchKey = searchKeyWord + '%';
        List < Contact > returnList = new List < Contact > ();
        List < Contact > lstOfContact = [select id, Name from contact where Name LIKE: searchKey];
        for (Contact con: lstOfContact) {
            returnList.add(con);
        }
        return returnList;
    }
}