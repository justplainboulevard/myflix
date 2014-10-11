
# module Form

#   class CreateVideo

#     include Virtus

#     extend ActiveModel::Naming
#     include ActiveModel::Conversion
#     include ActiveModel::Validations

#     attribute :title, String
#     attribute :description, Text
#     attribute :category_ids, Array

#     validates :title, presence: true, length: { maximum: 150 }
#     validates :description, presence: true, length: { maximum: 1500 }

#     def persisted?
#       false
#     end

#     def save
#       if valid?
#         persist!
#         true
#       else
#         false
#       end
#     end

#   private

#     def persist!
#       @video = Video.create!(title: title, description: description)
#       category_ids.each do |category_id|
#         VideoCategory.create!(category_id: category_id, video_id: @video.id)
#       end
#     end
#   end

#   # ALTERNATIVE APPROACH USING TRANSACTION:
#   # def create_objects
#   #   ActiveRecord::Base.transaction do
#   #     user.save!
#   #     business.save!
#   #     membership.save!
#   #   end
#   # rescue
#   #   false
#   # end
# end