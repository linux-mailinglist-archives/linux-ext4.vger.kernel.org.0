Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA067694A
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjAUUgv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjAUUgo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DDD28D3B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5405B60B67
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C1C433A1
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333399;
        bh=AgmHiIs2J6FuFyZRjrQINs9UznUsQbN9FZ8mbWSnQac=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LQoRe2SKGeBgIKTqP51sQMiHBPWICKm8rCclnmKFTrsMY06gf2PoX5tkVqHbXavcz
         G/8RkAEVlbqJ4Qd6NRz8SYUN4hZ9t0+7PMhH6G0lw7Qg0j5EPdbW0KbWbmtnkrHmAn
         tP4aeo6C/iEcuiKLmXuBSO+UPsIAPTAFO0I/ugnFRmlcB/jafh9dCEUgfZ3e91UkuF
         o8/xeTaWVgYY5jYFCzeKHTHLbeviecJ41n87B0AIegiY1Ojw7f4bsmz5Rux6IsxiBO
         1h6oNJ+9/nzjdMnxccAzKNsy1Gug5QzUJKyDUD2G8YkWgpLvKS8QgGeX90CKX+BG0D
         gNuGgM92u4sOw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 05/38] config/install-sh: update to latest version
Date:   Sat, 21 Jan 2023 12:31:57 -0800
Message-Id: <20230121203230.27624-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The version of install-sh in the source tree is extremely old and
doesn't work when passed multiple path arguments, which breaks
'make install' on macOS.

Therefore, delete this file and run 'autoreconf -i' to update it to the
latest version.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 config/install-sh | 683 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 493 insertions(+), 190 deletions(-)

diff --git a/config/install-sh b/config/install-sh
index 89fc9b098..ec298b537 100755
--- a/config/install-sh
+++ b/config/install-sh
@@ -1,238 +1,541 @@
-#! /bin/sh
-#
+#!/bin/sh
 # install - install a program, script, or datafile
-# This comes from X11R5.
+
+scriptversion=2020-11-14.01; # UTC
+
+# This originates from X11R5 (mit/util/scripts/install.sh), which was
+# later released in X11R6 (xc/config/util/install.sh) with the
+# following copyright and license.
+#
+# Copyright (C) 1994 X Consortium
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to
+# deal in the Software without restriction, including without limitation the
+# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+# sell copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+# X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNEC-
+# TION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+#
+# Except as contained in this notice, the name of the X Consortium shall not
+# be used in advertising or otherwise to promote the sale, use or other deal-
+# ings in this Software without prior written authorization from the X Consor-
+# tium.
+#
+#
+# FSF changes to this file are in the public domain.
 #
 # Calling this script install-sh is preferred over install.sh, to prevent
-# `make' implicit rules from creating a file called install from it
+# 'make' implicit rules from creating a file called install from it
 # when there is no Makefile.
 #
 # This script is compatible with the BSD install script, but was written
 # from scratch.
-#
 
+tab='	'
+nl='
+'
+IFS=" $tab$nl"
+
+# Set DOITPROG to "echo" to test this script.
+
+doit=${DOITPROG-}
+doit_exec=${doit:-exec}
 
-# set DOITPROG to echo to test this script
+# Put in absolute file names if you don't have them in your path;
+# or use environment vars.
 
-# Don't use :- since 4.3BSD and earlier shells don't like it.
-doit="${DOITPROG-}"
+chgrpprog=${CHGRPPROG-chgrp}
+chmodprog=${CHMODPROG-chmod}
+chownprog=${CHOWNPROG-chown}
+cmpprog=${CMPPROG-cmp}
+cpprog=${CPPROG-cp}
+mkdirprog=${MKDIRPROG-mkdir}
+mvprog=${MVPROG-mv}
+rmprog=${RMPROG-rm}
+stripprog=${STRIPPROG-strip}
 
+posix_mkdir=
 
-# put in absolute paths if you don't have them in your path; or use env. vars.
+# Desired mode of installed file.
+mode=0755
 
-mvprog="${MVPROG-mv}"
-cpprog="${CPPROG-cp}"
-chmodprog="${CHMODPROG-chmod}"
-chownprog="${CHOWNPROG-chown}"
-chgrpprog="${CHGRPPROG-chgrp}"
-stripprog="${STRIPPROG-strip}"
-rmprog="${RMPROG-rm}"
-mkdirprog="${MKDIRPROG-mkdir}"
+# Create dirs (including intermediate dirs) using mode 755.
+# This is like GNU 'install' as of coreutils 8.32 (2020).
+mkdir_umask=22
 
