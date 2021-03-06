///////////////////////////////////////////////////////////////////////////////
// Name:        tests/events/evthandler.cpp
// Purpose:     Test the new event types and wxEvtHandler-methods
// Author:      Peter Most
// Created:     2009-01-24
// RCS-ID:      $Id$
// Copyright:   (c) 2009 Peter Most
///////////////////////////////////////////////////////////////////////////////

// ----------------------------------------------------------------------------
// headers
// ----------------------------------------------------------------------------

#include "testprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

#include "wx/event.h"

// ----------------------------------------------------------------------------
// test events and their handlers
// ----------------------------------------------------------------------------

const wxEventType LegacyEventType = wxNewEventType();

class MyEvent;
wxDEFINE_EVENT(MyEventType, MyEvent);

class MyEvent : public wxEvent
{
public:
    MyEvent() : wxEvent(0, MyEventType) { }

    virtual wxEvent *Clone() const { return new MyEvent; }
};

typedef void (wxEvtHandler::*MyEventFunction)(MyEvent&);
#if wxEVENTS_COMPATIBILITY_2_8
    #define MyEventHandler(func) wxEVENT_HANDLER_CAST(MyEventFunction, func)
#else
    #define MyEventHandler(func) &func
#endif
#define EVT_MYEVENT(func) \
    wx__DECLARE_EVT0(MyEventType, MyEventHandler(func))

class AnotherEvent : public wxEvent
{
};

namespace
{

struct Called
{
    Called() { Reset(); }

    void Reset()
    {
        function =
        functor =
        method =
        smethod = false;
    }

    bool function,
         functor,
         method,
         smethod;
} g_called;

void GlobalOnMyEvent(MyEvent&)
{
    g_called.function = true;
}

void GlobalOnAnotherEvent(AnotherEvent&);

void GlobalOnIdle(wxIdleEvent&)
{
    g_called.function = true;
}

struct MyFunctor
{
    void operator()(MyEvent &) { g_called.functor = true; }
};

struct IdleFunctor
{
    void operator()(wxIdleEvent &) { g_called.functor = true; }
};

class MyHandler : public wxEvtHandler
{
public:
    static void StaticOnMyEvent(MyEvent &) { g_called.smethod = true; }
    static void StaticOnAnotherEvent(AnotherEvent &);
    static void StaticOnIdle(wxIdleEvent&) { g_called.smethod = true; }

    void OnMyEvent(MyEvent&) { g_called.method = true; }
    void OnEvent(wxEvent&) { g_called.method = true; }
    void OnAnotherEvent(AnotherEvent&);
    void OnIdle(wxIdleEvent&) { g_called.method = true; }
};

// we can also handle events in classes not deriving from wxEvtHandler
struct MySink
{
    void OnMyEvent(MyEvent&) { g_called.method = true; }
    void OnEvent(wxEvent&) { g_called.method = true; }
    void OnIdle(wxIdleEvent&) { g_called.method = true; }
};

// also test event table compilation
class MyClassWithEventTable : public wxEvtHandler
{
public:
    void OnMyEvent(MyEvent&) { g_called.method = true; }
    void OnEvent(wxEvent&) { g_called.method = true; }
    void OnAnotherEvent(AnotherEvent&);
    void OnIdle(wxIdleEvent&) { g_called.method = true; }

private:
    DECLARE_EVENT_TABLE()
};

BEGIN_EVENT_TABLE(MyClassWithEventTable, wxEvtHandler)
    EVT_IDLE(MyClassWithEventTable::OnIdle)

    EVT_MYEVENT(MyClassWithEventTable::OnMyEvent)
#if !wxEVENTS_COMPATIBILITY_2_8
    EVT_MYEVENT(MyClassWithEventTable::OnEvent)
#endif

    // this shouldn't compile:
    //EVT_MYEVENT(MyClassWithEventTable::OnIdle)
    //EVT_IDLE(MyClassWithEventTable::OnAnotherEvent)
END_EVENT_TABLE()

} // anonymous namespace


// --------------------------------------------------------------------------
// test class
// --------------------------------------------------------------------------

