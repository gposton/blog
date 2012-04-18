atom_feed :language => 'en-US' do |feed|
  feed.title 'Three programmers walked into a bar...'
  feed.updated @posts.last.created_at unless @posts.empty?

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry( post ) do |entry|
      entry.url post_url(post)
      entry.title post.title
      entry.content textilize(post.content), :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name 'Glenn Poston'
      end
    end
  end
end