-tranformbasename=""
-transform_arg=""
-instcmd="$mvprog"
-chmodcmd="$chmodprog 0755"
-chowncmd=""
-chgrpcmd=""
-stripcmd=""
+backupsuffix=
+chgrpcmd=
+chmodcmd=$chmodprog
+chowncmd=
+mvcmd=$mvprog
 rmcmd="$rmprog -f"
-mvcmd="$mvprog"
-src=""
-dst=""
-dir_arg=""
-
-while [ x"$1" != x ]; do
-    case $1 in
-	-c) instcmd="$cpprog"
-	    shift
-	    continue;;
-
-	-d) dir_arg=true
-	    shift
-	    continue;;
-
-	-m) chmodcmd="$chmodprog $2"
-	    shift
-	    shift
-	    continue;;
-
-	-o) chowncmd="$chownprog $2"
-	    shift
-	    shift
-	    continue;;
-
-	-g) chgrpcmd="$chgrpprog $2"
-	    shift
-	    shift
-	    continue;;
-
-	-s) stripcmd="$stripprog"
-	    shift
-	    continue;;
-
-	-t=*) transformarg=`echo $1 | sed 's/-t=//'`
-	    shift
-	    continue;;
-
-	-b=*) transformbasename=`echo $1 | sed 's/-b=//'`
-	    shift
-	    continue;;
-
-	*)  if [ x"$src" = x ]
-	    then
-		src=$1
-	    else
-		# this colon is to work around a 386BSD /bin/sh bug
-		:
-		dst=$1
-	    fi
-	    shift
-	    continue;;
-    esac
-done
+stripcmd=
 
-if [ x"$src" = x ]
-then
-	echo "install:	no input file specified"
-	exit 1
-else
-	true
-fi
+src=
+dst=
+dir_arg=
+dst_arg=
 
-if [ x"$dir_arg" != x ]; then
-	dst=$src
-	src=""
-	
-	if [ -d $dst ]; then
-		instcmd=:
-	else
-		instcmd=mkdir
-	fi
-else
+copy_on_change=false
+is_target_a_directory=possibly
 
-# Waiting for this to be detected by the "$instcmd $src $dsttmp" command
-# might cause directories to be created, which would be especially bad 
-# if $src (and thus $dsttmp) contains '*'.
+usage="\
+Usage: $0 [OPTION]... [-T] SRCFILE DSTFILE
+   or: $0 [OPTION]... SRCFILES... DIRECTORY
+   or: $0 [OPTION]... -t DIRECTORY SRCFILES...
+   or: $0 [OPTION]... -d DIRECTORIES...
 
-	if [ -f $src -o -d $src ]
-	then
-		true
-	else
-		echo "install:  $src does not exist"
-		exit 1
-	fi
-	
-	if [ x"$dst" = x ]
-	then
-		echo "install:	no destination specified"
-		exit 1
-	else
-		true
-	fi
+In the 1st form, copy SRCFILE to DSTFILE.
+In the 2nd and 3rd, copy all SRCFILES to DIRECTORY.
+In the 4th, create DIRECTORIES.
 
-# If destination is a directory, append the input filename; if your system
-# does not like double slashes in filenames, you may need to add some logic
+Options:
+     --help     display this help and exit.
+     --version  display version info and exit.
 
-	if [ -d $dst ]
-	then
-		dst="$dst"/`basename $src`
-	else
-		true
-	fi
-fi
+  -c            (ignored)
+  -C            install only if different (preserve data modification time)
+  -d            create directories instead of installing files.
+  -g GROUP      $chgrpprog installed files to GROUP.
+  -m MODE       $chmodprog installed files to MODE.
+  -o USER       $chownprog installed files to USER.
+  -p            pass -p to $cpprog.
+  -s            $stripprog installed files.
+  -S SUFFIX     attempt to back up existing files, with suffix SUFFIX.
+  -t DIRECTORY  install into DIRECTORY.
+  -T            report an error if DSTFILE is a directory.
 
-## this sed command emulates the dirname command
-dstdir=`echo $dst | sed -e 's,[^/]*$,,;s,/$,,;s,^$,.,'`
+Environment variables override the default commands:
+  CHGRPPROG CHMODPROG CHOWNPROG CMPPROG CPPROG MKDIRPROG MVPROG
+  RMPROG STRIPPROG
 
