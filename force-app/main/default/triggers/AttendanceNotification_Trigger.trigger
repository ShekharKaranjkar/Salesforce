/* To Create Notifications Records once City Head /Cluster Head is Approved or Rejected
*/
trigger AttendanceNotification_Trigger on Attendance__c (After Update) {
if(trigger.isAfter && trigger.isUpdate){
       
      AttendanceNotificationHelper.createNotification(trigger.New,trigger.oldmap);
    }
}