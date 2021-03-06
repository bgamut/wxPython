////////////////////////////////////////////////////////////////////////////
// Name:        wxPython_int.h   (int == internal)
// Purpose:     Helper functions/classes for the wxPython extension module
//              This header should only be inclued directly by those source
//              modules included in the wx._core module.  All others should
//              include wx/wxPython/wxPython.h instead.
//
// Author:      Robin Dunn
//
// Created:     1-July-1997
// RCS-ID:      $Id$
// Copyright:   (c) 1998 by Total Control Software
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

#ifndef __wxp_helpers__
#define __wxp_helpers__

#include <wx/wx.h>

#include <wx/busyinfo.h>
#include <wx/caret.h>
#include <wx/choicebk.h>
#include <wx/clipbrd.h>
#include <wx/colordlg.h>
#include <wx/config.h>
#include <wx/cshelp.h>
#include <wx/dcmirror.h>
#include <wx/dcps.h>
#include <wx/dirctrl.h>
#include <wx/dirdlg.h>
#include <wx/numdlg.h>
#include <wx/dnd.h>
#include <wx/docview.h>
#include <wx/encconv.h>
#include <wx/fdrepdlg.h>
#include <wx/fileconf.h>
#include <wx/filesys.h>
#include <wx/fontdlg.h>
#include <wx/fs_inet.h>
#include <wx/fs_mem.h>
#include <wx/fs_zip.h>
#include <wx/gbsizer.h>
#include <wx/wrapsizer.h>
#include <wx/geometry.h>
#include <wx/htmllbox.h>
#include <wx/image.h>
#include <wx/imaglist.h>
#include <wx/intl.h>
#include <wx/laywin.h>
#include <wx/listbook.h>
#include <wx/minifram.h>
#include <wx/notebook.h>
#include <wx/print.h>
#include <wx/printdlg.h>
#include <wx/process.h>
#include <wx/progdlg.h>
#include <wx/sashwin.h>
#include <wx/spinbutt.h>
#include <wx/spinctrl.h>
#include <wx/splash.h>
#include <wx/splitter.h>
#include <wx/statline.h>
#include <wx/stream.h>
#include <wx/sysopt.h>
#include <wx/taskbar.h>
#include <wx/tglbtn.h>
#include <wx/tipwin.h>
#include <wx/toolbook.h>
#include <wx/tooltip.h>
#include <wx/treebook.h>
#include <wx/vlbox.h>
#include <wx/vscroll.h>
#include <wx/dateevt.h>
#include <wx/datectrl.h>
#include <wx/power.h>
#include <wx/hyperlink.h>
#include <wx/pickerbase.h>
#include <wx/clrpicker.h>
#include <wx/filepicker.h>
#include <wx/fontpicker.h>    
#include <wx/collpane.h>
#include <wx/srchctrl.h>

#ifdef _MSC_VER
# pragma warning(disable:4800)
# pragma warning(disable:4190)
#endif

#ifdef __WXMAC__  // avoid a bug in Carbon headers
#define scalb scalbn
#endif

//---------------------------------------------------------------------------

#ifndef wxHAS_POWER_EVENTS
class wxPowerEvent : public wxEvent
{
public:
    wxPowerEvent(wxEventType evtType) : wxEvent(wxID_NONE, evtType) {}
    void Veto() {}
    bool IsVetoed() const { return false; }
    virtual wxEvent *Clone() const { return new wxPowerEvent(*this); }
};
#endif

//---------------------------------------------------------------------------
typedef unsigned char  byte;
typedef unsigned char* buffer;

typedef wxPoint2DDouble wxPoint2D;    
typedef wxRect2DDouble  wxRect2D;

#ifndef SWIG_TYPE_TABLE
#define SWIG_TYPE_TABLE wxPython_type_table
#endif

#ifdef __WXGTK__
#define wxDEFAULT_STATUSBAR_STYLE wxST_SIZEGRIP|wxFULL_REPAINT_ON_RESIZE
#else
#define wxDEFAULT_STATUSBAR_STYLE wxST_SIZEGRIP
#endif

#ifndef wxPyUSE_EXPORTED_API

void      __wxPyPreStart(PyObject*);
void      __wxPyCleanup();
PyObject* __wxPySetDictionary(PyObject*, PyObject* args);

void        wxSetDefaultPyEncoding(const char* encoding);
const char* wxGetDefaultPyEncoding();


void wxPyEventThunker(wxObject*, wxEvent& event);


bool wxPyCheckSwigType(const wxString& className);
PyObject* wxPyConstructObject(void* ptr,
                              const wxString& className,
                              int setThisOwn=0);
bool wxPyConvertSwigPtr(PyObject* obj, void **ptr,
                        const wxString& className);
PyObject* wxPyMakeSwigPtr(void* ptr, const wxString& classname);


PyObject* wx2PyString(const wxString& src);
wxString  Py2wxString(PyObject* source);

PyObject* wxPyMake_wxObject(wxObject* source, bool setThisOwn, bool checkEvtHandler=true);
PyObject* wxPyMake_wxSizer(wxSizer* source, bool setThisOwn);
void      wxPyPtrTypeMap_Add(const char* commonName, const char* ptrName);

long      wxPyGetWinHandle(wxWindow* win);

void wxPy_ReinitStockObjects(int pass);

bool wxPyInstance_Check(PyObject* obj);
bool wxPySwigInstance_Check(PyObject* obj);

#endif // wxPyUSE_EXPORTED_API
//---------------------------------------------------------------------------

// if we want to handle threads and Python threads are available...
#if defined(WXP_USE_THREAD) && defined(WITH_THREAD)
#define WXP_WITH_THREAD
#else  // no Python threads...
#undef WXP_WITH_THREAD
#endif


// In Python 2.3 and later there are the PyGILState_* APIs that we can use for
// blocking threads when calling back into Python. Using them instead of my
// home-grown hacks greatly simplifies wxPyBeginBlockThreads and
// wxPyEndBlockThreads.
//
// Unfortunatly there is a bug somewhere when using these new APIs on Python
// 2.3.  It manifests in Boa Constructor's debugger where it is unable to stop
// at breakpoints located in event handlers.  I think that the cause may be
// something like the original PyThreadState for the main thread is not being
// restored for the callbacks, but I can't see where that could be
// happening...  So we'll only activate this new change for Python 2.4+  :-(

#if PY_VERSION_HEX < 0x02040000
#define wxPyUSE_GIL_STATE 0
typedef bool wxPyBlock_t;
#define wxPyBlock_t_default false
#else
#define wxPyUSE_GIL_STATE 1
typedef PyGILState_STATE wxPyBlock_t;
#define wxPyBlock_t_default PyGILState_UNLOCKED
#endif


// Python 2.5 changes the type of some API parameter and return types.  Using
// this typedef for versions < 2.5 will help with the transition...
#if PY_VERSION_HEX < 0x02050000
typedef int Py_ssize_t;
#endif


#ifndef wxPyUSE_EXPORTED_API

// For Python --> C++
PyThreadState* wxPyBeginAllowThreads();
void           wxPyEndAllowThreads(PyThreadState* state);

// For C++ --> Python
wxPyBlock_t wxPyBeginBlockThreads();
void wxPyEndBlockThreads(wxPyBlock_t blocked);

#endif // wxPyUSE_EXPORTED_API


// A macro that will help to execute simple statments wrapped in
// StartBlock/EndBlockThreads calls
#define wxPyBLOCK_THREADS(stmt) \
    { wxPyBlock_t blocked = wxPyBeginBlockThreads(); stmt; wxPyEndBlockThreads(blocked); }

