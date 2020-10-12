public class ChargeDataQueueable implements Queueable,Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        // Your processing logic here       
        HttpLocationChargeController.getChargeData();
        
        // Chain this job to next job by submitting the next job
        DateTime dt = System.now().addMinutes(2);
        String day = string.valueOf(dt.day());
        String month = string.valueOf(dt.month());
        String hour = string.valueOf(dt.hour());
        String minute = string.valueOf(dt.minute());
        String second = string.valueOf(dt.second());
        String year = string.valueOf(dt.year());
        
        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        System.schedule('HttpLocationCharge Job'+system.now(), strSchedule, new ScheduleHttpLocationCharge());
        
    }
}