trigger MomEmailTrigger on Event (after insert, after update) {
    //list<event> eventList = Trigger.New;
	MomEmailTriggerHandler.handleMethod(Trigger.New);
    For(Event e:Trigger.New){
        System.debug('e.WhoId:'+e.WhoId);
    }
}