###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_tigervnc_detect_win.nasl 8159 2017-12-18 15:10:39Z cfischer $
#
# TigerVNC Version Detection (Windows)
#
# Authors:
# Sooraj KS <kssooraj@secpod.com>
#
# Copyright:
# Copyright (c) 2011 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.801897");
  script_version("$Revision: 8159 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-12-18 16:10:39 +0100 (Mon, 18 Dec 2017) $");
  script_tag(name:"creation_date", value:"2011-06-13 15:28:04 +0200 (Mon, 13 Jun 2011)");
  script_tag(name:"qod_type", value:"registry");
  script_name("TigerVNC Version Detection (Windows)");

tag_summary =
"Detection of installed version of TigerVNC.

The script logs in via smb, searches for TigerVNC in the registry and
gets the version from registry.";


  script_tag(name : "summary" , value : tag_summary);

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2011 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("secpod_reg_enum.nasl", "smb_reg_service_pack.nasl");
  script_mandatory_keys("SMB/WindowsVersion", "SMB/Windows/Arch");
  script_require_ports(139, 445);
  exit(0);
}

include("smb_nt.inc");
include("secpod_smb_func.inc");
include("cpe.inc");
include("host_details.inc");

##Variable initialization
osArch = "";
key_list = "";
appName = "";
appLoc = "";
tigerVncVer = "";

osArch = get_kb_item("SMB/Windows/Arch");
if(!osArch)
{
  exit(-1);
}

## if os is 32 bit iterate over comman path
if("x86" >< osArch){
  key_list = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\";
}

## Check for 64 bit platform
else if("x64" >< osArch){
 key_list = make_list("SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\",
                      "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\");
}

foreach key (key_list)
{
  foreach item (registry_enum_keys(key:key))
  {
    appName = registry_get_sz(key:key + item, item:"DisplayName");

    # Confirm the application
    if("TigerVNC" >< appName)
    {
      tigerVncVer = registry_get_sz(key:key + item, item:"DisplayVersion");

      if(tigerVncVer)
      {
        appLoc = registry_get_sz(key:key + item, item:"InstallLocation");
        if(!appLoc){
          appLoc = "Couldn find the install location from registry";
        }
        set_kb_item(name:"TigerVNC6432/Win/Installed", value:TRUE);
        if("x64" >< osArch && "Wow6432Node" >!< key) {
          set_kb_item(name:"TigerVNC64/Win/Ver", value:tigerVncVer);
          register_and_report_cpe( app:appName, ver:tigerVncVer, base:"cpe:/a:tigervnc:tigervnc:x64:", expr:"^([0-9.]+)", insloc:appLoc );
        } else {
          set_kb_item(name:"TigerVNC/Win/Ver", value:tigerVncVer);
          register_and_report_cpe( app:appName, ver:tigerVncVer, base:"cpe:/a:tigervnc:tigervnc:", expr:"^([0-9.]+)", insloc:appLoc );
        }
      }
    }
  }
}
