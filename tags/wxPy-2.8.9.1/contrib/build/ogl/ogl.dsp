# Microsoft Developer Studio Project File - Name="ogl" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102
# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=ogl - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ogl.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ogl.mak" CFG="ogl - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ogl - Win32 DLL Universal Unicode Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Universal Unicode Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Universal Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Universal Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Unicode Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Unicode Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 DLL Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ogl - Win32 Universal Unicode Release" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Universal Unicode Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Universal Release" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Universal Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Unicode Release" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Unicode Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "ogl - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ogl - Win32 DLL Universal Unicode Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswunivudll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswunivudll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivu" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivudll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivu" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivudll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivu" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28u_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivu" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28u_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregexu.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28u_core.lib wxbase28u.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.pdb"
# ADD LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregexu.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28u_core.lib wxbase28u.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28u_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Unicode Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswunivuddll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswunivuddll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivud" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivuddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivud" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivuddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "__WXDEBUG__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivud" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28ud_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "__WXDEBUG__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivud" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28ud_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexud.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28ud_core.lib wxbase28ud.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.pdb"
# ADD LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexud.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28ud_core.lib wxbase28ud.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28ud_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswunivdll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswunivdll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswuniv" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivdll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswuniv" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivdll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "__WXMSW__" /d "__WXUNIVERSAL__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswuniv" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "__WXMSW__" /d "__WXUNIVERSAL__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswuniv" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregex.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28_core.lib wxbase28.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.pdb"
# ADD LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregex.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28_core.lib wxbase28.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswunivddll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswunivddll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivd" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivd" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswunivddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "__WXDEBUG__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivd" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28d_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXUNIVERSAL__" /d "__WXDEBUG__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswunivd" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmswuniv28d_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexd.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28d_core.lib wxbase28d.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.pdb"
# ADD LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexd.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmswuniv28d_core.lib wxbase28d.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmswuniv28d_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Unicode Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswudll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswudll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswu" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswudll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswu" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswudll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "__WXMSW__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswu" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28u_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "__WXMSW__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswu" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28u_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregexu.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28u_core.lib wxbase28u.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.pdb"
# ADD LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregexu.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28u_core.lib wxbase28u.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28u_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Unicode Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswuddll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswuddll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswud" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswuddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswud" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswuddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXDEBUG__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswud" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28ud_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXDEBUG__" /d "_UNICODE" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswud" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28ud_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexud.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28ud_core.lib wxbase28ud.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.pdb"
# ADD LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexud.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28ud_core.lib wxbase28ud.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28ud_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswdll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswdll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\msw" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswdll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\msw" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswdll\wxprec_ogldll.pch" /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "__WXMSW__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "__WXMSW__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\msw" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "__WXMSW__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\msw" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregex.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28_core.lib wxbase28.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.pdb"
# ADD LINK32 wxtiff.lib wxjpeg.lib wxpng.lib wxzlib.lib wxregex.lib wxexpat.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28_core.lib wxbase28.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl.lib" /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP BASE Intermediate_Dir "vc_mswddll\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_dll"
# PROP Intermediate_Dir "vc_mswddll\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswd" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_dll\mswd" /I "..\..\src\ogl\..\..\..\include" /W4 /Yu"wx/wxprec.h" /Fp"vc_mswddll\wxprec_ogldll.pch" /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.pdb /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /c
# ADD BASE MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD MTL /nologo /D "WIN32" /D "_USRDLL" /D "DLL_EXPORTS" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "WXUSINGDLL" /D "WXMAKINGDLL_OGL" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXDEBUG__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswd" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28d_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
# ADD RSC /l 0x409 /d "_DEBUG" /d "__WXMSW__" /d "__WXDEBUG__" /i "..\..\src\ogl\..\..\..\lib\vc_dll\mswd" /i "..\..\src\ogl\..\..\..\include" /d WXDLLNAME=wxmsw28d_ogl_vc_custom /i "..\..\src\ogl\..\..\include" /d "WXUSINGDLL" /d WXMAKINGDLL_OGL
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexd.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28d_core.lib wxbase28d.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.pdb"
# ADD LINK32 wxtiffd.lib wxjpegd.lib wxpngd.lib wxzlibd.lib wxregexd.lib wxexpatd.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib wxmsw28d_core.lib wxbase28d.lib /nologo /dll /machine:i386 /out:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.dll" /libpath:"..\..\src\ogl\..\..\..\lib\vc_dll" /implib:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl.lib" /debug /pdb:"..\..\src\ogl\..\..\..\lib\vc_dll\wxmsw28d_ogl_vc_custom.pdb"

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Unicode Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswunivu\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswunivu\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivu" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28u_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivu\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivu" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28u_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivu\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "_UNICODE" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28u_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28u_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Unicode Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswunivud\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswunivud\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivud" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28ud_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivud\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivud" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28ud_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivud\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /D "_UNICODE" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28ud_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28ud_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswuniv\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswuniv\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswuniv" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswuniv\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "__WXUNIVERSAL__" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswuniv" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswuniv\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "__WXUNIVERSAL__" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswunivd\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswunivd\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivd" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28d_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivd\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswunivd" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28d_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswunivd\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXUNIVERSAL__" /D "__WXDEBUG__" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28d_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmswuniv28d_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Unicode Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswu\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswu\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswu" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28u_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswu\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "_UNICODE" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswu" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28u_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswu\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /D "_UNICODE" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28u_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28u_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Unicode Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswud\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswud\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswud" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28ud_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswud\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswud" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28ud_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswud\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /D "_UNICODE" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28ud_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28ud_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_msw\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_msw\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\msw" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_msw\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /c
# ADD CPP /nologo /FD /MD /O2 /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\msw" /I "..\..\src\ogl\..\..\..\include" /W4 /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_msw\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "__WXMSW__" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28_ogl.lib"

