public without sharing class LeaveHistoryController {
    @AuraEnabled
    public List<Leave__c> leave30List = new List<Leave__c>();
    @AuraEnabled
    public List<Leave__c> leave60List = new List<Leave__c>();
    @AuraEnabled
    public List<Leave__c> leave90List = new List<Leave__c>();
    
    @AuraEnabled 
    
    public static LeaveHistoryController LeaveHistoryMethod(){
        LeaveHistoryController userLeaves = new LeaveHistoryController();
        Id cUser =  UserInfo.getUserId();
        
        
         list<Service_Provider__c> servList = new list<Service_Provider__c>();
        if(userinfo.getUserType() != 'Standard'){
            Contact provider = [Select Id,Service_Provider__c from Contact where Id=:[Select id,contactid from user where id=:userinfo.getUserId()].ContactID];
            servList = [Select Id,Name,Lithium_ID__c from Service_Provider__c where id =:provider.Service_Provider__c and Status__c ='Active' Order By Createddate desc Limit 1];
            // if(VehicleAssignmentList.isempty())
            system.debug('servList12'+servList);
        }
        else
            servList = [Select Id,Name,Lithium_ID__c from Service_Provider__c where Status__c ='Active'  Order By Createddate desc Limit 1];
        system.debug('servList'+servList);
        list<Leave__c> leaveList =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c from Leave__c where Service_Provider__c =:servList[0].id];
        system.debug('leaveList'+leaveList);
        Date currentMonth = system.today();
        system.debug('currentMonth'+currentMonth);
        Date startDate = Date.valueOf(currentMonth);
        if(leaveList != null && !leaveList.isEmpty()){
            Date dueDate; 
            for(Leave__c lv: leaveList){
                
                dueDate= Date.valueOf(lv.From_date__c);
            }
         
        system.debug('dueDate'+dueDate);
        if(dueDate != null){
            Integer numberDaysDue = dueDate.daysBetween(startDate);
            system.debug('numberDaysDue'+numberDaysDue);
            if(numberDaysDue <= 30){
                Date newDate = startDate.addDays(-30);
                system.debug('newDate'+newDate);
                //leave30List = new list<Leave__c>();
                userLeaves.leave30List =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c,RecordType.Name,Emergency_Leave_Approval__c  from Leave__c where Service_Provider__c =:servList[0].id and From_date__c >=:newDate Order By Createddate desc];
                system.debug('leave30List'+userLeaves.leave30List);
            }
            if(numberDaysDue <= 60 || numberDaysDue > 30){
                
                Date new60Date = startDate.addDays(-60);
                system.debug('new60Date'+new60Date);
                //leave60List = new list<Leave__c>();
                userLeaves.leave60List =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c,RecordType.Name,Emergency_Leave_Approval__c  from Leave__c where Service_Provider__c =:servList[0].id and From_date__c >=:new60Date Order By Createddate desc];
                system.debug('leave60List'+userLeaves.leave60List);
            }
            if(numberDaysDue <= 90 || numberDaysDue > 60){
                Date new90Date = startDate.addDays(-90);
                system.debug('new90Date'+new90Date);
               // leave90List = new list<Leave__c>();
                userLeaves.leave90List =[Select Id,Name,Approval_Request__c,From_date__c,CreatedDate,Service_Provider__c,To_date__c,RecordType.Name,Emergency_Leave_Approval__c  from Leave__c where Service_Provider__c =:servList[0].id and From_date__c >=:new90Date Order By Createddate desc];
                system.debug('leave60List'+userLeaves.leave90List);
            }
            
            
        }
        }
        
        return userLeaves;
        
    }
   
}