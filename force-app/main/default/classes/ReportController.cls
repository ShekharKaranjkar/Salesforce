public class ReportController 
{
	public ReportController()
	{  
		Apexpages.currentPage().getHeaders().put('X-Frame-Options', 'sameorigin');
     Apexpages.currentPage().getHeaders().put('Content-Security-Policy', 'frame-ancestors \'self\'');
	}
}