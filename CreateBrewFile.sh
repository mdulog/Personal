# Check if BrewFile exists and remove it if it does
if [ -e "BrewFile" ]; then
  echo "Removing existing BrewFile"
  rm BrewFile -v
else
  echo "BrewFile does not exist"
fi

# Create BrewFile
echo "Creating BrewFile"
brew bundle dump -v