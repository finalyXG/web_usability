Under this folder, each .mat file is a web page object with following fields:

.I: the image of the web page.

.components: the segmentation of the web into a set of components. Each component has the following fields:
	.tag: the type of the component (e.g., IMG, BUTTON and TEXT)
	.polygon: the geometry of the component (x: the x-coordinates of four corners of the bounding box, y: the y-coordinates of four corners of the bounding box)