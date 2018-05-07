class CmdUtils
  DEFAULT_COMMENT = '対応しました。ご確認お願いします。'.freeze

  def initialize(argv)
    @argv = argv
  end

  def self.print_help
    puts ''
    puts 'Usage: $ruby /path/to/gh.rb cmd issue_id1 [issue_id2 ...] [comment content]'
    puts 'cmd:'
    puts '     comment: Comment into given issue(s)'
    puts '     move: Move given issue(s) from GH_COLUMN_SOURCE to GH_COLUMN_TARGET'
    puts '     comment_and_move: Combination of comment and move commands'
    puts '     info: Get given issue(s) link(s) and title(s)'
    puts 'Eg:    $ruby gh.rb move 1498 1750 1321 1678 507 1645 1135'
    puts 'Or:    $ruby gh.rb comment 1498 1750 1321 1678 507 1645 1135 "This is a comment content"'
  end

  def self.digit?(str)
    str.scan(/\D/).empty?
  end

  def valid_argv?
    !@argv.empty? && digit?(@argv[1])
  end

  def cmd
    @argv[0]
  end

  def extract_issue_ids_and_comment
    issue_ids = issue_ids(false)
    comment = comment_content
    if digit?(comment)
      issue_ids << comment.to_i
      comment = DEFAULT_COMMENT
    end

    [issue_ids, comment]
  end

  private

  def digit?(str)
    self.class.digit?(str)
  end

  def issue_ids(take_last = true)
    return @argv[1..-2].map(&:to_i) unless take_last
    @argv[1..-1].map(&:to_i)
  end

  def comment_content
    @argv[-1]
  end
end
