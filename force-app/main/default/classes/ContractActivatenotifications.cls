public class ContractActivatenotifications {
    public Static Boolean Isrecursive = true;
    public ContractActivatenotifications(){
       
    }
    public void  contractlists(List<Contract> contractlist,Boolean recursive,Map<Id,Contract>oldContractMap){
        if(recursive){
         List<String>userIdsList = New List<String>();
 
        for (User member :  [select id from User where IsActive = True AND  Profile.Name in ('Sales','System Administrator','KAM','Maintenance Manager','Site Manager','Maintenance Executive','Maintenance Head')]){
        userIdsList.add(member.id);
        }
       system.debug('user'+userIdsList);
    
        for  (Contract contractstatus : contractlist){
            system.debug('oldContractMap.get(contractstatus.id).Status ' + oldContractMap.get(contractstatus.id).Status);
            system.debug('contractstatus.Status ' + contractstatus.Status);
            if(oldContractMap.get(contractstatus.id).Status!= contractstatus.Status && contractstatus.Status== 'Active'){
            system.debug('contractstatus'+contractstatus);
                Map<String, Object> params = new Map<String, Object>();
                params.put('TargetId', contractstatus.id);
                params.put('NotificationTitle', 'Contract Activated');
                params.put('NotificationBody', 'Contract is Activated for '+contractstatus.Name);
                params.put('NotificationRecipientIDs', userIdsList);
                Flow.Interview.VehicleManagementNotifications flowToRemoveAcc = new Flow.Interview.VehicleManagementNotifications(params);
                flowToRemoveAcc.start();
            }
        }
            if(!Test.isRunningTest())
       ContractActivatenotifications.Isrecursive = false;
        }
    } 
}