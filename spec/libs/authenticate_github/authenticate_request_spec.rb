# This method will test the method that authenticates the posts from the webhook
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateGithub, type: :lib do

  describe 'authenticate_request' do

    let(:request_headers) {
      {
        'Content-Type':	'application/json',
        'X-Github-Event':	'issue_comment',
        'X-Hub-Signature': 'sha1=12c6b5721e813a955265c48a6fe9dbf01368bbbb',
        'X-Hub-Signature-256':	'sha256=2417365a3f1d442b24a8cc7b75fa67992c95ec0ccfe3c97110b96f55971e0953'
      }
    }

    let(:body) {
      "{\"action\":\"created\",\"issue\":{\"url\":\"https://api.github.com/repos/efranco89/messenger/issues/1\",\"repository_url\":\"https://api.github.com/repos/efranco89/messenger\",\"labels_url\":\"https://api.github.com/repos/efranco89/messenger/issues/1/labels{/name}\",\"comments_url\":\"https://api.github.com/repos/efranco89/messenger/issues/1/comments\",\"events_url\":\"https://api.github.com/repos/efranco89/messenger/issues/1/events\",\"html_url\":\"https://github.com/efranco89/messenger/issues/1\",\"id\":1117996550,\"node_id\":\"I_kwDOGWo1vs5Co0YG\",\"number\":1,\"title\":\"I want to test webhooks\",\"user\":{\"login\":\"efranco89\",\"id\":26636074,\"node_id\":\"MDQ6VXNlcjI2NjM2MDc0\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/26636074?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/efranco89\",\"html_url\":\"https://github.com/efranco89\",\"followers_url\":\"https://api.github.com/users/efranco89/followers\",\"following_url\":\"https://api.github.com/users/efranco89/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/efranco89/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/efranco89/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/efranco89/subscriptions\",\"organizations_url\":\"https://api.github.com/users/efranco89/orgs\",\"repos_url\":\"https://api.github.com/users/efranco89/repos\",\"events_url\":\"https://api.github.com/users/efranco89/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/efranco89/received_events\",\"type\":\"User\",\"site_admin\":false},\"labels\":[],\"state\":\"open\",\"locked\":false,\"assignee\":null,\"assignees\":[],\"milestone\":null,\"comments\":9,\"created_at\":\"2022-01-29T01:57:17Z\",\"updated_at\":\"2022-01-29T16:41:07Z\",\"closed_at\":null,\"author_association\":\"OWNER\",\"active_lock_reason\":null,\"body\":\"This is a webhook testing\",\"reactions\":{\"url\":\"https://api.github.com/repos/efranco89/messenger/issues/1/reactions\",\"total_count\":0,\"+1\":0,\"-1\":0,\"laugh\":0,\"hooray\":0,\"confused\":0,\"heart\":0,\"rocket\":0,\"eyes\":0},\"timeline_url\":\"https://api.github.com/repos/efranco89/messenger/issues/1/timeline\",\"performed_via_github_app\":null},\"comment\":{\"url\":\"https://api.github.com/repos/efranco89/messenger/issues/comments/1024944453\",\"html_url\":\"https://github.com/efranco89/messenger/issues/1#issuecomment-1024944453\",\"issue_url\":\"https://api.github.com/repos/efranco89/messenger/issues/1\",\"id\":1024944453,\"node_id\":\"IC_kwDOGWo1vs49F2lF\",\"user\":{\"login\":\"efranco89\",\"id\":26636074,\"node_id\":\"MDQ6VXNlcjI2NjM2MDc0\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/26636074?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/efranco89\",\"html_url\":\"https://github.com/efranco89\",\"followers_url\":\"https://api.github.com/users/efranco89/followers\",\"following_url\":\"https://api.github.com/users/efranco89/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/efranco89/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/efranco89/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/efranco89/subscriptions\",\"organizations_url\":\"https://api.github.com/users/efranco89/orgs\",\"repos_url\":\"https://api.github.com/users/efranco89/repos\",\"events_url\":\"https://api.github.com/users/efranco89/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/efranco89/received_events\",\"type\":\"User\",\"site_admin\":false},\"created_at\":\"2022-01-29T16:41:07Z\",\"updated_at\":\"2022-01-29T16:41:07Z\",\"author_association\":\"OWNER\",\"body\":\"GitHub's REST API considers every pull request to be an issue, but not every issue is a pull request. For this reason, the Issue Events and Timeline Events endpoints may return both issues and pull requests in the response. Pull requests have a pull_request property in the issue object. Because pull requests are issues, issue and pull request numbers do not overlap in a repository. For example, if you open your first issue in a repository, the number will be 1. If you then open a pull request, the number will be 2. Each event type specifies if the event occurs in pull request, issue\",\"reactions\":{\"url\":\"https://api.github.com/repos/efranco89/messenger/issues/comments/1024944453/reactions\",\"total_count\":0,\"+1\":0,\"-1\":0,\"laugh\":0,\"hooray\":0,\"confused\":0,\"heart\":0,\"rocket\":0,\"eyes\":0},\"performed_via_github_app\":null},\"repository\":{\"id\":426390974,\"node_id\":\"R_kgDOGWo1vg\",\"name\":\"messenger\",\"full_name\":\"efranco89/messenger\",\"private\":false,\"owner\":{\"login\":\"efranco89\",\"id\":26636074,\"node_id\":\"MDQ6VXNlcjI2NjM2MDc0\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/26636074?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/efranco89\",\"html_url\":\"https://github.com/efranco89\",\"followers_url\":\"https://api.github.com/users/efranco89/followers\",\"following_url\":\"https://api.github.com/users/efranco89/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/efranco89/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/efranco89/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/efranco89/subscriptions\",\"organizations_url\":\"https://api.github.com/users/efranco89/orgs\",\"repos_url\":\"https://api.github.com/users/efranco89/repos\",\"events_url\":\"https://api.github.com/users/efranco89/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/efranco89/received_events\",\"type\":\"User\",\"site_admin\":false},\"html_url\":\"https://github.com/efranco89/messenger\",\"description\":null,\"fork\":false,\"url\":\"https://api.github.com/repos/efranco89/messenger\",\"forks_url\":\"https://api.github.com/repos/efranco89/messenger/forks\",\"keys_url\":\"https://api.github.com/repos/efranco89/messenger/keys{/key_id}\",\"collaborators_url\":\"https://api.github.com/repos/efranco89/messenger/collaborators{/collaborator}\",\"teams_url\":\"https://api.github.com/repos/efranco89/messenger/teams\",\"hooks_url\":\"https://api.github.com/repos/efranco89/messenger/hooks\",\"issue_events_url\":\"https://api.github.com/repos/efranco89/messenger/issues/events{/number}\",\"events_url\":\"https://api.github.com/repos/efranco89/messenger/events\",\"assignees_url\":\"https://api.github.com/repos/efranco89/messenger/assignees{/user}\",\"branches_url\":\"https://api.github.com/repos/efranco89/messenger/branches{/branch}\",\"tags_url\":\"https://api.github.com/repos/efranco89/messenger/tags\",\"blobs_url\":\"https://api.github.com/repos/efranco89/messenger/git/blobs{/sha}\",\"git_tags_url\":\"https://api.github.com/repos/efranco89/messenger/git/tags{/sha}\",\"git_refs_url\":\"https://api.github.com/repos/efranco89/messenger/git/refs{/sha}\",\"trees_url\":\"https://api.github.com/repos/efranco89/messenger/git/trees{/sha}\",\"statuses_url\":\"https://api.github.com/repos/efranco89/messenger/statuses/{sha}\",\"languages_url\":\"https://api.github.com/repos/efranco89/messenger/languages\",\"stargazers_url\":\"https://api.github.com/repos/efranco89/messenger/stargazers\",\"contributors_url\":\"https://api.github.com/repos/efranco89/messenger/contributors\",\"subscribers_url\":\"https://api.github.com/repos/efranco89/messenger/subscribers\",\"subscription_url\":\"https://api.github.com/repos/efranco89/messenger/subscription\",\"commits_url\":\"https://api.github.com/repos/efranco89/messenger/commits{/sha}\",\"git_commits_url\":\"https://api.github.com/repos/efranco89/messenger/git/commits{/sha}\",\"comments_url\":\"https://api.github.com/repos/efranco89/messenger/comments{/number}\",\"issue_comment_url\":\"https://api.github.com/repos/efranco89/messenger/issues/comments{/number}\",\"contents_url\":\"https://api.github.com/repos/efranco89/messenger/contents/{+path}\",\"compare_url\":\"https://api.github.com/repos/efranco89/messenger/compare/{base}...{head}\",\"merges_url\":\"https://api.github.com/repos/efranco89/messenger/merges\",\"archive_url\":\"https://api.github.com/repos/efranco89/messenger/{archive_format}{/ref}\",\"downloads_url\":\"https://api.github.com/repos/efranco89/messenger/downloads\",\"issues_url\":\"https://api.github.com/repos/efranco89/messenger/issues{/number}\",\"pulls_url\":\"https://api.github.com/repos/efranco89/messenger/pulls{/number}\",\"milestones_url\":\"https://api.github.com/repos/efranco89/messenger/milestones{/number}\",\"notifications_url\":\"https://api.github.com/repos/efranco89/messenger/notifications{?since,all,participating}\",\"labels_url\":\"https://api.github.com/repos/efranco89/messenger/labels{/name}\",\"releases_url\":\"https://api.github.com/repos/efranco89/messenger/releases{/id}\",\"deployments_url\":\"https://api.github.com/repos/efranco89/messenger/deployments\",\"created_at\":\"2021-11-09T21:23:23Z\",\"updated_at\":\"2021-11-09T21:48:51Z\",\"pushed_at\":\"2022-01-29T01:21:50Z\",\"git_url\":\"git://github.com/efranco89/messenger.git\",\"ssh_url\":\"git@github.com:efranco89/messenger.git\",\"clone_url\":\"https://github.com/efranco89/messenger.git\",\"svn_url\":\"https://github.com/efranco89/messenger\",\"homepage\":null,\"size\":167,\"stargazers_count\":0,\"watchers_count\":0,\"language\":\"Ruby\",\"has_issues\":true,\"has_projects\":true,\"has_downloads\":true,\"has_wiki\":true,\"has_pages\":false,\"forks_count\":0,\"mirror_url\":null,\"archived\":false,\"disabled\":false,\"open_issues_count\":1,\"license\":null,\"allow_forking\":true,\"is_template\":false,\"topics\":[],\"visibility\":\"public\",\"forks\":0,\"open_issues\":1,\"watchers\":0,\"default_branch\":\"main\"},\"sender\":{\"login\":\"efranco89\",\"id\":26636074,\"node_id\":\"MDQ6VXNlcjI2NjM2MDc0\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/26636074?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/efranco89\",\"html_url\":\"https://github.com/efranco89\",\"followers_url\":\"https://api.github.com/users/efranco89/followers\",\"following_url\":\"https://api.github.com/users/efranco89/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/efranco89/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/efranco89/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/efranco89/subscriptions\",\"organizations_url\":\"https://api.github.com/users/efranco89/orgs\",\"repos_url\":\"https://api.github.com/users/efranco89/repos\",\"events_url\":\"https://api.github.com/users/efranco89/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/efranco89/received_events\",\"type\":\"User\",\"site_admin\":false}}"
    }

    context 'When the github key matches' do
      before do
        ENV['GITHUB_TOKEN'] = '123456789'
      end

      let(:authenticated_user) {
        AuthenticateGithub.authenticate_request(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns ok and a confirmation message' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:ok)
        expect(authenticated_user[1]).to eq('Github tokens are valid')
      end
    end

    context 'When the github key does not match' do
      before do
        ENV['GITHUB_TOKEN'] = '12345678654'
      end

      let(:authenticated_user) {
        AuthenticateGithub.authenticate_request(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('Github tokens are invalid')
      end
    end

    context 'When the headers are incomplete' do

      let(:request_headers) {
        {
          'X-Github-Event':	'issue_comment',
          'X-Hub-Signature': 'sha1=7183d7de5eaa11dc8872654858628f29729106c2',
          'X-Hub-Signature-256':	'sha256=05e12c2569ebccc48ea91176f5febd0148d35983cd279fe44c822996a10f3948'
        }
      }

      before do
        ENV['GITHUB_TOKEN'] = '12345678654'
      end

      let(:authenticated_user) {
        AuthenticateGithub.authenticate_request(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('The Content-Type header is mandatory')
      end
    end

    context 'When the content_type is not valid' do

      let(:request_headers) {
        {
          'Content-Type':	'application/json_url_encoded_xxx',
          'X-Github-Event':	'issue_comment',
          'X-Hub-Signature': 'sha1=7183d7de5eaa11dc8872654858628f29729106c2',
          'X-Hub-Signature-256':	'sha256=05e12c2569ebccc48ea91176f5febd0148d35983cd279fe44c822996a10f3948'
        }
      }

      before do
        ENV['GITHUB_TOKEN'] = '12345678654'
      end

      let(:authenticated_user) {
        AuthenticateGithub.authenticate_request(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('The application/json_url_encoded_xxx is not a valid format')
      end
    end

  end
end