// Raise the NotImplementedError exception  (blocking threads)
#define wxPyRaiseNotImplemented() \
    wxPyBLOCK_THREADS(PyErr_SetNone(PyExc_NotImplementedError))

// Raise any exception with a string value  (blocking threads)
#define wxPyErr_SetString(err, str) \
    wxPyBLOCK_THREADS(PyErr_SetString(err, str))


//---------------------------------------------------------------------------
// These are helpers used by the typemaps

#ifndef wxPyUSE_EXPORTED_API

wxString* wxString_in_helper(PyObject* source);

byte* byte_LIST_helper(PyObject* source);
int* int_LIST_helper(PyObject* source);
long* long_LIST_helper(PyObject* source);
char** string_LIST_helper(PyObject* source);
wxPoint* wxPoint_LIST_helper(PyObject* source, int* npoints);
wxPoint2D* wxPoint2D_LIST_helper(PyObject* source, size_t* npoints);
wxBitmap** wxBitmap_LIST_helper(PyObject* source);
wxString* wxString_LIST_helper(PyObject* source);
wxAcceleratorEntry* wxAcceleratorEntry_LIST_helper(PyObject* source);
wxPen** wxPen_LIST_helper(PyObject* source);

bool wxSize_helper(PyObject* source, wxSize** obj);
bool wxPoint_helper(PyObject* source, wxPoint** obj);
bool wxRealPoint_helper(PyObject* source, wxRealPoint** obj);
bool wxRect_helper(PyObject* source, wxRect** obj);
bool wxColour_helper(PyObject* source, wxColour** obj);
bool wxPoint2D_helper(PyObject* source, wxPoint2D** obj);
bool wxRect2D_helper(PyObject* source, wxRect2D** obj);
bool wxPosition_helper(PyObject* source, wxPosition** obj);

wxVariant wxVariant_in_helper(PyObject* source);
PyObject* wxVariant_out_helper(const wxVariant& value);

bool wxPySimple_typecheck(PyObject* source, const wxChar* classname, int seqLen);
bool wxColour_typecheck(PyObject* source);


// Other helpful stuff
bool wxPyCheckForApp();
bool wxPyTestDisplayAvailable();

bool wxPy2int_seq_helper(PyObject* source, int* i1, int* i2);
bool wxPy4int_seq_helper(PyObject* source, int* i1, int* i2, int* i3, int* i4);

PyObject* wxArrayString2PyList_helper(const wxArrayString& arr);
PyObject* wxArrayInt2PyList_helper(const wxArrayInt& arr);
PyObject* wxArrayDouble2PyList_helper(const wxArrayDouble& arr);

#endif // wxPyUSE_EXPORTED_API

//---------------------------------------------------------------------------

#if PYTHON_API_VERSION < 1009
#define PySequence_Fast_GET_ITEM(o, i) \
     (PyList_Check(o) ? PyList_GET_ITEM(o, i) : PyTuple_GET_ITEM(o, i))
#endif

#define RETURN_NONE()                 { Py_INCREF(Py_None); return Py_None; }
#define DECLARE_DEF_STRING(name)      static const wxString wxPy##name(wx##name)
#define DECLARE_DEF_STRING2(name,val) static const wxString wxPy##name(val)

//---------------------------------------------------------------------------

#ifndef wxPyUSE_EXPORTED_API

class wxPyCallback : public wxObject {
    DECLARE_ABSTRACT_CLASS(wxPyCallback)
public:
    wxPyCallback(PyObject* func);
    wxPyCallback(const wxPyCallback& other);
    ~wxPyCallback();

    void EventThunker(wxEvent& event);

    PyObject*   m_func;
};

#endif // wxPyUSE_EXPORTED_API
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// These Event classes can be derived from in Python and passed through the
// event system without loosing anything.  They do this by keeping a reference
// to themselves and some special case handling in wxPyCallback::EventThunker.



class wxPyEvtSelfRef {
public:
    wxPyEvtSelfRef();
    ~wxPyEvtSelfRef();

    void SetSelf(PyObject* self, bool clone=false);
    PyObject* GetSelf() const;
    bool GetCloned() const { return m_cloned; }

protected:
    PyObject*   m_self;
    bool        m_cloned;
};


class wxPyEvent : public wxEvent, public wxPyEvtSelfRef {
    DECLARE_ABSTRACT_CLASS(wxPyEvent)
public:
    wxPyEvent(int winid=0, wxEventType commandType = wxEVT_NULL);
    wxPyEvent(const wxPyEvent& evt);
    ~wxPyEvent();

    virtual wxEvent* Clone() const { return new wxPyEvent(*this); }
};


class wxPyCommandEvent : public wxCommandEvent, public wxPyEvtSelfRef {
    DECLARE_ABSTRACT_CLASS(wxPyCommandEvent)
public:
    wxPyCommandEvent(wxEventType commandType = wxEVT_NULL, int id=0);
    wxPyCommandEvent(const wxPyCommandEvent& evt);
    ~wxPyCommandEvent();

    virtual wxEvent* Clone() const { return new wxPyCommandEvent(*this); }
};



//----------------------------------------------------------------------
// Forward decalre a few things used in the exported API
class wxPyClientData;
class wxPyUserData;
class wxPyOORClientData;
class wxPyCBInputStream;
class wxPyCBOutputStream;

void wxPyClientData_dtor(wxPyClientData* self);
void wxPyUserData_dtor(wxPyUserData* self);
void wxPyOORClientData_dtor(wxPyOORClientData* self);
wxPyCBInputStream* wxPyCBInputStream_create(PyObject *py, bool block);
wxPyCBInputStream* wxPyCBInputStream_copy(wxPyCBInputStream* other);

wxPyCBOutputStream* wxPyCBOutputStream_create(PyObject *py, bool block);
wxPyCBOutputStream* wxPyCBOutputStream_copy(wxPyCBOutputStream* other);

//---------------------------------------------------------------------------
// Export a C API in a struct.  Other modules will be able to load this from
// the wx.core module and will then have safe access to these functions, even if
// in another shared library.

class wxPyCallbackHelper;

struct wxPyCoreAPI {

    bool                (*p_wxPyCheckSwigType)(const wxString& className);
    PyObject*           (*p_wxPyConstructObject)(void* ptr, const wxString& className, int setThisOwn);
    bool                (*p_wxPyConvertSwigPtr)(PyObject* obj, void **ptr, const wxString& className);
    PyObject*           (*p_wxPyMakeSwigPtr)(void* ptr, const wxString& className);
        
    PyThreadState*      (*p_wxPyBeginAllowThreads)();
    void                (*p_wxPyEndAllowThreads)(PyThreadState* state);
    wxPyBlock_t         (*p_wxPyBeginBlockThreads)();
    void                (*p_wxPyEndBlockThreads)(wxPyBlock_t blocked);

    void*               unused1; // this slot is no longer used

    wxString*           (*p_wxString_in_helper)(PyObject* source);
    wxString            (*p_Py2wxString)(PyObject* source);
    PyObject*           (*p_wx2PyString)(const wxString& src);

    byte*               (*p_byte_LIST_helper)(PyObject* source);
    int*                (*p_int_LIST_helper)(PyObject* source);
    long*               (*p_long_LIST_helper)(PyObject* source);
    char**              (*p_string_LIST_helper)(PyObject* source);
    wxPoint*            (*p_wxPoint_LIST_helper)(PyObject* source, int* npoints);
    wxBitmap**          (*p_wxBitmap_LIST_helper)(PyObject* source);
    wxString*           (*p_wxString_LIST_helper)(PyObject* source);
    wxAcceleratorEntry* (*p_wxAcceleratorEntry_LIST_helper)(PyObject* source);

