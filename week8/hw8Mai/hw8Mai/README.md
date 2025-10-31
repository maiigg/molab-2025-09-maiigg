# Filter Gallery 
Simple project that shows all the filters in a sliding style grid 
I was inspired by Mac's old version of photobooth where it would show you a gallery of the possible filters and you could see them all at once. I took the basics of the CaptureRecorder code and tweaked it to instead have an array of videos, each with filtered versions of the live camera. 





I replaced FrameView with GalleryView, which creates the format for the array, and then utilised the Grid Format Code I learned last week for my edited photo storage
In model-filterImage, I coded a new method which used similar logic as the original example's code, but obviously included tweaking to accomodate for printing ALL of the filters instead of one filter according to what was chosen. 
It took a lot of tweaking and deciding what needed to be tweaked and where, along with where to add new methods, but once I had everything I needed, doing the formating and everything was more self-explanatory. 

For debugging, I did use chatgpt for the errors when my app kept crashing because of permission issues, so I made it lead me through the process of adding all the permissions necessary. 

