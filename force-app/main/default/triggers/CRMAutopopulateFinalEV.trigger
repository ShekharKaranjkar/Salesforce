trigger CRMAutopopulateFinalEV on Final_EV_Input__c (before insert) {
    if(trigger.isbefore && trigger.isinsert){
        CRMAutoPopulateEVlisthelper.crmlists(Trigger.New);
    }
}