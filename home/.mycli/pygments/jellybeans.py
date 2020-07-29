# -*- coding: utf-8 -*-
"""
    Jellybeans Colorscheme
    ~~~~~~~~~~~~~~~~~~~~~~

    Inspired by
    https://github.com/StylishThemes/Syntax-Themes/blob/master/pygments/py/jellybeans.py
"""
from pygments.style import Style
from pygments.token import Token, Keyword, Number, Comment, Name, Operator, String, Generic

class JellybeansStyle(Style):

    background_color = '#161616'
    default_style = ""
    styles = {
        Token:              'noinherit #e8e8d3',
        Generic.Traceback:  'noinherit bg:#902020',
        Generic.Heading:    '#70b950 bold',
        Comment.Preproc:    'noinherit #8fbfdc',
        Name.Constant:      'noinherit #cf6a4c',
        Generic.Subheading: '#70b950 bold',
        Keyword:            'noinherit #8197bf',
        Name.Tag:           'noinherit #8197bf',
        Generic.Inserted:   'noinherit bg:#032218',
        Keyword.Type:       'noinherit #ffb964',
        Name.Variable:      'noinherit #c6b6ee',
        Generic.Deleted:    'noinherit #220000',
        Number:             'noinherit #cf6a4c',
        Operator.Word:      'noinherit #e8e8d3',
        Name.Function:      'noinherit #fad07a',
        Name.Entity:        'noinherit #799d6a',
        Name.Exception:     'noinherit #ffb964',
        Comment:            'noinherit #888888 italic',
        Generic.Output:     'noinherit #808080',
        Name.Attribute:     'noinherit #fad07a',
        String:             'noinherit #99ad6a',
        Name.Label:         'noinherit #ffb964',
        Generic.Error:      'noinherit bg:#902020',
    }
