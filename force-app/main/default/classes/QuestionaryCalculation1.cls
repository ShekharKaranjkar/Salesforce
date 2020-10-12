public class QuestionaryCalculation1 {

   
    @auraEnabled
    public static Lead getleadvalues(String id){
         Lead  reg=[select id,name,Overall_Transportation_Cost__c,
           Occupancy_Increase__c,Diesel_abatement_cost_anually__c,
            Fleet_Size_Reduction__c,Co2e_footprint_abatement_MT_annually__c from Lead where id=:id];
    return reg;
    }

}