-# Make sure that the destination directory exists.
-#  this part is taken from Noah Friedman's mkinstalldirs script
+By default, rm is invoked with -f; when overridden with RMPROG,
+it's up to you to specify -f if you want it.
 
-# Skip lots of stat calls in the usual case.
-if [ ! -d "$dstdir" ]; then
-defaultIFS='	
-'
-IFS="${IFS-${defaultIFS}}"
+If -S is not specified, no backups are attempted.
 
-oIFS="${IFS}"
-# Some sh's can't handle IFS=/ for some reason.
-IFS='%'
-set - `echo ${dstdir} | sed -e 's@/@%@g' -e 's@^%@/@'`
-IFS="${oIFS}"
+Email bug reports to bug-automake@gnu.org.
+Automake home page: https://www.gnu.org/software/automake/
+"
 
-pathcomp=''
+while test $# -ne 0; do
+  case $1 in
+    -c) ;;
 
-while [ $# -ne 0 ] ; do
-	pathcomp="${pathcomp}${1}"
-	shift
+    -C) copy_on_change=true;;
 
-	if [ ! -d "${pathcomp}" ] ;
-        then
-		$mkdirprog "${pathcomp}"
-	else
-		true
-	fi
+    -d) dir_arg=true;;
 
-	pathcomp="${pathcomp}/"
-done
-fi
+    -g) chgrpcmd="$chgrpprog $2"
+        shift;;
 
-if [ x"$dir_arg" != x ]
-then
-	$doit $instcmd $dst &&
+    --help) echo "$usage"; exit $?;;
 
-	if [ x"$chowncmd" != x ]; then $doit $chowncmd $dst; else true ; fi &&
-	if [ x"$chgrpcmd" != x ]; then $doit $chgrpcmd $dst; else true ; fi &&
-	if [ x"$stripcmd" != x ]; then $doit $stripcmd $dst; else true ; fi &&
-	if [ x"$chmodcmd" != x ]; then $doit $chmodcmd $dst; else true ; fi
-else
+    -m) mode=$2
+        case $mode in
+          *' '* | *"$tab"* | *"$nl"* | *'*'* | *'?'* | *'['*)
+            echo "$0: invalid mode: $mode" >&2
+            exit 1;;
+        esac
+        shift;;
 
-# If we're going to rename the final executable, determine the name now.
+    -o) chowncmd="$chownprog $2"
+        shift;;
 
-	if [ x"$transformarg" = x ] 
-	then
-		dstfile=`basename $dst`
-	else
-		dstfile=`basename $dst $transformbasename | 
-			sed $transformarg`$transformbasename
-	fi
+    -p) cpprog="$cpprog -p";;
 
-# don't allow the sed command to completely eliminate the filename
+    -s) stripcmd=$stripprog;;
 
-	if [ x"$dstfile" = x ] 
-	then
-		dstfile=`basename $dst`
-	else
-		true
-	fi
+    -S) backupsuffix="$2"
+        shift;;
 
-# Make a temp file name in the proper directory.
+    -t)
+        is_target_a_directory=always
+        dst_arg=$2
+        # Protect names problematic for 'test' and other utilities.
+        case $dst_arg in
+          -* | [=\(\)!]) dst_arg=./$dst_arg;;
+        esac
+        shift;;
 
-	dsttmp=$dstdir/#inst.$$#
+    -T) is_target_a_directory=never;;
 
-# Move or copy the file name to the temp name
+    --version) echo "$0 $scriptversion"; exit $?;;
 
-	$doit $instcmd $src $dsttmp &&
+    --) shift
+        break;;
 
-	trap "rm -f ${dsttmp}" 0 &&
+    -*) echo "$0: invalid option: $1" >&2
+        exit 1;;
 
-# and set any options; do chmod last to preserve setuid bits
+    *)  break;;
+  esac
+  shift
+done
 
-# If any of these fail, we abort the whole thing.  If we want to
-# ignore errors from any of these, just make sure not to ignore
-# errors from the above "$doit $instcmd $src $dsttmp" command.
+# We allow the use of options -d and -T together, by making -d
+# take the precedence; this is for compatibility with GNU install.
 
-	if [ x"$chowncmd" != x ]; then $doit $chowncmd $dsttmp; else true;fi &&
-	if [ x"$chgrpcmd" != x ]; then $doit $chgrpcmd $dsttmp; else true;fi &&
-	if [ x"$stripcmd" != x ]; then $doit $stripcmd $dsttmp; else true;fi &&
-	if [ x"$chmodcmd" != x ]; then $doit $chmodcmd $dsttmp; else true;fi &&
+if test -n "$dir_arg"; then
+  if test -n "$dst_arg"; then
+    echo "$0: target directory not allowed when installing a directory." >&2
+    exit 1
+  fi
+fi
 
