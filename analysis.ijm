
var index = -1;
var dir1 = getDirectory("Choose Source Directory, hier projections");
var path_data = "F:\DEND\areas\";
var list1 = getFileList(dir1);

macro "dialog [p]"{
	Dialog.create("Einstellungen");
	Dialog.addNumber("index; ist 1 zu niedrig", index);
	Dialog.addString("path for area selection", path_data);
	Dialog.show();
	path_data = Dialog.getString();
	index = Dialog.getNumber();
}
	
macro "next_image [q]" {
	
	if (roiManager("count")>0){
		roiManager("Deselect");
		roiManager("Delete");
	}
	run("Close All");
	index++;
	
	setTool("freehand");
	//print(dir1 + substring(list1[index], 0,8)+ "\\"+substring(list1[index], 	0,8)+"_fused.tif");
	open(dir1 + substring(list1[index], 0,8)+ "\\"+substring(list1[index], 	0,8)+"_fused.tif");
	run("Set Scale...", "distance=1 known=0.323 unit=um global");
	run("Set Measurements...", "area display redirect=None decimal=3");
	run("Duplicate...", "title=cheg");
	run("Duplicate...", "title="+list1[index]);
}

macro "analyze [r]"{
	list=getList("image.titles");
	run("Set Measurements...", "area center display redirect=None decimal=3");
	
	run("ROI Manager...");
	roiManager("Add");
	selectWindow("cheg");
	roiManager("Select", 0);
	run("Clear Outside");
	run("Fill", "slice");
	saveAs("Tiff", path_data + list[0]);
	close();
	
	selectWindow(list[0]);
	run("Gaussian Blur...", "sigma=2");
	run("Subtract Background...", "rolling=65");
	run("Clear Outside");
	run("Auto Threshold", "method=Otsu white");
	run("Invert");
	run("Analyze Particles...", "size=30-Infinity circularity=0.10-1.00 display add");
}

macro "areas [a]"{
	
	list1 = getFileList(path_data);
	for(i=0; i<lengthOf(list1); i++){
		open(path_data + list1[i]);
		Roi.remove;
		run("Auto Threshold", "method=Otsu white");
		run("Invert");
		run("Analyze Particles...", "size=623.03-Infinity circularity=0.05-1.00 display add");
		close("*");
	}
}
