class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, 
             :image_path,
             :tags
end
