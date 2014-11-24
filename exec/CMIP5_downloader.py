# this programm generates bash scripts to download CMIP5 data
# update regarding completely new models (i.e. institutions which
# havent contributed so far) just run his script, it will download
# just the new models, omitting the old ones. If you want to update
# existing models (e.g. get new runs or newer model version), then you
# have to delete the corresonding bash scripts in the individual
# folders.

# TODO: - if bash is invalid, omit it!
#       - download individual models
#       - download individual parameters

from xml.dom import minidom
import urllib
import os, stat, subprocess, math
import sys, getopt

class CmipDownloader:
    """downloads all CMIP5 data of given pathways and variables to
    a given directory""" 
    
    def __init__(self, pathway):
        self.getAvailableModels(pathway)        
    
    def getAvailableModels(self, pathway):
        url = 'http://pcmdi9.llnl.gov/esg-search/search?type=Dataset&latest=true&realm=atmos&project=CMIP5&time_frequency=mon&limit=0&facets=model,experiment,ensemble,variable,id&experiment=' + pathway ##&replica=false 
        print "opening url connection..."
        try:
            usock = urllib.urlopen(url)
            xmldoc = minidom.parse(usock)
            usock.close()
            print "...done"
        except:
            print "...could not connect to server"
            sys.exit()
        self.xmlCount = xmldoc
        self.loadXML(xmldoc)
        self.modelCounter()
        
    def loadXML(self, xml):
        """parse XML file and get number of datasets"""
        
        # get reuslt tag
        resultTag = xml.getElementsByTagName("result")
        self.numberOfResults = resultTag[0].attributes["numFound"].value
        ##print "datasets found: "+ self.numberOfResults
        
        # get all lts tags
        self.lsts = {}                                       
        for lst in xml.getElementsByTagName("lst"): 
            self.lsts[lst.attributes["name"].value] = lst       
        
    def modelCounter(self):
        modelTag = self.lsts["model"]
        self.models=[]
        for model in modelTag.getElementsByTagName("int"):
            self.models.append(model.attributes["name"].value)


# define functions
def makeFilestructure(models, pathways, directory):
    print "you are in directory " + os.getcwd()
    for model in models:
        model = model.encode()
        for pathway in pathways:
            pathway = pathway.encode()
            modeldir = os.path.join(directory, model, pathway) ##model + "/" + experiment
            if os.path.exists(modeldir) == False:
                print "create " + str(modeldir)
                os.makedirs(modeldir) 

def getBashes(models, pathways, directory, variable, overwrite = False):
    # retrieveing wget bash scripts for CMIP5
    
    varstring = "variable=" + variable
    rootdir = directory
    for model in models:
        model = model.encode()
        for pathway in pathways:
            pathway = pathway.encode()
            modeldir = os.path.join(directory, model, pathway)##model + "/" + pathway
            os.chdir(modeldir)
            bashname = variable + "_" + model + pathway + ".sh"
            if overwrite == False:
                if os.path.exists(bashname):
                    print "file " + str(bashname) + " exists, omitting"
                    os.chdir(rootdir)
                    continue
            print "getting bashscript " + bashname + "..."
            urlDownload = "http://pcmdi9.llnl.gov/esg-search/wget?latest=true&realm=atmos&project=CMIP5&experiment=" + pathway + "&time_frequency=mon&" + varstring +"&model=" + model +"&limit=1000&facets=experiment,ensemble" ##&replica=false
            urllib.urlretrieve(urlDownload, bashname)
            os.chmod(bashname, stat.S_IRWXU | stat.S_IRWXG | stat.S_IRWXO) # chmod
            os.chdir(rootdir)
    print "...done"



def executeBashes(models, pathways, directory, variable):
    # e.g. execueBashes(["ACCESS1.3"], ["historical"])
    rootdir = os.getcwd()
    for model in models:
        model = model.encode()
        for pathway in pathways:
            pathway = pathway.encode()
            modeldir = os.path.join(directory, model, pathway)
            os.chdir(modeldir)
            print os.getcwd()
            bashname = variable + "_" +  model + pathway + ".sh"
            print "executing bashscript " + bashname + "..."
            try:
                subprocess.call(["./" + bashname, "i"])            
            except:
                print "invalid bash script " + bashname + ", probably the variable short name you provided does not exist for this model"
            os.chdir(rootdir)


def getSumSize():
    # get filsizes of models to be downloaded
    modelss = "&model=".join(f.models).encode()
    urlDownloadInfo = "http://pcmdi9.llnl.gov/esg-search/search?type=File&latest=true&realm=atmos&project=CMIP5&experiment=historical&experiment=rcp26&experiment=rcp45&experiment=rcp60&experiment=rcp85&&time_frequency=mon&variable=tas&model=" +modelss+ "&limit=10000&facets=experiment,ensemble" ##&replica=false
    usock = urllib.urlopen(urlDownloadInfo)
    xmldoc = minidom.parse(usock)
    usock.close()
    sizes.append(getSize(xmldoc))
    print sum(sizes[0])

