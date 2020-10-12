({
    controllerFunction: function(component,event,helper) {
        
        var newEvent = event.currentTarget.getAttribute("data-value");
        component.set("v.isOpen", true);
        
         component.set('v.columns', [
            {label:'EOS Name', fieldName:'Name', type: 'text'},
            {label: 'Service Provider', fieldName: 'Service_Provider_Name__c', type: 'text'},
            {label: 'From Date', fieldName: 'From_date__c', type: 'date',},
            {label: 'To Date', fieldName: 'To_date__c', type: 'date'},
            {label: 'Status', fieldName: 'Approval_Request__c', type: 'text'},
            
        ]);
             
        var action = component.get('c.fetchLeaveHistory');
        action.setParams({ 
            "spRecId": newEvent
        });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                var leaveRecords = response.getReturnValue();
                console.log(JSON.stringify(leaveRecords));
                for(var i=0; i<leaveRecords.length; i++){
                    component.set("v.data",leaveRecords);
                    
                }
            }
        });
        $A.enqueueAction(action);
       
            },
            closeModel: function(component, event, helper) {
            // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
            component.set("v.isOpen", false);
            },
            
            approvrd : function(component,event,helper) {
           	 helper.approvalReq(component, event, helper);
            },
            rejected : function(component,event,helper) {
                component.set("v.ReqType", "Reject");
                helper.approvalReq(component, event, helper);
            }
            })