class EvtHandlerTestCase : public CppUnit::TestCase
{
public:
    EvtHandlerTestCase() {}

private:
    CPPUNIT_TEST_SUITE( EvtHandlerTestCase );
        CPPUNIT_TEST( BuiltinConnect );
        CPPUNIT_TEST( LegacyConnect );
#if !wxEVENTS_COMPATIBILITY_2_8
        CPPUNIT_TEST( BindFunction );
        CPPUNIT_TEST( BindStaticMethod );
        CPPUNIT_TEST( BindFunctor );
        CPPUNIT_TEST( BindMethod );
        CPPUNIT_TEST( BindMethodUsingBaseEvent );
        CPPUNIT_TEST( BindNonHandler );
        CPPUNIT_TEST( InvalidBind );
#endif // !wxEVENTS_COMPATIBILITY_2_8
    CPPUNIT_TEST_SUITE_END();

    void BuiltinConnect();
    void LegacyConnect();
#if !wxEVENTS_COMPATIBILITY_2_8
    void BindFunction();
    void BindStaticMethod();
    void BindFunctor();
    void BindMethod();
    void BindMethodUsingBaseEvent();
    void BindNonHandler();
    void InvalidBind();
#endif // !wxEVENTS_COMPATIBILITY_2_8


    // these member variables exceptionally don't use "m_" prefix because
    // they're used so many times
    MyHandler handler;
    MyEvent e;

    DECLARE_NO_COPY_CLASS(EvtHandlerTestCase)
};

// register in the unnamed registry so that these tests are run by default
CPPUNIT_TEST_SUITE_REGISTRATION( EvtHandlerTestCase );

// also include in it's own registry so that these tests can be run alone
CPPUNIT_TEST_SUITE_NAMED_REGISTRATION( EvtHandlerTestCase, "EvtHandlerTestCase" );

void EvtHandlerTestCase::BuiltinConnect()
{
    handler.Connect(wxEVT_IDLE, wxIdleEventHandler(MyHandler::OnIdle));
    handler.Disconnect(wxEVT_IDLE, wxIdleEventHandler(MyHandler::OnIdle));

    handler.Connect(wxEVT_IDLE, wxIdleEventHandler(MyHandler::OnIdle), NULL, &handler);
    handler.Disconnect(wxEVT_IDLE, wxIdleEventHandler(MyHandler::OnIdle), NULL, &handler);

    // using casts like this is even uglier than using wxIdleEventHandler but
    // it should still continue to work for compatibility
    handler.Connect(wxEVT_IDLE, (wxObjectEventFunction)(wxEventFunction)&MyHandler::OnIdle);
    handler.Disconnect(wxEVT_IDLE, (wxObjectEventFunction)(wxEventFunction)&MyHandler::OnIdle);

#if !wxEVENTS_COMPATIBILITY_2_8
    handler.Bind(wxEVT_IDLE, GlobalOnIdle);
    handler.Unbind(wxEVT_IDLE, GlobalOnIdle);

    IdleFunctor f;
    handler.Bind(wxEVT_IDLE, f);
    handler.Unbind(wxEVT_IDLE, f);

    handler.Bind(wxEVT_IDLE, &MyHandler::OnIdle, &handler);
    handler.Unbind(wxEVT_IDLE, &MyHandler::OnIdle, &handler);

    handler.Bind(wxEVT_IDLE, &MyHandler::StaticOnIdle);
    handler.Unbind(wxEVT_IDLE, &MyHandler::StaticOnIdle);
#endif // !wxEVENTS_COMPATIBILITY_2_8
}

void EvtHandlerTestCase::LegacyConnect()
{
    handler.Connect( LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );
    handler.Connect( 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );
    handler.Connect( 0, 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );

    handler.Disconnect( LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );
    handler.Disconnect( 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );
    handler.Disconnect( 0, 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent );


    handler.Connect( LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );
    handler.Connect( 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );
    handler.Connect( 0, 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );

    handler.Disconnect( LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );
    handler.Disconnect( 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );
    handler.Disconnect( 0, 0, LegacyEventType, (wxObjectEventFunction)&MyHandler::OnEvent, NULL, &handler );
}

#if !wxEVENTS_COMPATIBILITY_2_8

void EvtHandlerTestCase::BindFunction()
{
    // function tests
    handler.Bind( MyEventType, GlobalOnMyEvent );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.function );
    handler.Unbind( MyEventType, GlobalOnMyEvent );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.function ); // check that it was disconnected

    handler.Bind( MyEventType, GlobalOnMyEvent, 0 );
    handler.Unbind( MyEventType, GlobalOnMyEvent, 0 );

    handler.Bind( MyEventType, GlobalOnMyEvent, 0, 0 );
    handler.Unbind( MyEventType, GlobalOnMyEvent, 0, 0 );
}

