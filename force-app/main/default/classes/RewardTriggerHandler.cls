/* To calculate all the fields of reward related (Service Provider)
* Based on Attendance, Penalty, Mis, Roster,Driver Recovery objects
*/
public class RewardTriggerHandler {
    public static void calculateDistanceAndTrip(list<Reward__c> rList){
        set<Id> srvicProId=new set<Id>();
        set<String> weekOffDays=new set<String>();
        Map<string, list<MIS__c>> misMap = new Map<string, list<MIS__c>>();
        Map<Id, list<Attendance__c>> srvcProAttenMap = new Map<Id, list<Attendance__c>>();
        Map<Id, list<Rostering__c>> srvcProRostrMap = new Map<Id, list<Rostering__c>>();
        Map<Id, list<Rostering__c>> rosterMap = new Map<Id, list<Rostering__c>>();        
        Map<Id, list<Driver_Recovery__c>> drivrRecvryMap = new Map<Id, list<Driver_Recovery__c>>();
        Map<Id, Integer> atteMap = new Map<Id, Integer>();
        Map<Id, Integer> penaltyMap = new Map<Id, Integer>();
        Map<Id, AttendanceDaysWrapperClass> srvcProAttenCountMap = new Map<Id, AttendanceDaysWrapperClass>();
        Map<Id, Service_Provider__c> servcProviderIdMap = new Map<Id, Service_Provider__c>();
        try{
            for(Reward__c r:rList){
                srvicProId.add(r.Service_Provider__c);
            }
            //   system.debug('srvicProId-----------------'+srvicProId);
            
            for(Service_Provider__c s:[Select id,Site__c, City__c from Service_Provider__c where id In:srvicProId]){
                servcProviderIdMap.put(s.Id,s);
            }
            for(Attendance__c a:[Select id,Service_Provider__c, Login__c, Logout__c from Attendance__c 
                                 where 
                                 Service_Provider__c in:srvicProId And   Service_Provider__r.Status__c ='Active' AND  Login__c = LAST_N_DAYS:30 ])
            {
                if(!srvcProAttenMap.containskey(a.Service_Provider__c)){
                    srvcProAttenMap.put(a.Service_Provider__c,new list<Attendance__c>());
                }
                srvcProAttenMap.get(a.Service_Provider__c).add(a);
                
            }
            system.debug('srvcProAttenMap-----------------'+srvcProAttenMap);
            
            for(Rostering__c a:[Select id,Shift_Start_Date__c, Shift_End_Date__c, Start_Time__c, End_Time__c,
                                Sunday__c, Monday__c, Tuesday__c, Thrusday__c, Wednesday__c, Friday__c, Saturday__c,  
                                RecordType.Name, Lithium_ID__c 
                                from Rostering__c  
                                where  Lithium_ID__c in:srvicProId  And Status__c='Approved' And   Lithium_ID__r.Status__c ='Active'    ])
            {
                if(!srvcProRostrMap.containskey(a.Lithium_ID__c)){
                    srvcProRostrMap.put(a.Lithium_ID__c,new list<Rostering__c>());
                }
                srvcProRostrMap.get(a.Lithium_ID__c).add(a);
            }
            
            for(Driver_Recovery__c dr:[Select id,Service_Provider__c from Driver_Recovery__c 
                                       where 
                                       Service_Provider__c in:srvicProId and Service_Provider__r.Status__c ='Active' AND CreatedDate= LAST_N_DAYS:30])
            {
                if(!drivrRecvryMap.containskey(dr.Service_Provider__c)){
                    drivrRecvryMap.put(dr.Service_Provider__c,new list<Driver_Recovery__c>());
                }
                drivrRecvryMap.get(dr.Service_Provider__c).add(dr);
            }
            //   system.debug('srvcProAttenMap-----------------'+srvcProAttenMap);
            
            if(srvicProId !=null){
                for(Rostering__c r:[Select id,Shift_Start_Date__c, Shift_End_Date__c, Start_Time__c, End_Time__c,
                                    Sunday__c, Monday__c, Tuesday__c, Thrusday__c, Wednesday__c, Friday__c, Saturday__c,  
                                    RecordType.Name, Lithium_ID__c 
                                    from Rostering__c  
                                    where  Lithium_ID__c in:srvicProId  And Status__c='Approved' And   Lithium_ID__r.Status__c ='Active' ])
                { 
                    weekOffDays=new set<String>();
                    if(srvcProAttenMap.size()>0){
                        //  system.debug('srvcProAttenMap=======srvcProAttenMap======'+srvcProAttenMap);
                        //  system.debug('r.Lithium_ID__c=======srvcProAttenMap======'+r.Lithium_ID__c);
                        if(srvcProAttenMap.get(r.Lithium_ID__c)!=null){
                            //   system.debug('r.Lithium_ID__c=======srvcProAttenMap======11111111111111111111'+r.Lithium_ID__c);
                            for(Attendance__c a:srvcProAttenMap.get(r.Lithium_ID__c))
                            {
                                
                                if(a.Login__c!=null && a.Logout__c!=null){
                                    system.debug('v============='+a);
                                    Date loginDate = Date.newinstance(a.Login__c.year(), a.Login__c.month(), a.Login__c.day());
                                    Date logoutDate = Date.newinstance(a.Logout__c.year(), a.Logout__c.month(), a.Logout__c.day());
                                    Time  endTime =Time.newInstance(a.Logout__c.hour(), a.Logout__c.minute(), a.Logout__c.second(), a.Logout__c.millisecond());
                                    Time  startTime =Time.newInstance(a.Login__c.hour(), a.Login__c.minute(), a.Login__c.second(), a.Login__c.millisecond());
                                    
                                    if(r.Sunday__c ){
                                        weekOffDays.add('Sunday');
                                    }
                                    if(r.Monday__c ){
                                        weekOffDays.add('Monday');
                                    }
                                    if(r.Tuesday__c ){
                                        weekOffDays.add('Tuesday');
                                    }
                                    if(r.Wednesday__c){
                                        weekOffDays.add('Wednesday');
                                    }
                                    if(r.Thrusday__c  ){
                                        weekOffDays.add('Thursday');
                                    }
                                    if(r.Friday__c){
                                        weekOffDays.add('Friday');
                                    }
                                    if(r.Saturday__c ){
                                        weekOffDays.add('Saturday');
                                    }
                                    String todayDay = a.Login__c.format('EEEE');  
                                    // todayDay != 'Saturday' && todayDay !='Sunday'&&
                                    //   system.debug('todayDay'+todayDay);
                                    if(r.Shift_Start_Date__c<=loginDate && logoutDate<=r.Shift_End_Date__c 
                                       && weekOffDays.contains(todayDay) )
                                    {
                                        if(srvcProAttenCountMap.containsKey(a.Service_Provider__c)){
                                            AttendanceDaysWrapperClass wrpObj=srvcProAttenCountMap.get(a.Service_Provider__c);
                                            wrpObj.present=srvcProAttenCountMap.get(a.Service_Provider__c).present +1;
                                            srvcProAttenCountMap.put(a.Service_Provider__c, wrpObj);
                                            system.debug('srvcProAttenCountMap--------IF---------'+srvcProAttenCountMap);
                                        }
                                        else{
                                            AttendanceDaysWrapperClass wrObj=new AttendanceDaysWrapperClass();
                                            wrObj.present=1;
                                            //wrObj.bench=0;
                                            srvcProAttenCountMap.put(a.Service_Provider__c, wrObj);
                                            system.debug('srvcProAttenCountMap----Else--------'+srvcProAttenCountMap);
                                        }
                                    }  
                                    // system.debug('startTime ----Else--------'+startTime );
                                    // system.debug('r.Start_Time__c.addMinutes(15)----Else--------'+r.Start_Time__c.addMinutes(15));
                                    //  system.debug('r.Start_Time__c.addMinutes(-3)----Else--------'+r.Start_Time__c.addHours(-1));
                                    //  system.debug('todayDay----Else--------'+todayDay);
                                    //   system.debug('r.Shift_Start_Date__c.addMinutes(15)----Else--------'+r.Shift_Start_Date__c);
                                    //  system.debug('r.Shift_End_Date__c----Else--------'+r.Shift_End_Date__c);
                                    //    system.debug('loginDate----Else--------'+loginDate);
                                    if(!(r.Start_Time__c.addMinutes(15)>=startTime && startTime>=r.Start_Time__c.addHours(-1))
                                       &&(r.Shift_Start_Date__c<=loginDate && logoutDate<=r.Shift_End_Date__c 
                                          && weekOffDays.contains(todayDay))
                                      ){
                                          system.debug('loginDate----Else--------'+loginDate);
                                          if(penaltyMap.containsKey(a.Service_Provider__c)){
                                              integer count=penaltyMap.get(a.Service_Provider__c) +1;
                                              penaltyMap.put(a.Service_Provider__c, count);
                                              system.debug('penaltyMap--------IF---------'+penaltyMap);
                                          }
                                          else{
                                              penaltyMap.put(a.Service_Provider__c, 1);
                                              system.debug('penaltyMap----Else--------'+penaltyMap);
                                          }
                                      }
                                } 
                                
                                
                                
                            }    
                            
                        }
                        
                    }
                }
            }
            
            
            system.debug('penaltyMap'+penaltyMap);
            
            
            for(MIS__c m:[SELECT  Id,VIN_Number__c,Distance__c ,
                          ServiceProvider__c,ShiftTime__c,Date__c
                          FROM MIS__c where  ServiceProvider__c in:srvicProId And   ServiceProvider__r.Status__c ='Active' and  CreatedDate = LAST_N_DAYS:30 ])
            {
                //misMap.put(m.VIN_Number__c,m);
                
                if(!misMap.containskey(m.VIN_Number__c)){
                    misMap.put(m.VIN_Number__c,new list<MIS__c>());
                }
                misMap.get(m.VIN_Number__c).add(m);
            }
            //    system.debug('misMap'+misMap);
            Map<ID, RewardWrapperClass> SrvcProTripCountMap = new Map<ID, RewardWrapperClass>();
            Map<ID, Decimal> SrvcProDistanceCountMap = new Map<ID, Decimal>();
            if(srvicProId !=null){
                for(Vehicle_Assignment__c  v:[select  Id,Service_Provider__c, Check_In_Time__c, Check_Out_Time__c, VIN_Number__c
                                              from Vehicle_Assignment__c  
                                              where Service_Provider__c in:srvicProId  And   Service_Provider__r.Status__c ='Active' and  Check_In_Time__c = LAST_N_DAYS:30])
                {   if(v!=null){
                    system.debug('v'+v);
                    if(v.Check_Out_Time__c!=null && v.Check_In_Time__c!=null ){
                        Date startDate = Date.newinstance(v.Check_Out_Time__c.year(), v.Check_Out_Time__c.month(), v.Check_Out_Time__c.day());
                        date endDate = Date.newinstance(v.Check_In_Time__c.year(), v.Check_In_Time__c.month(), v.Check_In_Time__c.day());
                        DateTime hrco=v.Check_Out_Time__c.addHours(1);
                        DateTime minco=v.Check_Out_Time__c.addMinutes(1); 
                        DateTime hrci=v.Check_In_Time__c.addHours(1);
                        DateTime minci=v.Check_In_Time__c.addMinutes(1); 
                        //  Time  endTime =Time.newInstance(hrco.hour(), minco.minute(), v.Check_Out_Time__c.second(), v.Check_Out_Time__c.millisecond());
                        //  Time  startTime =Time.newInstance(hrci.hour(), minci.minute(), v.Check_In_Time__c.second(), v.Check_In_Time__c.millisecond());
                        
                        Time  endTime =Time.newInstance(v.Check_Out_Time__c.hour(), v.Check_Out_Time__c.minute(), v.Check_Out_Time__c.second(), v.Check_Out_Time__c.millisecond());
                        Time  startTime =Time.newInstance(v.Check_In_Time__c.hour(), v.Check_In_Time__c.minute(), v.Check_In_Time__c.second(), v.Check_In_Time__c.millisecond());
                        if(misMap.containsKey(v.VIN_Number__c)){
                            for(MIS__c m:misMap.get(v.VIN_Number__c)){
                                //    system.debug('ifv'+v);
                                //     system.debug('m'+m);
                                if(m!=null){
                                    string shifTimeString=m.ShiftTime__c;
                                    if(string.isNotBlank(shifTimeString)){
                                        string[] shifTimeStringSplit=shifTimeString.split(':');
                                        time convertTime=Time.newInstance(integer.valueof(shifTimeStringSplit[0]), integer.valueof(shifTimeStringSplit[1]),0,0);
                                        
                                        //  system.debug('convertTime'+convertTime);
                                        //   system.debug('startTime'+startTime);
                                        //                                    system.debug('endTime'+endTime);
                                        
                                        if((m.Date__c==startDate && endDate== m.Date__c)&&(convertTime>=startTime && convertTime<=endTime))
                                        {
                                            
                                            if(SrvcProTripCountMap.containsKey(v.Service_Provider__c)){
                                                RewardWrapperClass rwdObj=SrvcProTripCountMap.get(v.Service_Provider__c);
                                                
                                                decimal dist = SrvcProTripCountMap.get(v.Service_Provider__c).distance;
                                                integer trpCount = SrvcProTripCountMap.get(v.Service_Provider__c).tripCount;
                                                rwdObj.distance=dist+m.Distance__c;
                                                rwdObj.tripCount=trpCount+1;
                                                SrvcProTripCountMap.put(v.Service_Provider__c, rwdObj);
                                                //  system.debug('SrvcProTripCountMap--------IF---------'+SrvcProTripCountMap);
                                                
                                            }
                                            else{
                                                RewardWrapperClass rwrdObj=new RewardWrapperClass();
                                                rwrdObj.distance=m.Distance__c;
                                                rwrdObj.tripCount=1;
                                                SrvcProTripCountMap.put(v.Service_Provider__c, rwrdObj);
                                                //    system.debug('SrvcProTripCountMap----Else--------'+SrvcProTripCountMap);
                                            }
                                        } 
                                    }
                                }
                            }
                        }
                    }
                    
                }
                }
            }
            
            for(Reward__c r:rList){
                r.Late_coming_days__c=0;
                if(SrvcProTripCountMap.get(r.Service_Provider__c)!=null){
                    r.No_of_trips_conducted__c=SrvcProTripCountMap.get(r.Service_Provider__c).tripCount;   
                }
                if(SrvcProTripCountMap.get(r.Service_Provider__c)!=null){
                    r.No_of_Kms_driven__c=SrvcProTripCountMap.get(r.Service_Provider__c).distance;
                }
                
                if(penaltyMap.get(r.Service_Provider__c)!=null){
                    r.Late_coming_days__c=penaltyMap.get(r.Service_Provider__c);
                }
                if(srvcProAttenCountMap.get(r.Service_Provider__c)!=null){
                    date myDate = date.today();
                    list<Attendance__c> aList= srvcProAttenMap.get(r.Service_Provider__c);
                    r.Bench_Days__c=aList.size() - srvcProAttenCountMap.get(r.Service_Provider__c).present;
                    //  system.debug('aList'+aList.size());
                    Integer month = myDate.month();
                    if(month==2){
                        r.Total_Attendance__c=(aList.size() )*4.1666666;
                    }else{
                        r.Total_Attendance__c=(aList.size())* 3.84615;
                    }
                    r.Present_Days__c=srvcProAttenCountMap.get(r.Service_Provider__c).present;
                    
                    
                    system.debug('present'+srvcProAttenCountMap.get(r.Service_Provider__c).present);
                }
                if(srvcProAttenCountMap.get(r.Service_Provider__c)==null){
                    date myDate = date.today();
                    list<Attendance__c> aList= srvcProAttenMap.get(r.Service_Provider__c);
                    r.Bench_Days__c=aList.size() ;
                    system.debug('aList'+aList.size());
                    Integer month = myDate.month();
                    if(month==2){
                        r.Total_Attendance__c=(aList.size() )*4.1666666;
                    }else{
                        r.Total_Attendance__c=(aList.size())* 3.84615;
                    }
                    r.Present_Days__c=srvcProAttenCountMap.get(r.Service_Provider__c).present;
                    
                    
                    system.debug('present'+srvcProAttenCountMap.get(r.Service_Provider__c).present);
                }
                if(drivrRecvryMap.get(r.Service_Provider__c)!=null){
                    list<Driver_Recovery__c>drList=drivrRecvryMap.get(r.Service_Provider__c);
                    r.Accident_recovery__c=String.valueOf(drList.size());
                }
                
            }
            
        }catch(exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='DriverMenuCtrl';
            debug.Method_Name__c='uploadfiles';
            debug.User_Id__c=String.valueof(userinfo.getUserId());
            debug.Error_Message__c=e.getMessage( ) + ' LINE_NUMBER : ' + e.getLineNumber( ) + 'STACKTRACE : ' + e.getStacktraceString( );
            //    debug.Stack_Trace__c = 'Vehicle Assignment Record Id :'+FirstPublishLocationId;
            insert debug;
            //  Return null;
        }
    }
    
    public class RewardWrapperClass{
        public Decimal distance {get;set;}
        public integer tripCount {get;set;}
        public  RewardWrapperClass(){
            distance=0;
            tripCount=0;
        }
    }
    public class AttendanceDaysWrapperClass{
        public integer present {get;set;}
        public integer bench {get;set;}
        public  AttendanceDaysWrapperClass(){
            present=0;
            bench=0;
        }
    }
}