-# Now rename the file to the real destination.
+if test $# -ne 0 && test -z "$dir_arg$dst_arg"; then
+  # When -d is used, all remaining arguments are directories to create.
+  # When -t is used, the destination is already specified.
+  # Otherwise, the last argument is the destination.  Remove it from $@.
+  for arg
+  do
+    if test -n "$dst_arg"; then
+      # $@ is not empty: it contains at least $arg.
+      set fnord "$@" "$dst_arg"
+      shift # fnord
+    fi
+    shift # arg
+    dst_arg=$arg
+    # Protect names problematic for 'test' and other utilities.
+    case $dst_arg in
+      -* | [=\(\)!]) dst_arg=./$dst_arg;;
+    esac
+  done
+fi
 
-	$doit $rmcmd -f $dstdir/$dstfile &&
-	$doit $mvcmd $dsttmp $dstdir/$dstfile 
+if test $# -eq 0; then
+  if test -z "$dir_arg"; then
+    echo "$0: no input file specified." >&2
+    exit 1
+  fi
+  # It's OK to call 'install-sh -d' without argument.
+  # This can happen when creating conditional directories.
+  exit 0
+fi
 
-fi &&
+if test -z "$dir_arg"; then
+  if test $# -gt 1 || test "$is_target_a_directory" = always; then
+    if test ! -d "$dst_arg"; then
+      echo "$0: $dst_arg: Is not a directory." >&2
+      exit 1
+    fi
+  fi
+fi
+
+if test -z "$dir_arg"; then
+  do_exit='(exit $ret); exit $ret'
+  trap "ret=129; $do_exit" 1
+  trap "ret=130; $do_exit" 2
+  trap "ret=141; $do_exit" 13
+  trap "ret=143; $do_exit" 15
+
+  # Set umask so as not to create temps with too-generous modes.
+  # However, 'strip' requires both read and write access to temps.
+  case $mode in
+    # Optimize common cases.
+    *644) cp_umask=133;;
+    *755) cp_umask=22;;
+
+    *[0-7])
+      if test -z "$stripcmd"; then
+        u_plus_rw=
+      else
+        u_plus_rw='% 200'
+      fi
+      cp_umask=`expr '(' 777 - $mode % 1000 ')' $u_plus_rw`;;
+    *)
+      if test -z "$stripcmd"; then
+        u_plus_rw=
+      else
+        u_plus_rw=,u+rw
+      fi
+      cp_umask=$mode$u_plus_rw;;
+  esac
+fi
 
