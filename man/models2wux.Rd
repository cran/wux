\name{models2wux}
\alias{models2wux}

\title{
  Processing climate model output
}

\description{
  Reads various climate model NetCDF outputs, processes them according
  to \code{userinput}, and writes the processed data to a \code{data.frame}.

  The \code{data.frame} output of WUX (the WUX data frame) contains
  the climate change signals for user-specified periods, regions,
  seasons, and parameters for each of the indicated climate models as
  defined in \code{userinput}.

  The \code{userinput} is a named \code{list} object or a file
  containing a named \code{list}. It passes the controlling parameters to
  \code{models2wux}. The file paths, file names and meta-information on the
  climate simulations are stored in another list called
  \code{modelinput}.  See the "Details" section and the "Configfile
  userinput" and "Configfile modelinput" section for a detailed
  description of these two lists.

}

\usage{
models2wux(userinput, modelinput)
}

\arguments{
  \item{userinput}{
    The specification of e.g. the parameters, periods, aggregation
    statistics, seasons, subregions, and climate models to be processed.
    This is either a file name containing a list which will be sourced
    internally, or a list object.
  }
  
  \item{modelinput}{
    The specifications of file paths, file names and meta-information of
    every single climate simulation output you have stored on your HDD.
    This is either a file name containing a list which will be sourced
    internally, or a list object.
  }
  
    % \item{does.plot.subregions}{
    % Boolean. If TRUE, interactive plots will be
    % displayed showing (I) The Shapes of the
    % subregion files (shapefiles, rectangle, ...)
    % (II) a rough pixel map with the clipped areal
    % data of the NetCDF file. This keyword is for
    % debugging purposes, ideally to check whether
    % newly added models in the config file \code{InitModelDictionary.R} are
    % read in correctly. Default is no display.
  }

\details{
  To process a climate multimodel ensemble of your choice, \code{models2wux}
  needs two config files \code{userinput} and \code{modelinput}, both
  being named list objects or files containing a named
  list.

  \code{modelinput} stores general information about your climate data,
  i.e. the locations of the NetCDF files and their filenames. It also
  safes certain metainformation for the specific climate simulations
  (e.g. a unique acronym for the simulation; the developing institution;
  the radiative forcing). Usually the \code{modelinput} information
  should be stored in a single file on your system and should be updated
  when new climate simulations come in. It is advisable to share this
  file with your collegues if you work with the same NetCDF files on a
  shared IT infrastructure.

  \code{userinput} contains information on what you actually want
  \code{models2wux} to be doing for you, mainly, which climate
  simulations defined in \code{modelinput} should be processed and what
  kind of statistic should be performed. You also define the
  geographical regions of interest you want to investigate and what time
  horizon you want to regard. Here is an overview of all possible tags a
  \code{userinput} list contains:
  \tabular{ll}{
    \code{parameter.names} \tab Specification of parameters to process. \cr
    \code{reference.period} \tab Specification of the reference period. \cr
    \code{scenario.period} \tab Specification of the scenario period. \cr
    \code{temporal.aggregation} \tab Specification of the temporal
    aggregation of the climate models (e.g. monthly mean or season sum)
    and indicating if either time series or climate change signals
    should be created.  \cr
    \code{subregions} \tab Specification of subregions. \cr
    \code{area.fraction} \tab Take parts of model-pixels according to
    subregion coverage. \cr
    \code{spatial.weighting} \tab Cosine areal weighting of regular grid. \cr
    \code{na.rm} \tab Behavior for missing values of timeslices. \cr
    \code{save.as.data} \tab Specification of output directory and
    filename. \cr
    \code{climate.models} \tab Specification of climate models to be 
    processed. \cr
  }

  This is what \code{models2wux} is doing: First, \code{models2wux}
  extracts attributes set in the \code{userinput} list and loads the
  corresponding model information (storage paths, filenames, ...) from
  the \code{modelinput} list. It then retrieves the geographical
  boundaries of the specified regions in \code{subregions} (here the
  model gridfiles are introduced) and reads the specified parameter data
  from the NetCDF files within the boundaries of the actual
  subregion. Subsequently, \code{models2wux} \emph{aggregates over the
  time dimension} by the indicated months for the specified periods and
  calculates either the climatological mean values of the reference and
  future period and the according climate change signals or time
  series. Next, \code{models2wux} \emph{aggregates over the spatial
  dimension}. \code{models2wux} repeats these processing steps for each
  model specified in \code{climate.models}, each parameter in
  \code{parameter.names}, each subregion in \code{subregions}, and each
  period in \code{reference.period} and \code{scenario.period},
  respectively. Finally, the processed data is written to a
  \code{data.frame} and stored to the hard disk as indicated by
  \code{save.as.data}.

  For more detailed information on \code{modelinput} and
  \code{userinput} see the corresponding sections \code{Configfile
  "modelinput"} and \code{Configfile "userinput"} in this help page.
  }

  \section{Configfile "userinput"}{
    Those are specifications the user provides to control
    \code{models2wux}.
    
    \subsection{\code{parameter.names}}{
      A character vector of parameters to be processed according to the
      NetCDF Climate and Forecast (CF) Metadata Convention
      (\url{http://cf-pcmdi.llnl.gov/}), \cr
      e.g. \code{parameter.names = c("air_temperature", "precipitation_amount")}.
    }

    \subsection{\code{reference.period}}{
      A character specifying the climate change reference period defined
      by "from-to" ("YYYY-YYYY"), \cr
      e.g. \code{reference.period = "1961-1990"}.

    }
    \subsection{\code{scenario.period}}{
      A character specifying the climate change future period defined
      by "from-to" ("YYYY-YYYY"), \cr
      e.g. \code{scenario.period = "2021-2050"}.
    }

    \subsection{\code{temporal.aggregation}}{
      A named list containing the \emph{n} different levels of statistical
      aggregation where the single list elements are sequentially named by
      stat.level.1, stat.level.2, stat.level.3, ... ,
      stat.level.\emph{n}. Each stat.level is again a list containing three
      elements: period, statistic, and time.series.
      \describe{
	\item{period:}{
	  A named list containing the time period of temporal
	  aggregation. The first aggregation level (stat.level.1) refers to
	  the number of the month in the year. All subsequent aggregation
	  levels refer to the list names of the previous stat.level (i.e. nested
	  structure). For example, in stat.level.1 seasons are defined via \cr
	  \code{period=list(DJF=c(12,1,2), MAM=c(3,4,5), JJA=c(6,7,8),
	    SON=c(9,10,11))}. \cr
	  Winter and summer half years can then be
	  defined in  stat.level.2 referring to the list names indicated in
	  stat.level.1: \cr
	  \code{period=list(winter=c(SON,DJF), summer=c(MAM,JJA))}
	}
	\item{statistic:}{
	  A string indicating the statistic which is used to aggregate the
	  data. The statistic can be every statistic which is known to R
	  (e.g., mean, sum, quantile).
	}
	\item{time.series:}{
	  \code{TRUE} or \code{FALSE} indicating if time series or
	  climatological mean values of the reference and future period and
	  the according climate change signals are calculated.
	}
      }

    }

    \subsection{\code{subregions}}{
      Named list containing information for geographical
      regions. You can specify the boundaries by passing 
      \itemize{
	\item a rectangular region by hand
	\item a shapefile with subregions of interest
	\item a NetCDF file containing subregions
      }
      All longitude coordinate values are forced to the range from -180 to
      180 degrees. In case you want to define a subregion containing the
      (180,-180)-meridian, you should force the longitude values to the
      range from 0 to 360 degrees, as it could be the case for the
      Australasian domain. This can be done with the \code{wrap.to}-tag
      (currently defined only for shapefiles).

      \describe{
	\item{rectangle:}{
	  A vector of the form c(lon.west, lon.east, lat.north,
	  lat.south). \cr
	  e.g. \code{World = c(-180, 180, 90, -90)}
	}

	\item{shapefile:}{
	  A named list containing the directory to the shapefiles
	  \code{dirname} and the name of the files \code{filename} (without
	  file extension). Optional: If no projection file is available, you
	  can set a \code{projection} tag to \cr
	  e.g. \code{projection = "+proj=longlat +ellps=WGS84"}.

	  In case there are more regions defined in the
	  shapefile, one can give specific names  to the \code{subregionnames}
	  tag e.g \code{subregionnames = c("South_America",
	    "Central_America")}.
	  However, sometimes these multiple regions
	  form a set. Then the \code{category.variable} tag merges the
	  subregions with the same category to a single subregion and
	  \code{category.label} gives corresponding labels.
	  \code{category.label} has to be a
	  named vector, with the names being the category values from the
	  \code{category.variable} and their values being the
	  labels. Omitting the \code{category.label} vector when using
	  \code{category.variable}, WUX tries to get the names of
	  \code{category.variable}. Note that the \code{subregionnames}
	  tag and the \code{category.label} should not be used together.

	  In case you want to  wrap your longitudes to the 0-360-degrees
	  grid, flag the named vector \code{wrap.to = c("my.subregion" = "360")}. Example: \cr
	  \code{CORDEX = list(dirname = "/tmp/shapefiles/cordex", filename =
	    "cordex_regions", subregionnames = c("South_America",
	    "Central_America", "North_America", "EU.ENS", "Africa",
	    "West_Asia", "East_Asia","Central_Asia", "Australasia",
	    "Antarctica", "Arctic", "Mediterranean_domain"), wrap.to = c('Australasia' = "360"))}. 
	}
	
	\item{NetCDF subregionfile:}{
	  A named list containing information about the NetCDF file
	  defining the subregion by a constant value (e.g. all
	  pixels flagged by \code{1} define a subregion). Names of the list
	  have to be:
	  \tabular{ll}{
	    \code{subreg.file} \tab Name of the NetCDF subregions file. \cr	
	    \code{subreg.dir} \tab  Path to the NetCDF subregions file. \cr
	    \code{grid.file} \tab Name of NetCDF file with longitude and
	    latitude coordinates of the subregions file. \cr	
	    \code{grid.dir} \tab  Directory of \code{grid.file}. \cr
	    \code{mask.name} \tab Variable name in \code{subreg.file}
	    file defining the region. \cr 
	    \code{mask.value} \tab Value of \code{mask.name} defining
	    the region. If more regions are defined, use a vector of
	    values to analyse a set of them. \cr 
	  }
	}
      }
    }
    \subsection{\code{area.fraction}}{
      Dealing with gridded data, subregions almost never happen do be cut out
      exactly the way your subregion is specified. If the centroid of a
      single data pixel lies within the subregion, this datapoint will
      be taken into analysis, else the datapoint will be considered as
      lying outside of the subregion and set \code{NA}. This is WUX default behavior
      (\code{area.fraction = FALSE}). For very small subregions and/or
      very course data resolution however, it can happen you get very
      few data points or even none at all.
      
      However, if you want to take every data pixel which just 'touches' your
      subregion, use \code{area.fraction}. The pixel's centroid doesn't have to be
      necessarily inside the subregion to be taken into analysis then. With
      \code{area.fraction = TRUE} WUX does a weighted spatial average of
      all these pixels. The weight is the ratio of the pixel area lying
      within the subregion and the entire pixel area. So if one quarter of a
      data point is wihin the subregion (but its centroid for example is
      not), the data pixel value will be taken into analysis and
      weighted by \code{0.25} when averaging spatially. Pixels
      being covered completely in the 
      subregion have weight \code{1}. \code{area.fraction} is useful if
      you are dealing with very small subregions and/or small data
      resolution, resulting in just a few pixels. 
    }
    \subsection{\code{spatial.weighting}}{
      When averaging data over its spatial component, the simple arithmetic
      mean can result in strongly biased areal estimates. The reason for this
      is due the geographical projection of the data. The globe has 360 longitudinal
      degrees and 180 degrees in latitude. The real distance (km)
      between latitudes remains the same on the entire globe, whereas the
      distances between longitudes depend on the latitude
      considered. One degree in longitude near equator represents much
      more distance (km) than one degree in Norway as the
      longitudes converge at the poles.

      This fact has to be considered especially when dealing with global data
      (e.g. GCMs). GCM data is usually (within WUX so far 100\%)
      stored on a rectangular lon-lat grid. Therefore the poles seem
      overproportionaly large in area. Common practice is cosine
      weighting of latides, resulting in smaller weights near the poles
      and largest weights at the equator. See
      \url{http://www.grassaf.org/general-documents/gsr/gsr_10.pdf} for
      more details.

      \code{spatial.weighting = TRUE} enables cosine weighting of
      latitudes, whereas omitting or setting \code{FALSE} results in unweighted
      arithmetic areal mean (default). This option is valid only for
      data on a regular grid.
    }
    \subsection{\code{na.rm}}{
      It may happen that time slices of NetCDF data may be missing
      and the user does not know anything about it. Reason for these artifacts might be short time series
      (e.g. some models project only until 2035, so an analysis unitl 2050
      would be biased) or simply missing values due to corrupt or missing
      NetCDF files. 
      
      If \code{na.rm = TRUE} is set in the user input, missing values are
      filled with NA, but the temporal statistics are calculated using the \code{na.rm = TRUE}
      flag. \code{na.rm = FALSE} keeps the NA values
      and thus leads to NA statistics.}

    \subsection{\code{save.as.data}}{
      A character containing both the output path and
      filename. For example \code{save.as.data = "/tmp/cmip3"}  will
      save files in the directory \code{/tmp/} as \code{cmip3.csv}
      (data frame containing model climatologies), \code{cmip3_diff.csv}
      (data frame containing the differences of the climatologies, i.e. the
      climate change signals) and \code{cmip3.Rdata} (a R binary file which
      can be loaded into the next R session containing variables
      \code{wux.data} and \code{wux.data.diff} data frames analog to the
      csv-files).
    }

    \subsection{\code{climate.models}}{
      A character vector containing the names of the models to be
      processed. The names must be identical to the unique acronyms in
      the \code{modelinput} list. Read the next section if you want to
      add a model in the \code{modelinput} file.
    }
  }

  \section{Configfile "modelinput"}{

    When you want to read in a new climate simulation WUX does not know
    so far, all you need to do is to specify this model in the
    \code{modelinput} list (which should be stored in a file). You don't
    need to write tedious input routines, WUX does that for you.  The
    \code{modelinput} list is a named list of climate models and
    contains meta-information of all currently known climate
    models. Sometimes models indicate wrong attributes in their NetCDF
    files needed by \code{modelinput}. Therfore: KNOW YOUR MODEL YOU
    WANT TO ADD AND TAKE CARE OF THE META-INFORMATION YOU ARE INDICATING
    IN \code{modelinput}.

      Each tag consists of a named list with the following mandatory tags
      (i.e. names):
      
   	\subsection{\code{institute}}{
	  Character indicating the institute which is developing the model.}
	
	\subsection{\code{rcm}}{
	  Character name indicating the RCM acronym; if you are processing a
	  gcm type "".}
	
	\subsection{\code{gcm}}{
	  Character name indicating the GCM acronym.}
	
	\subsection{\code{emission}}{
	  Type of emission scenario used for the simulation.}
	
	\subsection{\code{gridfile.filename}}{
	  Name of NetCDF grid file containing the lon/lat variables.}
	
	\subsection{\code{gridfile.path}}{
	  Directory of the NetCDF grid file.}
	
	\subsection{\code{file.path.default}}{
	  Default directory of the NetCDF data files. If the files are
	  stored not only in one directory, use the \code{file.path.alt} tag
	  (see below).}
	
	\subsection{\code{file.path.alt}}{
	  If your files are stored not only in one directory, here you can
	  enter a named vector of paths. If files are scattered by parameter,
	  pass the parameter name (CF Metadata convention) as the vector
	  name. If they are split by periods, then pass
	  \code{reference.period} and  \code{scenario.period} as vector
	  names. If files are seperated by both period and parameter, you
	  can use nested named lists instead of vectors.
	}
	
	\subsection{\code{file.name}}{
	  Character vector of file names of the NetCDF data
	  files. If there are different file names for parameters (which
	  will be mostly the case) and/or file names in scenario- and
	  reference period are of different nature as well, use named
	  or nested lists as in the \code{file.path.alt} tag.
	  You can set this tag \code{NA} if this climate model has no
	  files. This makes sense for example for the GKSS model for global
	  radiation, as this ENSEMBLES model does not provide this
	  parameter. Values for this model will be \code{NA} in the WUX
	  dataframe.
	}
       
      These tags are optional:
	\subsection{\code{resolution}}{
	  Grid resolution character.}
	
	\subsection{\code{gcm.run}}{
	  GCM run. Default is blank "".}
	
	\subsection{\code{what.timesteps}}{
	  Default are daily time steps, type \code{"monthly"} for monthly
	  data.}

	\subsection{\code{calendar}}{
	  Define the NetCDF time:calender attribute by hand. This is
	  necessary if the NetCDF file contains wrong information. You can
	  pass \code{360_days}, \code{no_leap} or \code{julian}.}
	
	\subsection{\code{time.units}}{
	  Define the NetCDF time:units attribute by
	  hand. E.g. \code{days since 1950-01-06 00:00:00}.}
	
	\subsection{\code{count.first.time.value}}{
	  The time variable in NetCDF files is a vector of time steps relative
	  to the "time:units" attribute with calendar according
	  to the "time:calendar" attribute. However, there are cases where
	  certain climate models are dealing with two calendar types at
	  once! Yes, that's possible... For example: Data claim to have a
	  "360 days" calendar. 
	  The "time:units" attribute is set to \code{days since 1961-01-01
	    00:00:00} and the time vector looks like
	  \code{365, 366, ..., 723, 724}. The 365th day since 1961-01-01 is
	  definetely not the 1st January of 1962 concerning the 360-days
	  calendar but is correctly in terms of "julian" dates.

	  In such a case  we would set
	  \code{count.first.time.value = "julian"} and  \code{calendar}
	  remains 360 days. Other possibilities are
	  \code{count.first.time.value = "noleap"} (or \code{=
	    "360days"}). Currently this property is defined for \code{calendar
	    = "360 days"} only, but can easily be extended to other
	  calendars as well.}

	\subsection{\code{parameters}}{
	  A named vector indicating parameter long- and shortname which
	  belong together, e.g.
	  \code{parameters = c(air_temperature = "tas_dm",
	    precipitation_amount = "pr_24hc")}. This is important if the
	  NetCDF internal variable name deviates from the WUX default
	  parameter shortname:
	  \tabular{ll}{
	    \code{tas} \tab for \code{air_temperature} \cr
	    \code{pr} \tab for \code{precipitation_amount} \cr
	    \code{hurs} \tab for \code{relative_humidity} \cr
	    \code{rsds} \tab for \code{global_radiation} \cr
	    \code{wss} \tab for \code{wind_speed} \cr
	    \code{ua} \tab for \code{eastward_wind} \cr
	    \code{va} \tab for \code{northward_wind} \cr
	    \code{psl} \tab for \code{air_pressure_at_sea_level} \cr
	    \code{hus} \tab for \code{specific_humidity} \cr
	    \code{hfss} \tab for \code{surface_upward_sensible_heat_flux} \cr
	    \code{tasmin} \tab for \code{air_temperature_minimum} \cr
	    \code{tasmax} \tab for \code{air_temperature_maximum} \cr
	    \code{ts} \tab for \code{surface_temperature} \cr
	  }
	}  
    }
 


\value{
  A \code{data.frame} containing climate change signals for all models,
  subregions, and parameters specified in \code{userinput}. It also
  writes a csv file on your HDD.
}

\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at} and Georg Heinrich \email{g.heinrich@uni-graz.at}
}
\note{
  This is an awesome tool (rfp).
}

\seealso{
  \code{\link{modelinput_test}}, \code{\link{userinput_CMIP5_changesignal}},
  \code{\link{cmip5_2050}},  \code{\link{cmip5_2100}},
  \code{\link{ensembles}}, \code{\link{ensembles_gcms}}
  
}
\examples{
## This example shows a typical workflow for models2wux, the workhorse of
## the wux package. Going through this example step-by-step, you will
## retrieve NetCDF files of two CMIP5 simulations and aggregate them to
## an R data.frame for further analysis. 

## I) Load wux functions and example datasets...
library(wux)

## II) You need to obtain the climate simulations first. You can get
## started with downloading some example CMIP5 NetCDF files from the
## ESGF visiting for example http://pcmdi9.llnl.gov or using the
## CMIP5fromESGF function. Here, we dowload two simulations "NorESM1-M" and
## "CanESM2" into your home directory "~/tmp/CMIP5/" which will be
## created automatically. You will need a valid account at any ESGF
## node for this function to run. See ?CMIP5fromESGF for further help.
\dontrun{CMIP5fromESGF(save.to = "~/tmp/CMIP5/",
                models = c("NorESM1-M", "CanESM2"),
                variables = c("tas"),
                experiments= c("historical", "rcp85"))
}

## III) Specify those downloaded data for models2wux. models2wux needs
## to know where the data is stored on your HDD and needs to have access
## to certain metadata of the climate simulator, which you have to
## provide as well. This information is stored in a list, which should
## be saved as ONE file somewhere on your computer. We call this
## information "modelinput". You should share this 
## file with you collegues using the same IT infrastructure to share
## synergies. One example file would be the following:
data(modelinput_test)

## It specifies temperature and precipitation files for the two
## simulations "NorESM1-M" and "CanESM2" (RCP8.5), stored in
## "~/tmp/CMIP5/". 
str(modelinput_test)

## IV) Next, you need to specify which simulations you want to read in
## with models2wux, what kind of statistics to calculate, what subregion
## to analyze, what time periods and seasons to define, and so on. This
## is done with a user input file, which cntains a list with all the
## necessary information. You typically use different userinput files
## for different analysis, whereas your modelinput should remain in ONE
## file which will be updated each time you obtain a new climate
## simulation. One example user input file, which reads in both
## simulations specified above for the Alpine domain and returns their
## projected climate change signal, could look like follows: 
data(userinput_CMIP5_changesignal)
str(userinput_CMIP5_changesignal)

## alternatively following userinput returns a timeseries of both
## models, which only differs by the "time.series" tag and differently
## specified periods: 
data(userinput_CMIP5_timeseries)
str(userinput_CMIP5_timeseries)

## V) At last you can run models2wux to obtain a data.frame of the
## specified climatic change features defined above:
\dontrun{climchange.df <- models2wux(userinput = userinput_CMIP5_changesignal,
                            modelinput = modelinput_test)}
## A better practice is to safe both input files containing a named 
## list each somewhere on your disk and pass the files directly to the
## models2wux function. If you  had stored the two files in your home
## directory as e.g. "~/userinput.R" and "~/modelinput.R" you can call: 
\dontrun{climchange.df <- models2wux(userinput = "~/userinput.R",
                            modelinput = "~/modelinput.R")}
## if you downloaded the data correctly, you should obtain a data.frame:
\dontrun{
  climchange.df
}			    

## which should be identical to this example data.frame:
data(CMIP5_example_changesignal)
CMIP5_example_changesignal

## Instead of calculating the climate change signals, you can also
## generate time series of the two models aggregated over the Alpine
## domain, using a different user input file:
\dontrun{climchange.df <- models2wux(userinput = userinput_CMIP5_timeseries,
                            modelinput = modelinput_test)}


## VI) Finally you can make all kind of analysis you are interested in,
## using either functions from wux or from any other R funtionality
summaryWux(CMIP5_example_changesignal, parms = "delta.air_temperature")

## or plot timeseries as
require(lattice)
data(CMIP5_example_timeseries)
\dontrun{xyplot(air_temperature ~ year|season,
       groups = acronym,
       data = CMIP5_example_timeseries,
       type = c("l", "g"),
       main = "NorESM1-M and CanESM2 simulations over Alpine Region\nRCP 8.5 forcing")}
}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ datagen }% __ONLY ONE__ keyword per line
\keyword{ IO }
\keyword{ file }
\keyword{ spatial }
\keyword{ ts }
\keyword{ multivariate }