    bool                (*p_wxSize_helper)(PyObject* source, wxSize** obj);
    bool                (*p_wxPoint_helper)(PyObject* source, wxPoint** obj);
    bool                (*p_wxRealPoint_helper)(PyObject* source, wxRealPoint** obj);
    bool                (*p_wxRect_helper)(PyObject* source, wxRect** obj);
    bool                (*p_wxColour_helper)(PyObject* source, wxColour** obj);
    bool                (*p_wxPoint2D_helper)(PyObject* source, wxPoint2D** obj);

    
    bool                (*p_wxPySimple_typecheck)(PyObject* source, const wxChar* classname, int seqLen);
    bool                (*p_wxColour_typecheck)(PyObject* source);

    void                (*p_wxPyCBH_setCallbackInfo)(wxPyCallbackHelper& cbh, PyObject* self, PyObject* klass, int incref);
    bool                (*p_wxPyCBH_findCallback)(const wxPyCallbackHelper& cbh, const char* name, bool setGuard);
    int                 (*p_wxPyCBH_callCallback)(const wxPyCallbackHelper& cbh, PyObject* argTuple);
    PyObject*           (*p_wxPyCBH_callCallbackObj)(const wxPyCallbackHelper& cbh, PyObject* argTuple);
    void                (*p_wxPyCBH_delete)(wxPyCallbackHelper* cbh);

    PyObject*           (*p_wxPyMake_wxObject)(wxObject* source, bool setThisOwn, bool checkEvtHandler);
    PyObject*           (*p_wxPyMake_wxSizer)(wxSizer* source, bool setThisOwn);
    void                (*p_wxPyPtrTypeMap_Add)(const char* commonName, const char* ptrName);
    bool                (*p_wxPy2int_seq_helper)(PyObject* source, int* i1, int* i2);
    bool                (*p_wxPy4int_seq_helper)(PyObject* source, int* i1, int* i2, int* i3, int* i4);
    PyObject*           (*p_wxArrayString2PyList_helper)(const wxArrayString& arr);
    PyObject*           (*p_wxArrayInt2PyList_helper)(const wxArrayInt& arr);

    void                (*p_wxPyClientData_dtor)(wxPyClientData*);
    void                (*p_wxPyUserData_dtor)(wxPyUserData*);
    void                (*p_wxPyOORClientData_dtor)(wxPyOORClientData*);

    wxPyCBInputStream*  (*p_wxPyCBInputStream_create)(PyObject *py, bool block);
    wxPyCBInputStream*  (*p_wxPyCBInputStream_copy)(wxPyCBInputStream* other);
    
    bool                (*p_wxPyInstance_Check)(PyObject* obj);
    bool                (*p_wxPySwigInstance_Check)(PyObject* obj);

    bool                (*p_wxPyCheckForApp)();

    PyObject*           (*p_wxArrayDoublePyList_helper)(const wxArrayDouble& arr);
    wxPoint2D*          (*p_wxPoint2D_LIST_helper)(PyObject* source, size_t* npoints);
    bool                (*p_wxRect2D_helper)(PyObject* source, wxRect2D** obj);
    bool                (*p_wxPosition_helper)(PyObject* source, wxPosition** obj);

    wxPyCBOutputStream*  (*p_wxPyCBOutputStream_create)(PyObject *py, bool block);
    wxPyCBOutputStream*  (*p_wxPyCBOutputStream_copy)(wxPyCBOutputStream* other);

    wxVariant            (*p_wxVariant_in_helper)(PyObject* source);
    PyObject*            (*p_wxVariant_out_helper)(const wxVariant& value);

    void                 (*p_wxPyCSetFunc)(const wxChar *filename, const wxChar *func, int line);
    void                 (*p_wxThrowPyException)();
    void                 (*p_wxThrowCppException)();

    // Add all new items at the end...
};


#ifdef wxPyUSE_EXPORTED_API
// Notice that this is static, not extern.  This is by design, each module
// needs one, but doesn't have to use it.
static wxPyCoreAPI* wxPyCoreAPIPtr = NULL;
inline wxPyCoreAPI* wxPyGetCoreAPIPtr();
#endif // wxPyUSE_EXPORTED_API

//---------------------------------------------------------------------------

// A wxObject that holds a reference to a Python object
class wxPyUserData : public wxObject {
public:
    wxPyUserData(PyObject* obj) {
        m_obj = obj;
        Py_INCREF(m_obj);
    }

    ~wxPyUserData() {
#ifdef wxPyUSE_EXPORTED_API
        wxPyGetCoreAPIPtr()->p_wxPyUserData_dtor(this);
#else
        wxPyUserData_dtor(this);
#endif
    }
    PyObject* m_obj;
};


// A wxClientData that holds a refernece to a Python object
class wxPyClientData : public wxClientData {
public:
    wxPyClientData(PyObject* obj, bool incref=true) {
        m_obj = obj;
        m_incRef = incref;
        if (incref)
            Py_INCREF(m_obj);
    }
    ~wxPyClientData() {

#ifdef wxPyUSE_EXPORTED_API
        wxPyGetCoreAPIPtr()->p_wxPyClientData_dtor(this);
#else
        wxPyClientData_dtor(this);
#endif
    }
    PyObject* m_obj;
    bool      m_incRef;
};


// Just like wxPyClientData, except when this object is destroyed it does some
// OOR magic on the Python Object.
class wxPyOORClientData : public wxPyClientData {
public:
    wxPyOORClientData(PyObject* obj, bool incref=true)
        : wxPyClientData(obj, incref) {}
    ~wxPyOORClientData() {

#ifdef wxPyUSE_EXPORTED_API
        wxPyGetCoreAPIPtr()->p_wxPyOORClientData_dtor(this);
#else
        wxPyOORClientData_dtor(this);
#endif
    }
};


//---------------------------------------------------------------------------
// A wxImageHandler that can be derived from in Python.
//

class wxPyImageHandler: public wxImageHandler {
protected:
    PyObject *m_self;

    // used for interning method names as PyStrings
    static PyObject* m_DoCanRead_Name;
    static PyObject* m_GetImageCount_Name;
    static PyObject* m_LoadFile_Name;
    static PyObject* m_SaveFile_Name;

    // converstion helpers
    PyObject* py_InputStream(wxInputStream* stream);
    PyObject* py_Image(wxImage* image);
    PyObject* py_OutputStream(wxOutputStream* stream);

public:
    wxPyImageHandler();
    ~wxPyImageHandler();
    void _SetSelf(PyObject *self);
    
    virtual bool LoadFile(wxImage* image, wxInputStream& stream,
                          bool verbose=true, int index=-1 );
    virtual bool SaveFile(wxImage* image, wxOutputStream& stream,
                          bool verbose=true );
    virtual int GetImageCount(wxInputStream& stream );
    virtual bool DoCanRead(wxInputStream &stream);
};


//---------------------------------------------------------------------------
// Exceptions
//
// Propogate Python errors to the exception handler
void wxThrowPyException();
void wxThrowCppException();

// Identify a C++ function in a Python traceback
void wxPyCSetFunc(const wxChar *filename, const wxChar *func, int line);
#define PYSETFUNC(CBNAME)                           \
    static const wxChar *func_name = wxT(CBNAME);  \
    static const wxChar *file_name = wxT(__FILE__); \
    wxPyCSetFunc(file_name, func_name, __LINE__)

