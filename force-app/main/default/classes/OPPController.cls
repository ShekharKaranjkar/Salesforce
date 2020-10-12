public class OPPController {
    
     @AuraEnabled
    public static Opportunity getoppvalues(String id)
    {    
        
        Opportunity  reg=[select id,Overall_Transportation_Cost__c,Occupancy_Increase__c,Diesel_abatement_cost_anually__c,Co2e_footprint_abatement_MT_annually__c,Fleet_Size_Reduction__c from Opportunity where id=:id];

       system.debug('FROM APEX'+reg);
       // insert reg;
        //update reg;
        return reg;
        
   } 


}