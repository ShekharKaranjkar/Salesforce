public class MapMarkerController {
    public String oppId{get;set;}
    public MapMarkerController(ApexPages.StandardController controller) {
      oppId = controller.getId();
        system.debug(oppId);
      //System.debug(LoggingLevel.INFO, PracticeImpactId);
   }
    public MapMarkerController() {
   }
    public List<Universe_Input__c> getUniverseInputs(){
        return [SELECT Id,Name,First_Point_Pickup_Location_Geo_Code__Latitude__s,
                First_Point_Pickup_Location_Geo_Code__Longitude__s FROM Universe_Input__c 
                WHERE Opportunity__c =: oppId];
    }
    public List<Final_EV_Input__c> getFinalEVInputs(){
        return [SELECT Id,Name,First_Point_Pickup_Location_Geo_Code__Latitude__s,
                First_Point_Pickup_Location_Geo_Code__Longitude__s FROM Final_EV_Input__c 
                WHERE Opportunity__c =: oppId];
    }
}