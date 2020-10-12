trigger ContractAutopopulateCostsRisksMatrix on Costs_Risk_Matrix__c (before insert) {
if(trigger.isbefore && trigger.isinsert){
         ContractAutoPopulateCRMhelper.crmlists(Trigger.New);
    }
}