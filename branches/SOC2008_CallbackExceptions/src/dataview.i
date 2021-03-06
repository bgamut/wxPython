/////////////////////////////////////////////////////////////////////////////
// Name:        dataview.i
// Purpose:     Contains the wxDataViewCtrl and related classes
//
// Author:      Robin Dunn
//
// Created:     21-Jan-2008
// RCS-ID:      $Id: $
// Copyright:   (c) 2008 by Total Control Software
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

%define DOCSTRING
"The `DataViewCtrl` class can display data in either a tree-like
fashion, in a tabular form, or in a combination of the two.  It is a
native widget on the platforms that provide such a control, (currently
OS X and GTK) and generic elsewhere."
%enddef

%module(package="wx", docstring=DOCSTRING) dataview

%{
#include "wx/wxPython/wxPython.h"
#include "wx/wxPython/raiihelpers.h"
#include "wx/wxPython/pyclasses.h"
#include "wx/wxPython/printfw.h"

#include <wx/dataview.h>
%}

//---------------------------------------------------------------------------

%import core.i
%pythoncode { wx = _core }
%pythoncode { __docfilter__ = wx.__DocFilter(globals()) }

MAKE_CONST_WXSTRING_NOSWIG(EmptyString);
MAKE_CONST_WXSTRING(DataViewCtrlNameStr);

enum {
    wxDVC_DEFAULT_WIDTH,
    wxDVC_TOGGLE_DEFAULT_WIDTH,
    wxDVC_DEFAULT_MINWIDTH,

    wxDVR_DEFAULT_ALIGNMENT
};