!ELSEIF  "$(CFG)" == "ogl - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP BASE Intermediate_Dir "vc_mswd\ogl"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\src\ogl\..\..\..\lib\vc_lib"
# PROP Intermediate_Dir "vc_mswd\ogl"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswd" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28d_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswd\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /c
# ADD CPP /nologo /FD /MDd /Od /Gm /GR /EHsc /I "..\..\src\ogl\..\..\..\lib\vc_lib\mswd" /I "..\..\src\ogl\..\..\..\include" /W4 /Zi /Fd..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28d_ogl.pdb /Yu"wx/wxprec.h" /Fp"vc_mswd\wxprec_ogllib.pch" /I "..\..\src\ogl\..\..\include" /D "WIN32" /D "_LIB" /D "_DEBUG" /D "__WXMSW__" /D "__WXDEBUG__" /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28d_ogl.lib"
# ADD LIB32 /nologo /out:"..\..\src\ogl\..\..\..\lib\vc_lib\wxmsw28d_ogl.lib"

!ENDIF

# Begin Target

# Name "ogl - Win32 DLL Universal Unicode Release"
# Name "ogl - Win32 DLL Universal Unicode Debug"
# Name "ogl - Win32 DLL Universal Release"
# Name "ogl - Win32 DLL Universal Debug"
# Name "ogl - Win32 DLL Unicode Release"
# Name "ogl - Win32 DLL Unicode Debug"
# Name "ogl - Win32 DLL Release"
# Name "ogl - Win32 DLL Debug"
# Name "ogl - Win32 Universal Unicode Release"
# Name "ogl - Win32 Universal Unicode Debug"
# Name "ogl - Win32 Universal Release"
# Name "ogl - Win32 Universal Debug"
# Name "ogl - Win32 Unicode Release"
# Name "ogl - Win32 Unicode Debug"
# Name "ogl - Win32 Release"
# Name "ogl - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\ogl\basic.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\basic2.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\bmpshape.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\canvas.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\composit.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\constrnt.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\divided.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\drawn.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\..\..\..\src\common\dummy.cpp
# ADD BASE CPP /Yc"wx/wxprec.h"
# ADD CPP /Yc"wx/wxprec.h"
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\lines.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\mfutils.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\ogldiag.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\oglmisc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\src\ogl\..\..\..\src\msw\version.rc

!IF  "$(CFG)" == "ogl - Win32 DLL Universal Unicode Release"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Unicode Debug"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Release"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Universal Debug"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Unicode Release"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Unicode Debug"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Release"


!ELSEIF  "$(CFG)" == "ogl - Win32 DLL Debug"


!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Unicode Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Unicode Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Universal Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Unicode Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Unicode Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "ogl - Win32 Debug"

# PROP Exclude_From_Build 1

!ENDIF

# End Source File
# End Group
# End Target
# End Project

