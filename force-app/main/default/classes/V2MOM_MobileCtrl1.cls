public with sharing class V2MOM_MobileCtrl1 {
   
/*        @AuraEnabled
    public static V2MOM_UtilCls.newMethodAndMeasureWrap getMnMNew(string v2MOMId){
      	return V2MOM_UtilCls.getMnMNew(v2MOMId);
    }
    
   
    @AuraEnabled
    public static List<User> searchUsers(String vSearchStr){
        List<String> checkUserFields = new List<String>();
        checkUserFields.add('Name');
        checkUserFields.add('SmallPhotoUrl');
        checkUserFields.add('Title');
        if(! FLSCheck.isAccessible(checkUserFields, 'User') ){
            return new List<User>();
        }
        
        vSearchStr = String.escapeSingleQuotes('%'+vSearchStr+'%');
        List<User> userList = [select Id, Name, SmallPhotoUrl, Title from User where Name LIKE: vSearchStr];
        return userList;
    }
    
    @AuraEnabled
    public static String fetchUserId(){
        return V2MOM_UtilCls.getUserId();
    }
    
 
    @AuraEnabled
    public static List<V2MOM_UtilCls.labelValueWrap> getMeasureStatusPicklistValues(){
        return V2MOM_UtilCls.getStatusPicklistValues();
    }
    
    
    @AuraEnabled
    public static myV2MOM__V2MOM__c saveV2V(String visionVal, String valueVal, String v2momIdVal){
        if(!(FLSCheck.isAccessible(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c')  && FLSCheck.isCreateable(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c') &&
             FLSCheck.isUpdateable(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c'))){
            return new myV2MOM__V2MOM__c();
        }
        
        myV2MOM__V2MOM__c v2momObj;
        if(v2momIdVal != ''){
            List<myV2MOM__V2MOM__c> v2momObjList = [select Id, myV2MOM__Vision__c, myV2MOM__Vision__c from myV2MOM__V2MOM__c where id =: v2momIdVal];
            if(v2momObjList != null && v2momObjList.size() > 0){
                v2momObj = v2momObjList[0];
                v2momObj.myV2MOM__Vision__c = visionVal;
                v2momObj.myV2MOM__Values__c = valueVal;
                update v2momObj;
            }else{
                String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
                
                v2momObj = new myV2MOM__V2MOM__c();
                v2momObj.myV2MOM__Vision__c = visionVal;
                v2momObj.myV2MOM__Values__c = valueVal;
                v2momObj.myV2MOM__FY_Year__c = currentFiscalYear;
                v2momObj.myV2MOM__Status__c = 'Draft';
                v2momObj.Name = 'FY'+v2momObj.myV2MOM__FY_Year__c+' V2MOM '+UserInfo.getName();
                insert v2momObj;
            }
        }else{
            String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
            
            v2momObj = new myV2MOM__V2MOM__c();
            v2momObj.myV2MOM__Vision__c = visionVal;
            v2momObj.myV2MOM__Values__c = valueVal;
            v2momObj.myV2MOM__FY_Year__c = currentFiscalYear;
            v2momObj.myV2MOM__Status__c = 'Draft';
            v2momObj.Name = 'FY'+v2momObj.myV2MOM__FY_Year__c+' V2MOM '+UserInfo.getName();
            insert v2momObj;
        }
        return v2momObj;
    }
    
   
    @AuraEnabled
    public static myV2MOM__V2MOM__c fetchV2V(String v2momIdVal){
        if(! FLSCheck.isAccessible(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c') ){
            return new myV2MOM__V2MOM__c();
        }
        
        myV2MOM__V2MOM__c v2momObj;
        if(v2momIdVal != ''){
            List<myV2MOM__V2MOM__c> v2momObjList = [select Id, myV2MOM__Vision__c, myV2MOM__Values__c from myV2MOM__V2MOM__c where id =: v2momIdVal];
            if(v2momObjList != null && v2momObjList.size() > 0){
                v2momObj = v2momObjList[0];
            }else{
                v2momObj = new myV2MOM__V2MOM__c();
            }
        }else{
            v2momObj = new myV2MOM__V2MOM__c();
        }
        
        return v2momObj;
    }
    
    
    @AuraEnabled
    public static V2MOMHomeW fetchV2MOMRec(String v2momId){
        if(! FLSCheck.isAccessible(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c') ){
            return new V2MOMHomeW();
        }
        
        V2MOMHomeW v2momHWObj = new V2MOMHomeW();
        String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
        List<myV2MOM__V2MOM__c> v2momObjList = new List<myV2MOM__V2MOM__c>();
        
        if(v2momId != null && v2momId != ''){
            v2momObjList = [select Id, CreatedById, Name, myV2MOM__Vision__c, myV2MOM__Values__c, myV2MOM__FY_Year__c, myV2MOM__Published_Date__c, myV2MOM__Status__c, LastModifiedDate from myV2MOM__V2MOM__c where id =: v2momId];
        }else{
            v2momObjList = [select Id, myV2MOM__Vision__c, myV2MOM__Values__c, CreatedById, myV2MOM__FY_Year__c, myV2MOM__Published_Date__c, myV2MOM__Status__c, Name, LastModifiedDate from myV2MOM__V2MOM__c where myV2MOM__FY_Year__c =: currentFiscalYear AND CreatedById =: UserInfo.getUserId()];
        }
        
        myV2MOM__V2MOM__c v2momObj;
        if(v2momObjList != null && v2momObjList.size() > 0){
            v2momObj = v2momObjList[0];
        }else{
            v2momObj = new myV2MOM__V2MOM__c();
        }
        v2momHWObj.v2momObj = v2momObj;
        
        List<User> userList = [select id, ManagerId from User where id =: v2momHWObj.v2momObj.CreatedById];
        if(userList != null && userList.size() > 0){
            List<myV2MOM__V2MOM__c> v2momObjListM = [select id from myV2MOM__V2MOM__c where myV2MOM__FY_Year__c =: currentFiscalYear AND CreatedById =: userList[0].ManagerId];
            myV2MOM__V2MOM__c v2momObjM;
            if(v2momObjListM != null && v2momObjListM.size() > 0){
                v2momObjM = v2momObjListM[0];
            }else{
                v2momObjM = new  myV2MOM__V2MOM__c();
            }
            v2momHWObj.managerV2momId = v2momObjM.Id;
        }else{
            v2momHWObj.managerV2momId = '';
        }
        
        List<myV2MOM__V2MOM__c> v2momObjOptList = new List<myV2MOM__V2MOM__c>();
        if(v2momId != null && v2momId != ''){
            v2momObjOptList = [select Id, myV2MOM__FY_Year__c from myV2MOM__V2MOM__c where CreatedById =: v2momObj.CreatedById
                                         order by CreatedDate DESC];
        }else{
            v2momObjOptList = [select Id, myV2MOM__FY_Year__c from myV2MOM__V2MOM__c where CreatedById =: UserInfo.getUserId()];
        }
        
        if(v2momObjOptList != null && v2momObjOptList.size() > 0){
            v2momHWObj.v2momOptions = v2momObjOptList;
        }else{
            v2momHWObj.v2momOptions = new List<myV2MOM__V2MOM__c>();
        }
        
        List<myV2MOM__V2MOM__c> v2momObjcurrList =  [Select Id from myV2MOM__V2MOM__c where myV2MOM__FY_Year__c =: currentFiscalYear AND CreatedById =: UserInfo.getUserId()];
        myV2MOM__V2MOM__c v2momObjCurr;
        if(v2momObjcurrList != null && v2momObjcurrList.size() > 0){
            v2momObjCurr = v2momObjcurrList[0];
        }else{
            v2momObjCurr = new myV2MOM__V2MOM__c();
        }
        v2momHWObj.currentUserV2MOMId = v2momObjCurr.Id;
        
        if(v2momObjList != null && v2momObjList.size() > 0){
             v2momHWObj.lastupdatedDate = V2MOM_UtilCls.calcLastupdatedDate(v2momHWObj.v2momObj);
             system.debug('v2momHWObj.lastupdatedDate: '+v2momHWObj.lastupdatedDate);
        }else{
            v2momHWObj.lastupdatedDate = null;
        }
        
        return v2momHWObj;
    }
    
  
    public class V2MOMHomeW{
    	@AuraEnabled
        public myV2MOM__V2MOM__c v2momObj;
        @AuraEnabled
        public String managerV2momId;
        @AuraEnabled
        public List<myV2MOM__V2MOM__c> v2momOptions;
        @AuraEnabled
        public string currentUserV2MOMId;
        @AuraEnabled
        public DateTime lastupdatedDate;
    }
    
   
    @AuraEnabled
    public static boolean isUserAManagerMob(String uId){
        return V2MOM_Controller.isUserAManager(uId);
    }
    
    
    @auraEnabled
    public static String referManagerVisionMob(myV2MOM__V2MOM__c V2MOMrec){
        System.debug('In Mobile Ctrl::'+V2MOMrec);
        return V2MOM_Controller.referManagerVision(V2MOMrec);
    }
    
 
    @auraEnabled
    public static String referManagerValueMob(myV2MOM__V2MOM__c V2MOMrec){
        return V2MOM_Controller.referManagerValue(V2MOMrec);
    }
    

    @AuraEnabled
    public static myV2MOM__V2MOM__c publishV2MOMMob(String v2momIdVal){
        if(! FLSCheck.isAccessible(MeasureChatterCtrlSharing.getV2MOMFields(), 'myV2MOM__V2MOM__c') ){
            return new myV2MOM__V2MOM__c();
        }
        
        myV2MOM__V2MOM__c v2MOMObj = V2MOM_Controller.publishV2MOM(v2momIdVal);
        v2MOMObj = [select id, CreatedById, Name, myV2MOM__Vision__c, myV2MOM__Values__c, myV2MOM__FY_Year__c, myV2MOM__Published_Date__c, myV2MOM__Status__c from myV2MOM__V2MOM__c where id=: v2MOMObj.Id];
    	return v2MOMObj;
    } */
}