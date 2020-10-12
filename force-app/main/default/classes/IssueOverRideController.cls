public class IssueOverRideController {
   
    @AuraEnabled
    public static list<FieldsWrapperClass> getFieldswithSectionHeaders(String RecordtypeID) {
        Recordtype rectype = [Select id,name from recordtype where id=:RecordtypeID] ;
        list<string> fieldsApiname=new list<string>();
        list<FieldsWrapperClass> fieldsWrapperList=new list<FieldsWrapperClass>();
        for(string s:+Schema.SObjectType.Issues__c.fieldSets.getMap().keySet()){
            FieldsWrapperClass  fsWrap=new FieldsWrapperClass();
            system.debug('s'+s);
            String description = Schema.SObjectType.Issues__c.fieldSets.getMap().get(s).getDescription();
            if(description.contains(rectype.Name)){
            fieldsApiname=new list<string>();
            for(Schema.FieldSetMember fs:Schema.SObjectType.Issues__c.fieldSets.getMap().get(s).getFields()){
                fieldsApiname.add(fs.getFieldPath());
            }
            fsWrap.header=s;
            fsWrap.fieldsString=fieldsApiname;
            system.debug('fieldsApiname-------->'+fieldsApiname);
            fieldsWrapperList.add(fsWrap);
            system.debug('.........'+fieldsWrapperList);
            }
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
    } 
    
}