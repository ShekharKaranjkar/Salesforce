public class leadopp {
   @AuraEnabled
public static void createRecord (String jsonOpportunity){
     system.debug('jsonOpportunity '+ jsonOpportunity);
      Map<String,String>stagenameMap = New Map<String,String>{'Open'=>'Completed' ,'M1: Solution Sent for Approval'=>'M2: Solution Approved Internally','M2: Solution Approved Internally'=>'M3: Client given appointment to present Solution	','M3: Client given appointment to present Solution'=>'M4: Customer in Principal agrees and request for quote','M4: Customer in Principal agrees and request for quote'=>'M5: Commercial proposal sent, Meeting Setup to present','M5: Commercial proposal sent, Meeting Setup to present'=>'M6: Customer agrees to commercial proposal. Ready to start contratual discussion',
             'M6: Customer agrees to commercial proposal. Ready to start contratual discussion' => 'W1: Customer wishes to negotiate','W1: Customer wishes to negotiate' => 'W2: All terms agreed , Customer has sent final agreed contract' ,'W2: All terms agreed , Customer has sent final agreed contract' => 'Rollout Plan','Rollout Plan' =>'Rollout Plan' };
    	Opportunity ld = (Opportunity) JSON.deserialize(jsonOpportunity, Opportunity.class);
   List<Task>taskList = [Select Id,Subject,Opp_Next_Step__c From Task where  Status !='Completed' AND Whatid=:ld.Id AND Opp_Next_Step__c=:ld.StageName Order By Opp_Next_Step__c];
    List<Task>taskList1 = [Select Id,Subject,Opp_Next_Step__c From Task where  Status !='Completed' AND Whatid=:ld.Id];
    Opportunity updatedopportunity = [Select id,StageName from Opportunity where Id=:ld.Id];
     if(taskList.size()==0 && ld.Question__c && updatedopportunity.StageName != ld.StageName){
    ld.StageName = ld.StageName;
       ld.Task_Stage__c = true;
       //leadopp.updateOpportunity(ld.Id);
        //ld.Task_Stage__c = false;
      // ld.Question__c = false;
      
   }
    else if(taskList1.size()==0)
       ld.Task_Stage__c = true;

    
    
    	system.debug('ld >> '+ ld);
    	update ld;
    }
 @AuraEnabled
     public static Opportunity getleadvalues(String id)
    {    
   Opportunity  reg=[select id,name,StageName,Question__c,Does_the_solution_saves_cost__c,Is_the_solution_operationally_viable__c,	
 
 Have_we_internally_reviewed_the_final__c,Does_the_solution_meet_the_client_object__c,
 Have_you_prepared_an_executive_summary__c,
 Have_you_taken_time_with_the_client__c,
 
 Are_all_stakeholder_from_clientavailable__c,
 Do_you_need_Ops_or_Leadership_to_be_part__c,
 Have_you_identified_influencers_for__c,
 
Do_you_know_the_client_current_cost__c,
 Are_you_aware_of_his_current_suppliers__c,
 Is_the_client_cost_sensitive__c,
 Has_the_client_made_aware_of_Fuel_price__c,
 
 Have_you_collected_market_intel_about__c,
 Does_Lithium_commercials_save_client_s__c,
 Have_we_created_Savings_glidepath__c,
 Are_all_the_inclusions_and_exclusions__c,
 
 Does_the_customer_wants_to_negotiate__c,
 Are_you_aware_of_client_s_commercial__c,	
 Have_you_discussed_the_key_contract_term__c,
 Do_we_have_room_to_negotiate_and_close__c,
 
 Have_we_aprised_client_of_lithium_s_valu__c,
 Have_all_internal_stakeholders_reviewd_t__c,
  Have_we_highligted_all_deviations_in_the__c,
 Has_the_client_set_expectations_on_timel__c,
 
 Have_we_signed_the_contract_document__c,
 Have_we_shared_deployment_plan_and_ramp__c,
 
 Is_every_internal_fuction_aware_of_their__c,
 Has_the_charging_infra_work_planned_for__c,
 Has_the_client_discussed_operational_dos__c,Approval_Status__c from Opportunity where id=:id];
        return reg;
    }
    @Future
    Public Static Void updateOpportunity(Id oppId){
        Opportunity o = New Opportunity();
        o.id= oppId;
        o.Task_Stage__c = false;
       o.Question__c = false;
        update o;
    }
}