//---------------------------------------------------------------------------
// This class holds an instance of a Python Shadow Class object and assists
// with looking up and invoking Python callback methods from C++ virtual
// method redirections.  For all classes which have virtuals which should be
// overridable in wxPython, a new subclass is created that contains a
// wxPyCallbackHelper.
//

class wxPyCallbackHelper {
public:
    wxPyCallbackHelper(const wxPyCallbackHelper& other);

    wxPyCallbackHelper() {
        m_class = NULL;
        m_self = NULL;
        m_lastFound = NULL;
        m_incRef = false;
    }

    ~wxPyCallbackHelper() {
#ifdef wxPyUSE_EXPORTED_API
        wxPyGetCoreAPIPtr()->p_wxPyCBH_delete(this);
#else
        wxPyCBH_delete(this);
#endif
    }

    void        setSelf(PyObject* self, PyObject* klass, int incref=true);
    bool        findCallback(const char* name, bool setGuard=true) const;
    int         callCallback(PyObject* argTuple) const;
    PyObject*   callCallbackObj(PyObject* argTuple) const;
    PyObject*   GetLastFound() const { return m_lastFound; }

    void        setRecursionGuard(PyObject* method) const;
    void        clearRecursionGuard(PyObject* method) const;
    
private:
    PyObject*   m_self;
    PyObject*   m_class;
    PyObject*   m_lastFound;
    int         m_incRef;

    friend      void wxPyCBH_delete(wxPyCallbackHelper* cbh);
};


void wxPyCBH_setCallbackInfo(wxPyCallbackHelper& cbh, PyObject* self, PyObject* klass, int incref);
bool wxPyCBH_findCallback(const wxPyCallbackHelper& cbh, const char* name, bool setGuard=true);
int  wxPyCBH_callCallback(const wxPyCallbackHelper& cbh, PyObject* argTuple);
PyObject* wxPyCBH_callCallbackObj(const wxPyCallbackHelper& cbh, PyObject* argTuple);
void wxPyCBH_delete(wxPyCallbackHelper* cbh);


//---------------------------------------------------------------------------

// This is used in C++ classes that need to be able to make callback to
// "overloaded" python methods

#define PYPRIVATE                                                               \
    void _setCallbackInfo(PyObject* self, PyObject* _class, int incref=1) {     \
        wxPyCBH_setCallbackInfo(m_myInst, self, _class, incref);                \
    }                                                                           \
    private: wxPyCallbackHelper m_myInst


//---------------------------------------------------------------------------
// The wxPythonApp class

enum {
    wxPYAPP_ASSERT_SUPPRESS  = 1,
    wxPYAPP_ASSERT_EXCEPTION = 2,
    wxPYAPP_ASSERT_DIALOG    = 4,
    wxPYAPP_ASSERT_LOG       = 8
};

class wxPyApp: public wxApp
{
    DECLARE_ABSTRACT_CLASS(wxPyApp)

public:
    wxPyApp();
    ~wxPyApp();
    bool OnInit();
    int  MainLoop();

    int  GetAssertMode() { return m_assertMode; }
    void SetAssertMode(int mode) { m_assertMode = mode; }

    virtual bool OnInitGui();
    virtual int OnExit();
#ifdef __WXDEBUG__
    virtual void OnAssertFailure(const wxChar *file,
                                 int line,
                                 const wxChar *func,
                                 const wxChar *cond,
                                 const wxChar *msg);
#endif
    virtual void ExitMainLoop();
    // virtual int FilterEvent(wxEvent& event); // This one too????

#ifdef wxPyEXCEPTION_THROW
    virtual bool OnExceptionInMainLoop();
    virtual void HandleEvent(wxEvtHandler *handler, wxEventFunction func, wxEvent& event) const;
#endif

    // For catching Apple Events
    virtual void MacOpenFile(const wxString& fileName);
    virtual void MacOpenURL(const wxString& url);
    virtual void MacPrintFile(const wxString& fileName);
    virtual void MacNewFile();
    virtual void MacReopenApp();

    static bool GetMacSupportPCMenuShortcuts();
    static long GetMacAboutMenuItemId();
    static long GetMacPreferencesMenuItemId();
    static long GetMacExitMenuItemId();
    static wxString GetMacHelpMenuTitleName();

    static void SetMacSupportPCMenuShortcuts(bool val);
    static void SetMacAboutMenuItemId(long val);
    static void SetMacPreferencesMenuItemId(long val);
    static void SetMacExitMenuItemId(long val);
    static void SetMacHelpMenuTitleName(const wxString& val);


    void _BootstrapApp();

    // implementation only
    void SetStartupComplete(bool val) { m_startupComplete = val; };

    PYPRIVATE;
    int m_assertMode;
    bool m_startupComplete;
};

extern wxPyApp *wxPythonApp;



//Callback Macros
//
//NOTE: This system doesn't handle output through C++ arguments.
//
//Syntax:
//  Use the PYCALLBACK_* form for inline methods. Use the IMP_PYCALLBACK_* form when implementing a 
//  forward declared method outside of the class.
//
//  PYCALLBACK_/argcount/_/flags/([PCLASS], [RETTYPE, RETINIT], CBNAME, [ARGS])
//  IMP_PYCALLBACK_/argcount/_/flags/(CLASS, [PCLASS], [RETTYPE, RETINIT], CBNAME, [ARGS])
//
//Argcount:
//  This is a number 0 through 10, indicating the number of arguments of the callback.
//  If argcount is 0, omit the ARGS macro option. Otherwise, include an argument list 
//  with types. Argument names must be a, b, c, ... z, depending on the number of 
//  arguments, eg, (int a, const wxString& b, int c). 
//
//  An insertion operator function must be present for all argument types (see raiihelpers.h).
//
//Flags:
//  Separate flags with underscores. Order is VOID or EXTRACT, optionally PURE, and optionally CONST.
//
//  VOID - Implement a void method, ignoring any return value from the Python function. 
//         Omit RETTYPE and RETINIT macro arguments with VOID.  
//
//  EXTRACT - Implement a method that returns a value.
//            Must include RETTYPE and RETINIT arguments. RETTYPE is the return type, 
//            and RETINIT should initialize the return value, rval. An appropriate 
//            extraction operator function must be present (see raiihelpers.h).
//
//  PURE - Implement a pure virtual method, where no default exists in the parent class.
//         Omit the PCLASS argument.
//
//  CONST - Implement a const method.
//
//Examples:
//
// Pure virtual method, no arguments, string return value:
//  PYCALLBACK_0_EXTRACT_PURE(wxString, rval, OnSomeAction)
// Same as before, but indicate a default return value other than an empty string:
//  PYCALLBACK_0_EXTRACT_PURE(wxString, rval = "blah", OnSomeAction)
//
// Pure virtual method, one int argument, int return value:
//  PYCALLBACK_1_EXTRACT_PURE(int, rval = -1, OnSomeAction, (int a))
// Same as above, but the parent class includes a default for OnSomeAction:
//  PYCALLBACK_1_EXTRACT(MyParentClass, int, rval = -1, OnSomeAction, (int a))
//
// A pure void method, with no arguments:
//  PYCALLBACK_0_VOID_PURE(OnSomeAction)

//TODO: Have PURE callbacks raise NotImplementedError if python method not found. 
//
// Base callback macros.
#define B_PYCALLBACK_N(RETTYPE, CBNAME, LOOKUP, NARGS, ARGS, INSERT, DECOUT, EXTRACT, CALLPARENT, RETURN) \
    RETTYPE CBNAME ARGS {                                                                       \
        bool found;                                                                             \
        wxPyThreadBlocker blocker;                                                              \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                                                 \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                                \
            wxPyTuple args(NARGS);                                                              \
            wxPyObject ro;                                                                      \
            ro = wxPyCBH_callCallbackObj(m_myInst, INSERT);                   \
            EXTRACT;                                                                            \
        } else {                                                                                \
            blocker.Unblock();                                                                  \
            CALLPARENT;                                                                         \
        }                                                                                       \
        return RETURN;                                                                          \
    }

