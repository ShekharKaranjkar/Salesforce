({ 
    loadData :function(component,event){
      var action =component.get("c.getJournal");
		//action.setParams({ firstName : cmp.get("v.firstName") });

        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('response.getState() ',response.getState());
            if (state === "SUCCESS") {
                console.log('response.getReturnValue() ' ,response.getReturnValue());
                var dailyLst = response.getReturnValue();
                var newDailyLst = [];
                for(var i = 0; i < dailyLst.length;i++ ){
                    console.log(dailyLst[i]);
                    var account = {};
                    var lead = {};
                    console.log('dailyLst ', dailyLst);
                    if(dailyLst[i].AccountId){
                        account = {
                            "val":dailyLst[i].AccountId,
                            "text":dailyLst[i].AccountName,
                            "objName": "Account"
                    	};
                    }else if(dailyLst[i].LeadId){
                        lead = {
                            "val":dailyLst[i].LeadId,
                            "text":dailyLst[i].LeadName,
                            "objName": "Lead"
                    	};
                    }
                    console.log('account ',account);
                    var objDaily = {
                        "Id": dailyLst[i].Id,
                        "Hours":dailyLst[i].Hours ? dailyLst[i].Hours :0,
                        "Details":dailyLst[i].Details ? dailyLst[i].Details : "",
                        "Log_Hour":dailyLst[i].Log_Hour ? dailyLst[i].Log_Hour : "",
                        "Category":dailyLst[i].Category ? dailyLst[i].Category : "",
                        "AccountId":account,
                        "LeadId":lead,
                        "TaskId":dailyLst[i].TaskId ? dailyLst[i].TaskId : "",
                        "Type":dailyLst[i].Type ? dailyLst[i].Type : ""
                    };
                    newDailyLst.push(objDaily);
                }
                component.set("v.DailyList", newDailyLst);
            }
            else if (state === "INCOMPLETE") {
                // do something
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);

          
    },
    addJournalRecord: function(component, event) {
        
        var DailyList = component.get("v.DailyList");
        DailyList.push({});
        component.set("v.DailyList", DailyList);        
    },
    validateDailyList: function(component, event) {
        // alert('reet');
        var action = component.get("c.getJournal");
        var isValid = true;
        var DailyList = component.get("v.DailyList");
        for (var i = 0; i < DailyList.length; i++) {
            if (DailyList[i].Hours == '0' || (DailyList[i].Hours == '' && parseInt(DailyList[i].Hours) < 1)|| DailyList[i].Details =='') {
                isValid = false;
                //  alert('DailyJournal Hours or cannot be blank on row number ' + (i + 1));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: 'DailyJournal Hours or Details should not be blank ',
                    duration:'5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
        }
        return isValid;
    },
    
    
    saveDaiylList: function(component, event, helper) {
         //alert('hhh');
        var dailyLst = component.get("v.DailyList");
        console.log('Step10 ',dailyLst);
        var newDailyLst = [];
        for(var i = 0; i < dailyLst.length;i++ ){
            console.log(dailyLst[i]);
            var objDaily = {
                "Id": dailyLst[i].Id ? dailyLst[i].Id : "",
                "Hours":dailyLst[i].Hours,
                "Details":dailyLst[i].Details,
                "AccountId":dailyLst[i].AccountId ?dailyLst[i].AccountId.val:"",
                "LeadId":dailyLst[i].LeadId ?dailyLst[i].LeadId.val:"",
                "Log_Hour":dailyLst[i].Log_Hour ? dailyLst[i].Log_Hour : "",   
                "Category":dailyLst[i].Category ? dailyLst[i].Category : "",
                "TaskId":dailyLst[i].TaskId ? dailyLst[i].TaskId : "",
                "Type":dailyLst[i].Type ? dailyLst[i].Type : ""
            };
            newDailyLst.push(objDaily);
        }
        console.log('dailyLst >> ', newDailyLst);
        var removeIds = component.get("v.removeLogIds");
        console.log('removeIds ', removeIds );
        var action = component.get("c.saveJournal");
        action.setParams({
            "dailyList": JSON.stringify(newDailyLst),
            "removeIds": JSON.stringify(removeIds)
            
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var sMsg = 'Login Hours saved Successfully';
                // $A.get('e.force:refreshView').fire();
                component.set("v.removeLogIds",[]);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    mode: 'sticky',
                    message: sMsg,
                    duration:' 5000',
                    key: 'info_alt',
                    mode: 'pester',
                    type : 'success'
                    
                });
                toastEvent.fire();
                //this.loadData()
                 $A.get('e.force:refreshView').fire();
               // console.log('toast');
                
            }else if (state === "INCOMPLETE") {
                // do something
                
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        }); 
        $A.enqueueAction(action);
    },
})