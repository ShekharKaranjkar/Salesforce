public class Momdetails {
  @AuraEnabled
    public static classeventwrapper  geteventvalues(String id,List<Task>task)
    {    
       Event  eventobj=[select id,Over__c,Meeting_Summary__c,Subject,
                        Vehicles__c,Drivers__c,Operations__c,New_Opportunities__c,Technology__c,Threats__c,whatId from Event  where id=:id];
       
List<classtaskwrapper> wrapperList = new List<classtaskwrapper>(); 
        Map<String,List<Task>>taskMap =New Map<String,List<Task>>();
        system.debug('id' + id);
        system.debug('Step 1'+[select id,Subject,Discussion_Points__c,Temperature__c,ActivityDate,Event_ID__c,Owner.Name,whatId FROM Task where Event_ID__c=:id]);
        For(Task Ta: [select id,Subject,Discussion_Points__c,Temperature__c,ActivityDate,Event_ID__c,Owner.Name FROM Task where Event_ID__c=:id ]){
           String sectionname ;
            if(Ta.Subject == 'Maintenance' || Ta.Subject == 'Cleanliness' || Ta.Subject == 'Missing Accessorries'|| Ta.Subject == 'Breakdowns' || Ta.Subject == 'Accidents'|| Ta.Subject == 'RCA' || Ta.Subject == 'Compliance' )
                sectionname = 'Vehicles';
            else if(Ta.Subject == 'Driver Behaviour' || Ta.Subject == 'Driver Grooming' || Ta.Subject == 'Driver Shortage')
                sectionname = 'Drivers';
            else if(Ta.Subject == 'Team Issues' || Ta.Subject == 'Ground Team Capacity'|| Ta.Subject == 'Timeliness')
                sectionname = 'Operations';
            else if(Ta.Subject == 'New Site' || Ta.Subject == 'New Location'|| Ta.Subject == 'Change in Shifts'|| Ta.Subject == 'Increase in Vehicles')
                sectionname = 'New Opportunities';
            else if(Ta.Subject == 'New Vendor' || Ta.Subject == 'New EV'|| Ta.Subject == 'Reduction in Employee Count'|| Ta.Subject == 'Reduction in Shifts'|| Ta.Subject == 'Reduction in no.of Cars')
                sectionname = 'Threats';
            else if( Ta.Subject == 'Current Technology Change'|| Ta.Subject == 'New Devices'|| Ta.Subject == 'Safety')
                sectionname = 'Technology';
            if(taskMap.containskey(sectionname)){
           List<Task>innerTaskList = New List<Task>();
                innerTaskList.addAll(taskMap.get(sectionname));
                innerTaskList.add(Ta);
                taskMap.put(sectionname,innerTaskList);
            }
            else{
                taskMap.put(sectionname,New List<Task>{Ta});
            }
            }
        
        For(String s:taskMap.keyset()){
              classtaskwrapper wrapper = new classtaskwrapper();
      wrapper.SectionName=s;
                wrapper.Tasks= taskMap.get(s);
            wrapperList.add(wrapper);
        }
        classeventwrapper eventwrap = new classeventwrapper();
        eventwrap.eventObj = eventobj;
        eventwrap.TaskList = wrapperList;
        return eventwrap;
    }

    public Class classtaskwrapper{
        @AuraEnabled
        Public String SectionName{Set;Get;}
        @AuraEnabled
        Public List<Task>Tasks{Set;Get;}
       
    }
    public Class classeventwrapper{
        @AuraEnabled
        Public Event eventObj{Set;Get;}
        @AuraEnabled
        Public List<classtaskwrapper>TaskList{Set;Get;}
       
    }
    @AuraEnabled
    public static void updateeventvalues(string jsonEvent){
    	Event eve = (Event) JSON.deserialize(jsonEvent, Event.class);
        update eve;
    }
}