({    
    handleSave: function(component, event, helper) {
        var Notecmt = component.get("v.Notecmt");
        //alert(component.find("fuploader").get("v.files").length)
        let fileName = component.get("v.fileName"); 
        console.log('fileName' ,fileName + ' ' );
        if(fileName == ''){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message: 'Please select  file',
                    duration:'5000',
                    key: 'info_alt',
                    type: 'warning',
                    mode: 'pester'
                });
                toastEvent.fire();      
        }else{
            
            
            if (component.find("fuploader").get("v.files") == null || component.find("fuploader").get("v.files") == '' || component.find("fuploader").get("v.files").length==0){ 
                //alert('Please Select a Valid File');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message: 'Please select  file',
                    duration:'5000',
                    key: 'info_alt',
                    type: 'warning',
                    mode: 'pester'
                });
                toastEvent.fire();   
                
            } else {
                
                helper.uploadHelper(component, event);
            }
        }
    },
    
    handleFilesChange: function(component, event, helper) {
        var cmpTarget = component.find('fILE_NAMES');
        $A.util.removeClass(cmpTarget, 'slds-show');
        $A.util.addClass(cmpTarget, 'slds-hide');
        var fileName = 'No File Selected..';
        if (event.getSource().get('v.files').length > 0) {
            fileName = event.getSource().get('v.files')[0]['name'];
            
        }
        component.set('v.fileName', fileName);
    },
    download: function(component, event, helper){
        //helper.download(component, event);
        helper.gotoURL(component, event, helper);
    },
    
    handleCancel: function(component, event, helper) {
       // alert('1'+component.find("fuploader").get("v.files").length);
        //component.find("fuploader").get("v.files").set('v.value','');
        //var fileName = '';
        component.set('v.fileName', '');
        //component.set('v.filesdata', '');
        //if( component.find("fuploader").get("v.fileName") == null);
        //alert('Please a file');
        //console.log('c');
        //this.superRerender();
        //  component.find("fuploader").set("v.files",[]); 
        //component.find("fuploader").getElement().value='';
        // component.find('fuploader').set('v.files', []);
        
        
        
        //  $A.get("e.force:closeQuickAction").fire();   
    }
})