# reads all available CMIP5 simulations available on disk and creates
# an entry to WUX's InitModelsDictionary R file for each simulation

from string import Template
import os, os.path, sys, fnmatch, re, getopt
# import os, stat, subprocess, math
# import sys, getopt

# CMIPPATH = "/data/reloclim/rcm/CMIP5_update_2013_02_07"
# CMIPPATH = "/home/thm/tmp/CMIP5"

def cmip5_modelinput_gen(rcp, CMIPPATH):
    
    PARMS = ["tas", "pr"]
    
    instnames = {"BCC":
                 ["BCC-CSM1.1",
                  "BCC-CSM1.1(m)"],
             "CCCma":
                 ["CanAM4",
                  "CanCM4",
                  "CanESM2"],
             "CMCC":
                 ["CMCC-CESM",
                  "CMCC-CM",
                  "CMCC-CMS"],
             "CNRM-CERFACS":
                 ["CNRM-CM5",
                  "CNRM-CM5-2"],
             "COLA and NCEP":
                 ["CFSv2-2011"],
             "CSIRO-BOM":
                 ["ACCESS1.0",
                  "ACCESS1.3"],
             "CSIRO-QCCCE":
                 ["CSIRO-Mk3.6.0",
                  "CSIRO-Mk3L-1-2"],
             "EC-EARTH":
                 ["EC-EARTH"],
             "FIO":
                 ["FIO-ESM"],
             "GCESS":
                 ["BNU-ESM"],
             "INM":
                 ["INM-CM4"],
             "IPSL":
                 ["IPSL-CM5A-LR",
                  "IPSL-CM5A-MR",
                  "IPSL-CM5B-LR"],
             "LASG-CESS":
                 ["FGOALS-g2"],
             "LASG-IAP":
                 ["FGOALS-gl",
                  "FGOALS-s2"],
             "MIROC":
                 ["MIROC4h",
                  "MIROC5",
                  "MIROC-ESM-CHEM",
                  "MIROC-ESM"],
             "MOHC":
                 ["HadCM3",
                  "HadCM3Q",
                  "HadGEM2-A",
                  "HadGEM2-CC",
                  "HadGEM2-ES"],
             "MPI-M":
                 ["MPI-ESM-LR",
                  "MPI-ESM-MR",
                  "MPI-ESM-P"],
             "MRI":
                 ["MRI-AGCM3.2H",
                  "MRI-AGCM3.2S",
                  "MRI-CGCM3",
                  "MRI-ESM1"],
             "NASA GISS":
                 ["GISS-E2-H",
                  "GISS-E2-H-CC",
                  "GISS-E2-R",
                  "GISS-E2-R-CC"],
             "NASA GMAO":
                 ["GEOS-5"],
             "NCAR":
                 ["CCSM4"],
             "NCC":
                 ["NorESM1-M",
                  "NorESM1-ME"],
             "NICAM":
                 ["NICAM.09"],
             "NIMR/KMA":
                 ["HadGEM2-AO"],
             "NOAA GFDL":
                 ["GFDL-CM2.1",
                  "GFDL-CM3",
                  "GFDL-ESM2G",
                  "GFDL-ESM2M",
                  "GFDL-HIRAM-C180",
                  "GFDL-HIRAM-C360"],
             "NSF-DOE-NCAR":
                 ["CESM1(BGC)", 
                  "CESM1(CAM5)",
                  "CESM1(CAM5.1,FV2)",
                  "CESM1(FASTCHEM)",
                  "CESM1(WACCM)"]}
    
    # create wux R template
    templ=Template("""
################################################################################
    '${GCM}-${RUNINIT}_${RCP}' = list( 
      rcm = "",
      gcm = "${GCM}",
      gcm.run = ${RUN},
      institute = "${institute}",
      emission.scenario = "${RCP}",
      file.path.alt = list(
        air_temperature =
        list(reference.period = "${CMIPPATH}/${GCMDIR}/historical",
             scenario.period =  "${CMIPPATH}/${GCMDIR}/${RCP}"),
        precipitation_amount =
        list(reference.period = "${CMIPPATH}/${GCMDIR}/historical",
             scenario.period =  "${CMIPPATH}/${GCMDIR}/${RCP}")),
      file.name = list(
        air_temperature = list(
          reference.period = c(
            "${TASHIST}"
            ),
          scenario.period = c(
            "${TASSCEN}"
            )),
        precipitation_amount = list(
          reference.period = c(
            "${PRHIST}"
            ),
          scenario.period = c(
            "${PRSCEN}"
           ))),
      gridfile.path = "${CMIPPATH}/${GCMDIR}/historical",
      gridfile.filename = "${GRIDFILE}",
      resolution = "",
      what.timesteps = "monthly"
      )""")
    otext_cmip5 = ""
    acronyms = ""
    ################################################################################
    # for modeldirectories
    
    MODELDIRS = os.listdir(CMIPPATH)  ##["CESM1(CAM5.1,FV2)", "MIROC-ESM"]
    MODELDIRS = [f for f in os.listdir(CMIPPATH) if os.path.isdir(os.path.join(CMIPPATH,f))]
    for modeldir in MODELDIRS: ## = "CESM1(CAM5.1,FV2)"   ##EC-EARTH#ACCESS1.0 ACCESS1.3
        modelname = re.sub("[\(\.\,\)]", "-", modeldir)
        modelname = re.sub("-$", "", modelname)
        
        modelsdict = {"history": {"filename": [], "PAR": [], "RUNINIT": [], "RUN": []}, 
                      "rcp26": {"filename": [], "PAR": [], "RUNINIT": [], "RUN": []}, 
                      "rcp45": {"filename": [], "PAR": [], "RUNINIT": [], "RUN": []}, 
                      "rcp60": {"filename": [], "PAR": [], "RUNINIT": [], "RUN": []}, 
                      "rcp85": {"filename": [], "PAR": [], "RUNINIT": [], "RUN": []}}
        
        # search institute name for current GCM
        institute = ""
        #        instnames = {"CSIRO-BOM": ["ACCESS1.0","ACCESS1.3"]}
        for inst, models in instnames.items():
            try:
                models.index(modeldir)
            except ValueError:
                continue
            institute = inst
        
        if institute == "":
            print "institution for " + modeldir + " not found"
            institute = "XXXX"
            
        
        ################################################################################
        # get filenames of rcp in modeldir
        
        SCENPATH = "/".join([CMIPPATH, modeldir, rcp])
        try:
            SCENFILES = [f for f in os.listdir(SCENPATH) if os.path.isfile(os.path.join(SCENPATH,f))]
        except OSError:
            print "MISSING RCP: " + rcp + " for " + modelname
            continue
        
        SCENFILES = [i for i in SCENFILES if re.search(rcp + ".*" +"nc$", i)] # get nc files
        
        for i in SCENFILES:
            parts = re.split("_", i)
            if parts.__len__() != 6:
                print("wrong filename!")
            modelsdict[rcp]["filename"].append(i)
            modelsdict[rcp]["PAR"].append(parts[0])
            #    PATHWAY = parts[3]
            modelsdict[rcp]["RUNINIT"].append(parts[4])
            modelsdict[rcp]["RUN"].append(re.sub('r', '', re.split('i', parts[4])[0]))
        
        # get unique values
        # runinits_uniq = list(set(modelscen[3]))
        # runinits = list(modelscen[3])
        
        
        
        
        ################################################################################
        # get filenames of corresponding historical run in modeldir
        HISTPATH = "/".join([CMIPPATH, modeldir, "historical"])
        HISTFILES = [f for f in os.listdir(HISTPATH) if os.path.isfile(os.path.join(HISTPATH,f))]
        HISTFILES = [i for i in HISTFILES if re.search("historical.*" +"nc$", i)] # get nc files
        
        for i in HISTFILES:
            parts = re.split("_", i)
            if parts.__len__() != 6:
                print("wrong filename!")
            modelsdict["history"]["filename"].append(i)
            modelsdict["history"]["PAR"].append(parts[0])
            modelsdict["history"]["RUNINIT"].append(parts[4])
            modelsdict["history"]["RUN"].append(re.sub('r', '', re.split('i', parts[4])[0]))
        
        
        
        # get unique values for scenarios
        runinits_scen_uniq = list(set(modelsdict[rcp]["RUNINIT"]))
        runinits_scen_uniq.sort()       # sort runs alphabethicaally
        runinits_scen = list(modelsdict[rcp]["RUNINIT"])
        parms_scen_list = list(modelsdict[rcp]["PAR"])
        # get unique values for hist
        runinits_hist_uniq = list(set(modelsdict["history"]["RUNINIT"]))
        runinits_hist = list(modelsdict["history"]["RUNINIT"])
        parms_hist_list = list(modelsdict["history"]["PAR"])
        ################################################################################
        #  for runs...
        for runinit in runinits_scen_uniq:
            run = re.sub("r", "", runinit.split("i")[0])
            curr_run_idx_scen =  [i for i, x in enumerate(runinits_scen) if x == runinit]
            curr_run_idx_hist =  [i for i, x in enumerate(runinits_hist) if x == runinit]
            if curr_run_idx_hist.__len__() == 0:
                print("NO HISTFILES: no corresponding historical runs for " + modelname + "_" + runinit + "_" + rcp + "! no dictionary tag created!")
                continue
            outfiles = dict()
            for i in PARMS:
                outfiles[i] = dict()
                for k in ["hist", "scen"]:
                    outfiles[i][k] = []
            
            for parm in PARMS:
                par_scen_idx = [i for i, x in enumerate(parms_scen_list) if x == parm]
                par_run_scen_idx = list(set(par_scen_idx).intersection(set(curr_run_idx_scen)))
                filenames_scen = [modelsdict[rcp]["filename"][f] for f in par_run_scen_idx]
                filenames_scen.sort()
                # if any filesize == 0 then warning and dont write TAG
                filesizes = [os.path.getsize(os.path.join(CMIPPATH, modeldir,rcp, i)) for i in filenames_scen]
                if 0 in filesizes:
                    print "BROKEN FILE: files of " + parm + "-" + modelname + "-" + runinit + "_" + rcp + "are faulty (0 size)"
                outfiles[parm]["scen"] = filenames_scen
                par_hist_idx = [i for i, x in enumerate(parms_hist_list) if x == parm]
                par_run_hist_idx = list(set(par_hist_idx).intersection(set(curr_run_idx_hist)))
                filenames_hist = [modelsdict["history"]["filename"][f] for f in par_run_hist_idx]
                filenames_hist.sort()
                outfiles[parm]["hist"] = filenames_hist
                # lastdate = outfiles[parm]["scen"][-1]
                try:
                    lastdate = ((outfiles[parm]["scen"][-1].split("_")[5]).split("-")[1]).split(".")[0][0:4]
                except:
                    lastdate = "0"
                
                if float(lastdate) < 2050:
                    if lastdate == "0":
                        print "no files found for \"" + parm + "\""
                    else:
                        print "short scenario for " +  modelname + "_" + runinit + "_" + rcp + " (until " +  lastdate + ")"
            
            ################################################################################
            # fill ref-scen pairs into WUX R template
            acronym = modelname + "-" + runinit + "_" + rcp
            d_modelsdict = dict(GCM = modelname,
                                GCMDIR = modeldir,
                                RUNINIT = runinit,
                                RUN = run,
                                RCP = rcp,
                                TASSCEN = '", \n            "'.join(outfiles["tas"]["scen"]),
                                TASHIST = '", \n            "'.join(outfiles["tas"]["hist"]),
                                PRSCEN = '", \n            "'.join(outfiles["pr"]["scen"]),
                                PRHIST = '", \n            "'.join(outfiles["pr"]["hist"]),
                                GRIDFILE = outfiles["tas"]["hist"][0],
                                CMIPPATH = CMIPPATH,
                                institute = institute)
            cmip5 = templ.substitute(d_modelsdict)
            if otext_cmip5 != "":
                # for the first entry, no comma at beginning
                cmip5 = ", \n" + cmip5
            ##cmip5 = ", \n" + cmip5 
            otext_cmip5 = otext_cmip5 + cmip5
            acronyms = acronyms + "\n##" + acronym
        # end for runs...
    return(otext_cmip5, acronyms)
    # end modeldirectories...
    


