public class LeadController{
    
@AuraEnabled
public static void createRecord (String jsonLead){
      	system.debug('jsonLead '+ jsonLead);
    	Lead ld = (Lead) JSON.deserialize(jsonLead, Lead.class);
    	system.debug('ld >> '+ ld);
    
    	update ld;
    	system.debug('ld >> '+ ld.id);
    
       

    } 

     @AuraEnabled
    public static Lead getleadvalues(String id)
    {    
        // Initialize setup variables
        String objectName = 'Lead';  // modify as needed
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        
        // Grab the fields from the describe method and append them to the queryString one by one.
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ', ';
        }
        query = query.removeEnd(', ');
        query += ' FROM Lead where id=:id';
        system.debug('query' + query);
        /*Lead  reg=[select id,name,What_are_the_Locations_for_transport_ser__c,How_many_number_of_shifts__c,What_are_the_Shift_Durations__c,What_are_the_no_of_Operational_Days__c,What_is_the_load_distribution__c,How_many_of_your_Employees_use_transport__c,What_are_the_typical_Trip_Distances__c,
                  How_many_total_trips_routes_are_deployed__c,What_of_Female_Emp_use_transportation__c,How_many_Escort_Trips_deployed_per_day__c,Are_the_Escort_Trips_treated_as_1_Trip__c,Are_Back_to_Back_Trips_treated_as_1Trip__c,What_are_current_Internal_trans_systems__c,
                  Can_we_put_charging_stations_in_Parking__c,What_are_your_Electricity_Rates__c,Trip_Length_Profile_one_way_distance__c,What_are_your_Occupancies_for_vehicles__c, Company,
                   Overall_Transportation_Cost__c,Occupancy_Increase__c,Diesel_abatement_cost_anually__c,Co2e_footprint_abatement_MT_annually__c,Fleet_Size_Reduction__c,Number_of_Cars_used__c,No_of_Trips_per_Day__c,Avg_Km_per_Car_per_month__c from Lead where id=:id];
		
       system.debug('FROM APEX'+reg);
       // insert reg;
        //update reg;*/
        return Database.query(query);
        
   } 
 
}