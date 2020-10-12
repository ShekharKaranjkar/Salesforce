trigger InsuranceTigger on Insurance__c (after insert,before insert) {
 /*  if(trigger.IsAfter && trigger.IsInsert){
        Set<Id>vehicleidSet =New Set<Id>();
       list<Insurance__c> insue = new   list<Insurance__c>();
    For(Insurance__c documnet:Trigger.New){
        if(documnet.Vehicle__c != Null)
     //       insue.add(documnet.Vehicle__c);
        //Vehicle__c oldveh = Trigger.oldMap.get(documnet.Id);
    }
   
        if(insue.size()>0){
            try{
                List<Vehicle__c>updateVehiclesList = New List<Vehicle__c>();
          //      For(Id recid:insue){
                    Vehicle__c v= New Vehicle__c(Id=recid,Is_insurance_filled__c=True);
                    updateVehiclesList.add(v);
                }
                update updateVehiclesList;
            }catch(Exception e) {
                
            } 
        }
    } */
}