###############################################################################
# Name: python.py                                                             #
# Purpose: Define Python syntax for highlighting and other features           #
# Author: Cody Precord <cprecord@editra.org>                                  #
# Copyright: (c) 2007 Cody Precord <staff@editra.org>                         #
# License: wxWindows License                                                  #
###############################################################################

"""
FILE: python.py
AUTHOR: Cody Precord
@summary: Lexer configuration module for Python.

"""

__author__ = "Cody Precord <cprecord@editra.org>"
__svnid__ = "$Id$"
__revision__ = "$Revision$"

#-----------------------------------------------------------------------------#
# Dependancies
import keyword

#-----------------------------------------------------------------------------#

#---- Keyword Specifications ----#

# Indenter keywords
INDENT_KW = u"def if elif else for while class try except finally"
UNINDENT_KW = u"return raise break continue pass exit quit"

# Python Keywords
KEYWORDS = keyword.kwlist
KEYWORDS.extend(['True', 'False', 'None', 'self'])
PY_KW = (0, u" ".join(KEYWORDS))

# Highlighted builtins
try:
    import __builtin__
    BUILTINS = dir(__builtin__)
except:
    BUILTINS = list()
#BUILTINS.append('self')
BUILTINS = list(set(BUILTINS))

PY_BIN = (1, u" ".join(sorted(BUILTINS)))

#---- Syntax Style Specs ----#
SYNTAX_ITEMS = [ ('STC_P_DEFAULT', 'default_style'),
                 ('STC_P_CHARACTER', 'char_style'),
                 ('STC_P_CLASSNAME', 'class_style'),
                 ('STC_P_COMMENTBLOCK', 'comment_style'),
                 ('STC_P_COMMENTLINE', 'comment_style'),
                 ('STC_P_DECORATOR', 'decor_style'),
                 ('STC_P_DEFNAME', 'keyword3_style'),
                 ('STC_P_IDENTIFIER', 'default_style'),
                 ('STC_P_NUMBER', 'number_style'),
                 ('STC_P_OPERATOR', 'operator_style'),
                 ('STC_P_STRING', 'string_style'),
                 ('STC_P_STRINGEOL', 'stringeol_style'),
                 ('STC_P_TRIPLE', 'string_style'),
                 ('STC_P_TRIPLEDOUBLE', 'string_style'),
                 ('STC_P_WORD', 'keyword_style'),
                 ('STC_P_WORD2', 'userkw_style')]

#---- Extra Properties ----#
FOLD = ("fold", "1")
TIMMY = ("tab.timmy.whinge.level", "1") # Mark Inconsistant indentation

#-----------------------------------------------------------------------------#

#---- Required Module Functions ----#
def Keywords(lang_id=0):
    """Returns Specified Keywords List
    @param lang_id: used to select specific subset of keywords

    """
    return [PY_KW, PY_BIN]

def SyntaxSpec(lang_id=0):
    """Syntax Specifications
    @param lang_id: used for selecting a specific subset of syntax specs

    """
    return SYNTAX_ITEMS

def Properties(lang_id=0):
    """Returns a list of Extra Properties to set
    @param lang_id: used to select a specific set of properties

    """
    return [FOLD, TIMMY]

def CommentPattern(lang_id=0):
    """Returns a list of characters used to comment a block of code
    @param lang_id: used to select a specific subset of comment pattern(s)

    """
    return [u'#']

def AutoIndenter(stc, pos, ichar):
    """Auto indent python code. uses \n the text buffer will
    handle any eol character formatting.
    @param stc: EditraStyledTextCtrl
    @param pos: current carat position
    @param ichar: Indentation character
    @return: string

    """
    rtxt = u''
    line = stc.GetCurrentLine()
    text = stc.GetTextRange(stc.PositionFromLine(line), pos)

    # Ignore empty lines
    while text.isspace():
        line -= 1
        if line < 0:
            return u''
        text = stc.GetTextRange(stc.PositionFromLine(line), pos)

    indent = stc.GetLineIndentation(line)
    if ichar == u"\t":
        tabw = stc.GetTabWidth()
    else:
        tabw = stc.GetIndent()

    i_space = indent / tabw
    end_spaces = ((indent - (tabw * i_space)) * u' ')

    tokens = filter(None, text.strip().split())
    if tokens:
        if tokens[-1].endswith(u":"):
            if tokens[0].rstrip(u":") in INDENT_KW:
                i_space += 1
        elif tokens[-1].endswith(u"\\"):
            i_space += 1
        elif tokens[0] in UNINDENT_KW:
            i_space = max(i_space - 1, 0)

    return u"\n" + ichar * i_space + end_spaces

#---- End Required Module Functions ----#

#---- Syntax Modules Internal Functions ----#
def KeywordString():
    """Returns the specified Keyword String
    @note: not used by most modules

    """
    return PY_KW[1]

#---- End Syntax Modules Internal Functions ----#

#-----------------------------------------------------------------------------#
