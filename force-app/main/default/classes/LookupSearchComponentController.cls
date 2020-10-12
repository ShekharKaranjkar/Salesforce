public class LookupSearchComponentController {
    
    @AuraEnabled
    public static List<SObJectResult> getResults(String ObjectName, String fieldName, String value) {
        system.debug('ObjectName'+ObjectName);
        system.debug('fieldName'+fieldName);
        system.debug('value'+value);
        List<SObJectResult> sObjectResultList = new List<SObJectResult>();
        for(sObject so : Database.Query('Select Id,'+fieldName+' FROM '+ObjectName+' WHERE '+fieldName+' LIKE \'%' + value + '%\'')) {
            String fieldvalue = (String)so.get(fieldName);
            system.debug('fieldvalue'+fieldvalue);
            sObjectResultList.add(new SObjectResult(fieldvalue, so.Id));
        }
        system.debug('sObjectResultList'+sObjectResultList);
        return sObjectResultList;
    }
    
    public class SObJectResult {
        @AuraEnabled
        public String recName;
        @AuraEnabled
        public Id recId;
        
        public SObJectResult(String recNameTemp, Id recIdTemp) {
            recName = recNameTemp;
            recId = recIdTemp;
        }
    }
}