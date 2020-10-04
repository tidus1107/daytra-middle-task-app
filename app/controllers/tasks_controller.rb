class TasksController < ApplicationController
    before_action :authenticate_user!

    # def index
    # end

    def show
      board = Board.find(params[:board_id])
      @task = board.tasks.find(params[:id])
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

    def edit
      board = Board.find(params[:board_id])
      @task = board.tasks.find(params[:id])
      @task.user = current_user
    end

    def update
      board = Board.find(params[:board_id])
      @task = board.tasks.find(params[:id])
      @task.user = current_user
        if @task.update(task_params)
            redirect_to board_task_path(id: @task.id), notice: '更新出来ました'
        else
            flash.now[:error] = '更新出来ませんでした'
            render :edit
        end
    end

    private
    def task_params
          params.require(:task).permit(:title, :content, :eyecatch)
    end
end