class TasksController < ApplicationController
    before_action :authenticate_user!

    # def index
    # end

    def show
      board = Board.find(params[:board_id])
      @tasks = board.tasks.find(params[:id])
    end

    def new
      board = Board.find(params[:board_id])
      @task = board.tasks.build
    end

    def create
      board = Board.find(params[:board_id])
      @task = board.tasks.build(task_params)
      @task.user = current_user
      if @task.save
          redirect_to board_path(board), notice: '保存しました'
      else
          flash.now[:error] = '保存に失敗しました'
          render :new
      end
    end

    private
    def task_params
          params.require(:task).permit(:title, :content)
    end
end