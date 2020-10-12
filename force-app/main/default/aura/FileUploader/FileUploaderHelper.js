({
    MAX_FILE_SIZE: 25000000,  
    CHUNK_SIZE: 750000,    
    
    uploadHelper: function(component, event) {
        component.set("v.showLoadingSpinner", true);
        var fileInput = component.find("fuploader").get("v.files") ;
        var Notecmt = component.get("v.Notecmt");
        // alert('Test Alert'+Notecmt);
        console.log('fileInPut');
        var file = fileInput[0];
        console.log('fileInPut');
        var self = this;
        console.log('fileInPut');
        
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner", false);
            component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            console.log('fileInPut');
            return;
        }
        
        
        var objFileReader = new FileReader();
        console.log('objFileReader');
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            console.log('base64');
            var dataStart = fileContents.indexOf(base64) + base64.length;
            
            fileContents = fileContents.substring(dataStart);
            
            self.uploadProcess(component, file, fileContents);
        });
        
        objFileReader.readAsDataURL(file);
        
    },
    
    uploadProcess: function(component, file, fileContents) {
        
        var startPosition = 0;
        
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
        
        
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
    },
    
    
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId) {
        
        var getchunk = fileContents.substring(startPosition, endPosition);
        var Notecmt = component.get("v.Notecmt");
        //  alert('In Helper Method'+Notecmt);
        var action = component.get("c.SaveFile");
        action.setParams({
           // parentId: component.get("v.recordId"),
            parentId: component.get("v.recordId"),
            Notescmt: Notecmt,
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
        
        
        action.setCallback(this, function(response) {
            
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    
                    var cmpTarget = component.find('fILE_NAMES');
                    $A.util.removeClass(cmpTarget, 'slds-hide');
                    $A.util.addClass(cmpTarget, 'slds-show');
                    var sMsg = 'File Uploaded Successfully';
                    $A.get('e.force:refreshView').fire();
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        mode: 'sticky',
                        message: sMsg,
                        duration:' 4000',
                        key: 'info_alt',
                        mode: 'pester',
                        type : 'success'
                        
                    });
                    window.setTimeout(
                        $A.getCallback(function() {
                            $A.util.removeClass(cmpTarget, 'slds-show');
                            $A.util.addClass(cmpTarget, 'slds-hide');
                        }), 3000
                    );
                    //$A.util.removeClass(cmpTarget, 'slds-show');
                    toastEvent.fire();
                    $A.util.removeClass(cmpTarget, 'slds-show');
                    $A.get('e.force:refreshView').fire();
                    
                    var fileName = '';
                    //var filename = component.get("v.fileName");
                    component.set('v.fileName', fileName );
                    //document.getElementById('fuploader').value= null;
                    component.set("v.showLoadingSpinner", false);
                    var Notecmt ='';  
                    component.set("v.Notecmt", "");
                    
                }
                
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        //document.getElementById("fuploader").value = null;
        // component.find("file").getElement().value='';
        $A.enqueueAction(action);
    },
    
    
    gotoURL : function (component, event, helper) { 
        var recordId = component.get( "v.recordId" );
        var action = component.get("c.downlaod");
        action.setParams({
            recordid: component.get("v.recordId"),
            
        });
        
        
        action.setCallback(this, function(response) {
            
            var retuenval = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") { 
                if(retuenval == 'success')
                    window.open("/apex/ZipFilesDownload?id="+recordId,"Download");
                else if(retuenval == 'error'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message:'This Record not contain any file.',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();  
                }             
            } 
        });
        
        $A.enqueueAction(action);
        
        /*var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "/apex/ZipFileDownload?id="+recordId
        });
        urlEvent.fire();*/
        //window.href = "/apex/ZipFileDownload?id="+recordId;
    }
})