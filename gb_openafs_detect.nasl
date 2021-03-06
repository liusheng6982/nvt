###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_openafs_detect.nasl 8209 2017-12-21 08:12:18Z cfischer $
#
# OpenAFS Version Detection (Windows)
#
# Authors:
# Tushar Khelge <ktushar@secpod.com>
#
# Copyright:
# Copyright (C) 2016 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
##############################################################################

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.808072");
  script_version("$Revision: 8209 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-12-21 09:12:18 +0100 (Thu, 21 Dec 2017) $");
  script_tag(name:"creation_date", value:"2016-06-08 12:16:58 +0530 (Wed, 08 Jun 2016)");
  script_name("OpenAFS Version Detection (Windows)");

  script_tag(name: "summary" , value: "Detection of installed version of
  OpenAFS.

  The script logs in via smb, searches for 'OpenAFS' in the registry and
  gets the version from registry.");

  script_tag(name:"qod_type", value:"registry");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
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
include("version_func.inc");

## variable Initialization
os_arch = "";
key = "";
afsPath = "";
afsVer = "";
afsName = "";

## Get OS Architecture
os_arch = get_kb_item("SMB/Windows/Arch");
if(!os_arch){
  exit(0);
}

## Key is same for 32 bit and 64 bit platform 
key = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\";
if(!registry_key_exists(key:key)){
  exit(0);
}

##Iterate
foreach item (registry_enum_keys(key:key))
{
  afsName = registry_get_sz(key:key + item, item:"DisplayName");

  #### Confirm Application
  if("OpenAFS" >< afsName)
  {
    afsVer = registry_get_sz(key:key + item, item:"DisplayVersion");
    afsPath = registry_get_sz(key:key + item, item:"InstallLocation");
    if(!afsPath){
      afsPath = "Couldn find the install location from registry";
    }

    if(afsVer)
    {

      set_kb_item(name:"OpenAFS/Win/Installed", value:TRUE);

      ## Register for 64 bit app on 64 bit OS
      if("64" >< os_arch) {
        set_kb_item(name:"OpenAFS/Win64/Ver", value:afsVer);
        register_and_report_cpe( app:afsName, ver:afsVer, base:"cpe:/a:openafs:openafs:x64:", expr:"^([0-9.]+)", insloc:afsPath );
      } else {
        set_kb_item(name:"OpenAFS/Win/Ver", value:afsVer);
        register_and_report_cpe( app:afsName, ver:afsVer, base:"cpe:/a:openafs:openafs:", expr:"^([0-9.]+)", insloc:afsPath );
      }
    }
    exit(0);
  }
}
