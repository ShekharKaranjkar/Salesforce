/**
 * An Fluent API based Apex Class
 * to manipulate Rich Texts.
 *
 * @author      Deepak (Dazeworks Inc)
 * @version     1.0
 * @revisions   -----------------------------------------------------------------------
 *              Date                Change                                      Author
 *              -----------------------------------------------------------------------
 *              15 May 2020         Added Function - trimUnsupportedTags        Deepak
 */
public class RichTextAPI {
    private final String IMG_REGEX = '<img(.+?)>';
    
    public String richText;
    public String richTextWithoutImgTags;
    public String imageMarkup;
    
    public List<String> imageTags;
    public List<String> imageURLs;
    
    public List<Id> contentDocs;
    
    /**
     * ctor
     */
    public RichTextAPI( String richText ) {
        this.richText = richText;
        
        this.imageTags = new List<String>();
        this.imageURLs = new List<String>();
        
        this.contentDocs = new List<String>();
    }
    
    /**
     * Use RegEx to extract the Image Tags from
     * a given block of Rich Text.
     * 
     * @return      RichTextAPI      An instance of the RichTextAPI
     *                               class
     */
    public RichTextAPI getImageURLs() {
        if( String.isNotBlank( this.richText ) ) {
            Matcher imgMatcher = Pattern.compile( IMG_REGEX ).matcher( this.richText );
            
            while ( imgMatcher.find() ) {
                String imageTag = imgMatcher.group();
                
                /**
                 * Grab the path to the
                 * image contained in the
                 * Rich Text in the form of
                 * an HTML <img> tag.
                 */
                String imageURL = imageTag.substringBetween( ' src="', '"' );
                
                /**
                 * Unescape the src especially
                 * to remove the &amp; in them.
                 */
                String decodedURL = imageURL.unescapeHtml4();
               
                this.imageTags.add( imageTag );
                
                this.imageURLs.add( decodedURL );
            }
        }
        
        return this;
    }

    /**
     * Returns true if the given block of
     * Rich Text has <img> tags in them.
     * 
     * @return Boolean  TRUE if there are <img> tags
     */
    public Boolean hasInlineImages() {
        return !this.imageTags.isEmpty();
    }
    
    /**
     * Grab the ContentDocument IDs from the
     * Image URLs.
     * 
     * @return      RichTextAPI      An instance of the RichTextAPI
     *                               class
     */
    public RichTextAPI getImageContentDocuments() {
        if( !this.imageURLs.isEmpty() ) {
            Set<Id> contentVersionIds = new Set<Id>();
            
            /**
             * When you upload images via the lighting:inputRichText
             * and if the sharedWithEntityId is being used, Salesforce
             * would upload them to the ContentDocument instead of
             * ContentReference. But the <img> tags would be having
             * links to the down-loadable ContentVersion records. Thus
             * query the ContentVersion and grab the ContentDocument IDs
             * as these are handy when making a Chatter Post.
             */
            for( String imgUrl : this.imageURLs ) {
                //Extract CV Id
                String cvId = imgUrl.substringBetween( 'download/', '?' );
                
                contentVersionIds.add( cvId );
            }
            
            if( !contentVersionIds.isEmpty() ) {
                for( ContentVersion cv : [
                    SELECT  ContentDocumentId
                    FROM    ContentVersion
                    WHERE   Id IN :contentVersionIds
                ] ) {
                    this.contentDocs.add( cv.ContentDocumentId );
                }
            }
        }
        
        return this;
    }
    
    /**
     * Remove the <img> tags from the Rich Text.
     * 
     * @return      RichTextAPI      An instance of the RichTextAPI
     *                               class
     */
    public RichTextAPI trimImageTags() {
        if( !this.imageTags.isEmpty() ) {
            this.richTextWithoutImgTags = this.richText;
            for( String imgTag : this.imageTags ) {
                this.richTextWithoutImgTags = this.richTextWithoutImgTags.replace( imgTag, '' );
            }
        }
        
        return this;
    }
    
    /**
     * Remove unsupported tags such as <br> by
     * replacing it with <p></p>
     * 
     * @return      RichTextAPI      An instance of the RichTextAPI
     *                               class
     */
    public RichTextAPI trimUnsupportedTags() {
        if( !String.isBlank( this.richText ) ) {
            this.richText = this.richText.replaceAll( '<br>', '<p>&nbsp;</p>' )
                                         .replaceAll( '<strike>', '<s>' )
                                         .replaceAll( '</strike>', '</s>' );
        }
        
        if( !String.isBlank( this.richTextWithoutImgTags ) ) {
            this.richTextWithoutImgTags = this.richTextWithoutImgTags.replaceAll( '<br>', '<p>&nbsp;</p>' )
                                                                     .replaceAll( '<strike>', '<s>' )
                                                                     .replaceAll( '</strike>', '</s>' );
        }
        
        return this;
    }

    
    /**
     * Create a ConnectApiHelper friendly markup
     * to insert images.
     * Refer: https://github.com/forcedotcom/ConnectApiHelper/blob/master/force-app/main/default/classes/ConnectApiHelper.cls#L94
     * 
     * @return      RichTextAPI      An instance of the RichTextAPI
     *                               class
     */
    public RichTextAPI createImageMarkup() {
        if( !this.contentDocs.isEmpty() ) {
            this.imageMarkup = '';
            for( String contDocId : this.contentDocs ) {
                this.imageMarkup += '{img:' + contDocId + ':Uploaded Image}';
            }
        }
        
        return this;
    }
}