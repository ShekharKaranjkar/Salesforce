public class LookupInventoryController {
    
    @AuraEnabled
    public static List<SObJectResult> getResults(String ObjectName, String fieldName, String value) {
        List<SObJectResult> sObjectResultList = new List<SObJectResult>();
        for(sObject so : Database.Query('Select Id,Stock__c,'+fieldName+' FROM '+ObjectName+' WHERE '+fieldName+' LIKE \'%' + value + '%\'')) {
            String fieldvalue = (String)so.get(fieldName);
            sObjectResultList.add(new SObjectResult(fieldvalue, so.Id,(Decimal)so.get('Stock__c')) );
        }
        	system.debug('sObjectResultList > '+ sObjectResultList);
        return sObjectResultList;
    }
    
    public class SObJectResult {
        @AuraEnabled
        public String recName;
        @AuraEnabled
        public Id recId;
            @AuraEnabled
        public Decimal recQty;
        public SObJectResult(String recNameTemp, Id recIdTemp,Decimal recQtyTemp) {
            recName = recNameTemp;
            recId = recIdTemp;
            recQty = recQtyTemp;
        }
    }
}