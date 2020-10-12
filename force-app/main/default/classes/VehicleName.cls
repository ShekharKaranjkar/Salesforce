public class VehicleName {
    public static void notSame(list<vehicle__c>vList){
        system.debug('vList'+vList);
        for(vehicle__c v: vList){
            v.name=v.Vehicle_Registration_Number__c;
        }
    }
}