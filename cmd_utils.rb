class CmdUtils
  DEFAULT_COMMENT = '対応しました。ご確認お願いします。'.freeze

  def self.digit?(str)
    str.scan(/\D/).empty?
  end

  def self.valid_argv?(argv)
    !argv.empty? && digit?(argv[0])
  end

  def self.extract_issue_ids_and_comment(argv)
    issue_ids = argv[0..-2].map(&:to_i)
    comment = argv[-1]
    if digit?(comment)
      issue_ids << comment.to_i
      comment = DEFAULT_COMMENT
    end

    [issue_ids, comment]
  end

  def self.print_help
    puts 'Arguments invalid!'
    puts ''
    puts 'Usage: $ruby /path/to/gh.rb issue_id1 [issue_id2 ...] [comment]'
    puts 'Eg:    $ruby gh.rb 1498 1750 1321 1678 507 1645 1135'
    puts 'Or:    $ruby gh.rb 1498 1750 1321 1678 507 1645 1135 "This is a comment content"'
  end
end