#define B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, LOOKUP, NARGS, ARGS, INSERT, DECOUT, EXTRACT, CALLPARENT, RETURN) \
    RETTYPE CBNAME ARGS const {                                                                 \
        bool found;                                                                             \
        wxPyThreadBlocker blocker;                                                              \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                                                 \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                                \
            wxPyTuple args(NARGS);                                                              \
            wxPyObject ro;                                                                      \
            ro = wxPyCBH_callCallbackObj(m_myInst, INSERT);                   \
            EXTRACT;                                                                            \
        } else {                                                                                \
            blocker.Unblock();                                                                  \
            CALLPARENT;                                                                         \
        }                                                                                       \
        return RETURN;                                                                          \
    }

#define B_PYCALLBACK_N_VOID(CBNAME, LOOKUP, NARGS, ARGS, INSERT, CALLPARENT) \
    void CBNAME ARGS {                                                                       \
        bool found;                                                                             \
        wxPyThreadBlocker blocker;                                                              \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                                \
            wxPyTuple args(NARGS);                                                              \
            wxPyCBH_callCallback(m_myInst, INSERT);                   \
        } else {                                                                                \
            blocker.Unblock();                                                                  \
            CALLPARENT;                                                                          \
        }                                                                                       \
    }

#define B_PYCALLBACK_N_VOID_CONST(CBNAME, LOOKUP, NARGS, ARGS, INSERT, CALLPARENT) \
    void CBNAME ARGS const {                                                                       \
        bool found;                                                                             \
        wxPyThreadBlocker blocker;                                                              \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                                \
            wxPyTuple args(NARGS);                                                              \
            wxPyCBH_callCallback(m_myInst, INSERT);                   \
        } else {                                                                                \
            blocker.Unblock();                                                                  \
            CALLPARENT;                                                                          \
        }                                                                                       \
    }


#define B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, LOOKUP, NARGS, ARGS, INSERT, DECOUT, EXTRACT, RETURN)    \
    RETTYPE CBNAME ARGS {                                                                   \
        bool found;                                                                         \
        wxPyThreadBlocker blocker;                                                          \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                                              \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                            \
            wxPyTuple args(NARGS);                                                          \
            wxPyObject ro;                                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, INSERT);               \
            EXTRACT;                                                                         \
        }                                                                                   \
        return RETURN;                                                                              \
    }

#define B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, LOOKUP, NARGS, ARGS, INSERT, DECOUT, EXTRACT, RETURN)    \
    RETTYPE CBNAME ARGS const {                                                                   \
        bool found;                                                                         \
        wxPyThreadBlocker blocker;                                                          \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                                             \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                            \
            wxPyTuple args(NARGS);                                                          \
            wxPyObject ro;                                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, INSERT);               \
            EXTRACT;                                                                        \
        }                                                                                   \
        return RETURN;                                                                             \
    }

#define B_PYCALLBACK_N_VOID_PURE(CBNAME, LOOKUP, NARGS, ARGS, INSERT)                \
    void CBNAME ARGS {                                                                      \
        bool found;                                                                         \
        wxPyThreadBlocker blocker;                                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                            \
            wxPyTuple args(NARGS);                                                          \
            wxPyCBH_callCallback(m_myInst, INSERT);                       \
        }                                                                                   \
    }

#define B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, LOOKUP, NARGS, ARGS, INSERT)                 \
    void CBNAME ARGS const {                                                                \
        bool found;                                                                         \
        wxPyThreadBlocker blocker;                                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {                            \
            wxPyTuple args(NARGS);                                                          \
            wxPyCBH_callCallback(m_myInst, INSERT);                       \
        }                                                                                   \
    }

#define B_PYCALLBACK_0(RETTYPE, CBNAME, LOOKUP, DECOUT, EXTRACT, CALLPARENT, RETURN)  \
    RETTYPE CBNAME () {                                                     \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        DECOUT;                                                             \
        PYSETFUNC(#CBNAME);                                                                     \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyObject ro;                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL); \
            EXTRACT;                                                        \
        } else {                                                            \
            blocker.Unblock();                                              \
            CALLPARENT;                                                     \
        }                                                                   \
        return RETURN;                                                             \
    }

#define B_PYCALLBACK_0_CONST(RETTYPE, CBNAME, LOOKUP, DECOUT, EXTRACT, CALLPARENT, RETURN)  \
    RETTYPE CBNAME () const {                                               \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                             \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyObject ro;                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL); \
            EXTRACT;                                                        \
        } else {                                                            \
            blocker.Unblock();                                              \
            CALLPARENT;                                                     \
        }                                                                   \
        return RETURN;                                                             \
    }

#define B_PYCALLBACK_0_VOID(CBNAME, LOOKUP, CALLPARENT)                     \
    void CBNAME () {                                                        \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyCBH_callCallback(m_myInst, NULL);         \
        } else {                                                            \
            blocker.Unblock();                                              \
            CALLPARENT;                                                     \
        }                                                                   \
    }

#define B_PYCALLBACK_0_VOID_CONST(CBNAME, LOOKUP, CALLPARENT)                       \
    void CBNAME () const {                                                  \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyCBH_callCallback(m_myInst, NULL);         \
        } else {                                                            \
            blocker.Unblock();                                              \
            CALLPARENT;                                                     \
        }                                                                   \
    }

#define B_PYCALLBACK_0_PURE(RETTYPE, CBNAME, LOOKUP, DECOUT, EXTRACT, RETURN)         \
    RETTYPE CBNAME () {                                                   \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                             \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyObject ro;                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL); \
            EXTRACT;                                                        \
        }                                                                   \
        return RETURN;                                                             \
    }

#define B_PYCALLBACK_0_PURE_CONST(RETTYPE, CBNAME, LOOKUP, DECOUT, EXTRACT, RETURN)         \
    RETTYPE CBNAME () const {                                                   \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        PYSETFUNC(#CBNAME);                                                                     \
        DECOUT;                                                             \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyObject ro;                                                  \
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL); \
            EXTRACT;                                                        \
        }                                                                   \
        return RETURN;                                                             \
    }

#define B_PYCALLBACK_0_VOID_PURE(CBNAME, LOOKUP)                            \
    void CBNAME () {                                                        \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            wxPyCBH_callCallback(m_myInst, NULL);         \
        }                                                                   \
    }

