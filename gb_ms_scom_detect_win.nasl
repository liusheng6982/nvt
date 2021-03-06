###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_scom_detect_win.nasl 9584 2018-04-24 10:34:07Z jschulte $
#
# Microsoft System Center Operations Manager Detection (Windows)
#
# Authors:
# Rachana Shetty <srachana@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_summary = "Detection of installed version of Microsoft System
  Center Operations Manager.

The script logs in via smb, searches for Microsoft System Center Operations
Manager in the registry and gets the version from 'ServerVersion' string in
registry";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.803096";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 9584 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"last_modification", value:"$Date: 2018-04-24 12:34:07 +0200 (Tue, 24 Apr 2018) $");
  script_tag(name:"creation_date", value:"2013-01-09 08:54:53 +0530 (Wed, 09 Jan 2013)");
  script_name("Microsoft System Center Operations Manager Detection (Windows)");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("secpod_reg_enum.nasl");
  script_mandatory_keys("SMB/WindowsVersion");
  script_require_ports(139, 445);
  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}

include("cpe.inc");
include("host_details.inc");
include("smb_nt.inc");

## Variable Initialization
scomKey = "";
scomVer = "";
scomName = "";
scomPath = "";
baseVers = "";
scomDetails = "";
scom_newkey = "";
cpe = "";

## Confirm target is Windows
if(!get_kb_item("SMB/WindowsVersion")){
  exit(0);
}

## Check if System Center Operations Manager is installed
scomKey = "SOFTWARE\Microsoft\Microsoft Operations Manager\";
if(!registry_key_exists(key:scomKey)){
  exit(0);
}

## Iterate over possible versions to get version
## Can be Updated for later versions
baseVers =  make_list("1.0", "2.0", "3.0");

foreach basever (baseVers)
{
  scom_newkey = scomKey + basever + "\Setup";
  scomName = registry_get_sz(key: scom_newkey, item:"Product");
  if(!scomName){
    continue;
  }

  if("System Center Operations Manager" >< scomName)
  {
    scomVer = registry_get_sz(key:scom_newkey, item:"ServerVersion");
    if(scomVer)
    {
      ## Get the installation path
      scomPath = registry_get_sz(key:scom_newkey, item:"InstallDirectory");
      if(!scomPath){
        scomPath = "Could not find the install location from registry";
      }

      scomDetails = scomName + " Server Version " + scomVer;

      ## Set the KBs item
      set_kb_item(name:"MS/SCOM/Ver", value:scomDetails);
      set_kb_item(name:"MS/SCOM/Path", value:scomPath);

      cpe = build_cpe(value:scomVer, exp:"^([0-9.]+)",
                           base:"cpe:/a:microsoft:system_center_operations_manager:");

      if(!cpe){
        cpe = "cpe:/a:microsoft:system_center_operations_manager";
      }

      register_product(cpe:cpe, location:scomPath);

      log_message(data: build_detection_report(app: scomName,
                                              version:scomVer, install:scomPath, cpe:cpe,
                                              concluded: scomDetails));
      exit(0);
    }
  }
}
