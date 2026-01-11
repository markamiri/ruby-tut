# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "product_gallery"
pin "sortablejs" # @1.15.6
pin "image_preview"

pin "holo_cards"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.js"
pin "slideshow_controller"
pin "feature_banner"