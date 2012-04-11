class Notifier < ActionMailer::Base

  def new_comment(comment, object)
    recipients    'gposton1040@gmail.com'
    from          'Blog <gposton1040@gmail.com>'
    subject       '[Blog] New comment'
    content_type  'text/html'
    body          :comment => comment, :object => object
  end

  def new_photo(photo)
    recipients    'gposton1040@gmail.com'
    from          'Blog <gposton1040@gmail.com>'
    subject       '[Blog] New photo'
    content_type  'text/html'
    body          :photo => photo
  end

  def new_tournament(tournament, recent_tournaments)
    recipients    User.all.collect{|user|user.email}.join(', ')
    from          'Poker <gposton1040@gmail.com>'
    subject       'Poker!!!'
    content_type  'text/html'
    body          :tournament => tournament, :recent_tournaments => recent_tournaments
  end

end
