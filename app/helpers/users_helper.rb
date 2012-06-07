module UsersHelper
  def winnings_graph(results)
    winnings = results.collect{|result| result.net}
    max_winnings = winnings.sort{|a,b|b <=> a}.shift
    min_winnings = winnings.sort{|a,b|a <=> b}.shift
    dates = results.collect{|result|result.tournament.date_string}
    graph = Gchart.line( :data => winnings,
                         :labels => dates,
                         :size => '600x100',
                         :title => 'Winnings/Tournament',
                         :axis_with_labels => 'y',
                         :max_value => max_winnings,
                         :min_value => min_winnings,
                         :bg => {:color => 'eeddcc', :type => 'gradient'})
    graph
  end

  def cumulative_winnings_graph(results)
    winnings = results.collect{|result| result.net}
    cumulative = [winnings.pop]
    winnings.each_index do |i|
      cumulative << cumulative[i] + winnings.pop
    end
    max = cumulative.sort{|a,b|b <=> a}.shift
    min = cumulative.sort{|a,b|a <=> b}.shift
    dates = results.collect{|result|result.tournament.date_string}
    graph = Gchart.line( :data => cumulative,
                         :labels => dates,
                         :size => '600x100',
                         :title => 'Cumulative',
                         :axis_with_labels => 'y',
                         :max_value => max,
                         :min_value => min,
                         :bg => {:color => 'eeddcc', :type => 'gradient'})
    graph
  end

end
