require 'spec_helper'

describe UsersController, "RefererTracking" do
  before :each do
    @request.env['HTTP_REFERER'] = (@referer = "awesome.pa.ge/believe/me")
    @request.env['HTTP_USER_AGENT'] = @ua = "Fancy new UA"
    @request.env['REMOTE_ADDR'] = @ip = '102.97.107.101'
    @request.env['HTTP_ACCEPT_LANGUAGE'] = @accept_language = 'eo'
    @request.env['HTTP_X_FORWARDED_FOR'] = @forwarded_ip = '10.0.23.42'
    get :new
  end

  it "saves referer_url to session" do
    session[:retrack].should_not be_blank
    session[:retrack][:referer_url].should == @referer
  end

  it "saves first_url to session" do
    session[:retrack].should_not be_blank
    session[:retrack][:first_url].should =~ %r(users/new$)
  end

  context "on the second request" do
    before :each do
      @request.env['HTTP_REFERER'] = ("this.is.the.new/referer")
    end

    it "doesn't update referer_url" do
      get :index
      session[:retrack][:referer_url].should == @referer
    end

    it "doesn't update first_url" do
      get :index
      session[:retrack][:first_url].should =~ %r(users/new$)
    end
  end

  describe "POST 'create'" do
    it "saves a user" do
      expect {
        post :create
      }.to change(User.all, :count).by(1)
    end

    it "saves a RefererTracking" do
      expect {
        post :create
      }.to change(ReTrack::RefererTracking.all, :count).by(1)
    end

    context "when saving the RefererTracking" do
      before :each do
        post :create
        @rt = ReTrack::RefererTracking.last
      end

      it "saves the referer_url in RefererTracking" do
        @rt.referer_url.should == @referer
      end

      it "saves the first_url in RefererTracking" do
        @rt.first_url.should =~ %r(users/new$)
      end

      it "saves the user_agent in RefererTracking" do
        @rt.user_agent.should == @ua
      end

      it "saves the first_visited_at in RefererTracking" do
        # TODO: use Timecop
        @rt.first_visited_at.should be_within(5.seconds).of(DateTime.now)
      end

      it "saves the correct user in RefererTracking" do
        user = User.last
        @rt.trackable.should == user
      end

      it 'saves the ip in RefererTracking' do
        @rt.ip.should == @ip
      end

      it 'saves the accept_language in RefererTracking' do
        expect(@rt.accept_language).to eq @accept_language
      end

      it 'saves forwarded_ip in RefererTracking' do
        expect(@rt.forwarded_ip).to eq @forwarded_ip
      end
    end

    it "completes the response when there are errors in the sweeper" do
      ReTrack::RefererTracking.any_instance.stub(:save).and_raise
      post :create
      response.should be_a_redirect # not a 500
    end
  end
end
