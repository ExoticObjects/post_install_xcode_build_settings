
platform :ios, '7.0'

pod 'handlebars-objc', '~> 1.3.0'

#Useful documentation here: http://www.rubydoc.info/github/CocoaPods/Xcodeproj/Xcodeproj/Project/Object/XCBuildConfiguration
post_install do |installer|

    def modify_build_settings(project, filename, build_settings_key, new_compiler_flags)

        files = project.files.select { |file|       #find all PBXFileReference objects for the project
            file.display_name == filename
        }

		hb_xcconfig = files.first                       #There should be only one file that we need, with a path and a uuid

		project.native_targets.map { |native_target|    #Loop through project 'native_targets' to get XCBuildConfiguration files

			configs = Array.new
			for config in native_target.build_configuration_list.build_configurations

				if config.base_configuration_reference.uuid == hb_xcconfig.uuid   #If XCBuildConfiguration.uuid matches uuid of hb_xcconfig above, we want it
					configs.push(config)
				end
      end

      configs.each { |config|                       #Set flags on XCBuildConfiguration build_settings dictionary. In this case we want OTHER_CFLAGS
        config.build_settings[build_settings_key] = new_compiler_flags.split(' ')
      }

			# puts 'configs: ' + configs.inspect
		}

    end

    HANDLEBARS_FLAGS = "-fno-objc-arc -w -Xanalyzer -analyzer-disable-checker -Xanalyzer deadcode"
    modify_build_settings(installer.project, "Pods-handlebars-objc-Private.xcconfig", "OTHER_CFLAGS", HANDLEBARS_FLAGS)

end