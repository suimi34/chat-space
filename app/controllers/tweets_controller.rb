class TweetsController < ApplicationController
  def search
  client = Twitter::REST::Client.new do |config|
    config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
  end

  @tweets = []
  since_id = nil

  if params[:keyword].present?

    tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
    tweets.take(10).each do |tw|
      tweet = Tweet.new(tw.full_text)
      @tweets << tweet
    end
  end
  respond_to do |format|
    format.html
  end
end
