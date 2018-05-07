require_relative 'cmd_utils'
require_relative 'gh_tool'

gh = GhTool.new
util = CmdUtils.new(ARGV)

unless util.valid_argv?
  CmdUtils.print_help
  return
end

issue_ids, comment = util.extract_issue_ids_and_comment
case util.cmd
when 'comment'
  puts "Comment into issue(s): #{issue_ids.join(', ')}"
  puts "with comment: #{comment}"
  gh.comment(comment, *issue_ids)

when 'move'
  puts "Move issue(s): #{issue_ids.join(', ')}"
  gh.move(*issue_ids)

when 'info'
  puts "Get issue(s) info: #{issue_ids.join(', ')}"
  gh.info(*issue_ids)

when 'comment_and_move'
  puts "Comment and move issue(s): #{issue_ids.join(', ')}"
  puts "with comment: #{comment}"
  gh.comment_and_move(comment, *issue_ids)

else
  puts "INVALID COMMAND [#{ARGV[0]}]"
  CmdUtils.print_help
end
