class SlideShowsController < ApplicationController
  def create
    @slide_show = SlideShow.first_or_initialize
    @slide_show.images.attach(params[:slide_show][:images])

    if @slide_show.save
      redirect_to new_slide_show_path, notice: "Slide show image uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def reorder
    @slide_show = SlideShow.first_or_initialize

    params[:order].each_with_index do |image_id, index|
      attachment = @slide_show.images.attachments.find(image_id)
      attachment.update(position: index)
    end

    redirect_to new_slide_show_path, notice: "Slide show reordered successfully."
  rescue => e
    Rails.logger.error "Error reordering slideshow: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  def destroy
    @slide_show = SlideShow.first_or_initialize
    image = @slide_show.images.find(params[:image_id])

    image.purge
    redirect_to new_slide_show_path, notice: "Image removed successfully."
  end

  def remove_image
  @slide_show = SlideShow.first_or_initialize
  image = @slide_show.images.find(params[:image_id])
  image.purge
  redirect_to new_slide_show_path, notice: "Image removed successfully."
end

    def new
     @slide_show = SlideShow.first_or_initialize
    end
end