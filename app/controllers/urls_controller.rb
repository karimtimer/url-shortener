# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: %i[show edit update destroy]

  # GET /urls or /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1 or /urls/1.json
  def show; end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit; end

  # POST /urls or /urls.json
  def create
    shorten_url_operation = UrlShortener.call(long_url: url_params[:long_url])

    respond_to do |format|
      if shorten_url_operation[:success] == true
        @url = shorten_url_operation[:url]
        format.html { redirect_to url_url(@url), notice: 'Url was successfully created.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: shorten_url_operation[:errors], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1 or /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to url_url(@url), notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect
    redirect_to Url.find_by(short_url: params[:id]).long_url, status: :found, allow_other_host: true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_url
    @url = Url.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def url_params
    params.require(:url).permit(:long_url, :short_url)
  end
end
