class BoardsController < ApplicationController
    # before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
      @boards = Board.all
    end

    def show
      @board = Board.find(params[:id])
    end

    def new
      @board = Board.new
    end

    def create
      @board = Board.new(board_params)
      @board.user = current_user
      if @board.save
          redirect_to board_path(@board), notice: '保存しました'
      else
          flash.now[:error] = '保存に失敗しました'
          render 'boards/new'
      end
    end

    def edit
      @board = Board.find(params[:id])
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
end
