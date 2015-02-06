class Question < ActiveRecord::Base
    has_many :answers

    validates :title, presence: true
    validates :content, presence: true

    def upvote
        self.votes += 1
        self.save
    end

    def downvote
        self.votes -= 1
        self.save
    end
end
