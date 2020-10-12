trigger LocationDataTrigger on locationdata__c (Before Insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        Map<String,locationdata__c> driverMap = new Map<String,locationdata__c>();
        for(locationdata__c ld : Trigger.New){
            if(String.isNotBlank(ld.Vin_Number__c))
                driverMap.put(ld.Vin_Number__c, ld); 
        }
        if(driverMap.size() > 0){
            for(Vehicle__c car : [SELECT Id,Name,VIN_Number__c FROM Vehicle__c WHERE VIN_Number__c =: driverMap.KeySet()]){
                if(driverMap.containsKey(car.VIN_Number__c)){
                        driverMap.get(car.VIN_Number__c).VehicleId__c = car.Id;
                }
            }
            
        
        }
    } 
}