 class Collaboration < ActiveRecord::Base
   belongs_to :collaborable, polymorphic: true
   belongs_to :user
 end
