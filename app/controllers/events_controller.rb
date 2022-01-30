# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_request, only: :create

  # POST /events
  def create
    event = Event.new
    body = JSON.parse(@body)

    unless body['issue'].nil?
      issue = Issue.where(github_issue_id: body['issue']['id']).first
      if issue.nil?
        issue = Issue.new
        issue.github_issue_id = body['issue']['id']
        issue.tittle = body['issue']['title']
        issue.save
      end
      event = Event.new
      event.action = body['action']
      event.issue_id = issue.id
    end
    if event.save
      render json: event, status: :created, location: event
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  private

  def authenticate_request
    @body = request.body.rewind
    @body = request.body.read
    valid_request = AuthenticateGithub.authenticate_request(
      request_headers: request.headers, body: @body
    )
    render json: { errors: valid_request[1] }, status: 500 if valid_request[0] == :error
  end
end
