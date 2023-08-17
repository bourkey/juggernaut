#!/bin/bash
# PreReqs - docker login complete -
# Update the registry var - new_registry
# Path to the text file containing Docker image names
image_file="image_list.txt"

# Registry to tag and push the images
new_registry="new.registry.com"

# Log in to the new registry
#docker login $new_registry

# Read the image names from the file and process them
while IFS= read -r image_name || [[ -n "$image_name" ]]; do
    # Pull the original image
    docker pull $image_name

    # Tag the image with the new registry
    new_image_name="$new_registry/$image_name"
    docker tag $image_name $new_image_name

    # Push the tagged image to the new registry
    docker push $new_image_name

    # Remove the original and tagged images
    docker rmi $image_name
    docker rmi $new_image_name
done < "$image_file"

# Log out from the new registry
docker logout $new_registry