void EvtHandlerTestCase::BindStaticMethod()
{
    // static method tests (this is same as functions but still test it just in
    // case we hit some strange compiler bugs)
    handler.Bind( MyEventType, &MyHandler::StaticOnMyEvent );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.smethod );
    handler.Unbind( MyEventType, &MyHandler::StaticOnMyEvent );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.smethod );

    handler.Bind( MyEventType, &MyHandler::StaticOnMyEvent, 0 );
    handler.Unbind( MyEventType, &MyHandler::StaticOnMyEvent, 0 );

    handler.Bind( MyEventType, &MyHandler::StaticOnMyEvent, 0, 0 );
    handler.Unbind( MyEventType, &MyHandler::StaticOnMyEvent, 0, 0 );
}

void EvtHandlerTestCase::BindFunctor()
{
    // generalized functor tests
    MyFunctor functor;

    handler.Bind( MyEventType, functor );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.functor );
    handler.Unbind( MyEventType, functor );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.functor );

    handler.Bind( MyEventType, functor, 0 );
    handler.Unbind( MyEventType, functor, 0 );

    handler.Bind( MyEventType, functor, 0, 0 );
    handler.Unbind( MyEventType, functor, 0, 0 );
}

void EvtHandlerTestCase::BindMethod()
{
    // class method tests
    handler.Bind( MyEventType, &MyHandler::OnMyEvent, &handler );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.method );
    handler.Unbind( MyEventType, &MyHandler::OnMyEvent, &handler );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.method );

    handler.Bind( MyEventType, &MyHandler::OnMyEvent, &handler, 0 );
    handler.Unbind( MyEventType, &MyHandler::OnMyEvent, &handler, 0 );

    handler.Bind( MyEventType, &MyHandler::OnMyEvent, &handler, 0, 0 );
    handler.Unbind( MyEventType, &MyHandler::OnMyEvent, &handler, 0, 0 );
}

void EvtHandlerTestCase::BindMethodUsingBaseEvent()
{
    // test connecting a method taking just wxEvent and not MyEvent: this
    // should work too if we don't need any MyEvent-specific information in the
    // handler
    handler.Bind( MyEventType, &MyHandler::OnEvent, &handler );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.method );
    handler.Unbind( MyEventType, &MyHandler::OnEvent, &handler );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.method );

    handler.Bind( MyEventType, &MyHandler::OnEvent, &handler, 0 );
    handler.Unbind( MyEventType, &MyHandler::OnEvent, &handler, 0 );

    handler.Bind( MyEventType, &MyHandler::OnEvent, &handler, 0, 0 );
    handler.Unbind( MyEventType, &MyHandler::OnEvent, &handler, 0, 0 );
}


void EvtHandlerTestCase::BindNonHandler()
{
    // class method tests for class not derived from wxEvtHandler
    MySink sink;

    handler.Bind( MyEventType, &MySink::OnMyEvent, &sink );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( g_called.method );
    handler.Unbind( MyEventType, &MySink::OnMyEvent, &sink );
    g_called.Reset();
    handler.ProcessEvent(e);
    CPPUNIT_ASSERT( !g_called.method );
}

void EvtHandlerTestCase::InvalidBind()
{
    // these calls shouldn't compile but we unfortunately can't check this
    // automatically, you need to uncomment them manually and test that
    // compilation does indeed fail

    //handler.Bind(MyEventType, GlobalOnAnotherEvent);
    //IdleFunctor f; handler.Bind(MyEventType, f);
    //handler.Bind(MyEventType, &MyHandler::StaticOnAnotherEvent);
    //handler.Bind(MyEventType, &MyHandler::OnAnotherEvent, &handler);

    // Test that this sample (discussed on the mailing list) doesn't compile:
    // >struct C1 : wxEvtHandler { };
    // >struct C2 : wxEvtHandler { void OnWhatever(wxEvent&) };
    // >C1 c1;
    // >c1.Connect(&C2::OnWhatever); // BOOM

    //MySink mySink;
    //MyHandler myHandler;
    //myHandler.Bind( MyEventType, &MyHandler::OnMyEvent, &mySink ); 
}

#endif // !wxEVENTS_COMPATIBILITY_2_8
