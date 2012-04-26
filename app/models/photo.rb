require 'paperclip'

class Photo < ActiveRecord::Base
  belongs_to :uploaded_by, :foreign_key => 'user_id', :class_name => 'User'
  belongs_to :album

  validates_presence_of             :user_id
  validates_attachment_presence     :image
  validates_attachment_size         :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/gif', 'image/jpeg', 'image/png']

  has_attached_file :image,
                    :styles          => { :large => "1280x800", :medium => "700x400", :thumb => "100x60" },
                    :convert_options => { :all => '-auto-orient' },
                    :url             => "/system/images/uploaded/:style/:basename.:extension",
                    :path            => ":rails_root/public/system/images/uploaded/:style/:basename.:extension"

end
