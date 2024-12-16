# Final Project---Exploring the state of transitional care in pediatric pilocytic astrocytoma data analysis

## Overview
This project analyzes the state of transitional care in the pediatric pilocytic astrocytoma dataset, and andgenerate statistical summaries, visualizations, and a comprehensive report. The final report is an HTML file created using RMarkdown, with a fully reproducible workflow managed by Renv for package management and a Makefile for automation.

## System Requirements
Docker installed on your system.
MacOS environment for full compatibility.
	
1. you need to restore the R package library before running the analysis. This step ensures that all dependencies are synchronized:
```bash
make install
```
This is equivalent to running renv::restore() in R.

2. To build a Docker image from scratch, use the following command:
```bash
docker build -t shutingmao/550_final_project_image .
```
3. The renv package to manage the R package environment.



## Repository Structure

DATA550_project/

data/                    # Raw and cleaned data

code/                    # R scripts for data analysis

00_clean_data.R      # Data cleaning

01_make_table1.R     # Generates a demographic table

02_model.R           # Statistical modeling

03_visualization.R   # Visualization of model results

4_render_report.R   # Renders the final report

output/                  # Intermediate outputs (.rds and .png)

report/                  # Final compiled report

report.html

report.Rmd               # R Markdown file to create the final report

Dockerfile               # Dockerfile for containerization

Makefile                 # Automates the process

README.md                # Project documentation


## DockerHub Link
The Docker image for this project is available on DockerHub:  
[DockerHub - data550_final_image](https://hub.docker.com/repository/docker/shutingmao/data550_final_image/general)  


## Build the Docker Image
To build a Docker image from scratch, use the following command:
```bash
docker build -t shutingmao/550_final_project_image .
```

## Run the Docker Image and Generate the Report

The Makefile includes a rule to automate the process of running the Docker image and generating the final report. Follow these steps:
	
	1.	Run the Docker Image:
	
```bash
make report/report.html
```
2.	Output:
	•	The final report.html will be written to the local report/ folder.


### Running the Docker Container to Create the Report

To generate the report, run the Docker container using the following command:

```bash
make docker-run
```


## Code Details

### Generating the Summary Table

Table 1 presents the demographic characteristics of the pediatric and adult groups within the study cohort, focusing on key variables such as gender, race, and age at diagnosis.

### Generating the Figures
 A bar chart named Tumor Location Distribution visualizes the distribution of tumor locations across pediatric and adult patients.




