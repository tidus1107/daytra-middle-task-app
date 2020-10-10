class BoardsController < ApplicationController
    before_action :set_board, only: [:show]
    before_action :authenticate_user!

    def index
      @boards = Board.all
    end

    def show
      @tasks = @board.tasks
    end

    def new
      @board = current_user.boards.new
    end

    def create
      @board = current_user.boards.new(board_params)
      if @board.save
          redirect_to board_path(@board), notice: '保存しました'
      else
          flash.now[:error] = '保存に失敗しました'
          render 'boards/new'
      end
    end

    def edit
      @board = current_user.boards.find(params[:id])
    end

    def update
      @board = current_user.boards.find(params[:id])
        if @board.update(board_params)
            redirect_to board_path(@board), notice: '更新出来ました'
        else
            flash.now[:error] = '更新出来ませんでした'
            render :edit
        end
    end

    def destroy
      board = current_user.boards.find(params[:id])
      board.destroy!
      redirect_to '/', notice: '削除に成功しました'
    end

    private
    def board_params
      params.require(:board).permit(:name, :description)
    end

    def set_board
      @board = Board.find(params[:id])
    end
end
