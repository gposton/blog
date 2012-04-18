class PictureFrame
  def self.currently_displayed
    Photo.find_by_displaying true
  end

  def self.replace_displayed_with(new_photo)
    current_photo = PictureFrame.currently_displayed
    new_photo.displaying = true
    new_photo.save
    unless current_photo.nil?
      current_photo.displaying = false
      current_photo.save
    end
    %x{ssh gposton@roush 'pkill chrome'}
    %x{ssh -X gposton@roush 'DISPLAY=:0.0 nohup google-chrome --kiosk http://www.glennposton.com/picture_frame/show?layout=false > /dev/null 2> /dev/null &'}
  end
end
