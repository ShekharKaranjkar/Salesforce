trigger OpportuniyModelChanges on Opportunity (after insert, after update) {
    if((Trigger.isInsert && Trigger.isAfter) ||((Trigger.isupdate && Trigger.isAfter) )){
        
        Oppchange.OppchangeMethod(Trigger.New);
    }
    
    
}