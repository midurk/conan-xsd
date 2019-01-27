#!/usr/bin/env python
# -*- coding: utf-8 -*-

from conans import ConanFile, tools
import os


class XsdConan(ConanFile):
    name = "xsd"
    version = "4.0.0"
    description = "CodeSynthesis XSD is an open-source, cross-platform W3C XML Schema to C++ data binding compiler."

    topics = ("xml", "xsd", "xmlbinding")
    url = "https://github.com/midurk/conan-xsd"
    homepage = "https://www.codesynthesis.com/products/xsd/"
    author = "Michal Durkovic <michal.durkovic@innovatrics.com>"

    license = "GPL-2.0-only"
    exports = ["LICENSE.md"] 

    settings = "os", "arch"

    requires = (
        "xerces-c/3.2.2@mdurkovic/testing",
    )

    # Custom attributes for Bincrafters recipe conventions
    _source_subfolder = "source_subfolder"

    def source(self):
        source_url = ""
        source_sha1 = ""
        if (self.settings.os == "Linux"):
            if (self.settings.arch == "x86"):
                source_url = "https://www.codesynthesis.com/download/xsd/4.0/linux-gnu/i686/xsd-4.0.0-i686-linux-gnu.tar.bz2"
                source_sha1 = "6d244d447cc995cc7df77dcf0f015d60002782a0"
            else:
                source_url = "https://www.codesynthesis.com/download/xsd/4.0/linux-gnu/x86_64/xsd-4.0.0-x86_64-linux-gnu.tar.bz2"
                source_sha1 = "5eeb2eeca0d893949e3677bb374e7b96f19770d6"

        tools.get(source_url, sha1=source_sha1)
        extracted_dir = source_url.split("/")[-1][:-8] # after last slash '/' and remove last 8 chars '.tar.bz2'

        os.rename(extracted_dir, self._source_subfolder)


    def package(self):
        include_folder = os.path.join(self._source_subfolder, "libxsd")
        
        self.copy(pattern="LICENSE", dst="licenses", src=include_folder)
        self.copy(pattern="GPLv2", dst="licenses", src=include_folder)
        self.copy(pattern="FLOSSE", dst="licenses", src=include_folder)
     
        self.copy(pattern="*.hxx", dst="include", src=include_folder)
        self.copy(pattern="*.ixx", dst="include", src=include_folder)
        self.copy(pattern="*.txx", dst="include", src=include_folder)

        self.copy(pattern="Findxsd.cmake", dst="", src=self.source_folder)


    def package_id(self):
        self.info.header_only()
