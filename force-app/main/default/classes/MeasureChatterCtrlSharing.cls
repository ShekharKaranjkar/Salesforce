public without sharing class MeasureChatterCtrlSharing {
    
    /*  
    public static void shareMeasureManually(String measureId, List<String> userList){
        if(! (FLSCheck.isAccessible(MeasureChatterCtrlSharing.getMeasureFields(), 'myV2MOM__Measure__c') && FLSCheck.isCreateable(MeasureChatterCtrlSharing.getMeasureFields(), 'myV2MOM__Measure__c')) ){
            return;
        }
        
        List<Measure__Share> meaShareExists = new  List<Measure__Share>();
        meaShareExists = [select id,UserOrGroupId from Measure__Share where ParentId =: measureId];
        List<String> remoUsers = new List<String>();
        for(Measure__Share meaShare : meaShareExists){
            remoUsers.add(meaShare.UserOrGroupId);
        }
        
        Set<String> usersToShare = new Set<String>();
        usersToShare.addAll(userList);
        usersToShare.removeAll(remoUsers);
        
        List<Measure__Share> mRecdShareList = new List<Measure__Share>();
        for(String userId : usersToShare){
            Measure__Share mRecdShare = new Measure__Share();
            mRecdShare.AccessLevel = 'Edit';
            mRecdShare.ParentId = measureId;
            mRecdShare.UserOrGroupId = userId;
            mRecdShareList.add(mRecdShare);
        }
        if(mRecdShareList != null && mRecdShareList.size() > 0){
            insert mRecdShareList;
        }
    }
    
   
    public static List<String> getMethodFields(){
        List<String> fieldNames = new List<String>();
        Map<String,Schema.SObjectField> m = Schema.SObjectType.myV2MOM__Method__c.fields.getMap();
        for (Schema.SObjectField sfield : m.Values()) {
            if (sfield.getDescribe().isUpdateable()) {
                //system.debug('field-->'+sfield.getDescribe().getname());
                fieldNames.add(sfield.getDescribe().getname());
            }
        }
        return fieldNames;
    } 
    
    
    public static List<String> getMeasureFields(){
        List<String> fieldNames = new List<String>();
        Map<String,Schema.SObjectField> m = Schema.SObjectType.myV2MOM__Measure__c.fields.getMap();
        for (Schema.SObjectField sfield : m.Values()) {
            if (sfield.getDescribe().isUpdateable()) {
                //system.debug('field-->'+sfield.getDescribe().getname());
                fieldNames.add(sfield.getDescribe().getname());
            }
        }
        return fieldNames;
    } 
    
     
    public static List<String> getV2MOMFields(){
        List<String> fieldNames = new List<String>();
        Map<String,Schema.SObjectField> m = Schema.SObjectType.myV2MOM__V2MOM__c.fields.getMap();
        for (Schema.SObjectField sfield : m.Values()) {
            if (sfield.getDescribe().isUpdateable()) {
                //system.debug('field-->'+sfield.getDescribe().getname());
                fieldNames.add(sfield.getDescribe().getname());
            }
        }
        return fieldNames;
    } 
    
   
    public static List<String> getMeasureTeamFields(){
        List<String> fieldNames = new List<String>();
        Map<String,Schema.SObjectField> m = Schema.SObjectType.myV2MOM__Measure_Team__c.fields.getMap();
        for (Schema.SObjectField sfield : m.Values()) {
            if (sfield.getDescribe().isUpdateable()) {
                //system.debug('field-->'+sfield.getDescribe().getname());
                fieldNames.add(sfield.getDescribe().getname());
            }
        }
        return fieldNames;
    } */
}