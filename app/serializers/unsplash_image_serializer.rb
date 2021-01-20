class UnsplashImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :curator, :artist_link, :artist_name, :image_path, :alt_description
end
