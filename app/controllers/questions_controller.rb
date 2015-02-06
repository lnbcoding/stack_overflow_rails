class QuestionsController < ApplicationController

    def index
        @questions = Question.order("votes desc").all
        headers = { :headers => {
          "Authorization" => "token #{ENV["GH_KEY"]}",
          "User-Agent" => "zenman"
        } }

        response = HTTParty.get("https://api.github.com/zen", headers)
        @random_quote = response.parsed_response
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
        # respond_to do |format|
        #     format.js do
        #         render partial: "newquestion"
        #     end

        #     format.any do
        #         redirect_to new_question_path
        #     end
        # end
    end

    def edit
        @question = Question.find(params[:id])
    end

    def create
        @question = Question.new(question_params)
        @question.save

        redirect_to @question
        # respond_to do |format|
        #     format.js do
        #         redirect_to questions_path
        #     end

        #     format.any do
        #         redirect_to @question
        #     end
        # end
    end

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            redirect_to @question
        else
            render 'edit'
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy

        respond_to do |format|
            format.js do
                render nothing: true
            end

            format.any do
                redirect_to questions_path
            end
        end
    end

    def upvotes
        @question = Question.find(params[:id])
        @question.upvote

        respond_to do |format|
            format.js { render "vote", :locals => {:votes_count => @question.votes} }

            format.any { redirect_to questions_path }
        end
    end

    def downvotes
        @question = Question.find(params[:id])
        @question.downvote

        respond_to do |format|
            format.js { render "vote", :locals => {:votes_count => @question.votes} }

            format.any { redirect_to questions_path }
        end
    end

    private
        def question_params
            params.require(:question).permit(:title, :content)
        end

end
