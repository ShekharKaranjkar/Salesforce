/*
 * Service Provider can able to see their Attendance History Records for '30 Days'..
 * */


public without sharing class AttendanceHistoryController {
    @AuraEnabled
    public List<Attendance__c> leave30List = new List<Attendance__c>();
    
    @AuraEnabled 
    public static AttendanceHistoryController attendanceHistoryMethod(){
        AttendanceHistoryController userAttendance = new AttendanceHistoryController();
        
        list<Service_Provider__c> servList = new list<Service_Provider__c>();
        if(userinfo.getUserType() != 'Standard'){
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            servList = [Select Id,Name,Lithium_ID__c from Service_Provider__c where id =:provider.Service_Provider__c AND  Status__c ='Active' Order By Createddate desc Limit 1 ];
            // if(VehicleAssignmentList.isempty())
            system.debug('servList12'+servList);
        }
        else
            servList = [Select Id,Name,Lithium_ID__c,Status__c from Service_Provider__c where Status__c='Active' Order By Createddate desc Limit 1 ];
        system.debug('servList'+servList);
        
        list<Attendance__c> attenList =[Select Id,Name,CreatedDate,Login__c,Status__c,Lithium_ID__c,Service_Provider__c,Logout__c from Attendance__c where Service_Provider__c =: servList[0].id];
        system.debug('attenList'+attenList);
        Date currentMonth = system.today();
        system.debug('currentMonth'+currentMonth);
        Date startDate = Date.valueOf(currentMonth);
        Date dueDate ;
        for(Attendance__c lv :attenList){
            
            dueDate = Date.valueOf(lv.Login__c);
        }
        
        system.debug('dueDate'+dueDate);
        if(dueDate != null){
            Integer numberDaysDue = dueDate.daysBetween(startDate);
            system.debug('numberDaysDue'+numberDaysDue);
            if(numberDaysDue <= 30){
                Date newDate = startDate.addDays(-30);
                system.debug('newDate'+newDate);
                //leave30List = new list<Attendance__c>();
                userAttendance.leave30List =[Select Id,Name,Status__c,CreatedDate,Login__c,Lithium_ID__c,Service_Provider__c,Logout__c from Attendance__c where Service_Provider__c =:servList[0].id and Login__c >=:newDate Order By Createddate desc];
                system.debug('leave30List'+userAttendance.leave30List);
            }
            
        }
        
        return userAttendance;
        
    }
    
}