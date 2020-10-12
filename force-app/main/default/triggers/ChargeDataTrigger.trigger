trigger ChargeDataTrigger on chargedata__c (Before Insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        Map<String,chargedata__c > chargeMap = new Map<String,chargedata__c>();
        for(chargedata__c ld : Trigger.New){
            if(String.isNotBlank(ld.Vin_Number__c))
                chargeMap.put(ld.Vin_Number__c, ld);
        }
        if(chargeMap.size() > 0){
            for(Vehicle__c car : [SELECT Id,Name,Vin_Number__c FROM Vehicle__c WHERE VIN_Number__c =: chargeMap.KeySet()]){
                if(chargeMap.containsKey(car.Vin_Number__c)){
                        chargeMap.get(car.Vin_Number__c).VehicleId__c = car.Id;
                }
            }
            
        
        }
    } 
}