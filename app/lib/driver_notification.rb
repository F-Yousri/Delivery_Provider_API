class DriverNotification
    require 'httparty'
   
   
   
     def self.send_notification(headers = {},params = {},order, device_token)
   
       #this is our header we will place our server api key
       headers.merge!({"Authorization" => "key=AAAA3cB_zrg:APA91bFV3D9nL_4D6VlVPgZKm_f_a82MgHlzmiMIU21hPcRBwZ3lbGXSWVPPbC2DRMghZoxnx4OBny2ZN0E7XSWRRKcSDreXHBaO7HIyzgrrMiHRhBqvgno9weJzdwO_f8OsX8SmpIFpVi2SFXSD1u3E_zIHefuW4A", "Content-Type" => "application/json"})
   
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
       params[:notification] = notification
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
