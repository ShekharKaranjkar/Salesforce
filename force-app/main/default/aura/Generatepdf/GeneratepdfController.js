({
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },
    loadOptions: function (component, event, helper) {
        var options = [ ];
        var action = component.get("c.getDepartment");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var arr = response.getReturnValue() ;
                arr.forEach(function(element) {
                    options.push({ value: element, label: element });
                });
                component.set("v.statusOptions", options);
                
            }
            
            
        });
        $A.enqueueAction(action);
        
    },
    handleOptionSelected: function (component, event) {
        var action = component.get("c.getContactsByDept");
        action.setParams({deptName:event.getParam("value")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.contacts" ,  response.getReturnValue() ) ; 
            }
        });
        $A.enqueueAction(action); 
        
    },
    Pdfsend:function(component, event, helper){
        console.log('Step1');
        var action = component.get("c.sendquote");
        console.log('v.recordId',component.get('v.recordId'));
        action.setParams({
            "recordId": component.get('v.recordId')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state=='SUCCESS'){
                var result = response.getReturnValue();
                $A.get('e.force:refreshView').fire();
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();
                console.log('###@@@!#'+result);
            }
        });
        $A.enqueueAction(action);
    },
    
    close: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
        $A.get("e.force:closeQuickAction").fire();
    },
    doInit : function(component, event, helper) {
        
        var recid = component.get('v.recordId');
        component.set('v.quoteid',recid);
        console.log('####'+component.get('v.quoteid'));
    },
    save: function(component, event, helper){
        var action = component.get("c.quoteSave");  
        console.log('v.recordId',component.get('v.recordId'));
        action.setParams({  
            "recordId": component.get('v.recordId') 
        });
        action.setCallback(this,function(response){  
            var state = response.getState();  
            if(state=='SUCCESS'){  
                var result = response.getReturnValue(); 
                $A.get('e.force:refreshView').fire();
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire(); 
            }  
        });  
        $A.enqueueAction(action);  
        $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
    },
    
    openModel: function(component, event, helper) {
        
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        
        component.set("v.isOpen", false);
    },
    
    sendMail: function(component, event, helper) {
        
        component.set("v.Spinner", true);
        console.log('get vallist'+component.get("v.selectedLookUpRecords")) ; 
        console.log('Enter SendEmail');
        var toAddress = [];
        var valsit = component.get("v.selectedLookUpRecords"); 
        console.log('Enter SendEmail'+valsit);
        for(var i =0;i<valsit.length;i++){
            toAddress.push(valsit[i].Email);
            console.log(valsit[i].Email);
        }
        console.log('get vallist1'+component.get("v.selectedLookUp")) ; 
        console.log('Enter SendEmail1');
        var ccAddress = [];
        var valsit1 = component.get("v.selectedLookUp"); 
        console.log('Enter SendEmail1'+valsit1);
        for(var i =0;i<valsit1.length;i++){
            ccAddress.push(valsit1[i].Email);
            console.log(valsit1[i].Email);
        }
        console.log('get vallist1'+component.get("v.selectedbccLookUp")) ; 
        console.log('Enter SendEmail2');
        var bccAddress = [];
        var valsit2 = component.get("v.selectedLookUp"); 
        console.log('Enter SendEmail2'+valsit2);
        for(var i =0;i<valsit1.length;i++){
            bccAddress.push(valsit1[i].Email);
            console.log(valsit1[i].Email);
        }
        //var toAddressLst = component.get("v.selectedLookUpRecords");
        
        // var getcc = component.get("v.cc");
        
        // var getbcc = component.get("v.bcc");
        var getSubject = component.get("v.subject");
        console.log('getSubject+'+getSubject);
        var getbody = component.get("v.body");
        console.log('getbody+'+getbody);
        
        // var getbcc;
         if ($A.util.isEmpty(valsit) || !valsit[i].Email) {
            alert('Please Enter valid Email Address');
             component.set("v.Spinner", false);
        } else {
           helper.sendHelper(component, toAddress, ccAddress,getSubject, getbody, bccAddress);
        }
        
        
    },
    
    
    list: function(component, event, helper) {
        var toAddress = [];
        var valsit = component.get("v.selectedLookUpRecords");  
        for(var i =0;i<valsit.length;i++){
            toAddress.push(valsit[i].Email);
            console.log(valsit[i].Email);
        }
        //console.log('valsit', valsit);
    },
    
    
    closeMessage: function(component, event, helper) {
        
        component.set("v.selectedLookUpRecords", null);
        component.set("v.selectedLookUp", null);
        component.set("v.selectedbccLookUp", null);
        component.set("v.subject", null);
        component.set("v.body", null);
        component.set("v.isOpen", false);
    },
    
    showSpinner: function(component, event, helper) {
        
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },
    
    
})