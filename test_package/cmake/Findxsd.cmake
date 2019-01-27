#.rst:
# FindXSD
# --------
#
# Find the XSD includes.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines :prop_tgt:`IMPORTED` target ``xsd::xsd``, if
# XSD has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   XSD_INCLUDE_DIRS   - where to find XSD.h, etc.
#   XSD_FOUND          - True if XSD found.
#
# Hints
# ^^^^^
#
# A user may set ``XSD_ROOT`` to a XSD installation root to tell this
# module where to look.

set(_XSD_SEARCHES)

# Search XSD_ROOT first if it is set.
if(XSD_ROOT)
  set(_XSD_SEARCH_ROOT PATHS ${XSD_ROOT} NO_DEFAULT_PATH)
  list(APPEND _XSD_SEARCHES _XSD_SEARCH_ROOT)
endif()

# Try each search configuration.
foreach(search ${_XSD_SEARCHES})
  find_path(XSD_INCLUDE_DIR NAMES xsd/cxx/version.hxx ${${search}} PATH_SUFFIXES include)
endforeach()
find_path(XSD_INCLUDE_DIR NAMES xsd/cxx/version.hxx PATH_SUFFIXES include)

mark_as_advanced(XSD_INCLUDE_DIR)

if(XSD_INCLUDE_DIR AND EXISTS "${XSD_INCLUDE_DIR}/xsd/cxx/version.hxx")
    file(STRINGS "${XSD_INCLUDE_DIR}/xsd/cxx/version.hxx" XSD_H REGEX "^#define XSD_STR_VERSION \"[^\"]*\"$")

    string(REGEX REPLACE "^.*XSD_STR_VERSION \"([0-9]+).*$" "\\1" XSD_VERSION_MAJOR "${XSD_H}")
    string(REGEX REPLACE "^.*XSD_STR_VERSION \"[0-9]+\\.([0-9]+).*$" "\\1" XSD_VERSION_MINOR  "${XSD_H}")
    string(REGEX REPLACE "^.*XSD_STR_VERSION \"[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" XSD_VERSION_PATCH "${XSD_H}")
    set(XSD_VERSION_STRING "${XSD_VERSION_MAJOR}.${XSD_VERSION_MINOR}.${XSD_VERSION_PATCH}")

    set(XSD_MAJOR_VERSION "${XSD_VERSION_MAJOR}")
    set(XSD_MINOR_VERSION "${XSD_VERSION_MINOR}")
    set(XSD_PATCH_VERSION "${XSD_VERSION_PATCH}")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(XSD REQUIRED_VARS XSD_INCLUDE_DIR VERSION_VAR XSD_VERSION_STRING)

if(XSD_FOUND)
    set(XSD_INCLUDE_DIRS ${XSD_INCLUDE_DIR})

    if(NOT TARGET xsd::xsd)      
      add_library(xsd::xsd INTERFACE IMPORTED)
      set_target_properties(xsd::xsd PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${XSD_INCLUDE_DIRS}")
    endif()
endif()
