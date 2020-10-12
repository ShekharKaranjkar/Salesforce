public class checkPDIChecklistinVehicleHelper {
    public static void  checklist(Map<id,Vehicle__c> oldvehicleMap,Map<id,Vehicle__c> newvehiclemap){
        Map<Id,Vehicle__c>vehicleMap = New Map<Id,Vehicle__c>([Select id,Task_Stage__c,All_Vehicle_Documents_Received__C,IS_PDI_FILLED__c,Is_Accessories_filled__c,
                                                               (select id from Insurances__r limit 1)
                                                               from Vehicle__c Where id=: newvehiclemap.Keyset()]);
        for(Vehicle__c record:newvehiclemap.values()){
            system.debug('#######'+record.Status1__c);
            system.debug('@@@@@@@@'+oldvehicleMap.get(record.id).IS_PDI_FILLED__c);
            if(record.Status1__c != oldvehicleMap.get(record.id).Status1__c && record.Status1__c == 'Onroad' && vehicleMap.containsKey(record.id) &&  vehicleMap.get(record.id).IS_PDI_FILLED__c!= true)
                record.addError('Please fill the PDI form before moving to Onroard');
            if(record.Status1__c != oldvehicleMap.get(record.id).Status1__c && record.Status1__c == 'Onroad' && vehicleMap.containsKey(record.id) && vehicleMap.get(record.id).Task_Stage__c != true)
                record.addError('Please complete Task before moving to Onroad');  
            if(record.Status1__c != oldvehicleMap.get(record.id).Status1__c && record.Status1__c == 'Onroad' && vehicleMap.containsKey(record.id) && vehicleMap.get(record.id).All_Vehicle_Documents_Received__C != true)
                record.addError('Please fill the related documents FC,Permit,RC and Taxes before moving to onroad');
            if(record.Status1__c != oldvehicleMap.get(record.id).Status1__c && record.Status1__c == 'Onroad' && vehicleMap.containsKey(record.id) && vehicleMap.get(record.id).Is_Accessories_filled__c != true)
                record.addError('Please fill the Accessories form before moving to Onroad');
            if(record.Status1__c != oldvehicleMap.get(record.id).Status1__c && record.Status1__c == 'Onroad' && vehicleMap.containsKey(record.id) && vehicleMap.get(record.id).Insurances__r.IsEmpty())
                record.addError('Please fill the Insurance form before moving to Onroad');
            
        }
    }
}