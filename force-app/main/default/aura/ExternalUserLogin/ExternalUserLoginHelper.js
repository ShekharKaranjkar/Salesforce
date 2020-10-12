({
	backToMain : function(component, event, helper) {
        component.set("v.isFirstTime",true);
        component.set("v.forgotPassword",false);
        component.set("v.gotOtp",false);
        component.set("v.disableMobileNumber",false);
        component.set("v.checkStatus",true);
        component.set("v.mobileNumber",'');
        component.set("v.usrpassword",'');
        component.set("v.cnfpassword",'');
        component.set("v.readOtp",'');
        component.set("v.storedOtp",'');
    },
    
    ModelToastMsg : function(component, event, helper,msg) {
        var modalBody;
        $A.createComponent("c:ExternalUserLoginError", { "body":msg},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content; 
                                   component.find('overlayLib').showCustomModal({
                                       body: modalBody, 
                                       showCloseButton: true,
                                       cssClass: "slds-modal_small",  
                                       closeCallback: function() {
                                           console.log('closed');
                                       }
                                   })
                               }                               
                           }); 
        
    },
    getSOAPSUID : function(component, event, helper){
    	let action = component.get("c.loginPassword");
            action.setParams({  
                mobileNumber : component.get("v.mobileNumber"),
                password	:	component.get("v.usrpassword"),
            });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS"){
                let returnValue = response.getReturnValue();
                if(returnValue !== undefined && returnValue != null){
                    
                }
            }else if(state === "ERROR"){}
        });
        $A.enqueueAction(action);
	},
    createCookie : function(name,value,days){
        //var expires;
        //document.cookie=name+"="+value+";expires=0;path=/;Secure;SameSite=Lax;";
        var d = new Date();
        d.setTime(d.getTime() + (7 * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie=name+"="+value+";"+expires+";path=/;Secure;SameSite=Lax;";
        
    },passwordLoginHelper : function(component, event, helper) {
        console.log('Step2');
        if(component.get("v.usrpassword").trim() != ''){
            let action = component.get("c.loginPassword");
            action.setParams({  
                mobileNumber : component.get("v.mobileNumber"),
                password	:	component.get("v.usrpassword"),
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if(state === "SUCCESS"){
                    let returnValue = response.getReturnValue();
                    if(returnValue !== undefined && returnValue != null){
                        var uri_dec = decodeURIComponent(returnValue);
                        /*var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url": '/serviceprovider/s/',
                            "isredirect":true,
                        });
                        urlEvent.fire();
                        $A.get('e.force:refreshView').fire();*/
                    }
                }else if(state === "ERROR"){
                    let errors = response.getError();
                    let message = 'Unknown error';
                    if (errors && Array.isArray(errors) && errors.length > 0) {
                        message = errors[0].message;
                    }
                    helper.ModelToastMsg(component, event, helper, message);
                }else{
                    helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginUnhandledError"));
                }
            });
            $A.enqueueAction(action);
        }else{
            helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginBlankPassword"));
        }
    },
    
})