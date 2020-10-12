public class conmom {
@AuraEnabled
public static void createRecord (String jsonContract){
      	system.debug('jsonContract '+ jsonContract);
    	Contract ld = (Contract) JSON.deserialize(jsonContract, Contract.class);
      List<Task>taskList = [Select Id,Subject,Opp_Next_Step__c From Task where  Status !='Completed' AND Whatid=:ld.Id AND Opp_Next_Step__c=:ld.Status Order By Opp_Next_Step__c];
 Contract updatedContract = [Select id,Status from Contract where Id=:ld.Id];
     if(taskList.size()==0 && ld.Question__c && updatedContract.Status != ld.Status){
    ld.Status = ld.Status;
       ld.Task_Stage__c = true;
   }
    	/*wrapperclass wp = new wrapperclass();
    wp = (wrapperclass) JSON.deserialize(jsonContract, wrapperclass.class);
   Contract contr = new Contract();
    contr.Id= wp.Id;
    contr.Question__c = wp.Question;
    contr.Status = wp.Status;
    contr.Has_the_KAM_and_ops_team_been_introduced__c = wp.Has_the_KAM_and_ops_team_been_introduced;
    contr.Is_the_marketing_team_preparing_for_laun__c = wp.Is_the_marketing_team_preparing_for_laun;
    contr.Have_all_drivers_cars_supervisors_been__c = wp.Have_all_drivers_cars_supervisors_been;
    contr.Are_any_CXOs_attending_EV_launch_at_clie__c = wp.Are_any_CXOs_attending_EV_launch_at_clie;
    contr.Have_we_understood_client_s_billing_and__c = wp.Have_we_understood_client_s_billing_and;*/
    system.debug('ld >> '+ ld);
    	update ld;

    } 
 @AuraEnabled
     public static Contract getleadvalues(String id)
    {    
        Contract  reg =[select id,name, Question__c,Status,Has_the_KAM_and_ops_team_been_introduced__c,Is_the_marketing_team_preparing_for_laun__c,
                        Have_we_understood_client_s_billing_and__c,Have_all_drivers_cars_supervisors_been__c,Are_any_CXOs_attending_EV_launch_at_clie__c from Contract where id=:id];
        return reg;
}
   /* public class wrapperclass {

	public String Id;
	public Boolean Question;
	public String Status;
	public String Has_the_KAM_and_ops_team_been_introduced;
	public String Is_the_marketing_team_preparing_for_laun;
	public String Have_all_drivers_cars_supervisors_been;
	public String  Are_any_CXOs_attending_EV_launch_at_clie;
        public String Have_we_understood_client_s_billing_and;

	
	/*public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}*/
//}
}