# coding: utf-8
require 'spec_helper'

module ReTrack
  describe RefererTracking do
    let(:referer_tracking) { RefererTracking.new }

    subject { referer_tracking.query('q') }

    it { should be_nil }

    context 'when there is a referer_url' do
      before { referer_tracking.referer_url = 'http://google.de/' }
      it { should be_nil }
    end

    context 'when the referer_url contains the parameter' do
      before { referer_tracking.referer_url = 'http://google.de/?q=query&a=b' }
      it { should == 'query' }
    end

    context 'when the referer_url does not contain the parameter' do
      before { referer_tracking.referer_url = 'http://google.de/?a=b' }
      it { should be_nil }
    end

    context 'when referer_url is url_encoded' do
      before do
        referer_tracking.referer_url = CGI::escape 'http://google.de/?q=query'
      end
      it { should == 'query' }
    end

    context 'with an invalid url' do
      before { referer_tracking.referer_url = 'h a l l o' }
      it { should be_nil }
    end

    context 'when querying an invalid field' do
      before do
        referer_tracking.referer_url = '?q=r'
        referer_tracking.user_agent = '?q=u'
      end
      subject { referer_tracking.query('q', 'user_agent') }
      it { should be_nil }
    end

    context 'when querying a non-existent field' do
      subject { referer_tracking.query('q', 'hidden') }
      it { should be_nil }
    end

    context 'when querying first_url' do
      before do
        referer_tracking.referer_url = '?q=r'
        referer_tracking.first_url = '?q=f'
      end
      subject { referer_tracking.query('q', 'first_url') }
      it { should == 'f' }
    end
  end
end
