public class GuestReviewProcessor {
    @InvocableMethod (label='Process Guest Reviews' description='Processes guest experience reviews and adds contact to related ca')
    public static List<GuestReviewResponse> processReviews(List<GuestReviewRequest> requests) {
        List<GuestReviewResponse> responses = new List<GuestReviewResponse>();
		List<Guest_Review__c> reviewsList = new List<Guest_Review__c>();
        for (GuestReviewRequest request : requests) {
            GuestReviewResponse response = new GuestReviewResponse();
			Guest_Review__c experienceRecord = new Guest_Review__c();
            experienceRecord.Contact__c = request.contact.Id;
            experienceRecord.Experience__c = request.experience.Id;
            experienceRecord.Rating__c = request.rating;
            experienceRecord.Comments__c = request.review;
            reviewsList.add(experienceRecord);
            
            try{              
				Database.SaveResult[] results = Database.insert(reviewsList, false);
				for(Integer i = 0; i<requests.size(); i++) {
                    if (results[i].isSuccess()) {
                        response.message = 'Guest review successfully processed';
                    }
                    
                    else{
                        response.message = 'Failed to process';
                    }  
            	}
                
                responses.add(response);
                
            }
            catch(Exception ex){
                
            }
            
        }
        return responses;
    }

    public class GuestReviewRequest{
        //TO-DO Build out GuestReviewRequest class with Invocable variables
        
	@InvocableVariable(required=true label='Contact' description= 'The contact who submits the review')
	public Contact contact;
        
	@InvocableVariable(required=true label='Experience description="Experience who submits the review')
	public Experience__c experience;

    @InvocableVariable(required=true label='Review' description='Description provided by guest')
	public String review;

    @InvocableVariable(required=true label='Rating' description='The rating given by guest')
	public String rating;
    }
        
	public class GuestReviewResponse {
    //TO-DO Build out GuestReviewResponse class with Invocable variables
    @InvocableVariable(label='Status' description='Status of the review')
    public String message;
    }
  }