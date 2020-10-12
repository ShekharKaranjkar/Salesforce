public class invoiceId1 {
    public string numtoword {get;set;}
    public string numtowordcn {get;set;}
    public string numtowordR {get;set;}
    public string numtowordG {get;set;}
    public string numtowordreg {get;set;}
    public Id recordId {set;get;}
    public decimal sgst {set;get;}
    public decimal sgstcn {set;get;}
    public decimal sgstR {set;get;}
    public decimal sgstreg {set;get;}
    public decimal CGST {set;get;}
    public decimal CGSTcn {set;get;}
    public decimal CGSTR {set;get;}
    public decimal CGSTreg {set;get;}
    public decimal IGSTR {set;get;}
    public decimal IGSTRcn {set;get;}
    public decimal IGSTRr {set;get;}
    public decimal IGSTreg {set;get;}
    public decimal IGSTG {set;get;}
    public decimal sgstG {set;get;}
    public decimal CGSTG {set;get;}
    
    public decimal total {set;get;}
    public decimal totalcn {set;get;}
    public decimal totalR {set;get;}
    public decimal subtotal {set;get;}
    public decimal subtotalcn {set;get;}
    public decimal subtotalR {set;get;}
    public decimal subtotalG {set;get;}
    public decimal subtotalreg {set;get;}
    public decimal totalG {set;get;}
    public decimal totalreg {set;get;}
    public Account acc {set;get;}
    public Invoices__c invoice {set;get;}
    public Invoices__c invoiceList{get;set;}
    public String a {get;set;}
    public List<Billing_Locations__c>getData {get;set;}
    public Billing_Locations__c billoc{get;set;}
    public List<Bank_Address__c>getD {get;set;}
    public Bank_Address__c bilc{get;set;}
    public  boolean showcgst{set;get;}
    
    public invoiceId1() {   
        
        recordId = ApexPages.currentPage().getParameters().get('recId');   
        system.debug('RecordId'+recordId);
        // invoice = Invoices__c.getvalues('Template');
        //if(recordId != null){
        invoiceList = [SELECT Id, Name,RecordTypeId, Description__c, No_of_Vehicles__c,Date__c, Rate_per_Car__c, Account__c,Account__r.Name,
                       Account__r.BillingStreet,Account__r.BillingCity,Account__r.BillingState,Rate_per_Trip__c,No_of_Trips__c,Due_Date__c,
                       Account__r.BillingPostalCode,Account__r.ShippingStreet,Account__r.ShippingCity,Account__r.ShippingState,
                       Contract__r.ContractNumber,Contract__r.StartDate,Account__r.Lithium_Bank_Account__c,Account__r.Lithium_Billing_Entity__c,
                       Sub_Totalcn__c, Sub_TotalR__c,Account__r.Payment_Terms__c,Subtotal__c,Description3__c,Description4__c,
                       SGST_6_cn__c, CGST_6__c,  IGST_12__c, IGST_12_cn__c,AmountsR__c, Amount__c,AmountG__c,Sub_TotalG__c, IGST_12_G__c,TotalG__c,
                       IGST_12_R__c, Total__c, Totalcn__c, CGST_6_cn__c, CGST_6_R__c, Total_R__c,Account__r.GSTN__c,Account__r.PAN__c,Amountcn__c,  
                       Account__r.Bank_Account_Number__c,Account__r.Bank_Address__c,Account__r.Bank_Name__c,Account__r.IFSC_Code__c, Description1__c, 
                       Account__r.ShippingPostalCode,Campus__r.Lithium_Bank_Account__c,Campus__r.Lithium_Billing_Entity__c,
                       Campus__r.PAN__c,Campus__r.GSTN__c,Campus__r.CIN__c,Campus__r.Bank_Name__c,Campus__r.IFSC_Code__c,Campus__r.Bank_Account_Number__c,
                       Campus__r.Bank_Address__c,Campus__r.Billing_Street__c,Campus__r.Billing_City__c,
                       SGST_6_Reg__c,CGST_6_Reg__c,IGST_12_Reg__c,
                       Campus__r.Billing_State_Province__c,Campus__r.Billing_Zip_Postal_Code__c,Amount_Reg__c,Subtotalreg__c,
                       Campus__r.Billing_Country__c,Campus__r.Shipping_City__c,Campus__r.Shipping_Country__c,Campus__r.Shipping_State_Province__c,
                       Campus__r.Shipping_Street__c,Campus__r.Shipping_Zip_Postal_Code__c,Campus__r.Payment_Terms__c
                       
                       
                       FROM Invoices__c where Id =:recordId];
        
        sgst=0;  CGST=0; IGSTR=0; sgstcn=0;  CGSTcn=0;  IGSTRcn=0;sgstR=0;CGSTR=0;IGSTRr=0; sgstG =0; CGSTG=0; IGSTG=0;sgstreg =0;CGSTreg =0;IGSTreg =0;
        if(invoiceList.Amount__C !=null){
            sgst = invoiceList.Amount__C*0.06;
            CGST = invoiceList.Amount__C*0.06;
            IGSTR= invoiceList.Amount__c *0.12;
        }
        if(invoiceList.Amountcn__c !=null){
            sgstcn =  invoiceList.Amountcn__c *0.06;
            CGSTcn =invoiceList.Amountcn__c *0.06; 
            IGSTRcn =invoiceList.Amountcn__c *0.12;
        }
        if(invoiceList.AmountsR__c !=null){
            sgstR  =invoiceList.AmountsR__c*0.06;
            CGSTR =invoiceList.AmountsR__c*0.06;
            IGSTRr = invoiceList.AmountsR__c *0.12;
        }
        if(invoiceList.AmountG__c !=null){
            sgstG  =invoiceList.AmountG__c*0.06;
            CGSTG =invoiceList.AmountG__c*0.06;
            IGSTG = invoiceList.AmountG__c * 0.12;
        }
        if(invoiceList.Amount_Reg__c !=null){
            sgstreg  =invoiceList.Amount_Reg__c*0.06;
            CGSTreg =invoiceList.Amount_Reg__c*0.06;
            IGSTreg = invoiceList.Amount_Reg__c * 0.12;
        }
        
        subtotal= invoiceList.Subtotal__c;
        subtotalcn= invoiceList.Sub_Totalcn__c;
        subtotalR= invoiceList.Sub_TotalR__c;
        subtotalG = invoiceList.Sub_TotalG__c;
        subtotalreg =   invoiceList.Subtotalreg__c;     
        //total = subtotal + sgst +CGST +IGSTR;
        //system.debug('1'+total);
        //totalcn = subtotalcn + sgstcn +CGSTcn+IGSTRcn;
        //  totalR = subtotalR +sgstR +CGSTR +IGSTRr;
        // totalG = subtotalG + sgstG+CGSTG+IGSTG;
        showcgst = false ;
        Map<String,Billing_Locations__c> allLocMap = Billing_Locations__c.getAll();
        //system.debug('alldata ' + alldata);
        if(allLocMap.containsKey(invoiceList.Campus__r.Lithium_Billing_Entity__c)){
            Billoc = allLocMap.get(invoiceList.Campus__r.Lithium_Billing_Entity__c);
            system.debug('test'+Billoc);
            system.debug('qq'+invoiceList.Campus__r.GSTN__c);
            if(invoiceList != NULL && String.isNotBlank(invoiceList.Campus__r.GSTN__c) && String.isNotBlank(Billoc.GSTIN__c)){
                if(invoiceList.Campus__r.GSTN__c.substring(0,2) == Billoc.GSTIN__c.substring(0,2) ){
                    showcgst = true;
                    total = subtotal + sgst +CGST;
                    system.debug('total'+total);
                    totalcn = subtotalcn + sgstcn +CGSTcn;
                    totalR = subtotalR + sgstR +CGSTR;
                    totalG = subtotalG + sgstG +CGSTG;
                    totalreg = subtotalreg + sgstreg + CGSTreg;
                }else{
                    total = subtotal+IGSTR;
                    system.debug('hh'+total);
                    totalcn = subtotalcn + IGSTRcn;
                    totalR = subtotalR + IGSTRr;
                    totalG = subtotalG + IGSTG;
                    totalreg = subtotalreg + IGSTreg;
                }
                numtoword = NumberToWord.english_number(integer.valueof(total)); 
                system.debug('zz'+numtoword);
                numtowordcn = NumberToWord.english_number(integer.valueof(totalcn));
                numtowordR = NumberToWord.english_number(integer.valueof(totalR));
                numtowordG = NumberToWord.english_number(Integer.valueof(totalG));
                numtowordreg = NumberToWord.english_number(Integer.valueof(totalreg));
            }
        }
        Map<String, Bank_Address__c> allBankMap =  Bank_Address__c.getAll();
        if(allBankMap.containsKey(invoiceList.Campus__r.Lithium_Bank_Account__c)){
            bilc = allBankMap.get(invoiceList.Campus__r.Lithium_Bank_Account__c);
        }
    } 
}