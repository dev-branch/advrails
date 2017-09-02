class KlassesController < ApplicationController
  before_action :auth_teacher

  def index
    @klasses = Klass.all.order(id: 'asc')
    ap @klasses
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(params[:klass].permit(:name, :subject, :level, :credits))
    if @klass.save
      redirect_to klasses_path
    else
      render 'new'
    end
  end

  def section_list
    @klass = Klass.find(params[:id])
    @section = Section.new
  end

  def section_create
    klass = Klass.find(params[:id])
    title = params[:section][:title]
    content = params[:section][:content]
    link = params[:section][:link]
    file = params[:section][:file]
    position = klass.sections.size

    if !file.blank?
      orig = file.original_filename
      token = SecureRandom.hex(64)
      path = "#{Rails.root}/uploads/#{token}"
      FileUtils.cp file.path, path
      UploadImagesJob.perform_later(klass.id, title, content, link, orig, token, path, file.content_type, position)
    else
      Section.create!(klass: klass, title: title, content: content, link: link, position: position)
    end

    redirect_to sections_klass_path(klass)
  end

  def up
    klass = Klass.find(params[:id])
    section1 = Section.find(params[:section_id])
    section2 = klass.sections.where(position: section1.position - 1).first

    if section1.position > 0
      section1.update(position: section1.position - 1)
      section2.update(position: section1.position + 1) if section2
    end

    redirect_to sections_klass_path(klass)
  end

  def down
    klass = Klass.find(params[:id])
    section1 = Section.find(params[:section_id])
    section2 = klass.sections.where(position: section1.position + 1).first

    if section1.position < klass.sections.size - 1
      section1.update(position: section1.position + 1)
      section2.update(position: section1.position - 1) if section2
    end

    redirect_to sections_klass_path(klass)
  end
end
