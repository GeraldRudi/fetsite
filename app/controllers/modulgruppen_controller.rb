# -*- coding: utf-8 -*-
class ModulgruppenController < ApplicationController
  # GET /modulgruppen


  load_and_authorize_resource
  def index
    @modulgruppen = Modulgruppe.all
    if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id])
    else
      @studium=Studium.first
    end
  end

  # GET /modulgruppen/1

  def show
    @modulgruppe = Modulgruppe.find(params[:id])
    @studium = Studium.find(@modulgruppe.studium_id)
    if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id])
    end
    @toolbar_elements = [ {:text=>'Zurück', :path=>studium_path(@studium, :ansicht=>:modulgruppenansicht)}]
    @toolbar_elements << {:hicon=>'icon-plus-sign', :text=>I18n.t('modulgruppe.addmodul'), :path=>new_modul_path(@modulgruppe)}
    @toolbar_elements << {:hicon=>'icon-pencil', :text=>I18n.t('modulgruppe.edit'), :path=>edit_modulgruppe_path(@modulgruppe)}
    @toolbar_elements << {:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => studium_path(@studium, :ansicht=>:modulgruppenansicht), :method=> :delete,:confirm=>"Sure?" }
  end

  # GET /modulgruppen/new

  def new
    @modulgruppe = Modulgruppe.new
    if !params[:studium_id].nil?
      @modulgruppe.studium_id=(params[:studium_id])
    else
      @modulgruppe.studium_id=studium_id=Studium.first.id
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modulgruppe }
    end

  end

  # GET /modulgruppen/1/edit
  def edit
    @modulgruppe = Modulgruppe.find(params[:id])
    if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id])
    end
  end

  # POST /modulgruppen

  def create
    @modulgruppe = Modulgruppe.new(params[:modulgruppe])
    
    respond_to do |format|
         
      if @modulgruppe.save
        format.html { redirect_to @modulgruppe.studium, notice: 'Modulgruppe was successfully created.' }

      else
        format.html { render action: "new" }
        
      end
    end
  end


  def update
    @modulgruppe = Modulgruppe.find(params[:id])

    respond_to do |format|
      if @modulgruppe.update_attributes(params[:modulgruppe])
        format.html { redirect_to @modulgruppe, notice: 'Modulgruppe was successfully updated.' }
        
      else
        format.html { render action: "edit" }
        
      end
    end
  end

  # DELETE /modulgruppen/1

  def destroy
    @modulgruppe = Modulgruppe.find(params[:id])
    @modulgruppe.destroy

    respond_to do |format|
      format.html { redirect_to modulgruppen_url }

    end
  end
end
