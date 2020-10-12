({
    sendHelper: function(component, toAddress,ccAddress, getSubject, getbody,  getbcc) {
        
        var toAddressLst = [];
        var valsit = component.get("v.selectedLookUpRecords");  
        for(var i =0;i<valsit.length;i++){
            toAddressLst.push(valsit[i].Email);
            console.log(valsit[i].Email);
        }
        
        var ccAddressLst = [];
        var valsit1 = component.get("v.selectedLookUp");  
        for(var i =0;i<valsit1.length;i++){
            ccAddressLst.push(valsit1[i].Email);
            console.log(valsit1[i].Email);
        }
        var bccAddressLst = [];
        var valsit2 = component.get("v.selectedbccLookUp");  
        for(var i =0;i<valsit2.length;i++){
            bccAddressLst.push(valsit2[i].Email);
            console.log(valsit2[i].Email);
        }
        
        
        //console.log('toAddressLst+'+toAddressLst);
        
        //component.set("v.showLoadingSpinner", true);
        var action = component.get("c.sendquote");
        
        
        ///console.log('valsit',valsit);
        action.setParams({
            recordId: component.get('v.recordId'),
            address1: JSON.stringify(toAddressLst),           
            cc1 : JSON.stringify(ccAddressLst),
            bcc1 : JSON.stringify(bccAddressLst),
            subject: getSubject,
            body: getbody
        });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                //  component.set("v.mailStatus", true);
                component.set("v.Spinner", false);
                var sMsg = 'Email sended Successfully';
                $A.get('e.force:refreshView').fire();
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    mode: 'sticky',
                    message: sMsg,
                    duration:' 5000',
                    key: 'info_alt',
                    mode: 'pester',
                    type : 'success'
                    
                });
                window.setTimeout(
                    $A.getCallback(function() {
                        component.set("v.isOpen", false);
                    }), 4000
                );
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();  
                component.set("v.isOpen", false);
                //component.set("v.mailStatus", false);
                component.set("v.selectedLookUpRecords", null);
                component.set("v.selectedLookUp", null);
                component.set("v.selectedbccLookUp", null);
                
                component.set("v.subject", null);
                component.set("v.body", null);
                //  component.set("v.showLoadingSpinner", false);
            }
            
        });
        $A.enqueueAction(action);
    },
    
    
})