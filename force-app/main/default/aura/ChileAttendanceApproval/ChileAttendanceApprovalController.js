({
    /*doInit : function(component, event, helper) {
        console.log('jjjjjjjjjjjjjjjjjjjjjjjjjj'); 
var t=component.get("v.attendance") ;
       d= t.Login__c
       var temp;
const birthday = new Date(d);
const day1 = birthday.getDate();
// Sunday - Saturday : 0 - 6

console.log(birthday.getMonth()); 
console.log(birthday.getFullYear());
console.log(day1);
console.log(birthday.getUTCHours());
        temp=birthday.getUTCHours();
        component.set("v.datete",temp);
          component.set("v.attendance",component.get("v.attendance") );
	},*/
    approvrd : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.saveRecord");
        console.log(JSON.stringify(component.get("v.attendance") ));
        
        action.setParams({
            
            'attendance' : component.get("v.attendance")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
            //    alert('kkkkkkkkaaaaaaaaa');
                var toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    title : 'Success Message',
                    message: ' "The record has been Updated successfully."',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                window.location.reload();
                
                // set searchResult list with return value from server.
                //  component.set("v.listOfSearchRecords", storeResponse);
            }
            
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
    rejected : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.saverej");
        console.log(JSON.stringify(component.get("v.attendance") ));
        action.setParams({
            
            'attendance' : component.get("v.attendance")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              //  alert('kkkkkkkkaaaaaaaaa');
                var toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    title : 'Success Message',
                    message: ' "The record has been Updated successfully."',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                window.location.reload();
                
                // set searchResult list with return value from server.
                //  component.set("v.listOfSearchRecords", storeResponse);
            }
            
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
    detail : function (component, event, helper) {
        var lithium = component.get("v.attendance")
        var navEvt = $A.get("e.force:navigateToSObject");
        
        navEvt.setParams({
            "recordId":lithium.Service_Provider__c ,
            "slideDevName": "detail"
        });
     
        navEvt.fire();
    },
    names : function (component, event, helper) {
        var lithium1 = component.get("v.attendance")
        var navEvt = $A.get("e.force:navigateToSObject");
         console.log(JSON.stringify(lithium1 ));
       //   console.log('recordId'+recordId);
        navEvt.setParams({
            "recordId":lithium1.Id ,
            "slideDevName": "names"
           
        });
   
        navEvt.fire();
    }
    
    
    
})