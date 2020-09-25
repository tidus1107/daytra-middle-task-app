class TasksController < ApplicationController
    before_action :authenticate_user!

    def show
      board = Board.find(params[:board_id])
      @tasks = current_user.board
    end
end