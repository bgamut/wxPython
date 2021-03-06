/////////////////////////////////////////////////////////////////////////////
// Name:        _bitmap.i
// Purpose:     SWIG interface for wxBitmap and wxMask
//
// Author:      Robin Dunn
//
// Created:     7-July-1997
// RCS-ID:      $Id$
// Copyright:   (c) 2003 by Total Control Software
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

// Not a %module

%{
#include <wx/rawbmp.h>
%}

//---------------------------------------------------------------------------

%{
#include <wx/image.h>
    
    static char** ConvertListOfStrings(PyObject* listOfStrings) {
        char**    cArray = NULL;
        int       count;

        if (!PyList_Check(listOfStrings)) {
            PyErr_SetString(PyExc_TypeError, "Expected a list of strings.");
            return NULL;
        }
        count = PyList_Size(listOfStrings);
        cArray = new char*[count];

        for(int x=0; x<count; x++) {
            // TODO: Need some validation and error checking here
            cArray[x] = PyString_AsString(PyList_GET_ITEM(listOfStrings, x));
        }
        return cArray;
    }

%}

//---------------------------------------------------------------------------

// TODO:  When the API stabalizes and is available on other platforms, add
// wrappers for the new wxBitmap, wxRawBitmap, wxDIB stuff...

DocStr(wxBitmap,
"The wx.Bitmap class encapsulates the concept of a platform-dependent
bitmap.  It can be either monochrome or colour, and either loaded from
a file or created dynamically.  A bitmap can be selected into a memory
device context (instance of `wx.MemoryDC`). This enables the bitmap to
be copied to a window or memory device context using `wx.DC.Blit`, or
to be used as a drawing surface.", "

The BMP and XMP image file formats are supported on all platforms by
wx.Bitmap.  Other formats are automatically loaded by `wx.Image` and
converted to a wx.Bitmap, so any image file format supported by
`wx.Image` can be used.

:todo: Add wrappers and support for raw bitmap data access.  Can this
       be be put into Python without losing the speed benefits of the
       teplates and iterators in rawbmp.h?

:todo: Find a way to do very efficient PIL Image <--> wx.Bitmap
       converstions.

:see: `wx.EmptyBitmap`, `wx.BitmapFromIcon`, `wx.BitmapFromImage`,
      `wx.BitmapFromXPMData`, `wx.BitmapFromBits`, `wx.BitmapFromBuffer`,
      `wx.BitmapFromBufferRGBA`, `wx.Image`
");


MustHaveApp(wxBitmap);

class wxBitmap : public wxGDIObject
{
public:
    DocCtorStr(
        wxBitmap(const wxString& name, wxBitmapType type=wxBITMAP_TYPE_ANY),
        "Loads a bitmap from a file.",
        "
    :param name:  Name of the file to load the bitmap from.
    :param type: The type of image to expect.  Can be one of the following
        constants (assuming that the neccessary `wx.Image` handlers are
        loaded):

        * wx.BITMAP_TYPE_ANY
        * wx.BITMAP_TYPE_BMP
        * wx.BITMAP_TYPE_ICO
        * wx.BITMAP_TYPE_CUR
        * wx.BITMAP_TYPE_XBM
        * wx.BITMAP_TYPE_XPM
        * wx.BITMAP_TYPE_TIF
        * wx.BITMAP_TYPE_GIF
        * wx.BITMAP_TYPE_PNG
        * wx.BITMAP_TYPE_JPEG
        * wx.BITMAP_TYPE_PNM
        * wx.BITMAP_TYPE_PCX
        * wx.BITMAP_TYPE_PICT
        * wx.BITMAP_TYPE_ICON
        * wx.BITMAP_TYPE_ANI
        * wx.BITMAP_TYPE_IFF

:see: Alternate constructors `wx.EmptyBitmap`, `wx.BitmapFromIcon`,
      `wx.BitmapFromImage`, `wx.BitmapFromXPMData`, `wx.BitmapFromBits`,
      `wx.BitmapFromBuffer`, `wx.BitmapFromBufferRGBA`,
");
        
    ~wxBitmap();

    DocCtorStrName(
        wxBitmap(int width, int height, int depth=-1),
        "Creates a new bitmap of the given size.  A depth of -1 indicates the
depth of the current screen or visual. Some platforms only support 1
for monochrome and -1 for the current display depth.", "",
        EmptyBitmap);

    DocCtorStrName(
        wxBitmap(const wxIcon& icon),
        "Create a new bitmap from a `wx.Icon` object.", "",
        BitmapFromIcon);

    DocCtorStrName(
        wxBitmap(const wxImage& image, int depth=-1),
        "Creates bitmap object from a `wx.Image`. This has to be done to
actually display a `wx.Image` as you cannot draw an image directly on
a window. The resulting bitmap will use the provided colour depth (or
that of the current screen colour depth if depth is -1) which entails
that a colour reduction may have to take place.", "",
        BitmapFromImage);

    
    %extend {
        DocStr(wxBitmap(PyObject* listOfStrings),
               "Construct a Bitmap from a list of strings formatted as XPM data.", "");
        
        %RenameCtor(BitmapFromXPMData, wxBitmap(PyObject* listOfStrings))
        {
            char**    cArray = NULL;
            wxBitmap* bmp;

            cArray = ConvertListOfStrings(listOfStrings);
            if (! cArray)
                return NULL;
            bmp = new wxBitmap(cArray);
            delete [] cArray;
            return bmp;
        }

        DocStr(wxBitmap(PyObject* bits, int width, int height, int depth=1 ),
               "Creates a bitmap from an array of bits.  You should only use this
function for monochrome bitmaps (depth 1) in portable programs: in
this case the bits parameter should contain an XBM image.  For other
bit depths, the behaviour is platform dependent.", "");
        
        %RenameCtor(BitmapFromBits, wxBitmap(PyObject* bits, int width, int height, int depth=1 ))
        {
            char*       buf;
            Py_ssize_t  length;
            PyString_AsStringAndSize(bits, &buf, &length);
            return new wxBitmap(buf, width, height, depth);
        }
    }    

    
    // wxGDIImage methods
#ifdef __WXMSW__
    long GetHandle();
    %extend {
        void SetHandle(long handle) { self->SetHandle((WXHANDLE)handle); }
    }
#endif

    bool Ok();
    
    DocDeclStr(
        int , GetWidth(),
        "Gets the width of the bitmap in pixels.", "");
    

    DocDeclStr(
        int , GetHeight(),
        "Gets the height of the bitmap in pixels.", "");
    

    DocDeclStr(
        int , GetDepth(),
        "Gets the colour depth of the bitmap. A value of 1 indicates a
monochrome bitmap.", "");
    


    %extend {
        DocStr(GetSize, "Get the size of the bitmap.", "");
        wxSize GetSize() {
            wxSize size(self->GetWidth(), self->GetHeight());
            return size;
        }
    }

    
    DocDeclStr(
        virtual wxImage , ConvertToImage() const,
        "Creates a platform-independent image from a platform-dependent
bitmap. This preserves mask information so that bitmaps and images can
be converted back and forth without loss in that respect.", "");
    

    DocDeclStr(
        virtual wxMask* , GetMask() const,
        "Gets the associated mask (if any) which may have been loaded from a
file or explpicitly set for the bitmap.

:see: `SetMask`, `wx.Mask`
", "");

    // MSW only?    wxBitmap GetMaskBitmap() const;

    DocDeclStr(
        virtual void , SetMask(wxMask* mask),
        "Sets the mask for this bitmap.

:see: `GetMask`, `wx.Mask`
", "");
    
    
    %extend {
        DocStr(SetMaskColour,
               "Create a Mask based on a specified colour in the Bitmap.", "");
        void SetMaskColour(const wxColour& colour) {
            wxMask *mask = new wxMask(*self, colour);
            self->SetMask(mask);
        }
    }


    DocDeclStr(
        virtual wxBitmap , GetSubBitmap(const wxRect& rect) const,
        "Returns a sub-bitmap of the current one as long as the rect belongs
entirely to the bitmap. This function preserves bit depth and mask
information.", "");
    

    DocDeclStr(
        virtual bool , SaveFile(const wxString &name, wxBitmapType type,
                                wxPalette *palette = NULL),
        "Saves a bitmap in the named file.  See `__init__` for a description of
the ``type`` parameter.", "");
    

    DocDeclStr(
        virtual bool , LoadFile(const wxString &name, wxBitmapType type),
        "Loads a bitmap from a file.  See `__init__` for a description of the
``type`` parameter.", "");
    

    
    virtual wxPalette *GetPalette() const;
#ifdef __WXMSW__
    virtual void SetPalette(const wxPalette& palette);
#endif
    
    
    virtual bool CopyFromIcon(const wxIcon& icon);

    DocDeclStr(
        virtual void , SetHeight(int height),
        "Set the height property (does not affect the existing bitmap data).", "");
    
    
    DocDeclStr(
        virtual void , SetWidth(int width),
        "Set the width property (does not affect the existing bitmap data).", "");
    

    DocDeclStr(
        virtual void , SetDepth(int depth),
        "Set the depth property (does not affect the existing bitmap data).", "");
    

    %extend {
        DocStr(SetSize, "Set the bitmap size (does not affect the existing bitmap data).", "");
        void SetSize(const wxSize& size) {
            self->SetWidth(size.x);
            self->SetHeight(size.y);
        }
    }
    
#ifdef __WXMSW__
    bool CopyFromCursor(const wxCursor& cursor);
    int GetQuality();
    void SetQuality(int q);
    %pythoncode { GetQuality = wx._deprecated(GetQuality) }
    %pythoncode { SetQuality = wx._deprecated(SetQuality) }
#endif

    %pythoncode { def __nonzero__(self): return self.Ok() }

    %extend {
        bool __eq__(const wxBitmap* other) { return other ? (*self == *other) : false; }
        bool __ne__(const wxBitmap* other) { return other ? (*self != *other) : true;  }
    }
};


//---------------------------------------------------------------------------
// Factory functions for creating wxBitmaps from Python buffer objects.  They
// use the Abstract Pixel API to be able to set RGB and A bytes directly into
// the wxBitmap's pixel buffer.

%{
// See http://tinyurl.com/e5adr for what premultiplying alpha means.  It
// appears to me that the other platforms are already doing it, so I'll just
// automatically do it for wxMSW here.
#ifdef __WXMSW__
#define wxPy_premultiply(p, a)   ((p) * (a) / 256)
#define wxPy_unpremultiply(p, a) ((a) ? ((p) * 256 / (a)) : (p))    
#else
#define wxPy_premultiply(p, a)   (p)
#define wxPy_unpremultiply(p, a) (p)    
#endif
%}


%newobject _BitmapFromBufferAlpha;
%newobject _BitmapFromBuffer;
%inline %{
    wxBitmap* _BitmapFromBufferAlpha(int width, int height,
                                    buffer data, int DATASIZE,
                                    buffer alpha, int ALPHASIZE)
    {
        if (DATASIZE != width*height*3) {
            wxPyErr_SetString(PyExc_ValueError, "Invalid data buffer size.");
            return NULL;
        }

        if (ALPHASIZE != width*height) {
            wxPyErr_SetString(PyExc_ValueError, "Invalid alpha buffer size.");
            return NULL;
        }

        wxBitmap* bmp = new wxBitmap(width, height, 32);
        wxAlphaPixelData pixData(*bmp, wxPoint(0,0), wxSize(width,height));
        if (! pixData) {
            // raise an exception...
            wxPyErr_SetString(PyExc_RuntimeError,
                              "Failed to gain raw access to bitmap data.");
            return NULL;
        }
                
        pixData.UseAlpha();
        wxAlphaPixelData::Iterator p(pixData);
        for (int y=0; y<height; y++) {
            wxAlphaPixelData::Iterator rowStart = p;
            for (int x=0; x<width; x++) {
                byte a = *(alpha++);
                p.Red()   = wxPy_premultiply(*(data++), a);
                p.Green() = wxPy_premultiply(*(data++), a);
                p.Blue()  = wxPy_premultiply(*(data++), a);
                p.Alpha() = a;
                ++p; 
            }
            p = rowStart;
            p.OffsetY(pixData, 1);
        }
        return bmp;
    }        
        
    wxBitmap* _BitmapFromBuffer(int width, int height, buffer data, int DATASIZE)
    {
        if (DATASIZE != width*height*3) {
            wxPyErr_SetString(PyExc_ValueError, "Invalid data buffer size.");
            return NULL;
        }

        wxBitmap* bmp = new wxBitmap(width, height, 24);
        wxNativePixelData pixData(*bmp, wxPoint(0,0), wxSize(width,height));
        if (! pixData) {
            // raise an exception...
            wxPyErr_SetString(PyExc_RuntimeError,
                              "Failed to gain raw access to bitmap data.");
            return NULL;
        }
                
        wxNativePixelData::Iterator p(pixData);
        for (int y=0; y<height; y++) {
            wxNativePixelData::Iterator rowStart = p;
            for (int x=0; x<width; x++) {
                p.Red()   = *(data++);
                p.Green() = *(data++);
                p.Blue()  = *(data++);
                ++p; 
            }
            p = rowStart;
            p.OffsetY(pixData, 1);
        }
        return bmp;
    }
%}    


%pythoncode {
def BitmapFromBuffer(width, height, dataBuffer, alphaBuffer=None):
    """
    Creates a `wx.Bitmap` from the data in dataBuffer.  The dataBuffer
    parameter must be a Python object that implements the buffer interface,
    such as a string, array, etc.  The dataBuffer object is expected to
    contain a series of RGB bytes and be width*height*3 bytes long.  A buffer
    object can optionally be supplied for the image's alpha channel data, and
    it is expected to be width*height bytes long.  On Windows the RGB values
    are 'premultiplied' by the alpha values.  (The other platforms do the
    multiplication themselves.)

    Unlike `wx.ImageFromBuffer` the bitmap created with this function does not
    share the memory buffer with the buffer object.  This is because the
    native pixel buffer format varies on different platforms, and so instead
    an efficient as possible copy of the data is made from the buffer objects
    to the bitmap's native pixel buffer.  

    :see: `wx.Bitmap`, `wx.BitmapFromBufferRGBA`, `wx.ImageFromBuffer`
    """
    if alphaBuffer is not None:
        return _gdi_._BitmapFromBufferAlpha(width, height, dataBuffer, alphaBuffer)
    else:
        return _gdi_._BitmapFromBuffer(width, height, dataBuffer)
}



%newobject _BitmapFromBufferRGBA;
%inline %{
    wxBitmap* _BitmapFromBufferRGBA(int width, int height, buffer data, int DATASIZE)
    {
        if (DATASIZE != width*height*4) {
            wxPyErr_SetString(PyExc_ValueError, "Invalid data buffer size.");
            return NULL;
        }

        wxBitmap* bmp = new wxBitmap(width, height, 32);
        wxAlphaPixelData pixData(*bmp, wxPoint(0,0), wxSize(width,height));
        if (! pixData) {
            // raise an exception...
            wxPyErr_SetString(PyExc_RuntimeError,
                              "Failed to gain raw access to bitmap data.");
            return NULL;
        }
               
        pixData.UseAlpha();
        wxAlphaPixelData::Iterator p(pixData);
        for (int y=0; y<height; y++) {
            wxAlphaPixelData::Iterator rowStart = p;
            for (int x=0; x<width; x++) {
                byte a = data[3];
                p.Red()   = wxPy_premultiply(*(data++), a);
                p.Green() = wxPy_premultiply(*(data++), a);
                p.Blue()  = wxPy_premultiply(*(data++), a);
                p.Alpha() = a; data++;
                ++p; 
            }
            p = rowStart;
            p.OffsetY(pixData, 1);
        }
        return bmp;
    }        
%}

%pythoncode {
def BitmapFromBufferRGBA(width, height, dataBuffer):
    """
    Creates a `wx.Bitmap` from the data in dataBuffer.  The dataBuffer
    parameter must be a Python object that implements the buffer interface,
    such as a string, array, etc.  The dataBuffer object is expected to
    contain a series of RGBA bytes (red, green, blue and alpha) and be
    width*height*4 bytes long.  On Windows the RGB values are 'premultiplied'
    by the alpha values.  (The other platforms do the multiplication
    themselves.)

    Unlike `wx.ImageFromBuffer` the bitmap created with this function does not
    share the memory buffer with the buffer object.  This is because the
    native pixel buffer format varies on different platforms, and so instead
    an efficient as possible copy of the data is made from the buffer object
    to the bitmap's native pixel buffer. 

    :see: `wx.Bitmap`, `wx.BitmapFromBuffer`, `wx.ImageFromBuffer`
    """
    if not isinstance(dataBuffer, buffer):
        dataBuffer = buffer(dataBuffer)
    return _gdi_._BitmapFromBufferRGBA(width, height, dataBuffer)
}



//---------------------------------------------------------------------------

DocStr(wxMask,
"This class encapsulates a monochrome mask bitmap, where the masked
area is black and the unmasked area is white. When associated with a
bitmap and drawn in a device context, the unmasked area of the bitmap
will be drawn, and the masked area will not be drawn.

A mask may be associated with a `wx.Bitmap`. It is used in
`wx.DC.DrawBitmap` or `wx.DC.Blit` when the source device context is a
`wx.MemoryDC` with a `wx.Bitmap` selected into it that contains a
mask.", "");

MustHaveApp(wxMask);

class wxMask : public wxObject {
public:

    DocStr(wxMask,
           "Constructs a mask from a `wx.Bitmap` and a `wx.Colour` in that bitmap
that indicates the transparent portions of the mask.  In other words,
the pixels in ``bitmap`` that match ``colour`` will be the transparent
portions of the mask.  If no ``colour`` or an invalid ``colour`` is
passed then BLACK is used.

:see: `wx.Bitmap`, `wx.Colour`", "");
    
    %extend {
        wxMask(const wxBitmap& bitmap, const wxColour& colour = wxNullColour) {
            if ( !colour.Ok() )
                return new wxMask(bitmap, *wxBLACK);
            else
                return new wxMask(bitmap, colour);
        }
    }
    
    //~wxMask();
};

%pythoncode { MaskColour = wx._deprecated(Mask, "wx.MaskColour is deprecated, use `wx.Mask` instead.") }

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
