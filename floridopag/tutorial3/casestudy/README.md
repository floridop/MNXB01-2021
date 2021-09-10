--------------------------------------------------------
# MNXB01-2021-casestudy
--------------------------------------------------------
### Author: Florido Paganelli florido.paganelli@hep.lu.se
###         Lund University
--------------------------------------------------------

## Overview 

This case study code does the following:

1) Copies a dataset from a given location
2) Reworks the content of such dataset using a bash script
   and various bash tools
3) Write out the results to screen or files in a specific format

## The problem

You are given a dataset from SMHI that contains data about the
temperatures measured by a weather station in Falsterbo:

`data/smhi-opendata_1_52230_20210906_212532.csv`

The data appears to be in CSV format, but presents some
inconsistencies.

You goal is to process this data using C++ and you need
to remove these inconsistencies and prepare the file in
a format that is good for C++, that is notoriously bad in
handling text files.

Looking a the dataset you realize there are three things to do:

- Remove metadata at the beginning of the file and in part of
  the initial lines

- Remove the CSV header

- Turn all the separators ; into plain spaces, as you notice that
the data contained never uses spaces. Space separated values are
easier to process for C++.

The initial dataset is in the file 

```
   data/smhi-opendata_1_52230_20210906_212532.csv
```
Its header looks like this:

```csv
Stationsnamn;Klimatnummer;Mäthöjd (meter över marken)
Falsterbo;52230;2.0

Parameternamn;Beskrivning;Enhet
Lufttemperatur;momentanvärde, 1 gång/tim;degree celsius

Tidsperiod (fr.o.m);Tidsperiod (t.o.m);Höjd (meter över havet);Latitud (decimalgrader);Longitud (decimalgrader)
1880-01-01 00:00:00;2021-09-01 06:00:00;1.541;55.3837;12.8167

Datum;Tid (UTC);Lufttemperatur;Kvalitet;;Tidsutsnitt:
pflorido@atariXL:~/git/MNXB01-2021/floridopag/tutorial3/casestudy$ head -20 result/original_smhi-opendata_1_52230_20210906_212532.csv 
Stationsnamn;Klimatnummer;Mäthöjd (meter över marken)
Falsterbo;52230;2.0

Parameternamn;Beskrivning;Enhet
Lufttemperatur;momentanvärde, 1 gång/tim;degree celsius

Tidsperiod (fr.o.m);Tidsperiod (t.o.m);Höjd (meter över havet);Latitud (decimalgrader);Longitud (decimalgrader)
1880-01-01 00:00:00;2021-09-01 06:00:00;1.541;55.3837;12.8167

Datum;Tid (UTC);Lufttemperatur;Kvalitet;;Tidsutsnitt:
1880-01-01;07:00:00;0.4;G;;Kvalitetskontrollerade historiska data (utom de senaste 3 mån)
1880-01-01;13:00:00;1.0;G;;Tidsperiod (fr.o.m.) = 1880-01-01 00:00:00 (UTC)
1880-01-01;20:00:00;1.7;G;;Tidsperiod (t.o.m.) = 2021-06-01 06:00:00 (UTC)
1880-01-02;07:00:00;3.8;G;;Samplingstid = Ej angivet
1880-01-02;13:00:00;4.0;G;;
1880-01-02;20:00:00;3.3;G;;Kvalitetskoderna:
1880-01-03;07:00:00;3.1;G;;Grön (G) = Kontrollerade och godkända värden.
1880-01-03;13:00:00;3.6;G;;Gul (Y) = Misstänkta eller aggregerade värden. Grovt kontrollerade arkivdata och okontrollerade realtidsdata (senaste 2 tim).
1880-01-03;20:00:00;3.4;G;;
1880-01-04;07:00:00;3.5;G;;Orsaker till saknade data:
...

```

The final result should look **exactly** like the in file

```
   result/rawdata_smhi-opendata_1_52230_20210906_212532.csv
```

that is, like this:

```csv
1880-01-01 07:00:00 0.4 G 
1880-01-01 13:00:00 1.0 G 
1880-01-01 20:00:00 1.7 G 
1880-01-02 07:00:00 3.8 G 
1880-01-02 13:00:00 4.0 G 
1880-01-02 20:00:00 3.3 G 
1880-01-03 07:00:00 3.1 G 
1880-01-03 13:00:00 3.6 G 
1880-01-03 20:00:00 3.4 G 
1880-01-04 07:00:00 3.5 G 

...
```

