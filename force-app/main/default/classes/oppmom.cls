public class oppmom {
    @AuraEnabled
public static void createRecord (String jsonLead){
        system.debug('jsonLead '+ jsonLead);
                Map<String,String>stagenameMap1 = New Map<String,String>{'Open'=>'Completed','C1: New'=>'C2: Working - Not Contacted','C2: Working - Not Contacted'=>'C3: Working - Contacted','C3: Working - Contacted'=>'U1: First Meeting Done','U1: First Meeting Done'=>'U2: Info Exchanged','U2: Info Exchanged'=>'U3: All Stakeholders Met','U3: All Stakeholders Met' => 'U4: Customer Confirms Need or Sends RFP1','U4: Customer Confirms Need or Sends RFP1'=>'U4: Customer Confirms Need or Sends RFP1'};
        Lead ld = (Lead) JSON.deserialize(jsonLead, Lead.class);
       List<Task> taskList = [Select Id,Subject,Opp_Next_Step__c,Lead_Next_Step__c From Task where Status !='Completed' AND Lead_Next_Step__c=:ld.Status AND Whoid=:ld.Id ];
       //system.debug('taskList ' + taskList);
       Lead updatedLead = [SELECT Id,Task_Stage__c,Status FROM Lead WHERE Id =: ld.Id];
       //system.debug('Opp_Next_Step__c ' + taskList);
        if(taskList.size()==0 && ld.Question__c && updatedLead.Status != ld.Status){
           ld.Status = ld.Status;
           ld.Task_Stage__c = true;
        }
        update ld;
        
     //if((taskList.size()==0 || ld.Task_Stage__c) && ld.Question__c){
      // ld.Status = stagenameMap1.get(ld.Status);
        //ld.Task_Stage__c = true;
       // oppmom.updateLead(ld.Id);
      //  ld.Task_Stage__c = false;
      //  ld.Question__c = false;
  //  }
        system.debug('ld >> '+ ld);
       
    } 
 @AuraEnabled
     public static Lead getleadvalues(String id)
    {    
        Lead  reg=[select id,name,Status,Question__c,Is_Highly_Qualified__c,Have_you_met_boss_of_the_contact__c,Roster_Data_Parameters_checked__c,Have_you_identified_EV_initiative_key_dr__c,
             Have_you_mapped_decision_making_hierarch__c,Have_you_met_atleast_2_and_taken_their_c__c,Is_everyone_aligned_on_the_objective_of__c,
                   Are_they_key_decision_makers__c,Has_the_client_requested_for_a_solution__c,Has_client_identified_timelines_for_the__c,Have_you_received_all_operational_info__c,Have_you_identified_the_procurement_proc__c,If_RFP_has_he_confirmed_to_invite__c,What_are_the_Locations_for_transport_ser__c ,
What_are_the_Shift_Durations__c ,
No_of_Trips_per_Day__c,
What_are_the_no_of_Operational_Days__c,
How_many_number_of_shifts__c,
What_is_the_load_distribution_on_Saturda__c,
What_is_the_load_distribution_on_Sunday__c,
Are_the_Escort_Trips_treated_as_1_Trip__c,
Are_Back_to_Back_Trips_treated_as_1Trip__c,
What_are_current_Internal_trans_systems__c,
                   Can_we_put_charging_stations_in_Parking__c
                    from Lead where id=:id];
        return reg;
    }   
    @Future
    Public Static Void updateLead(Id lId){
        Lead l = New Lead();
        l.id= lId;
        l.Task_Stage__c = false;
       l.Question__c = false;
        update l;
    }
}