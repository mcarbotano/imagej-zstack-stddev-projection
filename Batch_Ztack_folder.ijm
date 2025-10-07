// Macro to process TIFF files with Standard Deviation Z-projection (Batch Mode)
// Author: ImageJ Macro
// Description: Processes TIFF files in background without displaying images

// Clean up before starting
run("Close All");
print("\\Clear");

// Select input folder containing TIFF files
inputDir = getDirectory("Choose Input Folder with TIFF files");
print("Input folder: " + inputDir);

// Select output folder for PNG files
outputDir = getDirectory("Choose Output Folder for PNG files");
print("Output folder: " + outputDir);

// Enable batch mode - processes images in background without displaying
setBatchMode(true);

// Get list of all files in input directory
fileList = getFileList(inputDir);

// Counter for processed files
count = 0;

// Process each file
for (i = 0; i < fileList.length; i++) {
    filename = fileList[i];
    
    // Check if file is a TIFF (supports .tif and .tiff extensions)
    if (endsWith(filename, ".tif") || endsWith(filename, ".tiff")) {
        
        print("Processing: " + filename + " (" + (i+1) + "/" + fileList.length + ")");
        
        // Open the TIFF file (in batch mode, won't display)
        open(inputDir + filename);
        
        // Get the image title
        imageTitle = getTitle();
        
        // Perform Standard Deviation Z-projection
        run("Z Project...", "projection=[Standard Deviation]");
        
        // Get the projection result title
        projectionTitle = getTitle();
        
        // Create output filename (remove extension and add .png)
        outputName = replace(filename, ".tif", ".png");
        outputName = replace(outputName, ".tiff", ".png");
        
        // Save as PNG
        saveAs("PNG", outputDir + outputName);
        print("Saved: " + outputName);
        
        // Close all images to free memory
        close("*");
        
        count++;
    }
}

// Exit batch mode
setBatchMode(false);

// Summary
print("\n=== Processing Complete ===");
print("Total files processed: " + count);
print("Results saved to: " + outputDir);

// Beep to notify completion
beep();