class DriverNotification
    require 'httparty'
   
   
   
     def self.send_notification(headers = {},params = {},order, device_token)
   
       #this is our header we will place our server api key
       headers.merge!({"Authorization" => "key=AAAASIV9WLc:APA91bGI29Y5lSrSBDXSZ8FNqqFEZhjZKtafK2Mccp_muwCD7lD9LKvz8INKPgX75NhMNL-2nPUbm6nyHhgyA-EKiU6zHfXq4I-mf_-GQ5xr6WScw6kTtBXDFQEhl6tAoP1cVKfco1fy", "Content-Type" => "application/json"})
   
       #Here is the body and here we will pass FIREBASE_NOTIFICATION_URL#####
   
         params = notification_params(order,device_token)
         body = JSON.generate(params)
         HTTParty.post('https://fcm.googleapis.com/fcm/send',
         :body => body,
         :headers => headers).parsed_response
          
     end
   
     def self.notification_params(order,device_token)
       params = {}
       message = {}
       notification = {}
       body = order
       title = 'new order request'
       token = device_token
       notification[:body]=body
       notification[:title]=title
       params[:to]=token
       message[:notification] = notification
   
       params[:data] = message
      #  data = {}
      #  data[:notification_id] = order[:id]
      #  data[:title] = order[:title]
      #  data[:description] = order[:description]
      #  data[:src_latitude] = order[:src_latitude]
      #  data[:src_longitude] = order[:src_longitude]
      #  data[:dest_latitude] = order[:dest_latitude]
      #  data[:dest_longitude] = order[:dest_longitude]
       
   
      #  params[:message] = data
       params
     end 
end
