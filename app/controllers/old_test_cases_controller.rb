class OldTestCasesController < ApplicationController

  # GET /old_test_cases
  # GET /old_test_cases.json
  def index
    # @old_test_cases = OldTestCase.all
    @old_test_cases = OldTestCase.order(:test_link_id).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @old_test_cases }
    end
  end

  # GET /old_test_cases/1
  # GET /old_test_cases/1.json
  def show
    @old_test_case = OldTestCase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @old_test_case }
    end
  end

  # GET /old_test_cases/new
  # GET /old_test_cases/new.json
  def new
    @old_test_case = OldTestCase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @old_test_case }
    end
  end

  # GET /old_test_cases/1/edit
  def edit
    @old_test_case = OldTestCase.find(params[:id])
  end

  # POST /old_test_cases
  # POST /old_test_cases.json
  def create
    @old_test_case = OldTestCase.new(params[:old_test_case])

    respond_to do |format|
      if @old_test_case.save
        format.html { redirect_to @old_test_case, notice: 'Old test case was successfully created.' }
        format.json { render json: @old_test_case, status: :created, location: @old_test_case }
      else
        format.html { render action: "new" }
        format.json { render json: @old_test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /old_test_cases/1
  # PUT /old_test_cases/1.json
  def update
    @old_test_case = OldTestCase.find(params[:id])

    respond_to do |format|
      if @old_test_case.update_attributes(params[:old_test_case])
        format.html { redirect_to @old_test_case, notice: 'Old test case was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @old_test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /old_test_cases/1
  # DELETE /old_test_cases/1.json
  def destroy
    @old_test_case = OldTestCase.find(params[:id])
    @old_test_case.destroy

    respond_to do |format|
      format.html { redirect_to old_test_cases_url }
      format.json { head :ok }
    end
  end
end