## How to proceed

Your task is to use bash to accomplish the dataset cleanup.

Write a script that takes as input a path to a file similar
to the one in the examples reported below and produces a clean datafile
ready to be processed by C++.

The code must work with any filename, and not just with the ones 
in the examples, as the file might be in different locations
when the teacher tests your code.

In detail, the script must:

1. Be able to run when launched in these this way:

```console
# Dataset is on a filesystem:
  ./smhicleaner.sh /nfs/shared/pp/MNXB01/tutorial3/homework3/data/smhi-opendata_1_52240_20200905_163726.csv
```

2. Show errors and exit with `exit` status `1` if the input parameter is
   missing or the files cannot be retrieved/copied
   
3. Create the following 4 intermediate files:
- `original_smhi-opendata_1_52240_20200905_163726.csv` : a copy of the original file `smhi-opendata_1_52240_20200905_163726.csv`
- `clean1_smhi-opendata_1_52240_20200905_163726.csv`: a cleanup of the original data file with only the lines after the line that starts with `Datum`
- `clean2_smhi-opendata_1_52240_20200905_163726.csv`: a cleanup of `clean1_smhi-opendata_1_52240_20200905_163726.csv` without the additional metadata at the end of each line
- `rawdata_smhi-opendata_1_52240_20200905_163726.csv`: the final result that should contain only the lines about temperature data as in the example above.

4. The script must show the user what is going on and give good errors 
as in the `result/output_*` files (see "Folder structure" below for 
descriptions of each file).
This is an example of the solution and what the output and generated files should look like:
```console
pflorido@atariXL:~/git/MNXB01-2021/floridopag/tutorial3/casestudy/result$ ../code/smhicleaner.sh ../data/smhi-opendata_1_52230_20210906_212532.csv
Copying input file ../data/smhi-opendata_1_52230_20210906_212532.csv to original_smhi-opendata_1_52230_20210906_212532.csv
Finding the first line containing 'Datum'...
Removing the first 11 lines, result in clean1_smhi-opendata_1_52230_20210906_212532.csv
Selecting only relevant columns, result in clean2_smhi-opendata_1_52230_20210906_212532.csv
Substituting the ; with spaces, result in rawdata_smhi-opendata_1_52230_20210906_212532.csv
Writing filesizes summary to report_smhi-opendata_1_52230_20210906_212532.csv

pflorido@atariXL:~/git/MNXB01-2021/floridopag/tutorial3/casestudy/result$ ls -ltrah
total 25M
-rw-rw-r-- 1 pflorido pflorido 6,3M sep  6 23:25 original_smhi-opendata_1_52230_20210906_212532.csv
-rw-rw-r-- 1 pflorido pflorido  518 sep 10 11:43 output_noerrors
-rw-rw-r-- 1 pflorido pflorido  387 sep 10 11:47 output_filenotfound
-rw-rw-r-- 1 pflorido pflorido   65 sep 10 12:19 output_dirnotfile
-rw-rw-r-- 1 pflorido pflorido 6,3M sep 10 12:19 clean1_smhi-opendata_1_52230_20210906_212532.csv
-rw-rw-r-- 1 pflorido pflorido 6,3M sep 10 12:19 clean2_smhi-opendata_1_52230_20210906_212532.csv
-rw-rw-r-- 1 pflorido pflorido 6,3M sep 10 12:19 rawdata_smhi-opendata_1_52230_20210906_212532.csv
drwxrwxr-x 2 pflorido pflorido 4,0K sep 10 12:19 .
-rw-rw-r-- 1 pflorido pflorido  374 sep 10 12:19 report_smhi-opendata_1_52230_20210906_212532.csv
drwxrwxr-x 5 pflorido pflorido 4,0K sep 10 12:29 ..

```

All the above steps are detailed inside the homework pseudocode file
located in `code/smhicleaner.sh.pseudocode` and tell where to look
for hints.

### Prepare for the tutorial

1. Copy the case study directory to your 
   home directory on Aurora:

```console
cp -ar /projects/hep/fs10/mnxb01/tutorial3 ~
```

