trigger ProjectTask on MPM4_BASE__Milestone1_Milestone__c (after insert) {
ProjectTaskHandler Project = New ProjectTaskHandler();
    Project.createTask(Trigger.new);
}