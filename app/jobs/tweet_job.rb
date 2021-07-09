class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    # Rescheduled a tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end

end

# Push the publish_at time back
# noon -> 8am
# -
# 8am -> sets tweet id
# Noon -> already published, does nothing


# Push the publish_at time forward
# 9am -> 1pm
# -
# 9am -> should do nothing
# 1pm should publish the tweet and set the tweet id