@IsTest
public class ProjectTaskHandler_Test {
    static testMethod void getId() {
        MPM4_BASE__Milestone1_Program__c  program =new MPM4_BASE__Milestone1_Program__c ();
        program.Name = 'daze';
        insert program;
        MPM4_BASE__Milestone1_Project__c mpm4 = new MPM4_BASE__Milestone1_Project__c();
        mpm4.Name = 'Tstt';
        mpm4.MPM4_BASE__Program__c = program.id;
        //insert mpm4;
        system.debug('mpm4'+mpm4);
        Test.startTest();
        insert mpm4;
        
        //list<MPM4_BASE__Milestone1_Milestone__c> Mile = [Select Id,Name from MPM4_BASE__Milestone1_Milestone__c where MPM4_BASE__Project__c =:mpm4.Id];
        //ProjectTaskHandler taskhandler = New ProjectTaskHandler();
        //taskhandler.createTask(Mile);
        Test.stopTest();
    }
}