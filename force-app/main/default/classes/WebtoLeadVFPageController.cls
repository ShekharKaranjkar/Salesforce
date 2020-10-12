public class WebtoLeadVFPageController {
	public Lead leadObj {get;set;}

    public WebtoLeadVFPageController(){
        leadObj=new Lead(); 

    }
    public void save(){               

          insert leadObj;

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,' Lead submitted successfully'));
        leadObj=new Lead();
    }
    public void clear(){
        leadObj=new Lead();
    }
}