ROBO_ROCK_ROOT = C:\Users\csemp\dev\robotics\robo-rock-repos
CUDA_HOME = C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0
NVTOOLS_HOME = C:\Program Files\NVIDIA Corporation\NvToolsExt

LIBTORCH_HOME = $(ROBO_ROCK_ROOT)\external\libtorch_win_cuda90
OPENCV_HOME = $(ROBO_ROCK_ROOT)\external\opencv

INCLUDE_DIRS = /I"$(NVTOOLS_HOME)\include" /I"$(CUDA_HOME)\include" \
                /I"$(LIBTORCH_HOME)\include" /I"$(LIBTORCH_HOME)\include\torch\csrc\api\include" \
				/I"$(OPENCV_HOME)/build/include" \
				/I"./include" /I"."

NVIDIA_LIBS  = "$(NVTOOLS_HOME)\lib\x64\nvToolsExt64_1.lib" "$(CUDA_HOME)\lib\x64\cudart.lib" "$(CUDA_HOME)\lib\x64\cufft.lib" "$(CUDA_HOME)\lib\x64\curand.lib" "$(CUDA_HOME)\lib\x64\cudnn.lib" "$(CUDA_HOME)\lib\x64\cublas.lib" "$(CUDA_HOME)\lib\x64\cublas_device.lib" "$(CUDA_HOME)\lib\x64\cudart.lib"
LIBTORCH_LIBS = "$(LIBTORCH_HOME)\lib\torch.lib" "$(LIBTORCH_HOME)\lib\caffe2_gpu.lib" "$(LIBTORCH_HOME)\lib\caffe2.lib" "$(LIBTORCH_HOME)\lib\c10_cuda.lib" "$(LIBTORCH_HOME)\lib\c10.lib"
OPENCV_LIBS = "$(OPENCV_HOME)\build\x64\vc15\lib\opencv_world345.lib" "$(OPENCV_HOME)\build\x64\vc15\lib\opencv_world345d.lib"
LINKER_LIBS = $(NVIDIA_LIBS) $(LIBTORCH_LIBS) $(OPENCV_LIBS)

SOURCES = ".\main.cpp" ".\Darknet.cpp"
MAIN_TARGET_NAME = main
SECOND_TARGET_NAME = Darknet
# directory containing the output executable
RELEASE_DIR = .\bin

main:
    cl.exe /std:c++17 $(INCLUDE_DIRS) /nologo /W1 /WX- /diagnostics:classic /O2 /Ob2 /D WIN32 /D _WINDOWS /D NDEBUG  /D _MBCS /Gm- /EHsc /MD /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /GR /Fd"vc142.pdb" /Gd /TP /errorReport:prompt /c $(SOURCES)
    link.exe  /ERRORREPORT:PROMPT /OUT:"$(RELEASE_DIR)\$(MAIN_TARGET_NAME).exe" /INCREMENTAL:NO /NOLOGO $(LINKER_LIBS) kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /PDB:"$(RELEASE_DIR)/$(MAIN_TARGET_NAME).pdb" /SUBSYSTEM:CONSOLE /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"$(RELEASE_DIR)/$(MAIN_TARGET_NAME).lib" /MACHINE:X64  /machine:x64 ".\$(MAIN_TARGET_NAME)" ".\$(SECOND_TARGET_NAME)"
    rm .\$(MAIN_TARGET_NAME).obj
    rm $(RELEASE_DIR)\$(MAIN_TARGET_NAME).exp
    rm $(RELEASE_DIR)\$(MAIN_TARGET_NAME).lib
    rm .\$(SECOND_TARGET_NAME).obj