public class UpdateOpportunityHandler {
     Public Static Boolean IsRecurssive = True;
    public static void isStatusChecked(List<Opportunity> OpportunityLst,Map<Id,Opportunity> oldOpportunityMap,Boolean IsRecurrsive){
        system.debug('Step 13 isStatusChecked');
       if(IsRecurrsive){
        Map<String,String> stageMap = 
            new Map<String,String>{
                'M1: Solution Sent for Approval'=>'M2: Solution Approved Internally' ,
                    'M2: Solution Approved Internally'=>'M3: Client given appointment to present Solution' ,
                    'M3: Client given appointment to present Solution'=>'M4: Customer in Principal agrees and request for quote',
                    'M4: Customer in Principal agrees and request for quote'=>'M5: Commercial proposal sent, Meeting Setup to present',
                    'M5: Commercial proposal sent, Meeting Setup to present'=>'M6: Customer agrees to commercial proposal. Ready to start contratual discussion',
                    'M6: Customer agrees to commercial proposal. Ready to start contratual discussion' => 'W1: Customer wishes to negotiate',
                    'W1: Customer wishes to negotiate' => 'W2: All terms agreed , Customer has sent final agreed contract' ,
                    'W2: All terms agreed , Customer has sent final agreed contract' => 'Rollout Plan	',
                    'Rollout Plan' =>'Rollout Plan'
                    };   
        for(Opportunity opp : Opportunitylst){
            System.debug('opp.StageName'+opp.StageName);
            System.debug('opp.Question__c'+opp.Question__c);
            System.debug('opp.Task_Stage__c'+opp.Task_Stage__c);
            if(opp.RecordType_Name__c == 'Pilot')
                continue;
            if((opp.StageName == 'M1: Solution Sent for Approval' || opp.StageName == 'M2: Solution Approved Internally' || opp.StageName == 'M3: Client given appointment to present Solution' || opp.StageName == 'M4: Customer in Principal agrees and request for quote' || opp.StageName == 'M5: Commercial proposal sent, Meeting Setup to present' || opp.StageName ==  'M6: Customer agrees to commercial proposal. Ready to start contratual discussion' || opp.StageName ==  'W1: Customer wishes to negotiate' || opp.StageName ==  'W2: All terms agreed , Customer has sent final agreed contract' || opp.StageName == 'Rollout Plan')  && opp.Question__c && opp.Task_Stage__c){
                   opp.StageName=stageMap.get(opp.StageName);
                   opp.Task_Stage__c = false;
                   opp.Question__c = false;
               } 
            else if(opp.StageName != oldOpportunityMap.get(opp.Id).StageName) 
                opp.addError('please fill all questionnaire and complete the tasks');
        }
           
           UpdateOpportunityHandler.IsRecurssive = False;
       }
    }
}