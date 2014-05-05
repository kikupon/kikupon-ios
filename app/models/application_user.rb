class ApplicationUser
    attr_accessor :user_id, :twitter_user_id, :facebook_user_id, :user_name, :email
    def self.sharedUser
        Dispatch.once { @@instance ||= new }
        @@instance
    end

    def is_logined
        return !@user_name.nil?
    end

    def save
        NSLog("saved")
        App::Persistence['user_id'] = @user_id
        App::Persistence['twitter_user_id'] = @twitter_user_id
        App::Persistence['facebook_user_id'] = @facebook_user_id
        App::Persistence['user_name'] = @user_name
        App::Persistence['email'] = @email
        user = @@instance.user_name.nil? ? 'nil' : @@instance.user_name
        NSLog(user)
    end
    def load
        NSLog("loaded")
        @user_id          = App::Persistence['user_id']
        @twitter_user_id  = App::Persistence['twitter_user_id']
        @facebook_user_id = App::Persistence['facebook_user_id']
        @user_name        = App::Persistence['user_name']
        @email            = App::Persistence['email']
    end

end
