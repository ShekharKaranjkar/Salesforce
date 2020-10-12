({
    doInit : function(component, event, helper) {
        component.set("v.vehiclid",component.get('v.recordId'));
        console.log('recid'+component.get('v.recordId'));
         var action = component.get("c.getcheckvalues");
        var  newEvent;
        if(component.get('v.recordId') != undefined)
            newEvent = component.get('v.recordId');
        else if(component.get('v.parentrecid') != undefined)
         newEvent=component.get("v.parentrecid");
        action.setParams({ 
            "id": newEvent
        }); 
        action.setCallback(this, function(a) {
            //alert('set call back');
            debugger;
            //$A.get('e.force:refreshView').fire();
            var state = a.getState();
            if (state === "SUCCESS") {
                  console.log('state'+JSON.stringify(component.get('v.Vehiclerec')));

                alert('dd '+ component.get('v.recordId'));
                console.log('vehiclecomp'+JSON.stringify(returnval.vehcl[0]));
                component.set("v.Vehiclerec",returnval.vehcl[0]);                    
                // var carrec = {'Id':returnval.Site__r.Location__r.OwnerId,'Name':returnval.Site__r.Location__r.Owner.Name};
                // var carrec = {'Id':returnval.vehcl.OwnerId,'Name':returnval.vehcl.Owner.Name};
                // component.set("v.userobj", carrec);
                var  vehicle = component.get('v.Vehiclerec');
                var vehiclarray = [];
                console.log('vehicle'+vehicle);
                vehiclarray.push(vehicle);
                alert('veh---->>'+vehiclarray);
                component.set("v.selectedLookUpRecords", vehiclarray);
                //component.set("v.selectedLookUpRecords",id);
                var eventrec = component.get("v.dailyList");
                eventrec.Vehicle__c =returnval.vehcl.Id;
                
                
                console.log('eventrec'+JSON.stringify(eventrec));
                toastEvent.fire();
                //window.location.reload();
                var dismissQuickAction = $A.get("e.force:closeQuickAction");
                dismissQuickAction.fire();
                
                
            }
            
        });
        
        $A.enqueueAction(action);
        
    },
    
    
    CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        cmp.set("v.radioValue1",changeValue);
        cmp.set("v.dailyList.Sanitization_done__c",changeValue);
    },
    CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
        cmp.set("v.radioValue2",changeValue1);
        cmp.set("v.dailyList.Car_has_been_cleaned__c",changeValue1);
    },
    handleComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var eventrec = component.get("v.dailyList");
        eventrec.OwnerId =selecteduserGetFromEvent.Id;
        component.set("v.dailyList", eventrec);
        //alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        
    //    var userrec = {'Id':returnval.Site__r.Location__r.OwnerId,'Name':returnval.Site__r.Location__r.Owner.Name};
      //  var userlist = [];
    //    userlist.push(userrec);
     //   component.set("v.userobj", userrec);
     //   component.set("v.LookUpRecords3", userlist);
        
    },
    
    submitmethod:function(component, event, helper){
        debugger;
        var newCheck = component.get("v.dailyList");
         var newCheck1 = component.get("v.vehicleid");
         var newCheck2 = component.get("v.vehiclename");
        newcheck.Vehicle__c = component.get("v.vehicleid");
        //newCheck.Vehicle__c = component.get("v.recordId");
        console.log('newCheck'+JSON.stringify(newCheck));
        
        var elements = component.find('loadingSpinner');
        $A.util.addClass(elements, 'slds-show');
        $A.util.removeClass(elements, 'slds-hide');
        var action = component.get("c.createRecord");
        
        action.setParams({ 
            "jsonCheck": JSON.stringify(newCheck)
            
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if(state == "SUCCESS"){
                
                var retvalues= a.getReturnValue();
                console.log('state'+retvalues);
                //$A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    title : 'Success Message',
                    message: ' "The Daily Covid Activity- Vehicle has been Saved successfully."',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                window.location.reload();
                var dismissQuickAction = $A.get("e.force:closeQuickAction");
                dismissQuickAction.fire();
                
                
                var params = event.getParams();
        var parentId = params.response.id;
        console.log('params.response::',params.response.id);
                  component.set('v.parentId', params.response.id);
                 helper.uploadHelper(component, event);
                /*var temp=component.get('v.Vehiclerec');
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": a.getReturnValue(),
                    "slideDevName": "related" 
                });
                navEvt.fire(); */
                
                console.log('Record is Created Successfully');
                
                
            } else if(state == "ERROR"){
                console.log(this);
                console.log('Error in calling server side action');
            }                
            
            
        });
        $A.enqueueAction(action);
    } ,
    
    handlemultipleComponentEvent : function(component, event, helper) {
        debugger;
        alert('selecteduserGetFromEvent'+selecteduserGetFromEvent);
        var selecteduserGetFromEvent = event.getParam("vehicleByEvent");
        var IsServiceProvider1 = event.getParam("IsServiceProvider1");
        var eventrec = component.get("v.dailyList");
        if(IsServiceProvider1 == true){
            alert( eventrec.Vehicle__c);
            eventrec.Vehicle__c =selecteduserGetFromEvent.Id;
        component.set("v.dailyList", eventrec);
            
        }
    },
    
     Cancel : function(component, event, helper) {
         alert('Are you Sure');
        //Find the text value of the component with aura:id set to "address"
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": 'https://lithium--uat.lightning.force.com/lightning/n/Driver_Menu' 
        });
        urlEvent.fire();
    },
     handleFilesChange: function(component, event, helper) {
        //  alert('Enter handle file change');
        console.log('event ',event.getSource().get("v.files"));
        var fileName = [];
        if (event.getSource().get("v.files").length > 0) {
            console.log('Step1' ,event.getSource().get("v.files").length);
            for(var i = 0; i< event.getSource().get("v.files").length; i++){
                console.log('name ' ,event.getSource().get("v.files")[i]);
                fileName.push(event.getSource().get("v.files")[i].name); 
            }
            component.set("v.isFileAttached",true);
        }
        component.set("v.fileName", fileName);
    },
})