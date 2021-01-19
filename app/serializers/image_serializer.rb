class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, 
             :image_path,
             :tags,
             :artist
end
