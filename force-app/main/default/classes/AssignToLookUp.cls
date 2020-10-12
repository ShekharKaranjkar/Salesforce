public class AssignToLookUp {
 @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord ,String ObjectName, Sobject ExcludeitemsList) {
        String searchKey = '%' + searchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();
 
        /*List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }*/
        Id recid;
        if(ExcludeitemsList!=Null)
         recid = ExcludeitemsList.Id;
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery;
        If(ObjectName == 'Contact')
         sQuery =  'select id, Name,AccountId,Account.Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id !=: recid order by createdDate DESC limit 5';
        else
         sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id !=: recid order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
}