public class RecoveryInstallment {
    public static void createRecord(list<Driver_Recovery__c> dList){
      list<Recovery_Installments__c> rcoveryList=new list<Recovery_Installments__c>();
        for(Driver_Recovery__c dr:dList){
            
            for(integer i=0;i<dr.Total_Number_of_Installments__c;i++){
                Recovery_Installments__c robj=new Recovery_Installments__c();
                robj.Driver_Recovery__c=dr.Id;
         //       robj.Amount__c=dr.Total_Amount_to_be_paid_per_Month__c;
                rcoveryList.add(robj);
            }
            
        }
        insert rcoveryList;
    }
}