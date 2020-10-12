public class ChecklistDetails {
    @AuraEnabled
    public static void createRecord (String jsonCheck,Date jsonDate,Date jsonDate1){
        system.debug('jsonCheck1============'+ jsonCheck);
        
        Checklist__c cl = (Checklist__c) JSON.deserialize(jsonCheck,Checklist__c.class);
        cl.MonthyChecklistDate__c = jsonDate;
        cl.Date__c = jsonDate1;
        
        upsert cl;
        system.debug('pdi >> '+ cl); 
        
        
    }
    @AuraEnabled
    public static String createAccessriesRecord (String jsonCheck,Date jsonDate,Date jsonDate1,Boolean updateVehicle){
        system.debug('jsonCheck '+ jsonCheck);
        
        Checklist__c cl = (Checklist__c) JSON.deserialize(jsonCheck,Checklist__c.class);
        cl.MonthyChecklistDate__c = jsonDate;
        cl.Date__c = jsonDate1;
        
        upsert cl;
        system.debug('cl >> '+ cl); 
        if(updateVehicle){
            Vehicle__c v =New Vehicle__c(Id=cl.Vehicle__c,Is_Accessories_filled__c=True);
            update v;
        }
        return cl.Id;
    } 
    @AuraEnabled
    public static void createIssueAccessriesRecord (String jsonCheck,Date jsonDate,Date jsonDate1){
        system.debug('jsonCheck1============'+ jsonCheck);
        
        Checklist__c cl = (Checklist__c) JSON.deserialize(jsonCheck,Checklist__c.class);
        cl.MonthyChecklistDate__c = jsonDate;
        cl.Date__c = jsonDate1;
        
        upsert cl;
    }
    @AuraEnabled
    public static Issues__c getissuecheckvalue(String id)
    {    
        Issues__c c = [select id,name,Vehicle__c,Vehicle__r.id,OwnerId,Owner.Name from Issues__c where id=:id];
        return c;
    }
    @AuraEnabled
    public List<Vehicle__c> vehcl = new List<Vehicle__c>();
    @AuraEnabled
    public List<Checklist__c> chk = new List<Checklist__c>();
    @AuraEnabled
    public List<Checklist__c> acceslist = new List<Checklist__c>();
    
    @AuraEnabled
    public static ChecklistDetails getcheckvalues(String id)
    {    
        ChecklistDetails checklistdet = new ChecklistDetails();
        //Vehicle__c vc =[Select id,Name,Site__c,Site__r.Location__r.OwnerId,Site__r.Location__r.Owner.Name from Vehicle__c where id=:id];
        checklistdet.vehcl =[Select id,Name,OwnerId,Owner.Name from Vehicle__c where id=:id];
        system.debug('!!!'+checklistdet.vehcl);
        
        
        checklistdet.chk = new List<Checklist__c>([select id,Vehicle__c,Vehicle__r.id,OwnerId,Owner.Name,RecordType.Name from Checklist__c where Vehicle__r.id=:id and RecordType.Name ='PDI' ]);
        system.debug('checklistdet'+checklistdet);
        
        checklistdet.acceslist = new List<Checklist__c>([select id,Vehicle__c,Vehicle__r.id,OwnerId,Owner.Name,RecordType.Name from Checklist__c where Vehicle__r.id=:id and RecordType.Name ='Accessory List' ]);
        system.debug('checklistdet'+checklistdet);
        return checklistdet;
        
        
    }
    @AuraEnabled
    public static Campus__c getownervalues(String id)
    {    
        
        Campus__c cs =[Select id,Name,Location__c,Location__r.OwnerId,Location__r.Owner.Name from Campus__c where id=:id];
        return cs;
        
    }
    @AuraEnabled
    public static Checklist__c getcheckvalues1(String id)
    {    
        
        Checklist__c  check=[select id,name,Hood__c,Front__c,Front_Bumper__c,Fenders__c,Doors__c,Roof__c,Rear__c,Rear_Bumper__c,Trunk_Dickie__c,
                             Trim__c,Charging_Socket_Port__c,Paint_Condition__c,Windshield__c,Windows__c,Mirrors__c,Rear_Window__c,
                             Tyres__c,Wheels__c,Spare_Tyre__c,Headliner__c,Seats__c,Carpet__c,Door_Panels__c,Glove_Box__c from Checklist__c where id=:id];
        
        system.debug('FROM APEX'+check);
        
        return check;
        
    } 
    @AuraEnabled
    public static String createPDIRecord (String jsonCheck,Date jsonDate,Date jsonDate1,Boolean updateVehicle1,Double lattitude,Double longitude){
        system.debug('jsonCheck '+ jsonCheck);
        
        Checklist__c cl = (Checklist__c) JSON.deserialize(jsonCheck,Checklist__c.class);
        cl.MonthyChecklistDate__c = jsonDate;
        cl.Date__c = jsonDate1;
        
        upsert cl;
        system.debug('cl >> '+ cl); 
        
        if(cl != null){
            Id MismatchRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByDeveloperName().get('Accessory_Fitting').getRecordTypeId();
            
            Issues__c i = New Issues__c();
            // i.OwnerId = cl.OwnerId;
            i.RecordTypeId = MismatchRecordTypeId;
            i.Driver__c = cl.Driver__c;
            i.Vehicle__c = cl.Vehicle__c;
            i.Service_Center__c = cl.Service_Center__c;
            i.Current_Location__Latitude__s = lattitude;
            i.Current_Location__Longitude__s = longitude;
            Insert i;
            
        }
        
        if(updateVehicle1){
            Vehicle__c v =New Vehicle__c(Id=cl.Vehicle__c,IS_PDI_FILLED__c=True);
            update v;
        }
        return cl.Id;
    } 
    
    
}