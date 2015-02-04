class Answer < ActiveRecord::Base
    belongs_to :question

    validates :title, presence: true
    validates :content, presence: true
end