#define B_PYCALLBACK_0_VOID_PURE_CONST(CBNAME, LOOKUP)         \
    void CBNAME () const {                                                  \
        bool found;                                                         \
        wxPyThreadBlocker blocker;                                          \
        if ((found = wxPyCBH_findCallback(m_myInst, #LOOKUP))) {            \
            ro = wxPyCBH_callCallback(m_myInst, NULL);    \
        }                                                                   \
    }


//
// --
//

#define PYCALLBACK_0_VOID(PCLASS, CBNAME)     \
    B_PYCALLBACK_0_VOID(CBNAME, CBNAME, PCLASS::CBNAME())

#define PYCALLBACK_0_VOID_CONST(PCLASS, CBNAME) \
    B_PYCALLBACK_0_VOID_CONST(CBNAME, CBNAME, PCLASS::CBNAME())

#define PYCALLBACK_0_VOID_PURE(CBNAME)            \
    B_PYCALLBACK_0_VOID_PURE(CBNAME, CBNAME)

#define PYCALLBACK_0_VOID_PURE_CONST(CBNAME)          \
    B_PYCALLBACK_0_VOID_PURE_CONST(CBNAME, CBNAME)

#define PYCALLBACK_0_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME)              \
    B_PYCALLBACK_0(RETTYPE, CBNAME, CBNAME,                                 \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval = PCLASS::CBNAME(),                                    \
                rval)                                                   

#define PYCALLBACK_0_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME)        \
    B_PYCALLBACK_0_CONST(RETTYPE, CBNAME, CBNAME,                           \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval = PCLASS::CBNAME(),                                    \
                rval)                                                   

#define PYCALLBACK_0_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME)                 \
    B_PYCALLBACK_0_PURE(RETTYPE, CBNAME, CBNAME,                            \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_0_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME)           \
    B_PYCALLBACK_0_PURE_CONST(RETTYPE, CBNAME, CBNAME,                      \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_0_VOID(CLASS, PCLASS, CBNAME)     \
    B_PYCALLBACK_0_VOID(CLASS::CBNAME, CBNAME, PCLASS::CBNAME())

#define IMP_PYCALLBACK_0_VOID_CONST(CLASS, PCLASS, CBNAME) \
    B_PYCALLBACK_0_VOID_CONST(CLASS::CBNAME, CBNAME, PCLASS::CBNAME())

#define IMP_PYCALLBACK_0_VOID_PURE(CLASS, CBNAME)            \
    B_PYCALLBACK_0_VOID_PURE(CLASS::CBNAME, CBNAME)

#define IMP_PYCALLBACK_0_VOID_PURE_CONST(CLASS, CBNAME)          \
    B_PYCALLBACK_0_VOID_PURE_CONST(CLASS::CBNAME, CBNAME)

#define IMP_PYCALLBACK_0_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME)       \
    B_PYCALLBACK_0(RETTYPE, CLASS::CBNAME, CBNAME,                              \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(),                                        \
                rval)                                                   

#define IMP_PYCALLBACK_0_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME)\
    B_PYCALLBACK_0_CONST(RETTYPE, CLASS::CBNAME, CBNAME,                       \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(),                                       \
                rval)                                                   

#define IMP_PYCALLBACK_0_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME)      \
    B_PYCALLBACK_0_PURE(RETTYPE, CLASS::CBNAME, CBNAME,                     \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define IMP_PYCALLBACK_0_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME)\
    B_PYCALLBACK_0_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME,               \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

//
// --
//

#define PYCALLBACK_1_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 1, ARGS,    \
                args << a, \
                PCLASS::CBNAME(a))

#define PYCALLBACK_1_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 1, ARGS, \
                args << a, \
                PCLASS::CBNAME(a))

#define PYCALLBACK_1_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 1, ARGS,   \
                args << a)

#define PYCALLBACK_1_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 1, ARGS, \
                args << a)

#define PYCALLBACK_1_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 1, ARGS,                    \
                args << a,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a),                               \
                rval)                                                   

#define PYCALLBACK_1_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 1, ARGS,                    \
                args << a,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a),                              \
                rval)                                                   

#define PYCALLBACK_1_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 1, ARGS,           \
                args << a,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_1_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 1, ARGS,           \
                args << a,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_1_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 1, ARGS,    \
                args << a, \
                PCLASS::CBNAME(a))

#define IMP_PYCALLBACK_1_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 1, ARGS, \
                args << a, \
                PCLASS::CBNAME(a))

#define IMP_PYCALLBACK_1_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 1, ARGS,   \
                args << a)

#define IMP_PYCALLBACK_1_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 1, ARGS, \
                args << a)

#define IMP_PYCALLBACK_1_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 1, ARGS,                     \
                args << a,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a), \
                rval)                                                   

#define IMP_PYCALLBACK_1_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 1, ARGS,                        \
                args << a,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a), \
                rval)                                                   

#define IMP_PYCALLBACK_1_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 1, ARGS,                \
                args << a,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_1_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 1, ARGS,              \
                args << a,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_2_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 2, ARGS,    \
                args << a << b, \
                PCLASS::CBNAME(a, b))

#define PYCALLBACK_2_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 2, ARGS, \
                args << a << b, \
                PCLASS::CBNAME(a, b))

#define PYCALLBACK_2_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 2, ARGS,   \
                args << a << b)

#define PYCALLBACK_2_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 2, ARGS, \
                args << a << b)

#define PYCALLBACK_2_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 2, ARGS,                    \
                args << a << b,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b),                               \
                rval)                                                   

#define PYCALLBACK_2_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 2, ARGS,                    \
                args << a << b,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b),                              \
                rval)                                                   

#define PYCALLBACK_2_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 2, ARGS,           \
                args << a << b,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_2_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 2, ARGS,           \
                args << a << b,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_2_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 2, ARGS,    \
                args << a << b, \
                PCLASS::CBNAME(a, b))

#define IMP_PYCALLBACK_2_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 2, ARGS, \
                args << a << b, \
                PCLASS::CBNAME(a, b))

#define IMP_PYCALLBACK_2_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 2, ARGS,   \
                args << a << b)

#define IMP_PYCALLBACK_2_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 2, ARGS, \
                args << a << b)

#define IMP_PYCALLBACK_2_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 2, ARGS,                     \
                args << a << b,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b), \
                rval)                                                   

#define IMP_PYCALLBACK_2_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 2, ARGS,                        \
                args << a << b,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b), \
                rval)                                                   

#define IMP_PYCALLBACK_2_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 2, ARGS,                \
                args << a << b,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_2_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 2, ARGS,              \
                args << a << b,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_3_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 3, ARGS,    \
                args << a << b << c, \
                PCLASS::CBNAME(a, b, c))

#define PYCALLBACK_3_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 3, ARGS, \
                args << a << b << c, \
                PCLASS::CBNAME(a, b, c))

#define PYCALLBACK_3_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 3, ARGS,   \
                args << a << b << c)

#define PYCALLBACK_3_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 3, ARGS, \
                args << a << b << c)

#define PYCALLBACK_3_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 3, ARGS,                    \
                args << a << b << c,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c),                               \
                rval)                                                   

#define PYCALLBACK_3_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 3, ARGS,                    \
                args << a << b << c,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c),                              \
                rval)                                                   

#define PYCALLBACK_3_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 3, ARGS,           \
                args << a << b << c,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_3_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 3, ARGS,           \
                args << a << b << c,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_3_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 3, ARGS,    \
                args << a << b << c, \
                PCLASS::CBNAME(a, b, c))

#define IMP_PYCALLBACK_3_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 3, ARGS, \
                args << a << b << c, \
                PCLASS::CBNAME(a, b, c))

#define IMP_PYCALLBACK_3_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 3, ARGS,   \
                args << a << b << c)

#define IMP_PYCALLBACK_3_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 3, ARGS, \
                args << a << b << c)

#define IMP_PYCALLBACK_3_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 3, ARGS,                     \
                args << a << b << c,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c), \
                rval)                                                   

#define IMP_PYCALLBACK_3_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 3, ARGS,                        \
                args << a << b << c,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c), \
                rval)                                                   

#define IMP_PYCALLBACK_3_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 3, ARGS,                \
                args << a << b << c,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_3_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 3, ARGS,              \
                args << a << b << c,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_4_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 4, ARGS,    \
                args << a << b << c << d, \
                PCLASS::CBNAME(a, b, c, d))

#define PYCALLBACK_4_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 4, ARGS, \
                args << a << b << c << d, \
                PCLASS::CBNAME(a, b, c, d))

