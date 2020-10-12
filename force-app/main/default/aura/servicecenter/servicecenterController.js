({
    dointAction : function(component, event, helper) {
        var action = component.get("c.getservicecenter");
        action.setParams({ 
            "IssueId": component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            debugger;
            var state = data.getState();
            if(state=='SUCCESS'){
            var servicecenters = [];
            
            var wrapperreturnval = data.getReturnValue();
                if(wrapperreturnval !=null){
                var returnval = wrapperreturnval.sortDistanceWrapperList;
            if(returnval !=null && returnval.length>0){
                
            for(var i=0;i<returnval.length;i++){
                console.log(returnval[i]);
                var numb = returnval[i].distance;
            //    alert(numb);
          //   if(component.get(numb) != undefined)
                numb = numb.toFixed(2);
                var servicecenter = {"Name":returnval[i].CenterName,"Id":returnval[i].recordid,"distance":numb};
                
                servicecenters.push(servicecenter);
            }
            component.set("v.servicecenters", servicecenters);
            component.set("v.showmessage",true);
            }else{
			  
                component.set("v.ShowErrormessage",true);component.set("v.showmessage",false);
            }
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message: 'Issue location co-ordinates are empty',
                    duration:'5000',
                    key: 'info_alt',
                    type: 'warning',
                    mode: 'pester'
                });
                toastEvent.fire();
                }
            }
            if(state == "ERROR"){
                 var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message: 'Could not find service  ceters. Please contact Administrator.',
                    duration:'5000',
                    key: 'info_alt',
                    type: 'warning',
                    mode: 'pester'
                });
                toastEvent.fire();   
                
            }
        });
        $A.enqueueAction(action);
        
    },
    checkboxSelect: function(component, event, helper) {
        
        var selectedRec = event.getSource().get("v.value");
        
        var getSelectedNumber = component.get("v.selectedCount");
        
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        
        component.set("v.selectedCount", getSelectedNumber);
    },
    
    selectAll: function(component, event, helper) {
        
        var selectedHeaderCheck = event.getSource().get("v.value");
        
        var getAllId = component.find("boxPack");
        
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack").set("v.value", true);
                component.set("v.selectedCount", 1);
            }else{
                component.find("boxPack").set("v.value", false);
                component.set("v.selectedCount", 0);
            }
        }else{
            
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", true);
                    component.set("v.selectedCount", getAllId.length);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                    component.set("v.selectedCount", 0);
                }
            } 
        }  
        
    },
    
    assigntoservicecenter: function(component, event, helper) {
        debugger;
       
        var recodid = event.target.parentNode.getAttribute("id");
     
        if(component.get("v.isexecuting") == true){
            component.set("v.isexecuting",false);
        //component.set("v.IssueObj.Service_Center__c",selectedList[0]);
        component.set("v.IssueObj.Service_Center__c",recodid);
        component.set("v.IssueObj.Id",component.get("v.recordId"));  
        var Issue =   component.get("v.IssueObj");
              console.log('121'+Issue);
        var action = component.get("c.updateIssue");
        
        action.setParams({ 
            "issue": Issue
        }); 
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if(state=='SUCCESS'){
                
                console.log(actionResult.getReturnValue() );
               // $A.get('e.force:refreshView').fire();
                component.set("v.showmessage",false);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                     title : 'Success',
                    message: 'Service Center Assigned Successfully',
                    duration:' 5000',
                     key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                component.set("v.ShowErrormessage",true);
                window.location.reload();
                /*if(IssueObj.Service_Center_c !='{}'){
                    
                    alert('Test');
                    
                    component.set("v.ShowErrormessage",true);}*/
                
			                
            } else if(state == "ERROR"){
                // console.log(this);
                //alert('Error in calling server side action');
            }
            component.set("v.isexecuting",true);
        });   
        $A.enqueueAction(action);
        }
    },
    
})