+for src
+do
+  # Protect names problematic for 'test' and other utilities.
+  case $src in
+    -* | [=\(\)!]) src=./$src;;
+  esac
+
+  if test -n "$dir_arg"; then
+    dst=$src
+    dstdir=$dst
+    test -d "$dstdir"
+    dstdir_status=$?
+    # Don't chown directories that already exist.
+    if test $dstdir_status = 0; then
+      chowncmd=""
+    fi
+  else
+
+    # Waiting for this to be detected by the "$cpprog $src $dsttmp" command
+    # might cause directories to be created, which would be especially bad
+    # if $src (and thus $dsttmp) contains '*'.
+    if test ! -f "$src" && test ! -d "$src"; then
+      echo "$0: $src does not exist." >&2
+      exit 1
+    fi
+
+    if test -z "$dst_arg"; then
+      echo "$0: no destination specified." >&2
+      exit 1
+    fi
+    dst=$dst_arg
+
+    # If destination is a directory, append the input filename.
+    if test -d "$dst"; then
+      if test "$is_target_a_directory" = never; then
+        echo "$0: $dst_arg: Is a directory" >&2
+        exit 1
+      fi
+      dstdir=$dst
+      dstbase=`basename "$src"`
+      case $dst in
+	*/) dst=$dst$dstbase;;
+	*)  dst=$dst/$dstbase;;
+      esac
+      dstdir_status=0
+    else
+      dstdir=`dirname "$dst"`
+      test -d "$dstdir"
+      dstdir_status=$?
+    fi
+  fi
+
+  case $dstdir in
+    */) dstdirslash=$dstdir;;
+    *)  dstdirslash=$dstdir/;;
+  esac
+
+  obsolete_mkdir_used=false
+
+  if test $dstdir_status != 0; then
+    case $posix_mkdir in
+      '')
+        # With -d, create the new directory with the user-specified mode.
+        # Otherwise, rely on $mkdir_umask.
+        if test -n "$dir_arg"; then
+          mkdir_mode=-m$mode
+        else
+          mkdir_mode=
+        fi
+
+        posix_mkdir=false
+	# The $RANDOM variable is not portable (e.g., dash).  Use it
+	# here however when possible just to lower collision chance.
+	tmpdir=${TMPDIR-/tmp}/ins$RANDOM-$$
+
+	trap '
+	  ret=$?
+	  rmdir "$tmpdir/a/b" "$tmpdir/a" "$tmpdir" 2>/dev/null
+	  exit $ret
+	' 0
+
+	# Because "mkdir -p" follows existing symlinks and we likely work
+	# directly in world-writeable /tmp, make sure that the '$tmpdir'
+	# directory is successfully created first before we actually test
+	# 'mkdir -p'.
+	if (umask $mkdir_umask &&
+	    $mkdirprog $mkdir_mode "$tmpdir" &&
+	    exec $mkdirprog $mkdir_mode -p -- "$tmpdir/a/b") >/dev/null 2>&1
+	then
+	  if test -z "$dir_arg" || {
+	       # Check for POSIX incompatibilities with -m.
+	       # HP-UX 11.23 and IRIX 6.5 mkdir -m -p sets group- or
+	       # other-writable bit of parent directory when it shouldn't.
+	       # FreeBSD 6.1 mkdir -m -p sets mode of existing directory.
+	       test_tmpdir="$tmpdir/a"
+	       ls_ld_tmpdir=`ls -ld "$test_tmpdir"`
+	       case $ls_ld_tmpdir in
+		 d????-?r-*) different_mode=700;;
+		 d????-?--*) different_mode=755;;
+		 *) false;;
+	       esac &&
+	       $mkdirprog -m$different_mode -p -- "$test_tmpdir" && {
+		 ls_ld_tmpdir_1=`ls -ld "$test_tmpdir"`
+		 test "$ls_ld_tmpdir" = "$ls_ld_tmpdir_1"
+	       }
+	     }
+	  then posix_mkdir=:
+	  fi
+	  rmdir "$tmpdir/a/b" "$tmpdir/a" "$tmpdir"
+	else
+	  # Remove any dirs left behind by ancient mkdir implementations.
+	  rmdir ./$mkdir_mode ./-p ./-- "$tmpdir" 2>/dev/null
+	fi
+	trap '' 0;;
+    esac
+
+    if
+      $posix_mkdir && (
+        umask $mkdir_umask &&
+        $doit_exec $mkdirprog $mkdir_mode -p -- "$dstdir"
+      )
+    then :
+    else
+
+      # mkdir does not conform to POSIX,
+      # or it failed possibly due to a race condition.  Create the
+      # directory the slow way, step by step, checking for races as we go.
+
+      case $dstdir in
+        /*) prefix='/';;
+        [-=\(\)!]*) prefix='./';;
+        *)  prefix='';;
+      esac
+
+      oIFS=$IFS
+      IFS=/
+      set -f
+      set fnord $dstdir
+      shift
+      set +f
+      IFS=$oIFS
+
+      prefixes=
+
+      for d
+      do
+        test X"$d" = X && continue
+
+        prefix=$prefix$d
+        if test -d "$prefix"; then
+          prefixes=
+        else
+          if $posix_mkdir; then
+            (umask $mkdir_umask &&
+             $doit_exec $mkdirprog $mkdir_mode -p -- "$dstdir") && break
+            # Don't fail if two instances are running concurrently.
+            test -d "$prefix" || exit 1
+          else
+            case $prefix in
+              *\'*) qprefix=`echo "$prefix" | sed "s/'/'\\\\\\\\''/g"`;;
+              *) qprefix=$prefix;;
+            esac
+            prefixes="$prefixes '$qprefix'"
+          fi
+        fi
+        prefix=$prefix/
+      done
+
+      if test -n "$prefixes"; then
+        # Don't fail if two instances are running concurrently.
+        (umask $mkdir_umask &&
+         eval "\$doit_exec \$mkdirprog $prefixes") ||
+          test -d "$dstdir" || exit 1
+        obsolete_mkdir_used=true
+      fi
+    fi
+  fi
+
+  if test -n "$dir_arg"; then
+    { test -z "$chowncmd" || $doit $chowncmd "$dst"; } &&
+    { test -z "$chgrpcmd" || $doit $chgrpcmd "$dst"; } &&
+    { test "$obsolete_mkdir_used$chowncmd$chgrpcmd" = false ||
+      test -z "$chmodcmd" || $doit $chmodcmd $mode "$dst"; } || exit 1
+  else
+
+    # Make a couple of temp file names in the proper directory.
+    dsttmp=${dstdirslash}_inst.$$_
+    rmtmp=${dstdirslash}_rm.$$_
+
+    # Trap to clean up those temp files at exit.
+    trap 'ret=$?; rm -f "$dsttmp" "$rmtmp" && exit $ret' 0
+
+    # Copy the file name to the temp name.
+    (umask $cp_umask &&
+     { test -z "$stripcmd" || {
+	 # Create $dsttmp read-write so that cp doesn't create it read-only,
+	 # which would cause strip to fail.
+	 if test -z "$doit"; then
+	   : >"$dsttmp" # No need to fork-exec 'touch'.
+	 else
+	   $doit touch "$dsttmp"
+	 fi
+       }
+     } &&
+     $doit_exec $cpprog "$src" "$dsttmp") &&
+
+    # and set any options; do chmod last to preserve setuid bits.
+    #
+    # If any of these fail, we abort the whole thing.  If we want to
+    # ignore errors from any of these, just make sure not to ignore
+    # errors from the above "$doit $cpprog $src $dsttmp" command.
+    #
+    { test -z "$chowncmd" || $doit $chowncmd "$dsttmp"; } &&
+    { test -z "$chgrpcmd" || $doit $chgrpcmd "$dsttmp"; } &&
+    { test -z "$stripcmd" || $doit $stripcmd "$dsttmp"; } &&
+    { test -z "$chmodcmd" || $doit $chmodcmd $mode "$dsttmp"; } &&
+
+    # If -C, don't bother to copy if it wouldn't change the file.
+    if $copy_on_change &&
+       old=`LC_ALL=C ls -dlL "$dst"     2>/dev/null` &&
+       new=`LC_ALL=C ls -dlL "$dsttmp"  2>/dev/null` &&
+       set -f &&
+       set X $old && old=:$2:$4:$5:$6 &&
+       set X $new && new=:$2:$4:$5:$6 &&
+       set +f &&
+       test "$old" = "$new" &&
+       $cmpprog "$dst" "$dsttmp" >/dev/null 2>&1
+    then
+      rm -f "$dsttmp"
+    else
+      # If $backupsuffix is set, and the file being installed
+      # already exists, attempt a backup.  Don't worry if it fails,
+      # e.g., if mv doesn't support -f.
+      if test -n "$backupsuffix" && test -f "$dst"; then
+        $doit $mvcmd -f "$dst" "$dst$backupsuffix" 2>/dev/null
+      fi
+
+      # Rename the file to the real destination.
+      $doit $mvcmd -f "$dsttmp" "$dst" 2>/dev/null ||
+
+      # The rename failed, perhaps because mv can't rename something else
+      # to itself, or perhaps because mv is so ancient that it does not
+      # support -f.
+      {
+        # Now remove or move aside any old file at destination location.
+        # We try this two ways since rm can't unlink itself on some
+        # systems and the destination file might be busy for other
+        # reasons.  In this case, the final cleanup might fail but the new
+        # file should still install successfully.
+        {
+          test ! -f "$dst" ||
+          $doit $rmcmd "$dst" 2>/dev/null ||
+          { $doit $mvcmd -f "$dst" "$rmtmp" 2>/dev/null &&
+            { $doit $rmcmd "$rmtmp" 2>/dev/null; :; }
+          } ||
+          { echo "$0: cannot unlink or rename $dst" >&2
+            (exit 1); exit 1
+          }
+        } &&
+
+        # Now rename the file to the real destination.
+        $doit $mvcmd "$dsttmp" "$dst"
+      }
+    fi || exit 1
+
+    trap '' 0
+  fi
+done
 
-exit 0
+# Local variables:
+# eval: (add-hook 'before-save-hook 'time-stamp)
+# time-stamp-start: "scriptversion="
+# time-stamp-format: "%:y-%02m-%02d.%02H"
+# time-stamp-time-zone: "UTC0"
+# time-stamp-end: "; # UTC"
+# End:
-- 
2.39.0

