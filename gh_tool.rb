require 'octokit'
require 'dotenv/load'

class GhTool
  def initialize
    @gh = Octokit::Client.new(login: ENV['GH_USERNAME'],
                              password: ENV['GH_PASSWORD'])
    @info = {
      repo: ENV['GH_REPO'],
      project_name: ENV['GH_PROJECT_NAME'],
      source_column: ENV['GH_COLUMN_SOURCE'],
      target_column: ENV['GH_COLUMN_TARGET']
    }
  end

  def fetch_project
    projects = @gh.projects(@info[:repo])
    projects.find { |prj| prj[:name] == @info[:project_name] }
  end

  def fetch_columns
    project = fetch_project
    columns = @gh.project_columns(project[:id].to_i)
    source_column = columns.find { |c| c[:name] == @info[:source_column] }
    target_column = columns.find { |c| c[:name] == @info[:target_column] }
    [source_column, target_column]
  end

  def add_comment_to_issues(comment = '対応しました。ご確認お願いします。', *issue_ids)
    issue_ids.each do |issue_id|
      @gh.add_comment(@info[:repo], issue_id, comment)
      puts "Add comment to ISSUE ##{issue_id}"
    end
  end

  def fetch_my_cards(column_id, *issue_ids)
    cards = @gh.column_cards(column_id)
    cards.select do |card|
      issue_id = card[:content_url].split('/')[-1].to_i
      issue_ids.include?(issue_id)
    end
  end

  def move_cards(*issue_ids)
    source_column, target_column = fetch_columns
    source_column_id = source_column[:id].to_i
    target_column_id = target_column[:id].to_i

    my_cards = fetch_my_cards(source_column_id, *issue_ids)
    puts 'No card to move' || return if my_cards.empty?

    my_cards.each do |card|
      @gh.move_project_card(card[:id], 'top', column_id: target_column_id)
      puts "Moved card: #{card[:content_url]}"
    end
  end
end
