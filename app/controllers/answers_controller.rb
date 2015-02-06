class AnswersController < ApplicationController

    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.create(answer_params)

        redirect_to question_path(@question)
    end

    def destroy
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])
        @answer.destroy
        redirect_to question_path(@question)
    end

    def upvotes
        @answer = Answer.find(params[:id])
        @answer.upvote

        respond_to do |format|
            format.js { render "vote", :locals => {:votes_count => @answer.votes } }

            format.any { redirect_to question_path(@answer.question) }
        end
    end

    def downvotes
        @answer = Answer.find(params[:id])
        @answer.downvote

        respond_to do |format|
            format.js { render "vote", :locals => {:votes_count => @answer.votes } }

            format.any { redirect_to question_path(@answer.question) }
        end
    end

    private
        def answer_params
            params.require(:answer).permit(:title, :content)
        end

end
