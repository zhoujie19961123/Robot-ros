# ------------------- Required for MSVC nmake ---------------------------------
# This file should be included at the top of a MAKEFILE as follows:


CPU = AMD64

MACHINE     = kamasample1
TARGET      = sfun
CHART_SRCS   = c2_kamasample1.c
MACHINE_SRC  = kamasample1_sfun.c
MACHINE_REG = kamasample1_sfun_registry.c
MAKEFILE    = kamasample1_sfun.mak
MATLAB_ROOT  = F:\matlab
BUILDARGS   =

#--------------------------- Tool Specifications ------------------------------
#
#
MSVC_ROOT1 = $(MSDEVDIR:SharedIDE=vc)
MSVC_ROOT2 = $(MSVC_ROOT1:SHAREDIDE=vc)
MSVC_ROOT  = $(MSVC_ROOT2:sharedide=vc)

# Compiler tool locations, CC, LD, LIBCMD:
CC     = cl.exe
LD     = link.exe
LIBCMD = lib.exe
#------------------------------ Include/Lib Path ------------------------------

USER_INCLUDES   = 
AUX_INCLUDES   = 
MLSLSF_INCLUDES = \
    /I "F:\matlab\extern\include" \
    /I "F:\matlab\simulink\include" \
    /I "F:\matlab\stateflow\c\mex\include" \
    /I "F:\matlab\rtw\c\src" \
    /I "D:\�������о�\�������˲���\slprj\_sfprj\kamasample1\_self\sfun\src" 

COMPILER_INCLUDES = /I "$(MSVC_ROOT)\include"

THIRD_PARTY_INCLUDES   = 
INCLUDE_PATH = $(USER_INCLUDES) $(AUX_INCLUDES) $(MLSLSF_INCLUDES)\
 $(THIRD_PARTY_INCLUDES)
LIB_PATH     = "$(MSVC_ROOT)\lib"

CFLAGS = /c /Zp8 /GR /W3 /EHs /D_CRT_SECURE_NO_DEPRECATE /D_SCL_SECURE_NO_DEPRECATE /D_SECURE_SCL=0 /DMATLAB_MEX_FILE /nologo /MD 
LDFLAGS = /nologo /dll /MANIFEST /OPT:NOREF /export:mexFunction  
#----------------------------- Source Files -----------------------------------

REQ_SRCS  =  $(MACHINE_SRC) $(MACHINE_REG) $(CHART_SRCS)

USER_ABS_OBJS =

AUX_ABS_OBJS =

THIRD_PARTY_OBJS =

REQ_OBJS = $(REQ_SRCS:.cpp=.obj)
REQ_OBJS2 = $(REQ_OBJS:.c=.obj)
OBJS = $(REQ_OBJS2) $(USER_ABS_OBJS) $(AUX_ABS_OBJS) $(THIRD_PARTY_OBJS)
OBJLIST_FILE = kamasample1_sfun.mol
SFCLIB = 
AUX_LNK_OBJS =     
USER_LIBS = 
LINK_MACHINE_LIBS = 
BLAS_LIBS = "F:\matlab\extern\lib\win64\microsoft\libmwblas.lib" 
THIRD_PARTY_LIBS = 

#--------------------------------- Rules --------------------------------------

MEX_FILE_NAME_WO_EXT = $(MACHINE)_$(TARGET)
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw64
MEX_FILE_CSF =
all : $(MEX_FILE_NAME) $(MEX_FILE_CSF)

TMWLIB = "F:\matlab\extern\lib\win64\microsoft\sf_runtime.lib" "F:\matlab\extern\lib\win64\microsoft\libmx.lib" "F:\matlab\extern\lib\win64\microsoft\libmex.lib" "F:\matlab\extern\lib\win64\microsoft\libmat.lib" "F:\matlab\extern\lib\win64\microsoft\libfixedpoint.lib" "F:\matlab\extern\lib\win64\microsoft\libut.lib" "F:\matlab\extern\lib\win64\microsoft\libmwmathutil.lib" "F:\matlab\extern\lib\win64\microsoft\libemlrt.lib" "F:\matlab\extern\lib\win64\microsoft\libmwsl_log_load_blocks.lib" "F:\matlab\extern\lib\win64\microsoft\libmwsimulink.lib" "F:\matlab\lib\win64\libmwipp.lib" 

$(MEX_FILE_NAME) : $(MAKEFILE) $(OBJS) $(SFCLIB) $(AUX_LNK_OBJS) $(USER_LIBS) $(THIRD_PARTY_LIBS)
 @echo ### Linking ...
 $(LD) $(LDFLAGS) /OUT:$(MEX_FILE_NAME) /map:"$(MEX_FILE_NAME_WO_EXT).map"\
  $(USER_LIBS) $(SFCLIB) $(AUX_LNK_OBJS)\
  $(TMWLIB) $(LINK_MACHINE_LIBS) $(DSP_LIBS) $(BLAS_LIBS) $(THIRD_PARTY_LIBS)\
  @$(OBJLIST_FILE)
     mt -outputresource:"$(MEX_FILE_NAME);2" -manifest "$(MEX_FILE_NAME).manifest"
	@echo ### Created $@

.c.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"

.cpp.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"


