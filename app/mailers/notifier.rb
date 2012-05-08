class Notifier < ActionMailer::Base

  default :from => 'Blog <gposton1040@gmail.com>', :to => 'gposton1040@gmail.com'

  def new_comment(comment, object)
    @comment = comment
    @object = object
    mail(:subject => '[Blog] New comment', :content_type => 'text/html')
  end

  def new_photo(photo)
    @photo = photo
    mail(:subject => '[Blog] New photo', :content_type => 'text/html' )
  end

  def new_tournament(tournament, recent_tournaments, to)
    @tournament = tournament
    @recent_tournaments = recent_tournaments
    mail(:to => to.join(','), :from => 'Poker <gposton1040@gmail.com>', :subject => 'Poker!!!', :content_type => 'text/html')
  end

  def error(message, user)
    @time = Time.new.inspect
    @user = user
    @message = message
    mail(:subject => '[Poker] Error', :content_type => 'text/html')
  end

end
