class CommentsController < ApplicationController
    before_action :authenticate_user!

    def new
        board = Board.find(params[:board_id])
        task = board.tasks.find(params[:task_id])
        @comment = task.comments.build
    end

    def create
        board = Board.find(params[:board_id])
        task = board.tasks.find(params[:task_id])
        @comment = task.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save!
            redirect_to board_task_path(id: task.id), notice: 'コメントしました'
        else
            flash.now[:error] = 'コメント出来ませんでした'
            render :new
        end
    end

    private
    def comment_params
          params.require(:comment).permit(:content)
    end
end