# rcp list
# for ... rcp
    
# # end for rcp...



def main(argv):
    # options:
    infiledirectory = ''
    outfile = ''
    try:
        opts, args = getopt.getopt(argv,"i:o:",[])
    except getopt.GetoptError:
        print 'cmip5_to_wux_modeldict -i <infiledirectory> -o <oufile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'cmip5_to_wux_modeldict -i <infiledirectory> -o <oufile>'
            sys.exit()
        elif opt in ("-i"):
            infiledirectory = arg
        elif opt in ("-o"):
            outfile = arg
    
    # all arguments must be passed!
    if infiledirectory == '' or outfile == '':
        print 'cmip5_to_wux_modeldict -i <infiledirectory> -o <oufile>'
        sys.exit(2)

    # generate modelsinput for each climate simulation for each RCP
    RCPs = ["rcp26","rcp45","rcp60", "rcp85"]
    for rcp in RCPs:
        otext = ""
        acronyms = ""
        otext_rcp, acronyms_rcp = cmip5_modelinput_gen(rcp, infiledirectory)
        otext = otext + otext_rcp
        acronyms = acronyms + acronyms_rcp

    # write all modelsinputs into one file
    otext = "modelinput = list(\n################################################################################" + otext + "\n)\n\n## acronyms in this file:" + acronyms
    # write to file
    file = open(outfile, 'w')
    file.write(otext)
    file.close()
    print "\n...\"" + outfile + "\"" + " created sucessfully"

################################################################################
# run the script
if __name__ == "__main__":
   main(sys.argv[1:])
