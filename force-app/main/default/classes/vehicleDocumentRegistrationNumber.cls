public class vehicleDocumentRegistrationNumber {
    public static void copyFromVehicle(list<Vehicle_Documents__c>vList){
          system.debug('vlist'+vList);
        id vehicleId;
        string vehicleRegistrationName;
        set<id> vehicleIds=new set<id>();
        for(Vehicle_Documents__c v:vList){
            vehicleIds.add(v.Vehicle__c);  
        }
        list<vehicle__c> v=[select id ,Vehicle_Registration_Number__c from vehicle__c where id in: vehicleIds];
      string nameofvehicle=  v[0].Vehicle_Registration_Number__c;
              for(Vehicle_Documents__c ve:vList){
    
   //        ve.RegistrationNumber__c=nameofvehicle;
                   system.debug('vlist'+   ve.Name);
            
        }
        system.debug('vlist'+vList);
      //  insert vList;
    }
}