class BoardsController < ApplicationController
    # before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        render 'boards/index'
    end

    def new
        @board = current_user.boards.build
    end
end
