dir1 = getDirectory("Choose Source Directory ");
print(dir1);
list1 = getFileList(dir1);
for(i=0; i<lengthOf(list1); i++){
	currdir = dir1 + substring(list1[i], 0,10)+"\\";
	//list2 = getFileList(currdir);
	run("Grid/Collection stitching", "type=[Unknown position] order=[All files in directory] directory="+currdir+" output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.10 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]");
	//print(currdir);
	saveAs("Tiff", "F:\\DEND\\arbor\\stitched" + "\\" + substring(list1[i], 0,10) + "_fused" + ".tif");
	run("Close All");
}