public class CheckListRecordTypeController {

    public static Map<Id, String> recordtypemap {get;set;}
    
   @AuraEnabled        
    public static Map<Id, String> fetchRecordTypeValues(){
        List<Schema.RecordTypeInfo> recordtypes = Checklist__c.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap;
    }
    
}