/*
* 'Campus Assigned Site Incharge' is only able To See this Records.
* They can able to 'Approve /Reject' Attendance Records,Which is assiged to him.
* */



public class AttendanceApprovalController {
    
    @AuraEnabled
    public static list < Attendance__c > fetchAttendance() {
        
        list <Attendance__c> returnAttList = new List <Attendance__c> ();
        
        List <Attendance__c> lstAtt = [SELECT id,Name,Service_Provider__c,Service_Provider__r.Lithium_ID__c,Status__c,
                                       Preview__c,Service_Provider__r.Site__r.Assinged_To__c,Service_Provider__r.Status__c,Service_Provider__r.Preview__c, 
                                       Service_Provider__r.Site__r.Site_Incharge__r.Name  , Service_Provider__r.Site__r.Site_Incharge__r.id,
                                       Lithium_ID__c,Login__c,Logout__c,Shift_Start__c,Shift_End__c  From Attendance__c Where Status__c !='Approved' 
                                       AND Status__c!='Rejected' AND CreatedDate = Today AND Service_Provider__r.Status__c='Active'];
        system.debug('lstAtt-----------------'+lstAtt);
        for (Attendance__c c: lstAtt) {
            if(c.Service_Provider__r.Site__r.Site_Incharge__r.id ==  UserInfo.getUserId()){
                returnAttList.add(c);
            }
        }
        
        return returnAttList;
    } 
    
    
    /* @AuraEnabled
public static boolean saveAttendance( List<Attendance__c> attendanceUpdateList){

system.debug('rosterUpdateList'+attendanceUpdateList);


if(attendanceUpdateList.size()>0){
update attendanceUpdateList;
}
return true;
}
*/
    @AuraEnabled
    public static boolean saveRecord(Attendance__c attendance ){
        system.debug('line35');
        id i=attendance.Id;
        Attendance__c a=      [SELECT id, Name, Service_Provider__c, Status__c    From Attendance__c where id=:i];
        a.Status__c='Approved';
        a.Approved_by__c = UserInfo.getUserId();
        system.debug('rosterUpdateList'+attendance);
        
        
        
        update a;
        
        return true;
    }
    @AuraEnabled
    public static boolean saverej(Attendance__c attendance ){
        system.debug('hiiiiiiiiiiiiiiiiii');
        id i=attendance.Id;
        Attendance__c a=      [SELECT id, Name, Service_Provider__c, Status__c    From Attendance__c where id=:i];
        a.Status__c='Rejected';
        a.Approved_by__c =UserInfo.getUserId();
        system.debug('rosterUpdateList'+attendance);
        
        
        
        update a;
        
        return true;
    }
    
}