class TasksController < ApplicationController
    before_action :authenticate_user!

    # def index
    # end

    # def show
    #   board = Board.find(params[:board_id])
    #   @tasks = current_user.board
    # end

    def new
      board = Board.find(params[:board_id])
      @task = current_user.board.tasks.build
    end
end