#define PYCALLBACK_4_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 4, ARGS,   \
                args << a << b << c << d)

#define PYCALLBACK_4_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 4, ARGS, \
                args << a << b << c << d)

#define PYCALLBACK_4_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 4, ARGS,                    \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d),                               \
                rval)                                                   

#define PYCALLBACK_4_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 4, ARGS,                    \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d),                              \
                rval)                                                   

#define PYCALLBACK_4_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 4, ARGS,           \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_4_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 4, ARGS,           \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_4_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 4, ARGS,    \
                args << a << b << c << d, \
                PCLASS::CBNAME(a, b, c, d))

#define IMP_PYCALLBACK_4_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 4, ARGS, \
                args << a << b << c << d, \
                PCLASS::CBNAME(a, b, c, d))

#define IMP_PYCALLBACK_4_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 4, ARGS,   \
                args << a << b << c << d)

#define IMP_PYCALLBACK_4_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 4, ARGS, \
                args << a << b << c << d)

#define IMP_PYCALLBACK_4_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 4, ARGS,                     \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d), \
                rval)                                                   

#define IMP_PYCALLBACK_4_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 4, ARGS,                        \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d), \
                rval)                                                   

#define IMP_PYCALLBACK_4_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 4, ARGS,                \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_4_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 4, ARGS,              \
                args << a << b << c << d,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_5_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 5, ARGS,    \
                args << a << b << c << d << e, \
                PCLASS::CBNAME(a, b, c, d, e))

#define PYCALLBACK_5_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 5, ARGS, \
                args << a << b << c << d << e, \
                PCLASS::CBNAME(a, b, c, d, e))

#define PYCALLBACK_5_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 5, ARGS,   \
                args << a << b << c << d << e)

#define PYCALLBACK_5_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 5, ARGS, \
                args << a << b << c << d << e)

#define PYCALLBACK_5_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 5, ARGS,                    \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e),                               \
                rval)                                                   

#define PYCALLBACK_5_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 5, ARGS,                    \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e),                              \
                rval)                                                   

#define PYCALLBACK_5_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 5, ARGS,           \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_5_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 5, ARGS,           \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_5_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 5, ARGS,    \
                args << a << b << c << d << e, \
                PCLASS::CBNAME(a, b, c, d, e))

#define IMP_PYCALLBACK_5_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 5, ARGS, \
                args << a << b << c << d << e, \
                PCLASS::CBNAME(a, b, c, d, e))

#define IMP_PYCALLBACK_5_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 5, ARGS,   \
                args << a << b << c << d << e)

#define IMP_PYCALLBACK_5_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 5, ARGS, \
                args << a << b << c << d << e)

#define IMP_PYCALLBACK_5_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 5, ARGS,                     \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e), \
                rval)                                                   

#define IMP_PYCALLBACK_5_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 5, ARGS,                        \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e), \
                rval)                                                   

#define IMP_PYCALLBACK_5_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 5, ARGS,                \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_5_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 5, ARGS,              \
                args << a << b << c << d << e,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_6_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 6, ARGS,    \
                args << a << b << c << d << e << f, \
                PCLASS::CBNAME(a, b, c, d, e, f))

#define PYCALLBACK_6_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 6, ARGS, \
                args << a << b << c << d << e << f, \
                PCLASS::CBNAME(a, b, c, d, e, f))

#define PYCALLBACK_6_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 6, ARGS,   \
                args << a << b << c << d << e << f)

#define PYCALLBACK_6_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 6, ARGS, \
                args << a << b << c << d << e << f)

#define PYCALLBACK_6_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 6, ARGS,                    \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e, f),                               \
                rval)                                                   

#define PYCALLBACK_6_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 6, ARGS,                    \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e, f),                              \
                rval)                                                   

#define PYCALLBACK_6_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 6, ARGS,           \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_6_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 6, ARGS,           \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_6_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 6, ARGS,    \
                args << a << b << c << d << e << f, \
                PCLASS::CBNAME(a, b, c, d, e, f))

#define IMP_PYCALLBACK_6_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 6, ARGS, \
                args << a << b << c << d << e << f, \
                PCLASS::CBNAME(a, b, c, d, e, f))

#define IMP_PYCALLBACK_6_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 6, ARGS,   \
                args << a << b << c << d << e << f)

#define IMP_PYCALLBACK_6_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 6, ARGS, \
                args << a << b << c << d << e << f)

#define IMP_PYCALLBACK_6_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 6, ARGS,                     \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e, f), \
                rval)                                                   

#define IMP_PYCALLBACK_6_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 6, ARGS,                        \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e, f), \
                rval)                                                   

#define IMP_PYCALLBACK_6_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 6, ARGS,                \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_6_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 6, ARGS,              \
                args << a << b << c << d << e << f,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_7_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 7, ARGS,    \
                args << a << b << c << d << e << f << g, \
                PCLASS::CBNAME(a, b, c, d, e, f, g))

#define PYCALLBACK_7_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 7, ARGS, \
                args << a << b << c << d << e << f << g, \
                PCLASS::CBNAME(a, b, c, d, e, f, g))

#define PYCALLBACK_7_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 7, ARGS,   \
                args << a << b << c << d << e << f << g)

#define PYCALLBACK_7_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 7, ARGS, \
                args << a << b << c << d << e << f << g)

#define PYCALLBACK_7_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 7, ARGS,                    \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g),                               \
                rval)                                                   

#define PYCALLBACK_7_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 7, ARGS,                    \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g),                              \
                rval)                                                   

#define PYCALLBACK_7_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 7, ARGS,           \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_7_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 7, ARGS,           \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_7_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 7, ARGS,    \
                args << a << b << c << d << e << f << g, \
                PCLASS::CBNAME(a, b, c, d, e, f, g))

#define IMP_PYCALLBACK_7_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 7, ARGS, \
                args << a << b << c << d << e << f << g, \
                PCLASS::CBNAME(a, b, c, d, e, f, g))

#define IMP_PYCALLBACK_7_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 7, ARGS,   \
                args << a << b << c << d << e << f << g)

#define IMP_PYCALLBACK_7_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 7, ARGS, \
                args << a << b << c << d << e << f << g)

#define IMP_PYCALLBACK_7_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 7, ARGS,                     \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g), \
                rval)                                                   

#define IMP_PYCALLBACK_7_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 7, ARGS,                        \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g), \
                rval)                                                   

#define IMP_PYCALLBACK_7_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 7, ARGS,                \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_7_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 7, ARGS,              \
                args << a << b << c << d << e << f << g,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_8_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 8, ARGS,    \
                args << a << b << c << d << e << f << g << h, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h))

#define PYCALLBACK_8_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 8, ARGS, \
                args << a << b << c << d << e << f << g << h, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h))

#define PYCALLBACK_8_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 8, ARGS,   \
                args << a << b << c << d << e << f << g << h)

#define PYCALLBACK_8_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 8, ARGS, \
                args << a << b << c << d << e << f << g << h)

#define PYCALLBACK_8_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 8, ARGS,                    \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h),                               \
                rval)                                                   

#define PYCALLBACK_8_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 8, ARGS,                    \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h),                              \
                rval)                                                   

#define PYCALLBACK_8_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 8, ARGS,           \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_8_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 8, ARGS,           \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_8_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 8, ARGS,    \
                args << a << b << c << d << e << f << g << h, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h))

#define IMP_PYCALLBACK_8_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 8, ARGS, \
                args << a << b << c << d << e << f << g << h, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h))

