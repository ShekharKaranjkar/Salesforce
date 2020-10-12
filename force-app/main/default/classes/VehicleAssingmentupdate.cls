public class VehicleAssingmentupdate {
    public static void updateVehicleAndServiceProvider(List<Vehicle_Assignment__c> vaList){ 
        set<id>vehicleIds=new set<id>();
        set<id>serviceProviderIds=new set<id>();
        for(Vehicle_Assignment__c v:vaList){ // Iterating over account list.
            serviceProviderIds.add(v.Service_Provider__c);
            vehicleIds.add(v.Vehicle__c);
            
        }
        list<Vehicle__c>ve=[select id,Is_Available__c from Vehicle__c where id in:vehicleIds];
        list<Service_Provider__c>sp=[select id,Vehicle_Assigned_To__c from Service_Provider__c where id in:serviceProviderIds];

        for(Vehicle__c v:ve){
            v.Is_Available__c=true;
        }
        for(Service_Provider__c s:sp){
            s.Vehicle_Assigned_To__c=null;
        }
        update ve;
        update sp;
    }
}