public class Projectcontroller {
    @AuraEnabled
    public static string getId() {
        MPM4_BASE__Milestone1_Project__c  veh=[select Name,MPM4_BASE__Program__c, Id  from MPM4_BASE__Milestone1_Project__c  order by CreatedDate desc limit 1];
        
        return veh.Id ;
    }
    
   /* @AuraEnabled
    public static list<FieldsWrapperClass> getFields() {
        list<string> fieldsApiname=new list<string>();
        list<FieldsWrapperClass> fieldsWrapperList=new list<FieldsWrapperClass>();
        for(string s:+Schema.SObjectType.MPM4_BASE__Milestone1_Project__c.fieldSets.getMap().keySet()){
            FieldsWrapperClass  fsWrap=new FieldsWrapperClass();
            system.debug('s'+s);
            fieldsApiname=new list<string>();
            for(Schema.FieldSetMember fs:Schema.SObjectType.MPM4_BASE__Milestone1_Project__c.fieldSets.getMap().get(s).getFields()){
                fieldsApiname.add(fs.getFieldPath());
                
            }
            fsWrap.header=s;
            fsWrap.fieldsString=fieldsApiname;
            fieldsWrapperList.add(fsWrap);
        }
        return fieldsWrapperList;
    }
    
    
    public class FieldsWrapperClass{
        
        @AuraEnabled public String   header {get;set;}
        @AuraEnabled public List<String>  fieldsString{get;set;}
        
        public  FieldsWrapperClass(){
            fieldsString = new list<String> ();
            header= '';
        }
    } */
    
}