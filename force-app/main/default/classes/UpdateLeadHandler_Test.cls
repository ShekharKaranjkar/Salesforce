@isTest
public class UpdateLeadHandler_Test {
    static testmethod void isStatusChecked(){
         //     map<Id,Lead> leadmap = new map<Id,Lead>();
    //    leamap.put(leadLst.id, leadLst);
       // list<Lead> leadLst = new list<Lead>([select id,name from Lead]);
      /// system.debug('Status'+Status);
          Lead leadObj = new Lead(Lastname='TEST_LEAD',Company='ABCDEFG',LeadSource = 'Events',Status='C1: New',Task_Stage__c = true,Question__c = true);
     //   leadLst.add(leadObj);
     insert leadobj;
     
     //   insert leadLst;
        
       system.debug('leadLst'+leadobj);
      List<Task>taskList = [Select Id,Status from Task where WhoId=:leadobj.id];
        For(task t:taskList){
            t.Status = 'Completed';
        }
        update taskList; 
        
   //     map<Id,Lead> leadmap = new map<Id,Lead>();
    //   leadmap.put(leadLst.Id, leadLst);
     //  Lead lea = [select id,name from Lead where Status =: 'C1: New'];
        Test.startTest();
       UpdateLeadHandler handler = new UpdateLeadHandler();
        leadobj.Status = 'C2: Working - Not Contacted';
         leadobj.Task_Stage__c = true;
        update leadobj;
         
        leadobj.Status = 'C3: Working - Contacted';
        leadobj.Task_Stage__c = true;
        update leadobj;
        leadobj.Status = 'U1: First Meeting Done';
        leadobj.Task_Stage__c = false;
         update leadobj;
       // UpdateLeadHandler.isStatusChecked(leadLst, leadmap);
        Test.stopTest();

    }
    

}