#define IMP_PYCALLBACK_8_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 8, ARGS,   \
                args << a << b << c << d << e << f << g << h)

#define IMP_PYCALLBACK_8_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 8, ARGS, \
                args << a << b << c << d << e << f << g << h)

#define IMP_PYCALLBACK_8_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 8, ARGS,                     \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h), \
                rval)                                                   

#define IMP_PYCALLBACK_8_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 8, ARGS,                        \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h), \
                rval)                                                   

#define IMP_PYCALLBACK_8_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 8, ARGS,                \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_8_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 8, ARGS,              \
                args << a << b << c << d << e << f << g << h,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_9_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 9, ARGS,    \
                args << a << b << c << d << e << f << g << h << i, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i))

#define PYCALLBACK_9_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 9, ARGS, \
                args << a << b << c << d << e << f << g << h << i, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i))

#define PYCALLBACK_9_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 9, ARGS,   \
                args << a << b << c << d << e << f << g << h << i)

#define PYCALLBACK_9_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 9, ARGS, \
                args << a << b << c << d << e << f << g << h << i)

#define PYCALLBACK_9_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 9, ARGS,                    \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i),                               \
                rval)                                                   

#define PYCALLBACK_9_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 9, ARGS,                    \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i),                              \
                rval)                                                   

#define PYCALLBACK_9_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 9, ARGS,           \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_9_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 9, ARGS,           \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_9_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 9, ARGS,    \
                args << a << b << c << d << e << f << g << h << i, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i))

#define IMP_PYCALLBACK_9_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 9, ARGS, \
                args << a << b << c << d << e << f << g << h << i, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i))

#define IMP_PYCALLBACK_9_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 9, ARGS,   \
                args << a << b << c << d << e << f << g << h << i)

#define IMP_PYCALLBACK_9_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 9, ARGS, \
                args << a << b << c << d << e << f << g << h << i)

#define IMP_PYCALLBACK_9_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 9, ARGS,                     \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i), \
                rval)                                                   

#define IMP_PYCALLBACK_9_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 9, ARGS,                        \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i), \
                rval)                                                   

#define IMP_PYCALLBACK_9_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 9, ARGS,                \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_9_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 9, ARGS,              \
                args << a << b << c << d << e << f << g << h << i,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)

//
// --
//

#define PYCALLBACK_10_VOID(PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CBNAME, CBNAME, 10, ARGS,    \
                args << a << b << c << d << e << f << g << h << i << j, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j))

#define PYCALLBACK_10_VOID_CONST(PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CBNAME, CBNAME, 10, ARGS, \
                args << a << b << c << d << e << f << g << h << i << j, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j))

#define PYCALLBACK_10_VOID_PURE(CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CBNAME, CBNAME, 10, ARGS,   \
                args << a << b << c << d << e << f << g << h << i << j)

#define PYCALLBACK_10_VOID_PURE_CONST(CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CBNAME, CBNAME, 10, ARGS, \
                args << a << b << c << d << e << f << g << h << i << j)

#define PYCALLBACK_10_EXTRACT(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N(RETTYPE, CBNAME, CBNAME, 10, ARGS,                    \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                                \
                ro >> rval,                                                     \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j),                               \
                rval)                                                   

#define PYCALLBACK_10_EXTRACT_CONST(PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CBNAME, CBNAME, 10, ARGS,                    \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                               \
                ro >> rval,                                                    \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j),                              \
                rval)                                                   

#define PYCALLBACK_10_EXTRACT_PURE(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE(RETTYPE, CBNAME, CBNAME, 10, ARGS,           \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

#define PYCALLBACK_10_EXTRACT_PURE_CONST(RETTYPE, RETINIT, CBNAME, ARGS)   \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CBNAME, CBNAME, 10, ARGS,           \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                            \
                ro >> rval,                                                 \
                rval)

// -
#define IMP_PYCALLBACK_10_VOID(CLASS, PCLASS, CBNAME, ARGS)     \
    B_PYCALLBACK_N_VOID(CLASS::CBNAME, CBNAME, 10, ARGS,    \
                args << a << b << c << d << e << f << g << h << i << j, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j))

#define IMP_PYCALLBACK_10_VOID_CONST(CLASS, PCLASS, CBNAME, ARGS) \
    B_PYCALLBACK_N_VOID_CONST(CLASS::CBNAME, CBNAME, 10, ARGS, \
                args << a << b << c << d << e << f << g << h << i << j, \
                PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j))

#define IMP_PYCALLBACK_10_VOID_PURE(CLASS, CBNAME, ARGS)            \
    B_PYCALLBACK_N_VOID_PURE(CLASS::CBNAME, CBNAME, 10, ARGS,   \
                args << a << b << c << d << e << f << g << h << i << j)

#define IMP_PYCALLBACK_10_VOID_PURE_CONST(CLASS, CBNAME, ARGS)          \
    B_PYCALLBACK_N_VOID_PURE_CONST(CLASS::CBNAME, CBNAME, 10, ARGS, \
                args << a << b << c << d << e << f << g << h << i << j)

#define IMP_PYCALLBACK_10_EXTRACT(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS) \
    B_PYCALLBACK_N(RETTYPE, CLASS::CBNAME, CBNAME, 10, ARGS,                     \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j), \
                rval)                                                   

#define IMP_PYCALLBACK_10_EXTRACT_CONST(CLASS, PCLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 10, ARGS,                        \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                                                 \
                ro >> rval,                                                                      \
                rval = PCLASS::CBNAME(a, b, c, d, e, f, g, h, i, j), \
                rval)                                                   

#define IMP_PYCALLBACK_10_EXTRACT_PURE(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)    \
    B_PYCALLBACK_N_PURE(RETTYPE, CLASS::CBNAME, CBNAME, 10, ARGS,                \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                                        \
                ro >> rval,                                                             \
                rval)

#define IMP_PYCALLBACK_10_EXTRACT_PURE_CONST(CLASS, RETTYPE, RETINIT, CBNAME, ARGS)  \
    B_PYCALLBACK_N_PURE_CONST(RETTYPE, CLASS::CBNAME, CBNAME, 10, ARGS,              \
                args << a << b << c << d << e << f << g << h << i << j,  \
                RETTYPE RETINIT,                                                            \
                ro >> rval,                                                                 \
                rval)


//----------------------------------------------------------------------
// These macros are used to implement the virtual methods that should
// redirect to a Python method if one exists.  The names designate the
// return type, if any, as well as any parameter types.
//---------------------------------------------------------------------------

// For _pywindows.i, _pycontrol.i, wizard.i
#define DEC_PYCALLBACK_VOID_INTPINTP_const(CBNAME)                              \
    void CBNAME(int* a, int* b) const


#define IMP_PYCALLBACK_VOID_INTPINTP_const(CLASS, PCLASS, CBNAME)               \
    void CLASS::CBNAME(int* a, int* b) const {                                  \
        bool found;                                                             \
        wxPyThreadBlocker blocker;                                              \
        if ((found = wxPyCBH_findCallback(m_myInst, #CBNAME))) {                \
            wxPySequence ro;                                                    \
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL);     \
            if (ro.Ok()) {                                                      \
                if (ro.IsSequence() && ro.Size() == 2)                          \
                    ro >> *a >> *b;                                             \
                else {                                                          \
                    PyErr_SetString(PyExc_TypeError, "Expected a sequence of two integers"); \
                    wxThrowPyException();                                       \
                }                                                               \
            }                                                                   \
        }                                                                       \
        blocker.Unblock();                                                      \
        if (! found)                                                            \
            PCLASS::CBNAME(a,b);                                                \
    }                                

#endif
