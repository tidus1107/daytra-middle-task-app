class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        @profile = current_user.profile
    end

    def edit
      if current_user.profile.present?
        @profile = current_user.profile
      else
        @profile = current_user.build_profile
      end
    end

    def update
        @profile = current_user.build_profile(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィールを更新しました'
        else
            flash.now[:error] = '更新出来ませんでした'
            render :edit
        end
    end

    private
    def profile_params
        params.require(:profile).permit(
            :name,
            :department,
            :avatar
        )
    end
end