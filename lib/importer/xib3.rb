# Copyright 2014 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'importer/storyboard'

module Importer

  # Parses translatable strings from Apple Xib files (versions 3 and above),
  # generated by Xcode 5 and up.

  class Xib3 < Storyboard
    include IosCommon

    # Xpaths of strings to extract.
    XPATHS                      = [
        "//accessibility",
        "//label",
        "//segments",
        "//state[@key = 'disabled']",
        "//state[@key = 'highlighted']",
        "//state[@key = 'normal']",
        "//state[@key = 'selected']",
        "//textField"
    ]

    protected

    def import_file?(locale=nil)
      file.path =~ /#{Regexp.escape(base_rfc5646_locale)}\.lproj\/[^\/]+\.xib$/
    end

    def import_strings(receiver)
      xml = Nokogiri::XML(file.contents)
      return unless xml.root.name == 'document'

      super #TODO calls Nokogiri:XML twice
    end
  end
end
