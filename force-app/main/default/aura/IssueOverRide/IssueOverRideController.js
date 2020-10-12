({
    doint : function(component, event, helper) {
        debugger;
       // alert('component'+component.get("v.recordId"));
       var targetcmp =  component.find('loadingSpinner');
        $A.util.addClass(targetcmp, 'slds-show');
		$A.util.removeClass(targetcmp, 'slds-hide');
        //$A.get('e.force:refreshView').fire();
        //alert(component.get("v.RecordTypeId"));
        if(JSON.stringify(component.get("v.pageReference").state ).includes('additionalParams'))
        {
            console.log(JSON.stringify(component.get("v.pageReference").state ));
            console.log(JSON.stringify(component.get("v.pageReference").state.additionalParams));
            var additionalparams = JSON.stringify(component.get("v.pageReference").state.additionalParams);
            if( additionalparams != undefined && additionalparams.length>0 && additionalparams.includes('&')){
    //    if(JSON.stringify(component.get("v.pageReference").state ).includes('additionalParams')  &&  component.get("v.pageReference").state.additionalParams != undifined){
       // if(component.get("v.pageReference").state.additionalParams != undifined){
            var parentid = JSON.stringify(component.get("v.pageReference").state.additionalParams).split('&')[1].split('=')[1]; 
            var parentFiled = JSON.stringify(component.get("v.pageReference").state.additionalParams).split('&')[1].split('=')[0];
         component.set("v.Vehicle__c",parentid);//
            }
        }
        var recordTypeId = component.get("v.pageReference").state.recordTypeId;
        if(recordTypeId != undefined && recordTypeId.length>0){
        //alert('REcccc :'+recordTypeId);
       // debugger;
         component.set("v.RecordTypeId",recordTypeId);
         //alert(component.get("v.RecordTypeId"));
        var emptylist = [];
        component.set("v.listOfSecionToShow",emptylist);
        if(navigator.geolocation){
            console.log("capability is there");
            
        }else{
            console.log("No Capability");
        }
        navigator.geolocation.getCurrentPosition(function(position) {
            var latit = position.coords.latitude;
            var longit = position.coords.longitude;
            component.set("v.Current_Location__Latitude__s",latit);
            component.set("v.Current_Location__Longitude__s ",longit);
            //alert(latit+':'+longit);
        });
        //var sobject = component.get("v.sObjectName");
       
        helper.getFields(component, event, helper);
        //setTimeout(function(){ component.set("v.ContactName","0035D00001GMUVoQAP"); }, 3000);
	var interval = window.setInterval(function(){ 
        if(!window.location.href.includes('recordTypeId') ){
            window.location.reload();
            //event.preventDefault();
        //var urlEvent = $A.get("e.force:navigateToURL");
        /*var redirectid = component.get("v.recordId");
        if(redirectid != undefined && redirectid.length>0)
            window.location.href = redirectid;
        else
            window.location.href = '/lightning/o/Issues__c/list?filterName=Recent';*/
        }
                          }, 500);
            component.set("v.setIntervalId", interval) ; 
        }/*else {
            debugger;
            alert(component.get("v.setIntervalId"))
            console.log(':::::'+component.get("v.setIntervalId"));
            if(component.get("v.setIntervalId") != undefined){
            window.clearInterval(component.get("v.setIntervalId"));
        }
        }*/
        
    },
    onSuccess : function(component, event, helper) {
		  var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: ' "The record has been Saved successfully."',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
        //debugger;
        var responseJSON = event.getParams();
        //console.log(responseJSON);
    var recordresponse = responseJSON.response; 
        var recordId = recordresponse.id;
        /*var navEvt = $A.get("e.force:navigateToSObject");
        var redirectid = component.get("v.recordId");
        if(redirectid != undefined && redirectid.length>0)
            recordId = redirectid;
        navEvt.setParams({"recordId": recordId,"slideDevName": "detail"});
        console.log('navEvt'+navEvt);
        navEvt.fire();*/
        var redirectid = component.get("v.recordId");
        if(redirectid != undefined && redirectid.length>0)
            recordId = redirectid;
        
            window.location.href = '/'+recordId;
        /*var elements = component.find('loadingSpinner');
        $A.util.addClass(elements, 'slds-show');
        $A.util.removeClass(elements, 'slds-hide');
        */
    },
    handleOnSubmit : function(component, event, helper) {
        //window.clearInterval(component.get("v.setIntervalId"));
       // alert('On submit');
        //debugger;
        event.preventDefault();
        var fields = event.getParam("fields");
        //console.log('fields'+JSON.stringify(fields));
       // fields["RecordtypeId"] = component.get("v.RecordtypeID");
       // fields["Current_Location__Latitude__s"] = component.get("v.latitude");
        //fields["Current_Location__Longitude__s"] = component.get("v.longitude"); 
        
        
        component.find('Formdata').submit(fields);
        
      

        
       /* window.setTimeout(
            $A.getCallback(function() {
                helper.recorddetailspage(component, event,recordId);  
            }), 2000
        );
*/        
    },
    
    onError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": "Error."
        });
        toastEvent.fire();
    },
    cancel : function(component, event, helper) {
        //alert('cancel method');
        event.preventDefault();
        //var urlEvent = $A.get("e.force:navigateToURL");
        var redirectid = component.get("v.recordId");
        if(redirectid != undefined && redirectid.length>0)
            window.location.href = '/'+redirectid;
        else
            window.location.href = '/lightning/o/Issues__c/list?filterName=Recent';
           /*urlEvent.setParams({
            "url": '/'+ component.get("v.recordId")
        });
        else
        urlEvent.setParams({
            "url": '/lightning/o/Issues__c/list?filterName=Recent' 
        });*/
        //urlEvent.fire();
        
    },
})