public class vehicleController {
    @AuraEnabled
    public static Boolean getId(String recordId) {
        Vehicle__c  veh=[ select  VIN_Number__c, Id, Vehicle_Registration_Number__c  from Vehicle__c Where id=:recordId LImit 1];
        veh.Name=veh.Vehicle_Registration_Number__c;
        update veh;
        
       return true ;
    }
    
    @AuraEnabled
    public static list<FieldsWrapperClass> getFields() {
        list<string> fieldsApiname=new list<string>();
        List<vehicle__c>vehicleList=[select   Id,VIN_Number__c, Vehicle_Registration_Number__c,  Name from vehicle__c limit 10000];
        list<FieldsWrapperClass> fieldsWrapperList=new list<FieldsWrapperClass>();
        for(string s:+Schema.SObjectType.Vehicle__c.fieldSets.getMap().keySet()){
            FieldsWrapperClass  fsWrap=new FieldsWrapperClass();
            system.debug('s'+s);
            fieldsApiname=new list<string>();
            for(Schema.FieldSetMember fs:Schema.SObjectType.Vehicle__c.fieldSets.getMap().get(s).getFields()){
                fieldsApiname.add(fs.getFieldPath());
                
            }
            fsWrap.header=s;
        fsWrap.fieldsString=fieldsApiname;
            fsWrap.VehicleList=vehicleList;
            fieldsWrapperList.add(fsWrap);
            
        }
        return fieldsWrapperList;
    }
    
    
    public class FieldsWrapperClass{
        
        @AuraEnabled public String   header {get;set;}
        @AuraEnabled public List<String>  fieldsString{get;set;}
        @AuraEnabled public List<Vehicle__c>  VehicleList{get;set;}
        public  FieldsWrapperClass(){
            fieldsString = new list<String> ();
            header= '';
            VehicleList=new list<Vehicle__c>();
        }
    } 
    
}