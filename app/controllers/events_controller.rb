# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_request, only: :create
  before_action :authenticate_user, only: :index
  before_action :get_issue, only: :index

  # GET /issues
  def index
    events = @issue.events
    render json: events, status: 200
  end

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
      event.number = issue.github_issue_id
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

  def authenticate_user
    @body = request.body.rewind
    @body = request.body.read
    valid_user = AuthenticateUser.grant_access(
      request_headers: request.headers, body: @body
    )
    render json: { errors: valid_user[1] }, status: 500 if valid_user[0] == :error
  end

  def get_issue
    @issue = Issue.find(params[:issue_id])
  end
end
