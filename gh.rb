require_relative 'cmd_utils'
require_relative 'gh_tool'

if CmdUtils.valid_argv?(ARGV)
  issue_ids, comment = CmdUtils.extract_issue_ids_and_comment(ARGV)
  puts "Comment and move issue(s): #{issue_ids.join(', ')}"
  puts "with comment: #{comment}"

  gh = GhTool.new
  gh.add_comment_to_issues(comment, *issue_ids)
  gh.move_cards(*issue_ids)
else
  CmdUtils.print_help
end
