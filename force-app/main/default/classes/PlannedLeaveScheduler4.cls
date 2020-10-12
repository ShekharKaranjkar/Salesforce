global class PlannedLeaveScheduler4 implements Schedulable {
    global void execute(SchedulableContext sc) {
        
        Datetime sysTime = System.now();
        
        // this would increase the time to 1 hour after current time
        sysTime = sysTime.addHours(1);
        
        String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        
        
        //Schedule the next job, and give it the system time so name is unique
        System.schedule('New Schedule' + sysTime.getTime(),chron_exp, new PlannedLeaveScheduler4());
        
        
        PlannedLeaveApprovalBtch leave = new PlannedLeaveApprovalBtch(); 
        database.executebatch(leave);
    }
}