public class HttpCallout {

    private static final String ENDPOINT_URL = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2';

    public static void makeHttpCallout() {        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT_URL);
        request.setMethod('GET');

        try {           
            HttpResponse response = http.send(request);            
            if (response.getStatusCode() == 200) {                
                System.debug('HTTP Response Body: ' + response.getBody());
            } else {                
                System.debug('HTTP Request failed with status code: ' + response.getStatusCode());
            }
        } catch (Exception e) {            
            System.debug('Exception: ' + e.getMessage());
        }
    }
}