def getSize(xmldoc):
    longs = xmldoc.getElementsByTagName("long")
    sizeMB = []
    count = 0
    for ii in longs:
        sizeMB.append(float(longs[count].firstChild.data)/1024/1024)
        count = count + 1
    return(sizeMB)



def main(argv):
    # options:
    # mandatory: filepath, variable, pathways
    # usage...
    filedirectory = ''
    variable = ''
    pathway = ''
    model = ['',]
    try:
        opts, args = getopt.getopt(argv,"d:v:p:m:",[])
    except getopt.GetoptError:
        print 'bla CMIP5_downloader -d <filedirectory> -v <variable> -p <pathway> -m <models>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'CMIP5_downloader -d <filedirectory> -v <variable> -p <pathway> -m <models>'
            sys.exit()
        elif opt in ("-d"):
            filedirectory = arg
        elif opt in ("-v"):
            variable = arg
        elif opt in ("-p"):
            pathway = arg
        elif opt in ("-m"):
            model = [arg,]

    # all arguments must be passed!
    if filedirectory == '' or variable == '' or pathway == '':
        print 'CMIP5_downloader -d <filedirectory> -v <variable> -p <pathway> -m <models>'
        sys.exit(2)
        
    pathway = pathway
    
    # for pathway in pathways:
    # check which CMIP5 models are awailable at ESGF
    frcp = CmipDownloader(pathway)
    # user can select single simulations to be downloaded, but they
    # must be available at the ESGF
    if model[0] in frcp.models:
        frcp.models = model
    # else download all data
    
    # this GCM is not downloadable, thus we skip it
    # if pathway == "historical":
    # frcp.models.remove("CESM1(CAM5.1,FV2)")
    print "this program will download " + str(len(frcp.models)) + " CMIP5 models"
    # create directory structure 
    makeFilestructure(frcp.models, [pathway], filedirectory)
    # # download bashes from ESGF
    getBashes(frcp.models, [pathway], filedirectory ,variable)
    # # run bash for each simulation
    executeBashes(frcp.models, [pathway], filedirectory, variable)

################################################################################
# run the script
if __name__ == "__main__":
   main(sys.argv[1:])


# # EXECUTE BASHDOWNLOADS (dirstructure already created and bashscripts downloaded succesfully)
# frcp45 = CmipDownloader("rcp45") 
# print "this program will download " + str(len(frcp45.models)) + " CMIP5 models"
# makeFilestructure(frcp45.models, ["rcp45"])
# getBashes(frcp45.models, ["rcp45"])
# executeBashes(frcp45.models, ["rcp45"])

# fhist = CmipDownloader("historical") 
# print "this program will download " + str(len(fhist.models)) + " CMIP5 models"
# makeFilestructure(fhist.models, ["historical"])
# getBashes(fhist.models, ["historical"])
# ##fhist.models.remove("INM-CM4") # not working... yes it is...
# fhist.models.remove("CESM1(CAM5.1,FV2)") # not working...
# modelAmount = len(fhist.models)
# print modelAmount
# m1 = int(math.floor(modelAmount/3.))
# m2 = m1 + 1 + int(math.floor(modelAmount*2./9.))
# m3 = m2 + 1 + int(math.floor(modelAmount*2./9.))
# print fhist.models
# # executeBashes(['CSIRO-Mk3L-1-2'], ["historical"])
# executeBashes(fhist.models, ["historical"])
# # executeBashes(fhist.models[0:m1], ["historical"])
# # executeBashes(fhist.models[(m1 + 1):m2], ["historical"])
# # executeBashes(fhist.models[(m2 + 1):m3], ["historical"])
# # executeBasheseses(fhist.models[(m3 + 1):m3(len(fhist.models))], ["historical"])

# frcp26 = CmipDownloader("rcp26") 
# frcp26.models.remove("CESM1(WACCM)") # not working...
# print "this program will download " + str(len(frcp26.models)) + " CMIP5 models"
# makeFilestructure(frcp26.models, ["rcp26"])
# getBashes(frcp26.models, ["rcp26"])
# executeBashes(frcp26.models, ["rcp26"])

# frcp85 = CmipDownloader("rcp85") 
# print "this program will download " + str(len(frcp85.models)) + " CMIP5 models"
# makeFilestructure(frcp85.models, ["rcp85"])
# getBashes(frcp85.models, ["rcp85"])
# executeBashes(frcp85.models, ["rcp85"])

# # INM IS WORKING AGAIN...
# # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[0:17], ["rcp85"])

# # # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[18:21], ["rcp85"])

# # # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[22:25], ["rcp85"])

# # # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[26:29], ["rcp85"])

# # # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[30:33], ["rcp85"])

# # # frcp85.models.remove("INM-CM4") # not working...
# # executeBashes(frcp85.models[34:(len(frcp85.models))], ["rcp85"])
# # # # FGOALS-g2 sich nicht ausgangen...



# frcp60 = CmipDownloader("rcp60") 
# print "this program will download " + str(len(frcp60.models)) + " CMIP5 models"
# makeFilestructure(frcp60.models, ["rcp60"])
# getBashes(frcp60.models, ["rcp60"])
# executeBashes(frcp60.models, ["rcp60"])


