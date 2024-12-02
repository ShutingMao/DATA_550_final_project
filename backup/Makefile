report.html: report.Rmd code/03_render_report.R derived_data/data_clean.rds figure/scatter_plot.png
	Rscript code/03_render_report.R

derived_data/data_clean.rds: code/00_clean_data.R Data\ 550.xlsx
	Rscript code/00_clean_data.R

figure/scatter_plot.png: code/02_make_scatter.R derived_data/data_clean.rds
	Rscript code/02_make_scatter.R

table/table1.csv: code/01_make_table1.R derived_data/data_clean.rds
	Rscript code/01_make_table1.R

.PHONY: clean
clean:
	rm -f derived_data/*.rds figure/*.png table/*.csv output/* report.html

.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"