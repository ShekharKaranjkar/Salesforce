({
    doInit : function(component, event, helper) {
        helper.GetServiceProvider(component, event, helper);
    },
    
    goesBack : function(component, event, helper) {
        location.reload();
        
    },
    
    Save : function(component, event, helper) {
        var  Saveflag=component.get("v.Saveflag");
        console.log('save 1'+Saveflag);
        if(!Saveflag){
            console.log('serviceProviderList-child'+JSON.stringify(component.get("v.serviceProviderList")));
            var temp=component.get("v.serviceProviderList");
            var monthRecordTypeID=   component.get('v.monthRecordTypeID');
            var weekendRecordTypeID=   component.get('v.weekendRecordTypeID');
            var weekdayRecordTypeID=    component.get('v.weekdayRecordTypeID');
            var rosterInsertList =[]; 
            var rosterUpdateList =[];   
            var rosterInsertApprovedList =[]; 
            function checkDay( start,  endDate){
                var end = new Date(endDate); 
                const set1 = new Set();
                var loop = new Date(start);
                while(loop <= end){
                    var t=  loop.getDay();
                    set1.add(t);
                    var newDate = loop.setDate(loop.getDate() + 1);

                    loop = new Date(newDate);
                }
                return set1;
            }
            
            function dateconverterjs( ms ) {
                console.log('first'+ms);
                var dt = new Date(ms);
                dt.setDate( dt.getDate() - 1);
                
                var t=dt.getMonth();
                var Month;
                var date;
                var yr=dt.getYear() +1900;
                var mn=dt.getMonth()+1;
                var dat=dt.getDate();
                if(mn<10){
                    Month="0"+mn;
                }else{
                    Month=mn;
                }
                if(dat<10){
                    date="0"+dat;
                }else{
                    date=dat;
                }
                var fullDate=yr+"-"+Month+"-"+date;
                console.log('final'+fullDate);
                return fullDate;
                
            } 
            
            for(var i=0; i<temp.length; i++){
                if(temp[i].monthRost.Update ){
                    if(        
                        temp[i].monthRost.Shift_Start_Date__c !=null
                        && temp[i].monthRost.Shift_End_Date__c !=null
                        && temp[i].monthRost.End_Time__c  !=null
                        && temp[i].monthRost.Start_Time__c  !=null
                        
                    ){
                        temp[i].UpdateMonthly=true;
                    }else{
                        temp[i].UpdateMonthly=false; 
                    }
                }
                if(temp[i].weekendRost.Update ){
                    if(        
                        temp[i].weekendRost.Shift_Start_Date__c !=null
                        && temp[i].weekendRost.Shift_End_Date__c !=null
                        && temp[i].weekendRost.End_Time__c  !=null
                        && temp[i].weekendRost.Start_Time__c  !=null
                    ){
                        temp[i].UpdateWeekend=true;
                    }else{
                        temp[i].UpdateWeekend=false; 
                    }
                }
                if(temp[i].weekdayRost.Update ){
                    if(
                        temp[i].weekdayRost.Shift_Start_Date__c !=null
                        && temp[i].weekdayRost.Shift_End_Date__c !=null
                        && temp[i].weekdayRost.End_Time__c  !=null
                        && temp[i].weekdayRost.Start_Time__c  !=null
                    ){
                        temp[i].UpdateWeekDay=true;
                    }else{
                        temp[i].UpdateWeekDay=false;
                    }
                }
            }
            console.log('serviceProviderList-updatedfully'+JSON.stringify(temp));
            var monthflag=true;
            var weekdayflag=true;
            var weekendflag=true;
            var valmonth;
            var valweekend;
            var valweekday;
            var msgmonth;
            var msgweekend;
            var msgweekday;
            var countflag=true;
            var countmsg;
            var countofall=0
            for(var i=0; i<temp.length; i++){
                countofall=0;
                temp[i].count= 0;
                var countofleave=0;
                if( temp[i].monthRost.Sunday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Monday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Tuesday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Wednesday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Thrusday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Friday__c){
                    countofleave++;
                }
                if( temp[i].monthRost.Saturday__c){
                    countofleave++;
                }

                
                if(temp[i].UpdateMonthly){ 
                    temp[i].count= 1+temp[i].count;
                    console.log('temp[i].UpdateMonthly'+i);
                    console.log('temp[i].UpdateMonthly'+temp[i].UpdateMonthly);
                    if(temp[i].monthRost.Update){
                        if(    temp[i].UpdateMonthly
                           && temp[i].monthRost.weekOff 
                           && temp[i].monthRost.Shift_Start_Date__c 
                           && temp[i].monthRost.Shift_End_Date__c
                           && temp[i].monthRost.End_Time__c 
                           && temp[i].monthRost.Start_Time__c
                           && temp[i].monthRost.Shift_End_Date__c>temp[i].monthRost.Shift_Start_Date__c 
                           && temp[i].monthRost.End_Time__c>temp[i].monthRost.Start_Time__c
                           && (temp[i].monthRost.Shift__c=='Day' || temp[i].monthRost.Shift__c=='Night' ) 
                           && countofleave<=2
                          ){
                            monthflag=true;
                        }else{
                            if(countofleave>2){
                                monthflag=false;
                                valmonth=9;
                                msgmonth='You can not take Week Off for more then two days';
                            }
                            if(  !(temp[i].monthRost.Shift_End_Date__c>temp[i].monthRost.Shift_Start_Date__c) ){
                                monthflag=false;
                                valmonth=0;
                                msgmonth='End-Date should be greater then the Start-Date in Monthly Roster'
                            }
                            if(!temp[i].monthRost.Shift_Start_Date__c){
                                monthflag=false;
                                valmonth=1;
                                msgmonth='Start-Date Missing in Monthly Roster';
                            }
                            if(!temp[i].monthRost.Shift_End_Date__c){
                                monthflag=false;
                                valmonth=2;
                                msgmonth='End-Date Missing in Monthly Roster';
                            }
                            if(!temp[i].monthRost.Shift__c){
                                monthflag=false;
                                valmonth=3;
                                msgmonth='Shift Missing in Monthly Roster';
                            }
                            if(!temp[i].monthRost.weekOff){
                                monthflag=false;
                                valmonth=4;
                                msgmonth='WeekOff Missing in Monthly Roster';
                            }
                            if(!(temp[i].monthRost.Shift__c=='Day' || temp[i].monthRost.Shift__c=='Night' )){
                                monthflag=false;
                                valmonth=5;
                                msgmonth='Please select Shift in Monthly Roster';
                            }
                            if(  !(temp[i].monthRost.End_Time__c>temp[i].monthRost.Start_Time__c) ){
                                monthflag=false;
                                valmonth=6;
                                msgmonth='Shift End-Time should be greater then the Shift Start-Time in Monthly Roster';
                            }
                            if(  !(temp[i].monthRost.End_Time__c) ){
                                monthflag=false;
                                valmonth=7;
                                msgmonth='Shift End Time Missing in Monthly Roster';
                            }
                            if(  !(temp[i].monthRost.Start_Time__c )){
                                monthflag=false;
                                valmonth=8;
                                msgmonth='Shift Start Time Missing in Monthly Roster';
                            }
                            
                        }  
                    }
                    console.log('msgmonth'+msgmonth);
                    console.log('valmonth'+valmonth);
                    console.log('monthflag'+monthflag);}
                
                
                
                /* Weekend error handeling*/
                if(temp[i].UpdateWeekend){
                    
                    temp[i].count= 1+temp[i].count;
                    console.log('temp[i].UpdateWeekend'+i);
                    console.log('temp[i].UpdateWeekend'+temp[i].UpdateWeekend);
                    
                    if(temp[i].weekendRost.Update){
                        console.log('temp[i].weekendRost.Shift_End_Date__c>temp[i].monthRost.Shift_Start_Date__c'+temp[i].weekendRost.End_Time__c>temp[i].weekendRost.Start_Time__c);
                        if(      temp[i].UpdateWeekend 
                           &&   temp[i].weekendRost.Shift_Start_Date__c 
                           &&   temp[i].weekendRost.Shift_End_Date__c
                           &&   temp[i].weekendRost.End_Time__c 
                           &&   temp[i].weekendRost.Start_Time__c
                           &&   temp[i].weekendRost.Shift_End_Date__c>temp[i].weekendRost.Shift_Start_Date__c 
                           &&   temp[i].weekendRost.End_Time__c>temp[i].weekendRost.Start_Time__c 
                           &&   (temp[i].weekendRost.Shift__c=='Day' || temp[i].weekendRost.Shift__c=='Night' ) 
                           
                           
                          ){
                            
                            weekendflag=true;
                            
                        }else{
                            if(   !(temp[i].weekendRost.Shift_End_Date__c>temp[i].weekendRost.Shift_Start_Date__c)){
                                weekendflag=false;
                                valweekend=0;
                                msgweekend='End-Date should be greater then the Start-Date in Weekend Roster ';
                            }
                            if(!temp[i].weekendRost.Shift_Start_Date__c){
                                weekendflag=false;
                                valweekend=1;
                                msgweekend='Shift Start-Date Missing in Weekend Roster';
                            }
                            if(!temp[i].weekendRost.Shift_End_Date__c){
                                weekendflag=false;
                                valweekend=2;
                                msgweekend='Shift End-Date Missing in Weekend Roster';
                            }
                            if(!temp[i].weekendRost.Shift__c){
                                weekendflag=false;
                                valweekend=3;
                                msgweekend='Shift Missing in Weekend Roster';
                            }
                            if(!(temp[i].weekendRost.Shift__c=='Day' || temp[i].weekendRost.Shift__c=='Night' )){
                                weekendflag=false;
                                valweekend=4;
                                msgweekend='Please select Shift in Weekend Roster';
                            }                    
                            if(  !(temp[i].weekendRost.End_Time__c>temp[i].weekendRost.Start_Time__c) ){
                                weekendflag=false;
                                valweekend=5;
                                msgweekend='Shift End-Time should be greater then the Shift Start-Time in Weekend Roster';
                            }
                            if(  !(temp[i].weekendRost.End_Time__c) ){
                                weekendflag=false;
                                valweekend=6;
                                msgweekend='Shift End Time Missing in Weekend Roster';
                            }
                            if(  !(temp[i].weekendRost.Start_Time__c )){
                                weekendflag=false;
                                valweekend=7;
                                msgweekend='Shift Start Time Missing in Weekend Roster';
                            }
                        }
                    }
                    console.log('weekendflag'+weekendflag);
                    console.log('valweekend'+valweekend);
                    console.log('msgweekend'+msgweekend);}
                
                
                
                /* Week-Day error handeling*/
                if(temp[i].UpdateWeekDay ){
                    temp[i].count= 1+temp[i].count;
                    
                    console.log('temp[i].UpdateWeekDay'+i);
                    console.log('temp[i].UpdateWeekDay'+temp[i].UpdateWeekDay);
                    
                    if(temp[i].weekdayRost.Update){
                        if(      temp[i].UpdateWeekDay 
                           &&   temp[i].weekdayRost.Shift_Start_Date__c 
                           &&   temp[i].weekdayRost.Shift_End_Date__c
                           &&   temp[i].weekdayRost.End_Time__c 
                           &&   temp[i].weekdayRost.Start_Time__c
                           &&   temp[i].weekdayRost.Shift_End_Date__c>temp[i].weekdayRost.Shift_Start_Date__c 
                           &&   temp[i].weekdayRost.End_Time__c>temp[i].weekdayRost.Start_Time__c 
                           &&   (temp[i].weekdayRost.Shift__c=='Day' || temp[i].weekdayRost.Shift__c=='Night' )
                          )                
                            
                        {
                          /*  const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
                            const fDate =temp[i].weekdayRost.Shift_Start_Date__c ;
                            var firstDate = new Date(fDate);
                            const sDate = temp[i].weekdayRost.Shift_End_Date__c;
                            var secondDate = new Date(sDate);
                            const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
                            console.log('diffDays=============='+diffDays);
                            */
                            weekdayflag=true;
                            
                        }else{
                            if(   !(temp[i].weekdayRost.Shift_End_Date__c>temp[i].weekdayRost.Shift_Start_Date__c)){
                                weekdayflag=false;
                                valweekday=0;
                                msgweekday='Shift End-Date should be greater then the Shift Start-Date in Weekday Roster'
                            }
                            if(!temp[i].weekdayRost.Shift_Start_Date__c){
                                weekdayflag=false;
                                valweekday=1;
                                msgweekday='Shift Start-Date Missing in Weekday Roster';
                            }
                            if(!temp[i].weekdayRost.Shift_End_Date__c){
                                weekdayflag=false;
                                valweekday=2;
                                msgweekday='Shift End-Date Missing in Weekday Roster';
                            }
                            if(!temp[i].weekdayRost.Shift__c){
                                weekdayflag=false;
                                valweekday=3;
                                msgweekday='Shift Missing in Weekday Roster';
                            } 
                            if(!(temp[i].weekdayRost.Shift__c=='Day' || temp[i].weekdayRost.Shift__c=='Night' )){
                                weekdayflag=false;
                                valweekday=4;
                                msgweekday='Please select Shift in Weekday Roster';
                            }
                            
                            
                            if(  !(temp[i].weekdayRost.End_Time__c>temp[i].weekdayRost.Start_Time__c) ){
                                weekdayflag=false;
                                valweekday=5;
                                msgweekday='Shift End-Time should be greater then the Shift Start-Time in Weekend Roster';
                            }
                            if(  !(temp[i].weekdayRost.End_Time__c) ){
                                weekdayflag=false;
                                valweekday=6;
                                msgweekday='Shift End Time Missing in Weekend Roster';
                            }
                            if(  !(temp[i].weekdayRost.Start_Time__c )){
                                weekdayflag=false;
                                valweekday=7;
                                msgweekday='Shift Start Time Missing in Weekend Roster';
                            }
                            
                        }
                        
                    }
                    
                    console.log('weekdayflag'+weekdayflag);
                    console.log('valweekday'+valweekday);
                    console.log('msgweekday'+msgweekday);
                }
                
                
                if(temp[i].count>1){
                    console.log('temp[i].count'+temp[i].count);
                    countflag=false;
                    countmsg='One Roster for the Service Provider '+temp[i].monthRost.DriverName +' is already present';
                }
                //console.log('serviceProviderList-updatedfullyLast'+JSON.stringify(temp[i]));
            }
            var siteName;
            console.log('serviceProviderList-updatedfullyLast'+JSON.stringify(temp));
            if(weekdayflag && countflag && weekendflag && monthflag ){
                
                component.set('v.Saveflag',true);
                console.log('sucsess');
                for(var i=0; i<temp.length; i++){
                    siteName=temp[i].Site__c;
                    if(temp[i].UpdateMonthly && temp[i].monthRost.Update && temp[i].rosterPresent && temp[i].monthRost.Status_From_Parent__c=='Requested'){
                        console.log('monthRost updated');  
//                        siteName=temp[i].monthRost.Site__c;
                        var newobjmonth={
                            
                            "Id":temp[i].monthRost.Id,
                            "Lithium_ID__c": temp[i].monthRost.serviceProviderId,
                            "RecordTypeId": monthRecordTypeID,
                            "Shift_Start_Date__c": temp[i].monthRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].monthRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].monthRost.Start_Time__c,
                            "End_Time__c":temp[i].monthRost.End_Time__c,
                            "Shift__c": temp[i].monthRost.Shift__c,
                            "Sunday__c":!(temp[i].monthRost.Sunday__c),
                            "Monday__c": !(temp[i].monthRost.Monday__c),
                            "Tuesday__c": !(temp[i].monthRost.Tuesday__c),
                            "Wednesday__c":!(temp[i].monthRost.Wednesday__c),
                            "Thrusday__c": !(temp[i].monthRost.Thrusday__c),
                            "Friday__c": !(temp[i].monthRost.Friday__c),
                            "Saturday__c": !(temp[i].monthRost.Saturday__c),
                            "Active__c":true
                        }
                        rosterUpdateList.push(newobjmonth);
                    }
                    else if(temp[i].UpdateMonthly && temp[i].monthRost.Update && temp[i].rosterPresent && temp[i].monthRost.All_Status__c=='Approved'){
                        console.log('monthRost updated');  
                      //  siteName=temp[i].monthRost.Site__c;
                        var newobjinsertmonthapproved={
                            "Lithium_ID__c": temp[i].monthRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].monthRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].monthRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].monthRost.Start_Time__c,
                            "End_Time__c":temp[i].monthRost.End_Time__c,
                            "RecordTypeId": monthRecordTypeID,
                            "Shift__c": temp[i].monthRost.Shift__c,
                            "Sunday__c":!(temp[i].monthRost.Sunday__c),
                            "Monday__c": !(temp[i].monthRost.Monday__c),
                            "Tuesday__c": !(temp[i].monthRost.Tuesday__c),
                            "Wednesday__c":!(temp[i].monthRost.Wednesday__c),
                            "Thrusday__c": !(temp[i].monthRost.Thrusday__c),
                            "Friday__c": !(temp[i].monthRost.Friday__c),
                            "Saturday__c": !(temp[i].monthRost.Saturday__c),
                            "Active__c":true,
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjinsertmonthapproved);
                        var enddatemonthRost=dateconverterjs(temp[i].monthRost.Shift_End_Date_Temp);
                        console.log('monthRostApproved updated enddate'+enddatemonthRost); 
                        /*     var newobjmonth={
                        
                        "Id":temp[i].monthRost.Id,
                        "Lithium_ID__c": temp[i].monthRost.serviceProviderId,
                        
                        
                        "Start_Time__c":temp[i].monthRost.Start_Time__c,
                        "End_Time__c":temp[i].monthRost.End_Time__c,
                        "RecordTypeId": monthRecordTypeID,
                        "Shift__c": temp[i].monthRost.Shift__c,
                        "Sunday__c":temp[i].monthRost.Sunday__c,
                        "Monday__c": temp[i].monthRost.Monday__c,
                        "Tuesday__c": temp[i].monthRost.Tuesday__c,
                        "Wednesday__c":temp[i].monthRost.Wednesday__c,
                        "Thrusday__c": temp[i].monthRost.Thrusday__c,
                        "Friday__c": temp[i].monthRost.Friday__c,
                        "Saturday__c": temp[i].monthRost.Saturday__c,
                        "Active__c":false
                    }
                    rosterUpdateList.push(newobjmonth);
                  */  
                }
                    else if(temp[i].monthRost.Id=="" && temp[i].monthRost.Update &&  !temp[i].rosterPresent && temp[i].UpdateMonthly){
                        console.log('monthRost inserted'); 
                      //  siteName=temp[i].monthRost.Site__c;
                        var newobjinsertmonth={
                            "Lithium_ID__c": temp[i].monthRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].monthRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].monthRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].monthRost.Start_Time__c,
                            "End_Time__c":temp[i].monthRost.End_Time__c,
                            "RecordTypeId": monthRecordTypeID,
                            "Shift__c": temp[i].monthRost.Shift__c,
                            "Sunday__c":!(temp[i].monthRost.Sunday__c),
                            "Monday__c": !(temp[i].monthRost.Monday__c),
                            "Tuesday__c": !(temp[i].monthRost.Tuesday__c),
                            "Wednesday__c":!(temp[i].monthRost.Wednesday__c),
                            "Thrusday__c": !(temp[i].monthRost.Thrusday__c),
                            "Friday__c": !(temp[i].monthRost.Friday__c),
                            "Saturday__c": !(temp[i].monthRost.Saturday__c),
                            "Active__c":true,
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjinsertmonth);   
                    }
                
                    
                    
                    if(temp[i].UpdateWeekend && temp[i].weekendRost.Update  && temp[i].rosterPresent && temp[i].weekendRost.Status_From_Parent__c=='Requested'){
                   //     siteName=temp[i].weekendRost.Site__c;
                        console.log('weekendRost updated');  
                        var newobjweekendRost={
                            "Id":temp[i].weekendRost.Id,
                            "Lithium_ID__c": temp[i].weekendRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekendRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekendRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekendRost.Start_Time__c,
                            "End_Time__c":temp[i].weekendRost.End_Time__c,
                            "RecordTypeId": weekendRecordTypeID,
                            "Shift__c": temp[i].weekendRost.Shift__c,
                            "Sunday__c":checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(0),
                             "Saturday__c": checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(6),
                            
                            "Active__c":true
                        }
                        rosterUpdateList.push(newobjweekendRost);
                    }
                    else if(temp[i].UpdateWeekend  && temp[i].weekendRost.Update && temp[i].rosterPresent && temp[i].weekendRost.All_Status__c=='Approved'){
                      //  siteName=temp[i].weekendRost.Site__c;
                        console.log('weekendRost Approved');  
                        var newobjweekendRostapproved={
                            "Lithium_ID__c": temp[i].weekendRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekendRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekendRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekendRost.Start_Time__c,
                            "End_Time__c":temp[i].weekendRost.End_Time__c,
                            "RecordTypeId": weekendRecordTypeID,
                            "Shift__c": temp[i].weekendRost.Shift__c,
                            "Active__c":true,
                            "Sunday__c":checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(0),
                            "Saturday__c": checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(6),
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjweekendRostapproved);
                        
                        console.log('weekendRostApproved updated');  
                        var enddateweekendRost=dateconverterjs(temp[i].weekendRost.Shift_End_Date_Temp);
                        console.log('weekdayRostApproved updated enddate'+enddateweekendRost);  
                        /*    var newobjweekendRost={
                        "Id":temp[i].weekendRost.Id,
                        "Lithium_ID__c": temp[i].weekendRost.serviceProviderId,
                        "Start_Time__c":temp[i].weekendRost.Start_Time__c,
                        "End_Time__c":temp[i].weekendRost.End_Time__c,
                        "RecordTypeId": weekendRecordTypeID,
                        "Shift__c": temp[i].weekendRost.Shift__c,
                        "Active__c":false
                    }
                    rosterUpdateList.push(newobjweekendRost);
                  */  
                }
                    else if(temp[i].weekendRost.Id==""  && temp[i].weekendRost.Update && !temp[i].rosterPresent && temp[i].UpdateWeekend){
                        console.log('weekendRost inserted'); 
                   //     siteName=temp[i].weekendRost.Site__c;
                        var newobjinsertweekendRost={
                            
                            
                            "Lithium_ID__c": temp[i].weekendRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekendRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekendRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekendRost.Start_Time__c,
                            "End_Time__c":temp[i].weekendRost.End_Time__c,
                            "RecordTypeId": weekendRecordTypeID,
                            "Shift__c": temp[i].weekendRost.Shift__c,
                            "Active__c":true,
                            "Sunday__c":checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(0),
                         "Saturday__c": checkDay(temp[i].weekendRost.Shift_Start_Date__c,temp[i].weekendRost.Shift_End_Date__c).has(6),
                            
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjinsertweekendRost);
                    }
                    
                    
                    if(temp[i].UpdateWeekDay && temp[i].weekdayRost.Update && temp[i].rosterPresent && temp[i].weekdayRost.Status_From_Parent__c=='Requested'){
                        console.log('weekdayRost updated');  
                   //     siteName=temp[i].weekdayRost.Site__c;
                        var newobjweekdayRost={
                            "Id":temp[i].weekdayRost.Id,
                            "Lithium_ID__c": temp[i].weekdayRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekdayRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekdayRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekdayRost.Start_Time__c,
                            "End_Time__c":temp[i].weekdayRost.End_Time__c,
                            "RecordTypeId": weekdayRecordTypeID,
                            "Shift__c": temp[i].weekdayRost.Shift__c,
                            "Monday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(1),
                            "Tuesday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(2),
                            "Wednesday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(3),
                            "Thrusday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(4),
                            "Friday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(5),
                            
                            "Active__c":true
                        }
                        rosterUpdateList.push(newobjweekdayRost);
                    }
                    else if(temp[i].UpdateWeekDay && temp[i].weekdayRost.Update && temp[i].rosterPresent && temp[i].weekdayRost.All_Status__c=='Approved'){
                        console.log('weekdayRost updated'); 
                    //    siteName=temp[i].weekdayRost.Site__c;
                        var newobjweekdayRostApproved={
                            
                            "Lithium_ID__c": temp[i].weekdayRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekdayRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekdayRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekdayRost.Start_Time__c,
                            "End_Time__c":temp[i].weekdayRost.End_Time__c,
                            "RecordTypeId": weekdayRecordTypeID,
                            "Shift__c": temp[i].weekdayRost.Shift__c,
                            "Active__c":true,
                            "Monday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(1),
                            "Tuesday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(2),
                            "Wednesday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(3),
                            "Thrusday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(4),
                            "Friday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(5),
                            
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjweekdayRostApproved);
                        console.log('weekdayRostApproved updated');  
                        console.log('weekdayRostApproved  enddate'+temp[i].weekdayRost.Shift_End_Date_Temp); 
                        var enddate=dateconverterjs(temp[i].weekdayRost.Shift_End_Date_Temp);
                        console.log('weekdayRostApproved updated enddate'+enddate);  
                        /*       var newobjweekdayRost={
                        "Id":temp[i].weekdayRost.Id,
                        "Lithium_ID__c": temp[i].weekdayRost.serviceProviderId,
                        "Start_Time__c":temp[i].weekdayRost.Start_Time__c,
                        "End_Time__c":temp[i].weekdayRost.End_Time__c,
                        "RecordTypeId": weekdayRecordTypeID,
                        "Shift__c": temp[i].weekdayRost.Shift__c,
                        "Active__c":false,
                        
                    }
                    rosterUpdateList.push(newobjweekdayRost);
                    */
                }
                    else if(temp[i].weekdayRost.Id=="" && temp[i].weekdayRost.Update && !temp[i].rosterPresent && temp[i].UpdateWeekDay){
                        console.log('weekdayRost inserted');  
                      //  siteName=temp[i].weekdayRost.Site__c;
                        var newobjinsertweekdayRost={
                            
                            "Lithium_ID__c": temp[i].weekdayRost.serviceProviderId,
                            "Shift_Start_Date__c": temp[i].weekdayRost.Shift_Start_Date__c,
                            "Shift_End_Date__c": temp[i].weekdayRost.Shift_End_Date__c,
                            "Start_Time__c":temp[i].weekdayRost.Start_Time__c,
                            "End_Time__c":temp[i].weekdayRost.End_Time__c,
                            "RecordTypeId": weekdayRecordTypeID,
                            "Shift__c": temp[i].weekdayRost.Shift__c,
                            "Active__c":true,
                           "Monday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(1),
                            "Tuesday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(2),
                            "Wednesday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(3),
                            "Thrusday__c":checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(4),
                            "Friday__c": checkDay(temp[i].weekdayRost.Shift_Start_Date__c,temp[i].weekdayRost.Shift_End_Date__c).has(5),
                            
                            "Status__c":'Requested'
                        }
                        rosterInsertList.push(newobjinsertweekdayRost);
                    }
                }
                
                console.log('serviceProviderList-child===atlast'+JSON.stringify(component.get("v.serviceProviderList")));
                var action = component.get("c.saveRoster");
                console.log('rosterInsertList'+JSON.stringify(rosterInsertList));
                console.log('rosterUpdateList'+JSON.stringify(rosterUpdateList));
                console.log('rosterInsertApprovedList'+JSON.stringify(rosterInsertApprovedList));
                console.log('siteName'+siteName);
                action.setParams({
                    'rosterInsertApprovedList':rosterInsertApprovedList,
                    'rosterInsertList':rosterInsertList,
                    'rosterUpdateList':rosterUpdateList,
                    'siteName': siteName
                    
                });
                
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        let temp = response.getReturnValue();
                        console.log('temp'+temp);
                        
                        if(temp){
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Success Message',
                                message:  "The record has been created Successfully and Updated",
                                messageTemplate: 'Record {0} created! See it {1}!',
                                
                                key: 'info_alt',
                                type: 'success',
                                mode: 'pester'
                            });
                            toastEvent.fire();
                             location.reload();
                            
                        }else{
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error Message',
                                message:'Please select something to create Roster',
                                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                duration:' 2000',
                                key: 'info_alt',
                                type: 'error',
                                mode: 'pester'
                            });
                            toastEvent.fire();
                        }
                    }         
                    /*  else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message:  errors[0].message,
                            key: 'info_alt',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                    }
                }
            }*/
            });
                $A.enqueueAction(action);
            }else{
                console.log('elsemonthflag'+monthflag);   
                console.log('elseweekendflag'+weekendflag);
                console.log('elseweekdayflag'+weekdayflag);
                console.log('elsecountflag'+countflag);
                
                if(!countflag){
                    helper.errorMsgTost(component, event, helper,countmsg); 
                }
                //        console.log('valOneD'+valOneD);
                if(!monthflag){
                    switch (valmonth) {
                        case 0:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 1:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                            
                        case 2:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 3:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 4:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 5:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 6:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 7:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 8:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                        case 9:
                            helper.errorMsgTost(component, event, helper,msgmonth);
                            break;
                    }
                }
                //      console.log('val'+valtrip);
                if(!weekendflag){
                    //          console.log('flagFlat'+flagFlat);
                    switch (valweekend) {
                        case 0:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;     
                        case 1:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 2:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 3:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 4:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 5:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 6:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                        case 7:
                            helper.errorMsgTost(component, event, helper,msgweekend);
                            break;
                            
                            
                            
                    }
                }
                
                if(!weekdayflag){
                    switch (valweekday) {
                        case 0:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            
                            break;
                        case 1:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 2:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 3:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 4:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 5:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 6:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;
                        case 7:
                            helper.errorMsgTost(component, event, helper,msgweekday);
                            break;  
                            
                    }
                }
            }   
            
        }else{
            console.log('save 2'); 
        }
        
        //    component.set("v.Spinner", true); 
    },
})