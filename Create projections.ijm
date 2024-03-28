dir1 = getDirectory("Choose Source Directory ");
print(dir1);
list1 = getFileList(dir1);
for(i=0; i<lengthOf(list1); i++){
	currdir = dir1 + substring(list1[i], 0,8)+"\\";
	
	list2 = getFileList(currdir);
	for (j = 0; j < lengthOf(list2); j++) {
		path=currdir + list2[j];
		run("Bio-Formats Importer", "open=" + path + " " + "autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
		//print(path);
		run("Z Project...", "projection=[Max Intensity]");
		//run("Enhance Contrast", "saturated=0.35");
		run("Subtract Background...", "rolling=60");
		saveAs("Tiff", "F:\\DEND\\projections\\" + substring(list1[i], 0,8) + "\\" + substring(list2[j], 0,10) + ".tif");
		
		run("Close All");
	}
	
}
