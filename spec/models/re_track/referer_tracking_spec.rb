# coding: utf-8
require 'spec_helper'

module ReTrack
  describe RefererTracking do
    let(:referer_tracking) { RefererTracking.new }

    describe '#query' do
      subject { referer_tracking.query('q') }

      it { should be_nil }

      context 'when there is a first_url' do
        before { referer_tracking.first_url = 'http://google.de/' }
        it { should be_nil }
      end

      context 'when the first_url contains the parameter' do
        before { referer_tracking.first_url = 'http://google.de/?q=query&a=b' }
        it { should == 'query' }
      end

      context 'when the first_url does not contain the parameter' do
        before { referer_tracking.first_url = 'http://google.de/?a=b' }
        it { should be_nil }
      end

      context 'when first_url is url_encoded' do
        before do
          referer_tracking.first_url = CGI::escape 'http://google.de/?q=query'
        end
        it { should == 'query' }
      end

      context 'with an invalid url' do
        before { referer_tracking.first_url = 'h a l l o' }
        it { should be_nil }
      end

      context 'when querying an invalid field' do
        before do
          referer_tracking.first_url = '?q=f'
          referer_tracking.user_agent = '?q=u'
        end
        subject { referer_tracking.query('q', 'user_agent') }
        it { should be_nil }
      end

      context 'when querying a non-existent field' do
        subject { referer_tracking.query('q', 'hidden') }
        it { should be_nil }
      end

      context 'when querying referer_url' do
        before do
          referer_tracking.first_url = '?q=f'
          referer_tracking.referer_url = '?q=r'
        end
        subject { referer_tracking.query('q', 'referer_url') }
        it { should == 'r' }
      end
    end
  end
end