2. Access the directory where the pseudocode is:

```console
cd ~/tutorial3/casestudy/code
```

3. Rename the pseudocode file:

```console
mv smhicleaner.sh.pseudocode smhicleaner.sh
```

4. Open the file with Pluma or the editor you fancy and read and write the code described in the tasks

```console
pluma smhicleaner.sh&
```

- To test your code, don't forget to make smhicleaner.sh executable:

```console
chmod +x smhicleaner.sh
```

### How to progress 

The file shmicleaner.sh.pseudocode contains pseudocode written by the
teacher to help you progressing and increasing your knowledge of bash.
It consists of several tasks and their description.

You are requested to write code where the text says `YOUR_CODE_HERE`

**Delete** the text `YOUR_CODE_HERE` and start writing your own code
according to the exercise request. There is no limit in how much you 
write as long as it fulfils the requirements of the exercise.

You can do the exercises one by one and test the result against the
files in the `result/` folder (see folder structure below)

If you are annoyed by the error messages caused by lines that you did 
not yet edit, use the `#` symbol to comment out lines so that bash will 
ignore them as we've seen in the examples in Tutorial 3.

### Folder structure

the tutorial3/casestudy structure is as follows:

```
.
├── README.md # this document
├── code # contains the code you have to edit and the solution
│   └── smhicleaner.sh.pseudocode  # the file you have to edit
│   └── smhicleaner.sh.solution  # the solution
├── data # contains the original data
│   ├── README.md # info about the data and whre it can be retrieved
│   └── smhi-opendata_1_52240_20200905_163726.csv # original data taken from SMHI, see the README.md file above
└── result # contains examples of the final result and the command output
    ├── clean1_smhi-opendata_1_52240_20200905_163726.csv  # output file result of the relative task
    ├── clean2_smhi-opendata_1_52240_20200905_163726.csv  # output file result of the relative task
    ├── original_smhi-opendata_1_52240_20200905_163726.csv  # original file: it matches ../data/smhi-opendata_1_52240_20200905_163726.csv
    ├── output_noerrors  # output of the script when a file path is passed as parameter
    ├── output_error_noparams # output of the script when no parameter is passed
    ├── output_error_dirnofile  # output of the script when passing a directory instead of a file
    ├── output_error_filenotfound  # output of the script when the data file does not exist
    └── rawdata_smhi-opendata_1_52240_20200905_163726.csv # output file final result.
```

### Tracking your progress

You can track your progress by comparing the output of your script to 
the files

```
└── result # contains examples of the final result and the command output
    ├── output_noerrors # output of the script when everything went well
    ├── output_error...  # output of the script when something went wrong
```

Then you can check how much of you achieved by comparing each of 
the intermediate files you generate on each task that requires such files.

```
└── result # contains examples of the final result and the command output
    ├── clean1_smhi-opendata_1_52240_20200905_163726.csv  
    ├── clean2_smhi-opendata_1_52240_20200905_163726.csv  
    ├── original_smhi-opendata_1_52240_20200905_163726.csv  # original file: it matches ../data/smhi-opendata_1_52240_20200905_163726.csv
    └── rawdata_smhi-opendata_1_52240_20200905_163726.csv # final result.
```

And finally compare the final output of your script to

```
└── result # contains examples of the final result and the command output
    ├── output_noerrors  # output of the script when a file path is passed as parameter
```

for this purpose you can use a text tool called `diff`
<https://www.geeksforgeeks.org/diff-command-linux-examples/>

Compare `myfile` to `resultfile`:
```console
diff /path/to/myfile /path/to/resultfile
```

For example, if you're editing `smhicleaner.sh` in the `~/tutorial3/casestudy/code` folder,
and you generated the first file `clean1_smhi-opendata_1_52240_20200905_163726.csv` in
the same folder, you can do:

```console
diff ~/tutorial3/casestudy/code/clean1_smhi-opendata_1_52240_20200905_163726.csv ~/tutorial3/casestudy/result/clean1_smhi-opendata_1_52240_20200905_163726.csv
```

Or if you want a graphical tool you can use `meld`:
<https://meldmerge.org/>

Compare `myfile` to `resultfile`:
```console
meld /path/to/myfile /path/to/resultfile
```
