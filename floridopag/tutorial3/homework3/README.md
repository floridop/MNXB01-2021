--------------------------------------------------------
# MNXB01-2021-homework3
--------------------------------------------------------
### Author: Florido Paganelli florido.paganelli@hep.lu.se
###         Lund University
--------------------------------------------------------

## Overview 

In this homework you're required to write a bash script called `cityandyear.sh` that does the following: 

1) Takes as input **a folder** containing shmi datasets to scan, a **city name** and a **year**;
2) Finds the dataset file `<datafile>` for the requested city;
3) Runs the attached `shmicleaner.sh` script to generate a file called `rawdata_<datafile>`
4) Writes out to screen only the data for the requested year
5) If any of the above steps encounters an error, prints the error on screen
   and exits.

## The problem

You are given a collection of dataset files from SMHI that contain
data about the temperatures measured by a weather station in a selection
of Swedish cities. The city name is written in the metadata inside the files.

The data appears to be in CSV format, but presents some
inconsistencies. Luckily for you, your colleagues already solved the
problem last year and you can use a script `smhicleaner.sh` to generate
raw data without the metadata.

You goal is to scan this folder and extract only the processed data for
a given city and a given year. 

Looking a the dataset folder you realize there are three things to do:

- Scan all the files in the dataset folder to find the one that contains data
about the requested cities, say <datafile>.
Unfortunately the users using this script are lazy 
and may write the city name in different cases. For example, by writing *yStaD* 
they actually mean *Ystad*.

- Generate the `rawdata_<datafile>` using the `smhicleaner.sh` script

- Select from the `rawdata_<datafile>` only the lines regarding the requested
year and print them to screen.

For example if the user runs

```
  cityandyear.sh ../data/ ysTAD 1983
```

The Ystad dataset is in the file 

```
   ../data/smhi-opendata_1_53260_20210906_214756.csv
```

`smhicleaner.sh` will generate

```
   rawdata_smhi-opendata_1_53260_20210906_214756.csv
```

The first lines of the final result should look like this sample below:

```console
found file ../data//smhi-opendata_1_53260_20210906_214756.csv
running smhicleaner on file ../data//smhi-opendata_1_53260_20210906_214756.csv
Found RAW data: rawdata_smhi-opendata_1_53260_20210906_214756.csv. Start processing with grep...
1983-01-01 06:00:00 2.9 G
1983-01-01 09:00:00 3.4 G
1983-01-01 12:00:00 3.6 G
1983-01-01 15:00:00 3.6 G
1983-01-01 18:00:00 3.7 G
1983-01-02 06:00:00 4.0 G
1983-01-02 09:00:00 3.2 G
...
```

And exactly like the sample output file in
```
   result/output_noerrors
```

## How to proceed

Edit the provided pseudocode file and substitute the lines `YOUR_CODE_HERE` with
the code that accomplishes the requested task.

### Prepare for the homework

1. Copy the homework directory to your 
   home directory on Aurora:

```console
cp -ar /projects/hep/fs10/mnxb01/tutorial3/homework3 ~
```

2. Access the directory where the pseudocode is:

```console
cd ~/homework3/code
```

3. Rename the pseudocode file:

```console
mv cityandyear.sh.pseudocode cityandyear.sh
```

4. Open the file with Pluma or the editor you fancy and read and write the code described in the tasks

```console
pluma cityandyear.sh&
```

- To test your code, don't forget to make cityandyear.sh executable:

```console
chmod +x cityandyear.sh
```

While coding you may assume that the `smhicleaner.sh` script and the helper libraries are in the same path as the `cityandyear.sh` script.
However, correction will be done on a different computer than Aurora, so it is recommended to use relative paths to reference such
scripts.
   
### How to progress 

The file `cityandyear.sh.pseudocode` contains pseudocode written by the
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

the `tutorial3/homework3` structure is as follows:

```console
.
????????? code  # contains code you have to modify
??????? ????????? cityandyear.sh.pseudocode # the pseudocode file you need to edit
??????? ????????? helperfunctions # A library used by cityandyear.sh
??????? ????????? smhicleaner.sh # The smhicleaner.sh script from the case study
????????? data  # contains the datasets you will be working on
??????? ????????? smhi-opendata_1_52230_20210906_212532.csv
??????? ????????? smhi-opendata_1_53260_20210906_214756.csv
??????? ????????? ...
????????? README.md # this document
????????? result # the example output for the exercise
    ????????? original_smhi-opendata_1_53260_20210906_214756.csv # generated by smhicleaner.sh, data relative to Ystad
    ????????? clean1_smhi-opendata_1_53260_20210906_214756.csv # generated by smhicleaner.sh, data relative to Ystad
    ????????? clean2_smhi-opendata_1_53260_20210906_214756.csv # generated by smhicleaner.sh, data relative to Ystad
    ????????? rawdata_smhi-opendata_1_53260_20210906_214756.csv # generated by smhicleaner.sh, data relative to Ystad
    ????????? report_smhi-opendata_1_53260_20210906_214756.csv # generated by smhicleaner.sh, data relative to Ystad
    ????????? output_noerrors # the output of a successfull execution of `./cityandyear.sh ../data/ ysTAD 1983`
    ????????? output_errorcitynotfound # the output of the execution of `./cityandyear.sh ../data/ London 1984`
    ????????? output_erroryearnotfound # the output of the execution of `./cityandyear.sh ../data/ Ystad 1984`
    ????????? output.tee # the output of the solution of the task for the maxiumum grade for the execution of `./cityandyear.sh ../data/ ysTAD 1983`
    ????????? smhicleaner.log # The file generated at E4

```

### Tracking your progress

In this homework the best way to track your progress is to use the debug mode
(see Slide 37) or use echo to printout the content of a certain variable 
to cross check that it contains what you expect.

If you do not want to run the whole script but you want it to stop at
any point, you can simply add an `exit 0` statement at the point you want the 
script to stop. Remember everything is executed from top to bottom of the script.

Check the folder `result/` to compare what the files you generate should look like.
Some are generated by `smhicleaner.sh`. 

The `output_*` files in `result/` show you what the program should print when 
called on selected inputs. Check the section Folder Structure above.

You can compare files using `diff` or `meld`. More about this will come with the git tutorial.

## Grades

The cityandyear.sh.pseudocode contains a description of how the homework is 
graded. 

If you want the outstanding grade (5) you need complete the whole homework with the maximum score of 12 first AND fulfill the task below.

No maximum grade will be awarded for those who did not score 
the maximum number of points.

### Task for the maximum grade

To get the maximum grade you need to find a way, using the commands `tee` and `tail`, to write the output of `cityandyear.sh` BOTH on the terminal screen
AND on a file called `output.tee` at the same time, but skipping the informational output such as "found file..." etc.

The file `output.tee` should only contain raw data and no informational output messages from `cityandyear.sh`.

In other words the beginning of `output.tee` will look like:

```
1983-01-01 06:00:00 2.9 G
1983-01-01 09:00:00 3.4 G
1983-01-01 12:00:00 3.6 G
1983-01-01 15:00:00 3.6 G
1983-01-01 18:00:00 3.7 G
1983-01-02 06:00:00 4.0 G
1983-01-02 09:00:00 3.2 G
1983-01-02 12:00:00 4.3 G
1983-01-02 15:00:00 2.7 G
1983-01-02 18:00:00 1.7 G
....
```

That is, without all the `echo` messages that `cityandyear.sh` usually prints.

NOTE: This must NOT be done in the code of `cityandyear.sh`. That code must be 
left untouched. You need to send me the bash command you would run for this to happen as part of your Canvas submission, for example add the comment:

>    " I solved the task for maximum grade with this expression:
>>   `./cityandyear.sh ../data Ystad 1983 | something | something...`"

An example of `output.tee` for the execution of 
`./cityandyear.sh ../data Ystad 1983 | something | something...` is provided in the `result/` folder,
so that you can compare it against your solution above.

# Credits

The metereological data used in this exercise has been downloaded from 
the official "SMHI - Sveriges meteorologiska och hydrologiska institut"
website. 

The use of this data is covered by the statements at this link:
<http://www.smhi.se/data/oppna-data/information-om-oppna-data/villkor-for-anvandning-1.30622>
