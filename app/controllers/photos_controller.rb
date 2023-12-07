class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc})

    render({ :template => "photo_templates/index"})
  end

  def show
    url_id = params.fetch("path_id")
    
    matching_photos = Photo.where({ :id => url_id })

    @the_photo = matching_photos.at(0)

    render({ :template => "photo_templates/show"})
  end

  def destroy
    the_id = params.fetch("delete_id")

    matching_photos = Photo.where({ :id => the_id})

    the_photo = matching_photos.at(0)

    the_photo.destroy

    redirect_to("/photos")
  end

  def create
    # Parameters: {"query_image"=>"a", "query_caption"=>"b", "query_owner_id"=>"c"}

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save
    
    redirect_to("/photos/#{a_new_photo.id}")
  end

  def update
    the_id = params.fetch("modify_id")

    matching_photos = Photo.where({ :id => the_id})

    the_photo = matching_photos.at(0)

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")

    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save

    redirect_to("/photos/#{the_photo.id}")
  end
end
