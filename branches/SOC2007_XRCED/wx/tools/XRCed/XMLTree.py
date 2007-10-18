# Name:         XMLTree.py
# Purpose:      XMLTree class
# Author:       Roman Rolinsky <rolinsky@femagsoft.com>
# Created:      31.05.2007
# RCS-ID:       $Id$

from globals import *
from model import Model
from component import Manager, Component, Container
import images

class XMLTree(wx.TreeCtrl):
    def __init__(self, parent):
        style = wx.TR_HAS_BUTTONS | wx.TR_MULTIPLE | \
                wx.TR_HIDE_ROOT | wx.TR_LINES_AT_ROOT
        wx.TreeCtrl.__init__(self, parent, style=style)

        # Color scheme
        self.SetBackgroundColour(wx.Colour(224, 248, 224))
        self.COLOUR_COMMENT  = wx.Colour(0, 0, 255)
        self.COLOUR_REF      = wx.Colour(0, 0, 128)
        self.COLOUR_HIDDEN   = wx.Colour(128, 128, 128)
        self.COLOUR_HL       = wx.Colour(255, 0, 0)
        self.COLOUR_DT       = wx.Colour(0, 0, 255)

        # Comments use italic font
        self.fontComment = wx.FFont(self.GetFont().GetPointSize(),
                                    self.GetFont().GetFamily(),
                                    wx.FONTFLAG_ITALIC)

        # Create image list
        il = wx.ImageList(16, 16, True)
        # 0 is the default image index
        il.Add(images.getTreeDefaultImage().Scale(16,16).ConvertToBitmap())
        # 1 is root
#        self.rootImage = il.Add(images.getTreeRootImage().Scale(16,16).ConvertToBitmap())
        # Loop through registered components which have images
        for component in Manager.components.values():
            for im in component.images:
                im.Id = il.Add(im.Scale(16,16).ConvertToBitmap())
        self.il = il
        self.SetImageList(il)

        self.root = self.AddRoot('XML tree') #, self.rootImage)
        self.SetItemHasChildren(self.root)
#        self.Expand(self.root)

    def Clear(self):
        '''Clear everything except the root item.'''
        self.UnselectAll()
        self.DeleteChildren(self.root)
#        self.Expand(self.root)

    # Add tree item for given parent item if node is DOM element node with
    # object/object_ref tag
    def AddNode(self, parent, node):
        # Append tree item
        try:
            comp = Manager.getNodeComp(node, None)
            className = comp.klass
        except:
            className = node.getAttribute('class')
            # Try to create some generic component on-the-fly
            attributes = []
            isContainer = False
            for n in node.childNodes:
                if is_object(n):
                    isContainer = True
                elif n.nodeType == node.ELEMENT_NODE and not n.tagName in attributes:
                    attributes.append(n.tagName)
            if isContainer:
                comp = Container(className, 'unknown', attributes)
            else:
                comp = Component(className, 'unknown', attributes)
            Manager.register(comp)
            wx.LogWarning('Unknown component class "%s", registered as generic' % className)
        item = self.AppendItem(parent, comp.getTreeText(node), 
                               image=comp.getTreeImageId(node),
                               data=wx.TreeItemData(node))
        self.SetItemStyle(item, node)
        # Try to find children objects
        if comp.isContainer:
            for n in filter(is_object, node.childNodes):
                self.AddNode(item, comp.getTreeNode(n))

    def SetItemStyle(self, item, node):
        # Different color for comments and references
        if node.tagName == 'object_ref':
            self.SetItemTextColour(item, self.COLOUR_REF)
#        if className == 'comment':
#            self.SetItemTextColour(item, self.COLOUR_COMMENT)
#            self.SetItemFont(item, self.fontComment)
#        elif treeObj.hasStyle and treeObj.params.get('hidden', False):
#            self.SetItemTextColour(item, self.COLOUR_HIDDEN)        

    def Flush(self):
        '''Update all items after changes in model.'''
        self.Clear()
        # Update root item
        self.SetPyData(self.root, Model.mainNode)
        # (first node is test node)
        for n in filter(is_object, Model.mainNode.childNodes[1:]):
            self.AddNode(self.root, n)

    def FlushSubtree(self, item, node):
        '''Update all items after changes in model.'''
        if item == self.root:
            self.Flush()
            return
        self.DeleteChildren(item)
        className = node.getAttribute('class')
        try:
            comp = Manager.components[className]
        except:
            # Flush completely if unknown
            self.Flush()
            return
        for n in filter(is_object, node.childNodes):
            self.AddNode(item, comp.getTreeNode(n))

    def ExpandAll(self):
        i, cookie = self.GetFirstChild(self.root)
        while i:
            self.ExpandAllChildren(i)
            i, cookie = self.GetNextChild(self.root, cookie)

    def CollapseAll(self):
        i, cookie = self.GetFirstChild(self.root)
        while i:
            self.CollapseAllChildren(i)
            i, cookie = self.GetNextChild(self.root, cookie)

    # Override to use same form as InsertItem
    def InsertItemBefore(self, parent, next, label, image=-1, data=None):
        prev = self.GetPrevSibling(next)
        if prev:
            return self.InsertItem(parent, prev, label, image, data=data)
        else:
            return self.PrependItem(parent, label, image, data=data)

    def GetSelection(self):
        if self.GetSelections():
            return self.GetSelections()[-1]
        else: return None

    # Return item index in parent
    def ItemIndex(self, item):
        n = 0                           # index of sibling
        prev = self.GetPrevSibling(item)
        while prev.IsOk():
            prev = self.GetPrevSibling(prev)
            n += 1
        return n

    # Full tree index of an item - list of positions
    def ItemFullIndex(self, item):
        if not item.IsOk(): return None
        l = []
        while item != self.root:
            l.insert(0, self.ItemIndex(item))
            item = self.GetItemParent(item)
        return l

    # Get item position from full index
    def ItemAtFullIndex(self, index):
        if index is None: return wx.TreeItemId()
        item = self.root
        for i in index:
            item = self.GetFirstChild(item)[0]
            for k in range(i): item = self.GetNextSibling(item)
        return item

    # Get expanded state of all items
    def GetFullState(self, item=None):
        if not item: item = self.root
        states = []
        item = self.GetFirstChild(item)[0]
        while item:
            if self.ItemHasChildren(item):
                state = self.IsExpanded(item)
                states.append(self.IsExpanded(item))
                if state: states.extend(self.GetFullState(item))
            item = self.GetNextSibling(item)
        return states

    # Set expanded state of all items
    def SetFullState(self, states, item=None):
        if not item:
            item = self.root
            states = states[:]
        item = self.GetFirstChild(item)[0]
        while item:
            if self.ItemHasChildren(item):
                state = states.pop(0)
                if state: self.Expand(item)
                else: self.Collapse(item)
                if state: self.SetFullState(states, item)
            item = self.GetNextSibling(item)

    # Fix for broken

    def ItemHasChildren(self, item):
        return self.GetChildrenCount(item)

    if wx.Platform == '__WXMSW__':
        def UnselectAll(self):
            print self.GetSelections()
            wx.TreeCtrl.UnselectAll(self)
            print self.GetSelections()
        
        def SelectItem(self, item):
            print 'SelectItem',self.GetSelections()
            wx.TreeCtrl.SelectItem(self, item)
            evt = wx.TreeEvent(wx.EVT_TREE_SEL_CHANGED.typeId, self, item)
            wx.PostEvent(self, evt)
