###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_7zip_udf_code_execution_vuln_win.nasl 4694 2016-12-07 06:43:41Z antu123 $
#
# 7Zip UDF CInArchive::ReadFileItem Code Execution Vulnerability (Windows)
#
# Authors:
# Kashinath T <tkashinath@secpod.com>
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
###############################################################################

CPE = "cpe:/a:7-zip:7-zip";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.808160");
  script_version("$Revision: 4694 $");
  script_cve_id("CVE-2016-2335");
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"$Date: 2016-12-07 07:43:41 +0100 (Wed, 07 Dec 2016) $");
  script_tag(name:"creation_date", value:"2016-06-13 16:27:54 +0530 (Mon, 13 Jun 2016)");
  script_name("7Zip UDF CInArchive::ReadFileItem Code Execution Vulnerability");

  script_tag(name:"summary", value:"This host is installed with 7Zip
  and is prone to code execution vulnerability.");

  script_tag(name:"vuldetect", value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name:"insight", value:"The flaw exists due to an out of bound
  read error in the 'CInArchive::ReadFileItem method' functionality.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to cause a denial of service or code execution.

  Impact Level: Application");

  script_tag(name:"affected", value:"7Zip version 9.20 and 15.05 beta.");

  script_tag(name:"solution", value:"Upgrade to 7Zip version 16.04 or later.
  For updates refer to http://www.7-zip.org/history.txt");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"registry");

  script_xref(name : "URL" , value : "http://www.talosintel.com/reports/TALOS-2016-0094/");
  script_xref(name : "URL" , value : "http://lists.opensuse.org/opensuse-updates/2016-06/msg00004.html");

  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_category(ACT_GATHER_INFO);
  script_family("Denial of Service");
  script_dependencies("gb_7zip_detect_win.nasl");
  script_mandatory_keys("7zip/Win/Ver");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

## Variable Initialization
zipVer = "";

## Get version
if(!zipVer = get_app_version(cpe:CPE)){
  exit(0);
}

## grep for version only(incase of beta versions)
zipVer1 = eregmatch(pattern:"([0-9.]+)", string:zipVer);
if(zipVer1){
  zipVer1 = zipVer1[1];
}

if('beta' >< zipVer)
{
  if(version_is_equal(version:zipVer1, test_version:"15.05"))
  {
    VULN = TRUE;
  }
}

else if(version_is_equal(version:zipVer1, test_version:"9.20")){
   VULN = TRUE;
}

if(VULN)
{
  report = report_fixed_ver(installed_version:zipVer1, fixed_version:"16.04");
  security_message(data:report);
  exit(0);
}
