public class TimeFormat {
    public static string timeFormat(time StartTime){
        Integer StartTimeTemp = StartTime.hour();
        string AmOrPm;
        if(integer.valueOf(StartTimeTemp) >= 12){
            AmOrPm='PM';
        }else{
            AmOrPm='AM';
        }
        StartTimeTemp=math.mod(StartTimeTemp,12);
        if(math.mod(StartTimeTemp,12)==0){
            StartTimeTemp=12;
        }
        string s= StartTimeTemp +':' + StartTime.minute() + AmOrPm;
        return s;
    }        
}