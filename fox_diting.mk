#
#	This file is partOF the OrangeFox Recovery Project
# 	Copyright (C) 2025 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the termsOF the GNU General Public License as published by
#	the Free Software Foundation, either version 3OF the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warrantyOF
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any partOF it
#


OF_MAINTAINER := @LeCmnGend

OF_ENABLE_ALL_PARTITION_TOOLS := 1
OF_WORKAROUND_BACKUP_BUG := 1
OF_USE_AIDL_BOOT_CONTROL := 1
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1
OF_FORCE_PREBUILT_KERNEL := 1
OF_NO_RELOAD_AFTER_DECRYPTION := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_ENABLE_FRP_ADDON := 1

OF_USE_LZ4_COMPRESSION := 1
OF_ENABLE_FS_COMPRESSION := 1

# Some ofox flags
BOARD_USES_AB_IMAGE := true
TW_MAX_BRIGHTNESS := 255

# Real A/B, NOT Virtual A/B
TARGET_USES_VIRTUAL_AB := false
