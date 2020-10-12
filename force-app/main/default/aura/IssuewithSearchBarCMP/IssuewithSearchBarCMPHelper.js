({
    plotMap: function(component){
        var options = {
            //enableHighAccuracy: true
        };
        function success(position) {            
            const latitude  = position.coords.latitude;
            const longitude = position.coords.longitude;
            component.set('v.mapMarkers', [
                {
                    location: {
                        Latitude : latitude,
                        Longitude: longitude,
                    },
                    title: 'Current Position',
                    description: 'This is your current location'
                }
            ]);
            component.set('v.zoomLevel', 16);
            component.set('v.mapStatus', '');
            component.set('v.latitude', latitude);
            component.set('v.longitude', longitude);
        }
        function error() {
            component.set('v.mapStatus', 'Unable to retrieve your location');
        }
        if (!navigator.geolocation) {
            component.set('v.mapStatus', 'Geolocation is not supported by your browser');
        } else {
            component.set('v.mapStatus', 'Locating…');
            navigator.geolocation.getCurrentPosition(success, error, options);
        }
    },
    
    
    getType: function(component){
        var sObjectName = component.get("v.sObjectName");
        var objectFieldName;
        if(sObjectName !== undefined && sObjectName !== null){
            if(sObjectName.valueOf().includes("__c")){
                objectFieldName = sObjectName.valueOf();
            }else{
                objectFieldName = sObjectName.valueOf()+ '__c';
            }
            component.set("v.objectFieldName",objectFieldName);
        }
        var action = component.get("c.isCheckIn");
        action.setParams({ 
            objectsName: component.get("v.objectsName"),
            recordId: component.get("v.recordId"),
            dateTimeStampField: component.get("v.dateTime"),
            relatedObjectField: objectFieldName,
            typeField: component.get("v.typeField")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                component.set('v.isCheckIn', response.getReturnValue());
            }else if(state==='ERROR'){
                 $A.get("e.force:closeQuickAction").fire();
                this.showToast('fail');    
            }else{
                console.log('There is some technical Issue.');
            }
        });
        $A.enqueueAction(action);
    },
    
    
    saveRecord: function(component){
        var isCheckIn = component.get("v.isCheckIn");
        var action = component.get("c.saveRecord");
        action.setParams({ 
            objectsName: component.get("v.objectsName"),
            recordId: component.get("v.recordId"),
            latitudeField: component.get("v.latitudeField"),
            longitudeField: component.get("v.longitudeField"),
            latitude: component.get("v.latitude"),
            longitude: component.get("v.longitude"),
            dateTimeStampField: component.get("v.dateTime"),
            relatedObjectField: component.get("v.objectFieldName"),
            typeField: component.get("v.typeField"),
            isCheckIn: isCheckIn
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                component.set('v.stage', 'success');
                $A.get("e.force:closeQuickAction").fire();
                this.showToast('success', isCheckIn);
                $A.get('e.force:refreshView').fire();
            }else if(state==='ERROR'){
                component.set('v.stage', 'fail');
                $A.get("e.force:closeQuickAction").fire();
                this.showToast('fail', isCheckIn);   
            }else{
                console.log('There is some technical Issue.');
            }
        });
        $A.enqueueAction(action);
        component.set('v.stage', 'saving');
    },
    
    
    showToast: function(stage, isCheckIn) {
        var toastEvent = $A.get("e.force:showToast");
        var text = isCheckIn ? "in" : "out";
        
        switch (stage) {
            case 'success':
                toastEvent.setParams({
                    "mode": "dismissible",
                    "type": "success",
                    "title": "Checked " + text + "!",
                    "message": "You have successfully checked " + text  + "."
                });    
                break;
            default:
                toastEvent.setParams({
                    "mode": "dismissible",
                    "type": "error",
                    "title": "Error",
                    "message": "Something went wrong."
                });
                break;
        }
        toastEvent.fire();
    }
})