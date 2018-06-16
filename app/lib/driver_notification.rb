class DriverNotification
    require 'httparty'
   
   
   
     def self.send_notification(headers = {},params = {},order, device_token)
   
       #this is our header we will place our server api key
   
       headers.merge!({"Authorization" => "key=<%=Rails.application.secrets.firebase_API_key%>", "Content-Type" => "application/json"})
   
       #Here is the body and here we will pass FIREBASE_NOTIFICATION_URL#####
   
         params = notification_params(order,device_token)
         body = JSON.generate(params)
         HTTParty.post('https://fcm.googleapis.com/fcm/send',
         :body => body,
         :headers => headers)
          
     end
   
     def self.notification_params(order,device_token)
       params = {}
       params[:registration_ids] = device_token
   
       params[:priority] = "high"
       data = {}
       data[:notification_id] = order[:id]
       data[:title] = order[:title]
       data[:description] = order[:description]
       data[:src_latitude] = order[:src_latitude]
       data[:src_longitude] = order[:src_longitude]
       data[:dest_latitude] = order[:dest_latitude]
       data[:dest_longitude] = order[:dest_longitude]
       
   
       params[:data] = data
       params
     end 
end
