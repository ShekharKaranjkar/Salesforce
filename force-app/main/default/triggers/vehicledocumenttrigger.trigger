trigger vehicledocumenttrigger on Vehicle_Documents__c (after insert,before insert) {
    Id FCRecordTypeId = Schema.SObjectType.Vehicle_Documents__c.getRecordTypeInfosByDeveloperName().get('Fitness_Certificate').getRecordTypeId();
    Id PermitRecordTypeId = Schema.SObjectType.Vehicle_Documents__c.getRecordTypeInfosByDeveloperName().get('Permit').getRecordTypeId();
    Id RegistrationRecordTypeId = Schema.SObjectType.Vehicle_Documents__c.getRecordTypeInfosByDeveloperName().get('Registration').getRecordTypeId();
    Id TaxesRecordTypeId = Schema.SObjectType.Vehicle_Documents__c.getRecordTypeInfosByDeveloperName().get('Taxes').getRecordTypeId();
    Set<Id>RecordTypeIdSet = New Set<Id>();RecordTypeIdSet.add(FCRecordTypeId);RecordTypeIdSet.add(PermitRecordTypeId);
    RecordTypeIdSet.add(RegistrationRecordTypeId);RecordTypeIdSet.add(TaxesRecordTypeId);
    //Map<Id,Vehicle__c>vehicleMap = New Map<Id,Vehicle__c>([Select id,Task_Stage__c,All_Vehicle_Documents_Received__C,(select id,RecordtypeId from Vehicle_Documents__r) from Vehicle__c Where id=:Trigger.NewMap.Keyset()]);
    
    if(trigger.IsAfter && trigger.IsInsert){
        Set<Id>vehicleidSet =New Set<Id>();
        For(Vehicle_Documents__c documnet:Trigger.New){
            if(documnet.Vehicle__c != Null)
                vehicleidSet.add(documnet.Vehicle__c);
            //Vehicle__c oldveh = Trigger.oldMap.get(documnet.Id);
        }
        
        if(vehicleidSet !=Null){
            Set<Id>updateVehicleIds =New Set<Id>();
            Map<Id,Set<Id>>vehicleMap = New Map<Id,Set<Id>>();
            For(Vehicle_Documents__c doc:[select id,RecordtypeId,Vehicle__c from Vehicle_Documents__c where Vehicle__c =:vehicleidSet]){
                if(vehicleMap.containskey(doc.Vehicle__c)){
                    Set<Id>recodtypeids = new Set<Id>();
                    recodtypeids.addAll(vehicleMap.get(doc.Vehicle__c));
                    if(!recodtypeids.contains(doc.Recordtypeid)){
                        recodtypeids.add(doc.Recordtypeid);
                        vehicleMap.put(doc.Vehicle__c,recodtypeids);
                        if(recodtypeids.size() == 4)
                            updateVehicleIds.add(doc.Vehicle__c);
                    }
                }
                else{
                    vehicleMap.put(doc.Vehicle__c,new Set<Id>{doc.Recordtypeid});
                }
            }
            if(updateVehicleIds.size()>0){
                try{
                    List<Vehicle__c>updateVehiclesList = New List<Vehicle__c>();
                    For(Id recid:updateVehicleIds){
                        Vehicle__c v= New Vehicle__c(Id=recid,All_Vehicle_Documents_Received__C=True);
                        updateVehiclesList.add(v);
                    }
                    update updateVehiclesList;
                }catch(Exception e) {
                    
                } 
            }
        }
    }
    if(trigger.isBefore && trigger.isInsert){
        system.debug('inside the trigger');
        //  vehicleDocumentRegistrationNumber.copyFromVehicle(trigger.New);
        Set<Id>vehicleidSet =New Set<Id>();
        Set<Id>recodtypeidSet =New Set<Id>();//2 ids
        For(Vehicle_Documents__c documnet:Trigger.New){//2 recorsd ft,rc--same vehicle1.==count 1
            if(documnet.Vehicle__c != Null){
                vehicleidSet.add(documnet.Vehicle__c);
                recodtypeidSet.add(documnet.RecordTypeId);
            }
            //Vehicle__c oldveh = Trigger.oldMap.get(documnet.Id);
        }
        
        if(vehicleidSet !=Null){
            Set<Id>updateVehicleIds =New Set<Id>();
            Map<Id,Vehicle__c>vehicleMap = New Map<Id,Vehicle__c>([Select id ,(select id,RecordtypeId,Vehicle__c from Vehicle_Documents__r where recordtypeid =:recodtypeidSet) from Vehicle__c where id =:vehicleidSet]);
            For(Vehicle_Documents__c documnet:Trigger.New){
                if(documnet.Vehicle__c != Null && vehicleMap.containskey(documnet.Vehicle__c)){
                    if(vehicleMap.get(documnet.Vehicle__c).Vehicle_Documents__r.size()>0){
                        For(Vehicle_Documents__c doc:vehicleMap.get(documnet.Vehicle__c).Vehicle_Documents__r){
                            if(doc.RecordtypeId == documnet.Recordtypeid)
                                documnet.addError('You cannot create vehicle document again with same record type..');
                        }
                        //documnet.addError('You cannot create vehicledocument with same type.');
                    }
                    
                }
            }
        }
    }
}