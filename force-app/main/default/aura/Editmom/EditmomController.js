({
    
    handleChange: function (component, event) {
        var selectedOptionValue = event.getParam("value");
        //       alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
        
        component.set("v.selectedcontactList", selectedOptionValue);
        
        
    },
    doInit : function(component, event) {
        var action = component.get("c.getevent");
        action.setParams({'eventid':component.get("v.recordId")});
        action.setCallback(this, function(a) {
            debugger;
            var returnmap = a.getReturnValue();
            component.set("v.EventObj", returnmap.eventrecord); 
            var accountarray = returnmap.AccountcontactRelastionList;
            var selectedarray =returnmap.Selectedlist;
            var selectedarray2=[];
            var accountarray2 =[] ;
            for (var i = 0, len = accountarray.length; i < len; ++i) {
                
                accountarray2.push({label: accountarray[i].Contact.Name,value: accountarray[i].Contact.Name});
            }
            component.set("v.AccountContactRelationList", accountarray2);
            for (var key in selectedarray) {
                // alert('hey'+key);
                selectedarray2.push(key);
            }
            component.set("v.selectedcontactList", selectedarray2);
            var eventrec = component.get("v.EventObj");
            var userrec = {'Id':eventrec.OwnerId,'Name':eventrec.Owner.Name};
            var userlist = [];
            userlist.push(userrec);
            component.set("v.userobj", userrec);
            component.set("v.LookUpRecords3", userlist);
            component.set("v.accobj", returnmap.accrecord);
            if(returnmap.accrecord !=null)
                component.set("v.showacc", true);
            component.set("v.ContactLookUpRecords", returnmap.ContactRecords);
            //alert(component.get("v.ContactLookUpRecords")+'key');      
        });
        $A.enqueueAction(action);
    },
    OnSubmit : function(component, event,helper) {
        debugger;
        var action = component.get("c.updateEvent");
        
        var eventrec = component.get("v.EventObj");
        var multilist = component.get("v.selectedcontactList");
        action.setParams({'eventrec':eventrec,'selectedlist':multilist});
        action.setCallback(this, function(a) {
            debugger;
            var state = a.getState();
            if(state == "SUCCESS"){
                helper.showToast(component, event,"The record has been updated successfully.","success","Success!");
                var dismissQuickAction = $A.get("e.force:closeQuickAction");
                dismissQuickAction.fire();
            }
            else if(state == "ERROR"){
                helper.showToast(component, event,"Update failed.Please contact system administrator.","warning","Warning");
            }
            // $A.get('e.force:refreshView').fire();
            
            //$A.get('e.force:refreshView').fire();
            //alert('Success');
        });
        $A.enqueueAction(action);
    },
    handleComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var eventrec = component.get("v.userobj");
        var userrec = {'Id':selecteduserGetFromEvent.Id,'Name':selecteduserGetFromEvent.Name};
        var userlist = [];
        userlist.push(userrec);
        component.set("v.userobj", userrec);
        component.set("v.LookUpRecords3", userlist);
        
    },
    handlecontactComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var contactrecords = component.get("v.ContactLookUpRecords");
        //contactrecords.push(selecteduserGetFromEvent);
        //component.set("v.ContactLookUpRecords", contactrecords);
        var eventrec = component.get("v.EventObj");
        eventrec.WhatId =selecteduserGetFromEvent.AccountId;
        component.set("v.EventObj", eventrec);
        var accrec = {'Id':selecteduserGetFromEvent.AccountId,'Name':selecteduserGetFromEvent.Account.Name};
        component.set("v.accobj", accrec);
        if(accrec !=null)
            component.set("v.showacc", true);
        var action = component.get("c.getAccountcontactRelastionshiprecords");
        action.setParams({'accountid':selecteduserGetFromEvent.AccountId});
        action.setCallback(this, function(a) {
            debugger;
            var state = a.getState();
            if(state == "SUCCESS"){
                var accountarray = a.getReturnValue();
                var accountarray2 =[] ;
                for (var i = 0, len = accountarray.length; i < len; ++i) {
                    
                    accountarray2.push({label: accountarray[i].Contact.Name,value: accountarray[i].Contact.Name});
                    //alert(accountarray[i].Contact.Name);
                }
                // var contactarray = component.get("v.AccountContactRelationList");
                //contactarray=contactarray.concat(accountarray2);
                component.set("v.AccountContactRelationList", accountarray2);
                // alert(component.get("v.AccountContactRelationList").length)
            }
        });
        $A.enqueueAction(action);
        //component.set("v.LookUpRecords3", userlist);
        
    },
    
    doCancel: function(component, event) {
        var dismissQuickAction = $A.get("e.force:closeQuickAction");
        dismissQuickAction.fire();
    }
})