%{
// insertion operators
inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItem &obj)
{
    po.Push(wxPyConstructObject((void*)&obj, wxT("wxDataViewItem"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItem *obj)
{
    po.Push(wxPyConstructObject((void*)obj, wxT("wxDataViewItem"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItemAttr &obj)
{
    po.Push(wxPyConstructObject((void*)&obj, wxT("wxDataViewItemAttr"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItemAttr *obj)
{
    po.Push(wxPyConstructObject((void*)obj, wxT("wxDataViewItemAttr"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItemArray &obj)
{
    po.Push(wxPyConstructObject((void*)&obj, wxT("wxDataViewItemArray"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewItemArray *obj)
{
    po.Push(wxPyConstructObject((void*)obj, wxT("wxDataViewItemArray"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewModel &obj)
{
    po.Push(wxPyConstructObject((void*)&obj, wxT("wxDataViewModel"), 0));
    return po;
}

inline wxPyObject &operator<<(wxPyObject &po, const wxDataViewModel *obj)
{
    po.Push(wxPyConstructObject((void*)obj, wxT("wxDataViewModel"), 0));
    return po;
}

// extraction
inline wxPyObject &operator>>(wxPyObject &po, wxDataViewItem &out)
{
    wxPyExtractObjectCopy(wxT("wxDataViewItem"), po, out);
    return po;
}

%}


//---------------------------------------------------------------------------
// wxDataViewItem
%newgroup

DocStr(wxDataViewItem,
"wxDataViewItem is a small opaque class that represents an item in a
`DataViewCtrl` in a persistent way, i.e. indepent of the position of
the item in the control or changes to its contents.  It contains a C
void pointer which is used as the internal ID value for the item.  If
the ID is NULL then the DataViewItem is considered invalid and the
`IsOk` method will return False, which is used in many places in the
API to indicate that no item was found.", "");

class wxDataViewItem
{
public:
    wxDataViewItem( void* id = NULL );
    ~wxDataViewItem();

    DocDeclStr(
        bool , IsOk() const,
        "Returns ``True`` if the object refers to an actual item in the data
view control.", "");

    DocDeclStr(
        void* , GetID() const,
        "Get the opaque value of the ID object.", "");

    %extend {
        // methods to allow items to be dictionary keys
        long __hash__()
        {
            return (long)self->GetID();
        }

        int __cmp__(wxDataViewItem* other)
        {
            if ( self->GetID() < other->GetID() ) return -1;
            if ( self->GetID() > other->GetID() ) return  1;
            return 0;
        }
    }
};

wxARRAY_WRAPPER(wxDataViewItemArray, wxDataViewItem);

//---------------------------------------------------------------------------
// wxDataViewModelNotifier
%newgroup

DocStr(wxDataViewModelNotifier,
"This class allows multiple entities to be notified when a change
happens in a `DataViewModel` instance, and it mirrors the notification
interface in that class.  To add your own notifier object to a model,
derive a new class from `PyDataViewModelNotifier`, override the
methods you are interested in, and assign an instance of it to the
model with `DataViewModel.AddNotifier`.", "");

class wxDataViewModelNotifier {
public:
    //wxDataViewModelNotifier();    **** It's an ABC.
    virtual ~wxDataViewModelNotifier();

    DocDeclStr(
        virtual bool , ItemAdded( const wxDataViewItem &parent, const wxDataViewItem &item ),
        "Override this to be informed that an item has been added to the data
model.", "");

    DocDeclStr(
        virtual bool , ItemDeleted( const wxDataViewItem &parent, const wxDataViewItem &item ),
        "Override this to be informed that an item has been deleted.", "");

    DocDeclStr(
        virtual bool , ItemChanged( const wxDataViewItem &item ),
        "Override this to be informed that an item's value has changed.", "");

    DocDeclStr(
        virtual bool , ItemsAdded( const wxDataViewItem &parent, const wxDataViewItemArray &items ),
        "Override this to be informed that several items have been added to the model.", "");

    DocDeclStr(
        virtual bool , ItemsDeleted( const wxDataViewItem &parent, const wxDataViewItemArray &items ),
        "Override this to be informed that several items have been deleted.", "");

    DocDeclStr(
        virtual bool , ItemsChanged( const wxDataViewItemArray &items ),
        "Override this to be informed that several items have been changed.", "");

    DocDeclStr(
        virtual bool , ValueChanged( const wxDataViewItem &item, unsigned int col ),
        "Override this to be informed that a value has changed in the model.
This differs from `ItemChanged` in that this method is sensitive to
changes in sub-elements of an item, not just the whole item (row).", "");

    DocDeclStr(
        virtual bool , Cleared(),
        "Override this to be informed that all data has been cleared.  The
control will read the visible data items from the model again.", "");

    DocDeclStr(
        virtual void , Resort(),
        "Override this to be informed that a resort has been initiated after
the sort function has been changed.", "");


    DocDeclStr(
        void , SetOwner( wxDataViewModel *owner ),
        "Sets the owner (the model) of this notifier.  Used internally.", "");

    DocDeclStr(
        wxDataViewModel *, GetOwner(),
        "Returns the owner (the model) of this notifier.", "");


    %property(Owner, GetOwner, SetOwner);
};



%{ // Derive from the class in C++ for virtualization
class wxPyDataViewModelNotifier : public wxDataViewModelNotifier {
public:
    wxPyDataViewModelNotifier() {}

    PYCALLBACK_2_EXTRACT_PURE(bool, rval = false, ItemAdded, (const wxDataViewItem &a, const wxDataViewItem &b))
    PYCALLBACK_2_EXTRACT_PURE(bool, rval = false, ItemDeleted, (const wxDataViewItem &a, const wxDataViewItem &b))
    PYCALLBACK_1_EXTRACT_PURE(bool, rval = false, ItemChanged, (const wxDataViewItem &a))

    PYCALLBACK_2_EXTRACT(wxDataViewModelNotifier, bool, rval = false, ItemsAdded, 
                            (const wxDataViewItem &a, const wxDataViewItemArray &b))
    PYCALLBACK_2_EXTRACT(wxDataViewModelNotifier, bool, rval = false, ItemsDeleted, 
                            (const wxDataViewItem &a, const wxDataViewItemArray &b))
    PYCALLBACK_1_EXTRACT(wxDataViewModelNotifier, bool, rval = false, ItemsChanged, 
                            (const wxDataViewItemArray &a))

    PYCALLBACK_2_EXTRACT_PURE(bool, rval = false, ValueChanged, (const wxDataViewItem &a, unsigned int b))
    PYCALLBACK_0_EXTRACT_PURE(bool, rval = false, Cleared)
    PYCALLBACK_0_VOID_PURE(Resort)

    PYPRIVATE;
};
%}



DocStr(wxPyDataViewModelNotifier,
"This class is a version of `DataViewModelNotifier` that has been
engineered to know how to reflect the C++ virtual method calls to
Python methods in the derived class.  Use this class as your base
class instead of `DataViewModelNotifier`.", "");

class wxPyDataViewModelNotifier : public wxDataViewModelNotifier {
public:
    %pythonAppend wxPyDataViewModelNotifier  setCallbackInfo(PyDataViewModelNotifier);
    wxPyDataViewModelNotifier();
    void _setCallbackInfo(PyObject* self, PyObject* _class);
};

//---------------------------------------------------------------------------
// wxDataViewItemAttr: a structure containing the visual attributes of an item
%newgroup

class wxDataViewItemAttr
{
public:
    wxDataViewItemAttr();
    ~wxDataViewItemAttr();

    void SetColour(const wxColour& colour);
    void SetBold( bool set );
    void SetItalic( bool set );

    bool HasColour() const;
    const wxColour& GetColour() const;

    bool GetBold() const;
    bool GetItalic() const;
};

//---------------------------------------------------------------------------
// wxDataViewModel
%newgroup


// First, the base class...

DocStr(wxDataViewModel,
"`DataViewModel` is the base class for managing all data to be
displayed by a `DataViewCtrl`. All other models derive from it and
must implement several of its methods in order to define a complete
data model. In detail, you need to override `IsContainer`,
`GetParent`, `GetChildren`, `GetColumnCount`, `GetColumnType` and
`GetValue` in order to define the data model which acts as an
interface between your actual data and the `DataViewCtrl`. Since you
will usually also allow the `DataViewCtrl` to change your data through
its graphical interface, you will also have to override `SetValue`
which the `DataViewCtrl` will call when a change to some data has been
commited.  To implement a custom data model derive a new class from
`PyDataViewModel` and implement the required methods.

The data that is presented through this data model is expected to
change at run-time. You need to inform the data model when a change
happened. Depending on what happened you need to call one of the
following methods: `ValueChanged`, `ItemAdded`, `ItemDeleted`,
`ItemChanged`, `Cleared`. There are plural forms for notification of
addition, change or removal of several item at once. See `ItemsAdded`,
`ItemsDeleted`, `ItemsChanged`.

Note that ``DataViewModel`` does not define the position or index of
any item in the control because different controls might display the
same data differently. ``DataViewModel`` does provide a `Compare`
method which the `DataViewCtrl` may use to sort the data either in
conjunction with a column header or without (see `HasDefaultCompare`).

This class maintains a list of `DataViewModelNotifier` objects which
link this class to the specific implementations on the supported
platforms so that e.g. calling `ValueChanged` on this model will just
call `DataViewModelNotifier.ValueChanged` for each notifier that has
been added. You can also add your own notifier in order to get
informed about any changes to the data in the list model.

Currently wxWidgets provides the following models in addition to this
base class: `DataViewIndexListModel`, `DataViewVirtualListModel-, and
`DataViewTreeStore`.  To create your own model from Python you will
need to use the `PyDataViewModel` as your base class.

:note: The C++ DataView classes use the wxVariant class to pass around
    dynamically typed data values.  In wxPython we have typemaps that
    will convert variants to Python objects of appropriate types, and
    if the type of object is not one that wxVariant will understand
    then the raw PyObject is passed through, with appropriate
    ref-counting.  The wxVariant type names and the Python types they
    are converted to or from are listed in this table:

    ============= =======================
    'bool'        Boolean
    'long'        Integer
    'double'      Float
    'string'      String or Unicode
    'PyObject'    any other Python type
    ============= =======================
", "");

class wxDataViewModel: public wxObjectRefData
{
public:
    // wxDataViewModel();     ****  It's an ABC

    DocDeclStr(
        virtual unsigned int , GetColumnCount() const,
        "Override this to indicate the number of columns in the model.", "");


    // return type as reported by wxVariant
    DocDeclStr(
        virtual wxString , GetColumnType( unsigned int col ) const,
        "Override this to indicate what type of data is stored in the column
specified by col. This should return a string indicating the type name of
data type, as used by wxVariant.", "");


    %extend {
    //  ****  Changed semantics such that the value is the return value
    //virtual void GetValue( wxVariant &variant,
    //                       const wxDataViewItem &item, unsigned int col ) const;
        DocDeclStr(
            virtual wxVariant , GetValue(const wxDataViewItem &item,
                                         unsigned int col ) const,
            "Override this and return the value to be used for the item, in the
given column.  The type of the return value should match that given by
`GetColumnType`.", "")
        {
            wxVariant var;
            self->GetValue(var, item, col);
            return var;
        }
    }


    DocDeclStr(
        virtual bool , SetValue( const wxVariant &variant,
                                 const wxDataViewItem &item, unsigned int col ),
        "This gets called in order to set a value in the data model.  The most
common scenario is that the `DataViewCtrl` calls this method after the
user has changed some data in the view.  The model should then update
whatever it is using for storing the data values and then call
`ValueChanged` so proper notifications are performed.", "");


    DocDeclStr(
        virtual bool , GetAttr( const wxDataViewItem &item, unsigned int col,
                                wxDataViewItemAttr &attr ),
        "Override this to indicate that the item has special font
attributes. This only affects the `DataViewTextRendererText` renderer.
Return ``False`` if the default attributes should be used.", "");


    DocDeclStr(
        virtual wxDataViewItem , GetParent( const wxDataViewItem &item ) const,
        "Override this to indicate which item is the parent of the given item.
If the item is a child of the (hidden) root, then simply return an
invalid item, (one constructed with no ID.)", "");


    DocDeclStr(
        virtual bool , IsContainer( const wxDataViewItem &item ) const,
        "Override this to indicate whether an item is a container, in other
words, if it is a parent item that can have children.", "");


    DocDeclStr(
        virtual bool , HasContainerColumns(const wxDataViewItem& item) const,
        "Override this method to indicate if a container item merely acts as a
headline (such as for categorisation) or if it also acts a normal item with
entries for the other columns. The default implementation returns ``False``.", "");


    DocDeclStr(
        virtual unsigned int , GetChildren( const wxDataViewItem &item,
                                            wxDataViewItemArray &children ) const,
        "Override this so the control can find the children of a container
item.  The children array should be filled with the child items of the
given item, and the number of children should be returned.", "");


//     TODO:  define DnD capabilities
//     virtual bool IsDraggable( const wxDataViewItem &item );

// // TODO: **** Is the format supposed to be a return value? If so
// //            perhaps it should be split into two methods...
//     virtual size_t GetDragDataSize( const wxDataViewItem &item,
//                                     const wxDataFormat &format );

// // TODO: **** Data should be the return value.  How is format used here?
//     virtual bool GetDragData( const wxDataViewItem &item,
//                               const wxDataFormat &format,
//                               void* data, size_t size );

    DocDeclStr(
        virtual bool , ItemAdded( const wxDataViewItem &parent, const wxDataViewItem &item ),
        "Call this to inform the registered notifiers that an item has been
added to the model.", "");

    DocDeclStr(
        virtual bool , ItemsAdded( const wxDataViewItem &parent, const wxDataViewItemArray &items ),
        "Call this to inform the registered notifiers that multiple items have
been added to the data model.", "");

    DocDeclStr(
        virtual bool , ItemDeleted( const wxDataViewItem &parent, const wxDataViewItem &item ),
        "Call this to inform the registered notifiers that an item has been
deleted from the model.", "");

    DocDeclStr(
        virtual bool , ItemsDeleted( const wxDataViewItem &parent, const wxDataViewItemArray &items ),
        "Call this to inform the registered notifiers that multiple items have
been deleted from the data model.", "");

    DocDeclStr(
        virtual bool , ItemChanged( const wxDataViewItem &item ),
        "Call this to inform the registered notifiers that an item has changed.
This will eventually result in a EVT_DATAVIEW_ITEM_VALUE_CHANGED
event, in which the column field will not be set.", "");

    DocDeclStr(
        virtual bool , ItemsChanged( const wxDataViewItemArray &items ),
        "Call this to inform the registered notifiers that multiple items have
changed.  This will eventually result in EVT_DATAVIEW_ITEM_VALUE_CHANGED
events, in which the column field will not be set.", "");

    DocDeclStr(
        virtual bool , ValueChanged( const wxDataViewItem &item, unsigned int col ),
        "Call this to inform the registered notifiers that a value in the model
has been changed.  This will eventually result in a EVT_DATAVIEW_ITEM_VALUE_CHANGED
event.", "");

    DocDeclStr(
        virtual bool , Cleared(),
        "Call this to inform the registered notifiers that all data has been
cleared.  The contorl will then reread the data from the model again.", "");

    DocDeclStr(
        virtual void , Resort(),
        "Call this to initiate a resort after the sort function has been changed.", "");


    %disownarg( wxDataViewModelNotifier *notifier );
    void AddNotifier( wxDataViewModelNotifier *notifier );
    %cleardisown( wxDataViewModelNotifier *notifier );

    %pythonAppend RemoveNotifier "args[1].thisown = 1";
    void RemoveNotifier( wxDataViewModelNotifier *notifier );


    DocDeclStr(
        virtual int , Compare( const wxDataViewItem &item1, const wxDataViewItem &item2,
                               unsigned int column, bool ascending ),
        "The compare function to be used by the control. The default compare
function sorts by container and other items separately and in
ascending order. Override this for a different sorting behaviour.", "");

    DocDeclStr(
        virtual bool , HasDefaultCompare() const,
        "Override this to indicate that the model provides a default compare
function that the control should use if no column has been chosen for
sorting. Usually, the user clicks on a column header for sorting and
the data will be sorted alphanumerically. If any other order (e.g. by
index or order of appearance) is required, then this should be used.", "");


    // internal
    virtual bool IsVirtualListModel() const;
};



%{
// Create a C++ class for the Py version

class wxPyDataViewModel: public wxDataViewModel
{
public:
    wxPyDataViewModel() {}

    PYCALLBACK_0_EXTRACT_PURE_CONST(unsigned int, rval = 0, GetColumnCount)
    PYCALLBACK_1_EXTRACT_PURE_CONST(wxString, rval, GetColumnType, (unsigned int a))
    PYCALLBACK_1_EXTRACT_PURE_CONST(wxDataViewItem, rval, GetParent, (const wxDataViewItem &a))
    PYCALLBACK_1_EXTRACT_PURE_CONST(bool, rval = false, IsContainer, (const wxDataViewItem &a))
    PYCALLBACK_2_EXTRACT_PURE_CONST(unsigned int, rval = 0, GetChildren, 
                                    (const wxDataViewItem &a, wxDataViewItemArray &b))

    PYCALLBACK_1_EXTRACT(wxDataViewModel, bool, rval = false, IsDraggable, (const wxDataViewItem &a))
    PYCALLBACK_1_EXTRACT_CONST(wxDataViewModel, bool, rval = false, HasContainerColumns, 
                                (const wxDataViewItem &a))
    PYCALLBACK_4_EXTRACT(wxDataViewModel, int, rval = 0, Compare, 
                            (const wxDataViewItem &a, const wxDataViewItem &b, unsigned int c, bool d))
    PYCALLBACK_0_EXTRACT_CONST(wxDataViewModel, bool, rval = false, HasDefaultCompare) 

    void GetValue( wxVariant &variant,
                   const wxDataViewItem &item, unsigned int col ) const
    {
        // The wxPython version of this method returns the variant as
        // a return value instead of modifying the parameter.
        bool found;
        wxPyThreadBlocker blocker;
        PYSETFUNC("GetValue");

        if ((found = wxPyCBH_findCallback(m_myInst, "GetValue"))) {
            wxPyTuple args(2);
            wxPyObject ro;
            ro = wxPyCBH_callCallbackObj(m_myInst, args << item << col);
            if (ro.Ok())
                variant = wxVariant_in_helper(ro.Get());
        }
        else {
            PyErr_SetString(PyExc_NotImplementedError,
              "The GetValue method should be implemented in derived class");
            wxThrowCppException();
        }
    }

    PYCALLBACK_3_EXTRACT_PURE(bool, rval = false, SetValue, 
                                (const wxVariant &a, const wxDataViewItem &b, unsigned int c))

    PYCALLBACK_3_EXTRACT_PURE(bool, rval = false, GetAttr, 
                                (const wxDataViewItem &a, unsigned int b, wxDataViewItemAttr &c))

    PYPRIVATE;
};

%}


// tell SWIG about the Py class
DocStr(wxPyDataViewModel,
"This class is a version of `DataViewModel` that has been
engineered to know how to reflect the C++ virtual method calls to
Python methods in the derived class.  Use this class as your base
class instead of `DataViewModel`.", "");

class wxPyDataViewModel: public wxDataViewModel
{
public:
    %pythonAppend wxPyDataViewModel   setCallbackInfo(PyDataViewModel);
    wxPyDataViewModel();
    void _setCallbackInfo(PyObject* self, PyObject* _class);
};


//---------------------------------------------------------------------------
%newgroup

// The wxDataViewIndexListModel and wxDataViewVirtualIndexModel both have the
// same API and semantics, so use a macro for declaring them, and the related
// Py classes.
%define DECLARE_INDEX_MODEL(ClassName, PyClassName)

class ClassName: public wxDataViewModel
{
public:
    // ClassName( unsigned int initial_size = 0 );   **** ABC
    ~ClassName();


    %extend {
    //  ****  Changed semantics such that the data value is the return value
    //virtual void GetValue( wxVariant &variant,
    //                       unsigned int row, unsigned int col ) const;
        DocDeclStr(
            virtual wxVariant , GetValue( unsigned int row, unsigned int col ) const,
            "Override this method to return the data value to be used for the item
at the given row and column.", "")
        {
            wxVariant var;
            self->GetValue(var, row, col);
            return var;
        }
    }

    DocDeclStr(
        virtual bool , SetValue( const wxVariant &variant,
                                 unsigned int row, unsigned int col ),
        "This is called in order to set a value in the data model.", "");


    DocDeclStr(
        virtual bool , GetAttr( unsigned int row, unsigned int col,
                                wxDataViewItemAttr &attr ),
        "Override this to indicate that the item has special font
attributes. This only affects the `DataViewTextRendererText` renderer.
Return ``False`` if the default attributes should be used.", "");


    DocDeclStr(
        void , RowPrepended(),
        "Call this after a row has been prepended to the model.", "");

    DocDeclStr(
        void , RowInserted( unsigned int before ),
        "Call this after a row has been inserted at the given position", "");

    DocDeclStr(
        void , RowAppended(),
        "Call this after a row has been appended to the model.", "");

    DocDeclStr(
        void , RowDeleted( unsigned int row ),
        "Call this after a row has been deleted.", "");

    DocDeclStr(
        void , RowsDeleted( const wxArrayInt &rows ),
        "Call this after rows have been deleted. The array will internally get
copied and sorted in descending order so that the rows with the
highest position will be deleted first.", "");

    DocDeclStr(
        void , RowChanged( unsigned int row ),
        "Call this after a row has been changed.", "");

    DocDeclStr(
        void , RowValueChanged( unsigned int row, unsigned int col ),
        "Call this after a value has been changed.", "");

    DocDeclStr(
        void , Reset( unsigned int new_size ),
        "Call this if the data has to be read again from the model. This is
useful after major changes when calling methods like `RowChanged` or
`RowDeleted` (possibly thousands of times) doesn't make sense.", "");



    DocDeclStr(
        unsigned int , GetRow( const wxDataViewItem &item ) const,
        "Returns the row position of item.", "");

    DocDeclStr(
        wxDataViewItem , GetItem( unsigned int row ) const,
        "Returns the DataViewItem for the item at row.", "");


    // internal
    unsigned int GetLastIndex() const;
};


%{
// Create a C++ class for the Py version

class PyClassName : public ClassName
{
public:
    PyClassName( unsigned int initial_size = 0)
        : ClassName(initial_size) {}

    PYCALLBACK_0_EXTRACT_PURE_CONST(unsigned int, rval = 0, GetColumnCount)
    PYCALLBACK_1_EXTRACT_PURE_CONST(wxString, rval, GetColumnType, (unsigned int a))

    PYCALLBACK_1_EXTRACT_CONST(ClassName, wxDataViewItem, rval, GetParent, (const wxDataViewItem &a))
    PYCALLBACK_1_EXTRACT_CONST(ClassName, bool, rval = false, IsContainer, (const wxDataViewItem &a))
    PYCALLBACK_1_EXTRACT_CONST(ClassName, bool, rval = false, HasContainerColumns, (const wxDataViewItem &a))
    PYCALLBACK_2_EXTRACT_CONST(ClassName, unsigned int, rval = 0, GetChildren, 
                                    (const wxDataViewItem &a, wxDataViewItemArray &b))

    PYCALLBACK_1_EXTRACT(ClassName, bool, rval = false, IsDraggable, (const wxDataViewItem &a))
    PYCALLBACK_4_EXTRACT(ClassName, int, rval = 0, Compare, 
                            (const wxDataViewItem &a, const wxDataViewItem &b, unsigned int c, bool d))
    PYCALLBACK_0_EXTRACT_CONST(ClassName, bool, rval = false, HasDefaultCompare) 

    virtual void GetValue( wxVariant &variant,
                           unsigned int row, unsigned int col ) const
    {
        // The wxPython version of this method returns the variant as
        // a return value instead of modifying the parameter.
        bool found;
        wxPyThreadBlocker blocker;
        PYSETFUNC("GetValue");

        if ((found = wxPyCBH_findCallback(m_myInst, "GetValue"))) {
            wxPyTuple args(2);
            wxPyObject ro;
            ro = wxPyCBH_callCallbackObj(m_myInst, args << row << col);
            if (ro.Ok())
                variant = wxVariant_in_helper(ro.Get());
        }
        else {
            PyErr_SetString(PyExc_NotImplementedError,
              "The GetValue method should be implemented in derived class");
            wxThrowCppException();
        }
    }


    PYCALLBACK_3_EXTRACT_PURE(bool, rval = false, SetValue, 
                                (const wxVariant &a, unsigned int b, unsigned int c))

    PYCALLBACK_3_EXTRACT_PURE(bool, rval = false, GetAttr, 
                                (unsigned int a, unsigned int b, wxDataViewItemAttr &c))

    PYPRIVATE;
};
%}

// tell SWIG about the Py class
class PyClassName: public ClassName
{
public:
    %pythonAppend PyClassName
         setCallbackInfo(PyDataViewIndexListModel);

    PyClassName(unsigned int initial_size = 0);
    void _setCallbackInfo(PyObject* self, PyObject* _class);
};

%enddef    //------- end of macro -----------




DocStr(wxDataViewIndexListModel,
"DataViewIndexListModel is a specialized data model which lets you
address an item by its position (row) rather than its `DataViewItem`
(which you can obtain from this class). This model also provides its
own `Compare` method which sorts the model's data by the index.  To
implement a custom list-based data model derive a new class from
`PyDataViewIndexListModel` and implement the required methods.

This model is not a virtual model since the control stores each
`DataViewItem` in memory. Use a `DataViewVirtualListModel` if you need
to display millions of items or have other reasons to use a virtual
control.", "");

DocStr(wxPyDataViewIndexListModel,
"This class is a version of `DataViewIndexListModel` that has been
engineered to know how to reflect the C++ virtual method calls to
Python methods in the derived class.  Use this class as your base
class instead of `DataViewIndexListModel`.", "");

DECLARE_INDEX_MODEL(wxDataViewIndexListModel, wxPyDataViewIndexListModel);


DocStr(wxDataViewVirtualListModel,
"DataViewVirtualListModel is a specialized data model which lets you
address an item by its position (row) rather than its `DataViewItem`
and as such offers the exact same interface as
`DataViewIndexListModel`. The important difference is that under
platforms other than OS X, using this model will result in a truely
virtual control able to handle millions of items as the control
doesn't store any per-item data in memory (a feature not supported by
the Carbon API under OS X).

To implement a custom list-based data model derive a new class from
`PyDataViewVirtualListModel` and implement the required methods.", "");

DocStr(PyClassName,
"This class is a version of `DataViewVirtualListModel` that has been
engineered to know how to reflect the C++ virtual method calls to
Python methods in the derived class.  Use this class as your base
class instead of `DataViewVirtualListModel`.", "");

DECLARE_INDEX_MODEL(wxDataViewVirtualListModel, wxPyDataViewVirtualListModel);



//---------------------------------------------------------------------------
// TODO: should I wrap wxDataViewEditorCtrlEvtHandler ?


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// wxDataViewRenderer

enum wxDataViewCellMode
{
    wxDATAVIEW_CELL_INERT,
    wxDATAVIEW_CELL_ACTIVATABLE,
    wxDATAVIEW_CELL_EDITABLE
};

enum wxDataViewCellRenderState
{
    wxDATAVIEW_CELL_SELECTED    = 1,
    wxDATAVIEW_CELL_PRELIT      = 2,
    wxDATAVIEW_CELL_INSENSITIVE = 4,
    wxDATAVIEW_CELL_FOCUSED     = 8
};

DocStr(wxDataViewRenderer,
"This class is used by `DataViewCtrl` to render (or draw) the
individual cells. One instance of a renderer class is owned by each
`DataViewColumn`. There is a number of ready-to-use renderers
provided: `DataViewTextRenderer`, `DataViewTextRendererAttr`,
`DataViewIconTextRenderer`, `DataViewToggleRenderer`,
`DataViewProgressRenderer`, `DataViewBitmapRenderer`,
`DataViewDateRenderer`, `DataViewSpinRenderer`.

To create your own custom renderer derive a new class from
`PyDataViewCustomRenderer`.

The mode flag controls what actions the cell data
allows. ``DATAVIEW_CELL_ACTIVATABLE`` indicates that the user can double
click the cell and something will happen (e.g. a window for editing a
date will pop up). ``DATAVIEW_CELL_EDITABLE`` indicates that the user
can edit the data in-place, i.e. an control will show up after a slow
click on the cell. This behaviour is best known from changing the
filename in most file managers etc.
", "");

class wxDataViewRenderer: public wxObject
{
public:
//     ****  It's an ABC
//     wxDataViewRenderer( const wxString &varianttype,
//                         wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
//                         int alignment = wxDVR_DEFAULT_ALIGNMENT );
    ~wxDataViewRenderer();

    virtual bool Validate( wxVariant& value );

    void SetOwner( wxDataViewColumn *owner );
    wxDataViewColumn* GetOwner();

    virtual bool SetValue( const wxVariant& value );

    // Change this to return the value or None
    // virtual bool GetValue( wxVariant& value ) const;
    %extend {
        virtual wxVariant  GetValue( ) const
        {
            wxVariant var;
            if (! self->GetValue(var))
                var = wxVariant_in_helper(Py_None);
            return var;
        }
    }

    wxString GetVariantType() const;

    virtual void SetMode( wxDataViewCellMode mode );
    virtual wxDataViewCellMode GetMode() const;

    virtual void SetAlignment( int align );
    virtual int GetAlignment() const;


    // in-place editing
    virtual bool HasEditorCtrl();
    virtual wxControl* CreateEditorCtrl(wxWindow * parent,
                                        wxRect labelRect,
                                        const wxVariant& value);

    // Change this to return the value or None (or maybe raise an exception?)
    //virtual bool GetValueFromEditorCtrl(wxControl * editor,
    //                                    wxVariant& value);
    %extend {
        virtual wxVariant GetValueFromEditorCtrl(wxControl * editor)
        {
            wxVariant var;
            if (! self->GetValueFromEditorCtrl(editor, var))
                var = wxVariant_in_helper(Py_None);
            return var;
        }
    }

    virtual bool StartEditing( const wxDataViewItem &item, wxRect labelRect );
    virtual void CancelEditing();
    virtual bool FinishEditing();

    wxControl *GetEditorCtrl();

    %property(Owner, GetOwner, SetOwner);
    %property(Value, GetValue, SetValue);
    %property(VariantType, GetVariantType);
    %property(Mode, GetMode, SetMode);
    %property(Alignment, GetAlignment, SetAlignment);
    %property(EditorCtrl, GetEditorCtrl);
};


//---------------------------------------------------------------------------
// wxDataViewTextRenderer

DocStr(wxDataViewTextRenderer,
"This class is used for rendering text. It supports in-place editing if
desired.", "");

class wxDataViewTextRenderer: public wxDataViewRenderer
{
public:
    wxDataViewTextRenderer(const wxString& varianttype="string",
                           wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                           int align=wxDVR_DEFAULT_ALIGNMENT);
};


//---------------------------------------------------------------------------
// wxDataViewTextRendererAttr

DocStr(wxDataViewTextRendererAttr,
"The same as `DataViewTextRenderer` but with support for font
attributes. Font attributes are currently only supported under GTK+
and MSW.", "");

class wxDataViewTextRendererAttr: public wxDataViewTextRenderer
{
public:
    wxDataViewTextRendererAttr(const wxString& varianttype="string",
                           wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                           int align=wxDVR_DEFAULT_ALIGNMENT);
};


//---------------------------------------------------------------------------
// wxDataViewBitmapRenderer

DocStr(wxDataViewBitmapRenderer,
"DataViewBitmapRenderer", "");

class wxDataViewBitmapRenderer: public wxDataViewRenderer
{
public:
    wxDataViewBitmapRenderer(const wxString& varianttype="wxBitmap",
                             wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                             int align=wxDVR_DEFAULT_ALIGNMENT);
};

//---------------------------------------------------------------------------
// wxDataViewIconTextRenderer

DocStr(wxDataViewIconTextRenderer,
"The `DataViewIconTextRenderer` class is used to display text with a
small icon next to it as it is typically done in a file manager. This
class uses the `DataViewIconText` helper class to store its
data.", "");

class  wxDataViewIconTextRenderer: public wxDataViewRenderer
{
public:
  wxDataViewIconTextRenderer(const wxString& varianttype = "wxDataViewIconText",
                             wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                             int align=wxDVR_DEFAULT_ALIGNMENT);
};



DocStr(wxDataViewIconText,
"DataViewIconText is used to hold the data for columns using the
`DataViewIconTextRenderer`", "");

class wxDataViewIconText: public wxObject
{
public:
    wxDataViewIconText( const wxString &text = wxEmptyString,
                        const wxIcon& icon = wxNullIcon );


    void SetText( const wxString &text );
    wxString GetText() const;
    void SetIcon( const wxIcon &icon );
    const wxIcon &GetIcon() const;
};




//---------------------------------------------------------------------------
// wxDataViewToggleRenderer

DocStr(wxDataViewToggleRenderer,
"DataViewToggleRenderer", "");

class wxDataViewToggleRenderer: public wxDataViewRenderer
{
public:
    wxDataViewToggleRenderer(const wxString & varianttype = "bool",
                             wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                             int align=wxDVR_DEFAULT_ALIGNMENT);
};


//---------------------------------------------------------------------------
// wxDataViewProgressRenderer

DocStr(wxDataViewProgressRenderer,
"DataViewProgressRenderer", "");

class wxDataViewProgressRenderer: public wxDataViewRenderer
{
public:
    wxDataViewProgressRenderer(const wxString& label = wxEmptyString,
                               const wxString& varianttype="long",
                               wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                               int align=wxDVR_DEFAULT_ALIGNMENT);
};

//---------------------------------------------------------------------------
// wxDataViewSpinRenderer

DocStr(wxDataViewSpinRenderer,
"This is a specialized renderer for rendering integer values. It
supports modifying the values in-place by using a `wx.SpinCtrl`. The
renderer only support integer data items.", "");

class wxDataViewSpinRenderer: public wxDataViewRenderer
{
public:
    wxDataViewSpinRenderer( int min, int max,
                            wxDataViewCellMode mode = wxDATAVIEW_CELL_EDITABLE,
                            int alignment = wxDVR_DEFAULT_ALIGNMENT );
};

//---------------------------------------------------------------------------
// wxDataViewDateRenderer

DocStr(wxDataViewDateRenderer,
"","");

class wxDataViewDateRenderer: public wxDataViewRenderer
{
public:
  wxDataViewDateRenderer(const wxString& varianttype="datetime",
                         wxDataViewCellMode mode=wxDATAVIEW_CELL_ACTIVATABLE,
                         int align=wxDVR_DEFAULT_ALIGNMENT);
};

//---------------------------------------------------------------------------
// wxDataViewCustomRenderer

DocStr(wxDataViewCustomRenderer,
"See `PyDataViewCustomRenderer`.", "");

class wxDataViewCustomRenderer: public wxDataViewRenderer
{
};


%{ // Derive from the class in C++ for virtualization

class wxPyDataViewCustomRenderer : public wxDataViewCustomRenderer
{
public:
    wxPyDataViewCustomRenderer(const wxString& varianttype="string",
                               wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                               int align=wxDVR_DEFAULT_ALIGNMENT)
        : wxDataViewCustomRenderer(varianttype, mode, align)
    {}

    PYCALLBACK_0_EXTRACT_PURE_CONST(wxSize, rval(0,0), GetSize)
    PYCALLBACK_3_EXTRACT_PURE(bool, rval = false, Render, (wxRect a, wxDC* b, int c))
    PYCALLBACK_4_EXTRACT(wxDataViewCustomRenderer, bool, rval = false, Activate, 
                            (wxRect a, wxDataViewModel* b, const wxDataViewItem& c, unsigned int d))
    PYCALLBACK_5_EXTRACT(wxDataViewCustomRenderer, bool, rval = false, LeftClick, 
                            (wxPoint a, wxRect b, wxDataViewModel* c, const wxDataViewItem& d, unsigned int e))
    PYCALLBACK_5_EXTRACT(wxDataViewCustomRenderer, bool, rval = false, StartDrag, 
                            (wxPoint a, wxRect b, wxDataViewModel* c, const wxDataViewItem& d, unsigned int e))

    PYCALLBACK_1_EXTRACT_PURE(bool, rval = false, SetValue, (const wxVariant &a))

    virtual bool GetValue( wxVariant& value ) const
    {
        // The wxPython version of this method returns the variant as
        // a return value instead of modifying the parameter.
        bool found;
        wxPyThreadBlocker blocker;
        PYSETFUNC("GetValue");

        if ((found = wxPyCBH_findCallback(m_myInst, "GetValue"))) {
            wxPyObject ro;
            ro = wxPyCBH_callCallbackObj(m_myInst, NULL);
            if (ro.Ok())
                value = wxVariant_in_helper(ro.Get());
        }
        else {
            PyErr_SetString(PyExc_NotImplementedError,
              "The GetValue method should be implemented in derived class");
            wxThrowCppException();
        }
        return true;
    }


    virtual bool GetValueFromEditorCtrl(wxControl * editor,
                                        wxVariant& value)
    {
        // The wxPython version of this method returns the variant as
        // a return value instead of modifying the parameter.
        bool found;
        wxPyThreadBlocker blocker;
        if ((found = wxPyCBH_findCallback(m_myInst, "GetValueFromEditorCtrl"))) {
            wxPyTuple args(1);
            wxPyObject ro;
            ro = wxPyCBH_callCallbackObj(m_myInst, args << editor);
            if (ro.Ok())
                value = wxVariant_in_helper(ro.Get());
        }
        blocker.Unblock();
        if (!found)
            return wxDataViewCustomRenderer::GetValueFromEditorCtrl(editor, value);
        else
            return true;
    }



    PYPRIVATE;
};

%}



DocStr(wxDataViewCustomRenderer,
"", "");

class wxPyDataViewCustomRenderer: public wxDataViewCustomRenderer
{
public:
    wxPyDataViewCustomRenderer(const wxString& varianttype="string",
                               wxDataViewCellMode mode=wxDATAVIEW_CELL_INERT,
                               int align=wxDVR_DEFAULT_ALIGNMENT);

    DocDeclStr(
        void , RenderText( const wxString &text, int xoffset, wxRect cell, wxDC *dc, int state ),
        "This method should be called from within your `Render` override
whenever you need to render simple text. This will help ensure that the
correct colour, font and vertical alignment will be chosen so the text
will look the same as text drawn by native renderers.", "");

    DocDeclStr(
        virtual wxSize , GetSize() const,
        "Returns the size required to show content.  This must be overridden in
derived classes.", "");

    DocDeclStr(
        virtual bool , Render(wxRect cell, wxDC* dc, int state),
        "Override this to render the cell. Before this is called, `SetValue`
was called so that this instance knows what to render.  This must be
overridden in derived classes.", "");

    DocDeclStr(
        virtual bool , Activate(wxRect cell,
                                wxDataViewModel *model,
                                const wxDataViewItem & item, 
                                unsigned int col),
        "Override this to react to double clicks or <ENTER>.", "");

    DocDeclStr(
        virtual bool , LeftClick(wxPoint cursor,
                                 wxRect cell,
                                 wxDataViewModel *model,
                                 const wxDataViewItem & item, 
                                 unsigned int col),
        "Overrride this to react to a left click.", "");

//     DocDeclStr(
//         virtual bool , RightClick(wxPoint cursor,
//                                   wxRect cell,
//                                   wxDataViewModel *model,
//                                   const wxDataViewItem & item, 
//                                   unsigned int col),
//         "Overrride this to react to a right click.", "");

    DocDeclStr(
        virtual bool , StartDrag(wxPoint cursor,
                                 wxRect cell,
                                 wxDataViewModel *model,
                                 const wxDataViewItem & item, 
                                 unsigned int col),
        "Overrride this to react to the start of a drag operation.", "");

    DocDeclStr(
        virtual wxDC* , GetDC(void),
        "Create DC on request.", "");

//    void SetDC(wxDC* newDCPtr); // this method takes ownership of the pointer
};


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

%{
bool wxPyTextOrBitmap_helper(PyObject* obj, bool& wasString,
                             wxString& outstr, wxBitmap& outbmp)
{
    bool rv = false;
    wxString* text = NULL;
    wxPyThreadBlocker blocker;

    text = wxString_in_helper(obj);
    if (text != NULL) {
        wasString = true;
        outstr = *text;
        delete text;
        rv = true;
    }
    if (PyErr_Occurred()) PyErr_Clear();
    if (!rv) {
        if (wxPyConvertSwigPtr(obj, (void**)&outbmp, wxT("wxBitmap") )) {
            wasString = false;
            rv = true;
        }
    }
    if (!rv)
        // set an exception
        PyErr_SetString(PyExc_TypeError, "Expected String or Bitmap object");

    blocker.Unblock();
    return rv;
}
%}



enum wxDataViewColumnFlags
{
    wxDATAVIEW_COL_RESIZABLE     = 1,
    wxDATAVIEW_COL_SORTABLE      = 2,
    wxDATAVIEW_COL_REORDERABLE   = 4,
    wxDATAVIEW_COL_HIDDEN        = 8
};

class wxDataViewColumn: public wxObject
{
public:
    // make a custom overloading of the ctor to be able to keep the kw args
    %extend {
        wxDataViewColumn(PyObject* title_or_bitmap,
                         wxDataViewRenderer* renderer,
                         unsigned int model_column,
                         int width=80,
                         wxAlignment align=wxALIGN_CENTER,
                         int flags=wxDATAVIEW_COL_RESIZABLE)
        {
            bool wasString;
            wxString label;
            wxBitmap bitmap;
            if (! wxPyTextOrBitmap_helper(title_or_bitmap, wasString, label, bitmap))
                return NULL;
            return wasString ?
                new wxDataViewColumn(label, renderer, model_column, width, align, flags)
                :  new wxDataViewColumn(bitmap, renderer, model_column, width, align, flags);
        }
    }

    virtual ~wxDataViewColumnBase();


    virtual void SetTitle( const wxString &title );
    virtual void SetAlignment( wxAlignment align );
    virtual void SetSortable( bool sortable );
    virtual void SetReorderable(bool reorderable);
    virtual void SetResizeable( bool resizeable );
    virtual void SetHidden( bool hidden );
    virtual void SetSortOrder( bool ascending );
    virtual void SetFlags( int flags );
    virtual void SetOwner( wxDataViewCtrl *owner );
    virtual void SetBitmap( const wxBitmap &bitmap );
    virtual void SetMinWidth( int minWidth );
    virtual void SetWidth( int width );

    virtual wxString GetTitle() const;
    virtual wxAlignment GetAlignment() const;
    virtual int GetWidth() const;
    virtual int GetMinWidth() const;
    virtual int GetFlags() const;
    virtual bool IsHidden() const;
    virtual bool IsReorderable() const;
    virtual bool IsResizeable() const;
    virtual bool IsSortable() const;
    virtual bool IsSortOrderAscending() const;
    const wxBitmap &GetBitmap() const;
    unsigned int GetModelColumn() const;
    wxDataViewCtrl *GetOwner() const;
    wxDataViewRenderer* GetRenderer() const;

    %property(Title, GetTitle, SetTitle);
    %property(Alignment, GetAlignment, SetAlignment);
    %property(Width, GetWidth, SetWidth);
    %property(MinWidth, GetMinWidth, SetMinWidth);
    %property(Flags, GetFlags, SetFlags);
    %property(Hidden, IsHidden, SetHidden);
    %property(Reorderable, IsReorderable, SetReorderable);
    %property(Resizeable, IsResizeable, SetResizeable);
    %property(Sortable, IsSortable, SetSortable);
    %property(SortOrderAscending, IsSortOrderAscending, SetSortOrder);
    %property(Bitmap, GetBitmap, SetBitmap);
    %property(ModelColumn, GetModelColumn);
    %property(Owner, GetOwner, SetOwner);
    %property(Renderer, GetRenderer);

};


//---------------------------------------------------------------------------
// wxDataViewCtrl

enum {
    wxDV_SINGLE,
    wxDV_MULTIPLE,

    wxDV_NO_HEADER,
    wxDV_HORIZ_RULES,
    wxDV_VERT_RULES,

    wxDV_ROW_LINES,
    wxDV_VARIABLE_LINE_HEIGHT,
};


DocStr(wxDataViewCtrl,
"", "");

class wxDataViewCtrl: public wxControl
{
public:
    %pythonAppend wxDataViewCtrl         "self._setOORInfo(self)"
    %pythonAppend wxDataViewCtrl()       ""
    %typemap(out) wxDataViewCtrl*;       // turn off this typemap

    wxDataViewCtrl(wxWindow *parent, wxWindowID id=wxID_ANY,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = 0,
                   const wxValidator& validator = wxDefaultValidator);
    %RenameCtor(PreDataViewCtrl, wxDataViewCtrl());

    // Turn it back on again
    %typemap(out) wxDataViewCtrl* { $result = wxPyMake_wxObject($1, $owner); }


    virtual bool AssociateModel( wxDataViewModel *model );
    wxDataViewModel* GetModel();
    //%pythoncode { SetModel = AssociateModel }
    

    // All these Prepend and Append convenience methods are overloaded
    // on the first parameter, which can be either a wxString or a
    // wxBitmap.  So we'll handle the overloading ourselves in order
    // to still allow kwargs to be used for the other params.
    %extend {
    wxDataViewColumn*
        PrependTextColumn(PyObject* label_or_bitmap, unsigned int model_column,
                          wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                          int width = -1,
                          wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                          int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependTextColumn(label, model_column, mode, width, align, flags)
            : self->PrependTextColumn(bitmap, model_column, mode, width, align, flags);
    }


    wxDataViewColumn*
        PrependIconTextColumn( PyObject* label_or_bitmap, unsigned int model_column,
                               wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                               int width = -1,
                               wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                               int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependIconTextColumn(label, model_column, mode, width, align, flags)
            : self->PrependIconTextColumn(bitmap, model_column, mode, width, align, flags);
    }


    wxDataViewColumn*
        PrependToggleColumn( PyObject* label_or_bitmap, unsigned int model_column,
                             wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                             int width = wxDVC_TOGGLE_DEFAULT_WIDTH,
                             wxAlignment align = wxALIGN_CENTER,
                             int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependToggleColumn(label, model_column, mode, width, align, flags)
            : self->PrependToggleColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        PrependProgressColumn( PyObject* label_or_bitmap, unsigned int model_column,
                               wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                               int width = wxDVC_DEFAULT_WIDTH,
                               wxAlignment align = wxALIGN_CENTER,
                               int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependProgressColumn(label, model_column, mode, width, align, flags)
            : self->PrependProgressColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        PrependDateColumn( PyObject* label_or_bitmap, unsigned int model_column,
                           wxDataViewCellMode mode = wxDATAVIEW_CELL_ACTIVATABLE,
                           int width = -1,
                           wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                           int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependDateColumn(label, model_column, mode, width, align, flags)
            : self->PrependDateColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        PrependBitmapColumn( PyObject* label_or_bitmap, unsigned int model_column,
                             wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                             int width = -1,
                             wxAlignment align = wxALIGN_CENTER,
                             int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->PrependBitmapColumn(label, model_column, mode, width, align, flags)
            : self->PrependBitmapColumn(bitmap, model_column, mode, width, align, flags);
    }



    wxDataViewColumn*
        AppendTextColumn( PyObject* label_or_bitmap, unsigned int model_column,
                          wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                          int width = -1,
                          wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                          int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendTextColumn(label, model_column, mode, width, align, flags)
            : self->AppendTextColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        AppendIconTextColumn( PyObject* label_or_bitmap, unsigned int model_column,
                              wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                              int width = -1,
                              wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                              int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendIconTextColumn(label, model_column, mode, width, align, flags)
            : self->AppendIconTextColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        AppendToggleColumn( PyObject* label_or_bitmap, unsigned int model_column,
                            wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                            int width = wxDVC_TOGGLE_DEFAULT_WIDTH,
                            wxAlignment align = wxALIGN_CENTER,
                            int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendToggleColumn(label, model_column, mode, width, align, flags)
            : self->AppendToggleColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        AppendProgressColumn( PyObject* label_or_bitmap, unsigned int model_column,
                              wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                              int width = wxDVC_DEFAULT_WIDTH,
                              wxAlignment align = wxALIGN_CENTER,
                              int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendProgressColumn(label, model_column, mode, width, align, flags)
            : self->AppendProgressColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        AppendDateColumn( PyObject* label_or_bitmap, unsigned int model_column,
                          wxDataViewCellMode mode = wxDATAVIEW_CELL_ACTIVATABLE,
                          int width = -1,
                          wxAlignment align = (wxAlignment)(wxALIGN_LEFT|wxALIGN_CENTRE_VERTICAL),
                          int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendDateColumn(label, model_column, mode, width, align, flags)
            : self->AppendDateColumn(bitmap, model_column, mode, width, align, flags);
    }

    wxDataViewColumn*
        AppendBitmapColumn( PyObject* label_or_bitmap, unsigned int model_column,
                            wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
                            int width = -1,
                            wxAlignment align = wxALIGN_CENTER,
                            int flags = wxDATAVIEW_COL_RESIZABLE )
    {
        bool wasString; wxString label; wxBitmap bitmap;
        if (! wxPyTextOrBitmap_helper(label_or_bitmap, wasString, label, bitmap))
            return NULL;
        return wasString ?
            self->AppendBitmapColumn(label, model_column, mode, width, align, flags)
            : self->AppendBitmapColumn(bitmap, model_column, mode, width, align, flags);
    }

    }


    virtual bool PrependColumn( wxDataViewColumn *col );
    virtual bool InsertColumn( unsigned int pos, wxDataViewColumn *col );
    virtual bool AppendColumn( wxDataViewColumn *col );

    
    virtual unsigned int GetColumnCount() const;
    virtual wxDataViewColumn* GetColumn( unsigned int pos ) const;
    %pythoncode {
        def GetColumns(self):
            """Returns a list of column objects."""
            return [self.GetColumn(i) for i in range(self.GetColumnCount())]
    }
    
    virtual int GetColumnPosition( const wxDataViewColumn *column ) const;
    virtual bool DeleteColumn( wxDataViewColumn *column );
    virtual bool ClearColumns();

    void SetExpanderColumn( wxDataViewColumn *col );
    wxDataViewColumn *GetExpanderColumn() const;

    virtual wxDataViewColumn *GetSortingColumn() const;

    void SetIndent( int indent );
    int GetIndent() const;

    virtual wxDataViewItem GetSelection() const;
    virtual int GetSelections( wxDataViewItemArray & sel ) const;
    virtual void SetSelections( const wxDataViewItemArray & sel );
    virtual void Select( const wxDataViewItem & item );
    virtual void Unselect( const wxDataViewItem & item );
    virtual bool IsSelected( const wxDataViewItem & item ) const;

    virtual void SelectAll();
    virtual void UnselectAll();

    virtual void Expand( const wxDataViewItem & item );
    virtual void Collapse( const wxDataViewItem & item );

    virtual void EnsureVisible( const wxDataViewItem & item,
                                const wxDataViewColumn *column = NULL );
    virtual void HitTest( const wxPoint & point, wxDataViewItem &item, wxDataViewColumn* &column ) const;
    virtual wxRect GetItemRect( const wxDataViewItem & item, const wxDataViewColumn *column = NULL ) const;

    
    %property(Model, GetModel, AssociateModel);
    %property(ColumnCount, GetColumnCount);
    %property(Columns, GetColumns);
    %property(ExpanderColumn, GetExpanderColumn, SetExpanderColumn);
    %property(SortingColumn, GetSortingColumn);
    %property(Indent, GetIndent, SetIndent);
    %property(Selection, GetSelection);
};

//---------------------------------------------------------------------------

class wxDataViewEvent : public wxNotifyEvent
{
public:
    wxDataViewEvent(wxEventType commandType = wxEVT_NULL, int winid = 0);
    wxDataViewItem GetItem() const;
    void SetItem( const wxDataViewItem &item );

    int GetColumn() const;
    void SetColumn( int col );

    wxDataViewModel* GetModel() const;
    void SetModel( wxDataViewModel *model );

    const wxVariant &GetValue() const;
    void SetValue( const wxVariant &value );

    // for wxEVT_DATAVIEW_COLUMN_HEADER_CLICKED only
    void SetDataViewColumn( wxDataViewColumn *col );
    wxDataViewColumn *GetDataViewColumn() const;

    // for wxEVT_DATAVIEW_CONTEXT_MENU only
    wxPoint GetPosition() const;
    void SetPosition( int x, int y );

    virtual wxEvent *Clone() const;
};

%constant wxEventType wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED;
%constant wxEventType wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED;

%pythoncode {

EVT_DATAVIEW_SELECTION_CHANGED         = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED, 1)
EVT_DATAVIEW_ITEM_ACTIVATED            = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED, 1)
EVT_DATAVIEW_ITEM_COLLAPSED            = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED, 1)
EVT_DATAVIEW_ITEM_EXPANDED             = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED, 1)
EVT_DATAVIEW_ITEM_COLLAPSING           = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING, 1)
EVT_DATAVIEW_ITEM_EXPANDING            = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING, 1)
EVT_DATAVIEW_ITEM_EDITING_STARTED      = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED, 1)
EVT_DATAVIEW_ITEM_EDITING_DONE         = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE, 1)
EVT_DATAVIEW_ITEM_VALUE_CHANGED        = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED, 1)
EVT_DATAVIEW_ITEM_CONTEXT_MENU         = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU, 1)
EVT_DATAVIEW_COLUMN_HEADER_CLICK       = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK, 1)
EVT_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK, 1)
EVT_DATAVIEW_COLUMN_SORTED             = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED, 1)
EVT_DATAVIEW_COLUMN_REORDERED          = wx.PyEventBinder( wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED, 1)

}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


%init %{
%}

//---------------------------------------------------------------------------
