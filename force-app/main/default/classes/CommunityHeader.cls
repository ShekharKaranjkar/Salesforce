public class CommunityHeader {
	
    public String userId{get;set;}
    public CommunityHeader(){
        //userId = JSON.serialize( ApexPages.currentPage().getCookies());
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        Integer maxAge = 604800;  //7 Days
        
	   counter = new Cookie('SFUID',UserInfo.getUserId(),null,maxAge,true,'Lax');
       ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
    } 
   public PageReference Logout() {
	   
  //Pagereference pg1 = new Pagereference('/serviceprovider/secur/logout.jsp');
   //Pagereference pg1 = new Pagereference('/s/');
   	/*Cookie counter = ApexPages.currentPage().getCookies().get('counter');
	counter = new Cookie('Uid','',null,0,true);
    ApexPages.currentPage().setCookies(new Cookie[]{counter});*/
 	
       final PageReference target = new
        PageReference(Site.getBaseSecureUrl() + '/secur/logout.jsp');
        target.setRedirect(true);
        // This is a permanent redirection
        target.setRedirectCode(301);
        return target;
   
       
	
   /* After Logging out, we are redirecting the user to Login page */

   //pg1.setRedirect(true);

   //return pg1;

   }
  /*  public PageReference Notification() {
        final PageReference target = new
        PageReference(Site.getBaseSecureUrl() + '/secur/logout.jsp');
        target.setRedirect(true);
        // This is a permanent redirection
        target.setRedirectCode(301);
        return target;
    } */

   
}