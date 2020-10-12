trigger MISTrigger on MIS__c (before Insert,before Update) {
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        Map<String,List<MIS__c>> clientsMap = new Map<String,List<MIS__c>>();
        Map<String,List<MIS__c>> driversMap = new Map<String,List<MIS__c>>();
        Map<String,List<MIS__c>> vehiclesMap = new Map<String,List<MIS__c>>();
        Set<String> clientNameSet = new Set<String>();
        Set<String> clientFacilitySet = new Set<String>();
        for(MIS__c mis : trigger.new){
            if(String.isNotBlank(mis.DriverId__c)){
                List<MIS__c> driverLst = new List<MIS__c>(); 
                if(driversMap.containsKey(mis.DriverId__c)){
                   driverLst = driversMap.get(mis.DriverId__c); 
                }
                driverLst.add(mis);
                driversMap.put(mis.DriverId__c,driverLst);
            
            }
            if(String.isNotBlank(mis.VehicleNo__c)){
                List<MIS__c> vehicleLst = new List<MIS__c>(); 
                if(vehiclesMap.containsKey(mis.VehicleNo__c)){
                   vehicleLst = vehiclesMap.get(mis.VehicleNo__c); 
                }
                vehicleLst.add(mis);
                vehiclesMap.put(mis.VehicleNo__c,vehicleLst);
                
            }
            if(String.isNotBlank(mis.ClientName__c) && String.isNotBlank(mis.ClientFacility__c)){
                clientFacilitySet.add(mis.ClientFacility__c);
                clientNameSet.add(mis.ClientName__c);
                List<MIS__c> clientLst = new List<MIS__c>(); 
                if(clientsMap.containsKey(mis.ClientName__c + mis.ClientFacility__c)){
                   clientLst = clientsMap.get(mis.ClientName__c + mis.ClientFacility__c); 
                }
                clientLst.add(mis);
                clientsMap.put(mis.ClientName__c + mis.ClientFacility__c,clientLst);
            }
        
        }
        
        for(Account acc: [SELECT Id ,Name,(SELECT Id,Name FROM Sites__r WHERE Name IN:clientFacilitySet) 
                            FROM Account WHERE Name IN: clientNameSet]){
            
            for(Campus__c st : acc.Sites__r){
                for(MIS__c mis : clientsMap.get(acc.Name + st.Name)){
                        mis.Client__c = acc.Id;
                        mis.Campus__c = st.Id;
                }
            
            }
        }
        system.debug('vehiclesMap '+ vehiclesMap);
        for(Vehicle__c car: [SELECT Id,Name,VIN_Number__c FROM Vehicle__c WHERE Name IN: vehiclesMap.keySet()]){
            for(MIS__c mis : vehiclesMap.get(car.Name)){
                mis.Vehicle__c = car.Id; 
            }
        }
        for(Service_Provider__c driver: [SELECT Id,Name FROM Service_Provider__c WHERE Name IN: driversMap.keySet()]){
            for(MIS__c mis : driversMap.get(driver.Name)){
                mis.ServiceProvider__c= driver.Id; 
            }
        }
    }
}