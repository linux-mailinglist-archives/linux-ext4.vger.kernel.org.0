Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30AC46599F
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Dec 2021 00:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhLAXHn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 18:07:43 -0500
Received: from omta002.cacentral1.a.cloudfilter.net ([3.97.99.33]:47650 "EHLO
        omta002.cacentral1.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234771AbhLAXHk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 18:07:40 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 18:07:40 EST
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id sPTtmUyNhztEjsYX0mRjwg; Wed, 01 Dec 2021 22:56:54 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id sYWzmzaAT5livsYWzmkHTf; Wed, 01 Dec 2021 22:56:54 +0000
X-Authority-Analysis: v=2.4 cv=IfaU5Ema c=1 sm=1 tr=0 ts=61a7fdb6
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=FP58Ms26AAAA:8 a=xDA5UoXM69o270h-HjUA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] misc: fix chattr usage message for project ID
Date:   Wed,  1 Dec 2021 15:56:51 -0700
Message-Id: <20211201225651.58251-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHK7VjJklm0M+vwOz91mbhsGI+y+uZSSPbmiIGkE0zZv4xc6r0dHU3qPKpGECwqzaF0FkDlAEvBma4AeMvUbiNNNwWqU2aRlRBatsTDRaYa01qHXM7N9
 BtJSx/XMZDg8FAnU5fn86WMfy8yID5Krspxv/2gQPTO39XpOHSzqsw4tLbuen6T+bWaGtlEQmW3wLlwNASBvEmHT4IfCodhZUGIuYeMu+54kXHL3xHQT4ZYe
 ETAJsORafldz/+FqSYZB/Q==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the "chattr -h" usage message to properly document that the
"-p" option takes a project argument, like "-v" takes a version.

Update the man page formatting to emphasize literal strings.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 misc/chattr.1.in | 86 +++++++++++++++++++++++++++++++++---------------
 misc/chattr.c    |  2 +-
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 922410b6..cd2e0020 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -23,44 +23,77 @@ chattr \- change file attributes on a Linux file system
 .B chattr
 changes the file attributes on a Linux file system.
 .PP
-The format of a symbolic mode is +-=[aAcCdDeFijmPsStTux].
+The format of a symbolic
+.I mode
+is
+.BR +-= [ aAcCdDeFijmPsStTux ].
 .PP
-The operator '+' causes the selected attributes to be added to the
-existing attributes of the files; '-' causes them to be removed; and '='
+The operator
+.RB ' + '
+causes the selected attributes to be added to the
+existing attributes of the files;
+.RB ' - '
+causes them to be removed; and
+.RB ' = '
 causes them to be the only attributes that the files have.
 .PP
-The letters 'aAcCdDeFijmPsStTux' select the new attributes for the files:
-append only (a),
-no atime updates (A),
-compressed (c),
-no copy on write (C),
-no dump (d),
-synchronous directory updates (D),
-extent format (e),
-case-insensitive directory lookups (F),
-immutable (i),
-data journaling (j),
-don't compress (m),
-project hierarchy (P),
-secure deletion (s),
-synchronous updates (S),
-no tail-merging (t),
-top of directory hierarchy (T),
-undeletable (u),
-and direct access for files (x).
+The letters
+.RB ' aAcCdDeFijmPsStTux '
+select the new attributes for the files:
+append only
+.RB ( a ),
+no atime updates
+.RB ( A ),
+compressed
+.RB ( c ),
+no copy on write
+.RB ( C ),
+no dump
+.RB ( d ),
+synchronous directory updates
+.RB ( D ),
+extent format
+.RB ( e ),
+case-insensitive directory lookups
+.RB ( F ),
+immutable
+.RB ( i ),
+data journaling
+.RB ( j ),
+don't compress
+.RB ( m ),
+project hierarchy
+.RB ( P ),
+secure deletion
+.RB ( s ),
+synchronous updates
+.RB ( S ),
+no tail-merging
+.RB ( t ),
+top of directory hierarchy
+.RB ( T ),
+undeletable
+.RB ( u ),
+and direct access for files
+.RB ( x ).
 .PP
 The following attributes are read-only, and may be listed by
 .BR lsattr (1)
 but not modified by chattr:
-encrypted (E),
-indexed directory (I),
-inline data (N),
-and verity (V).
+encrypted
+.RB ( E ),
+indexed directory
+.RB ( I ),
+inline data
+.RB ( N ),
+and verity
+.RB ( V ).
 .PP
 Not all flags are supported or utilized by all file systems; refer to
 file system-specific man pages such as
 .BR btrfs (5),
 .BR ext4 (5),
+.BR mkfs.f2fs (8),
 and
 .BR xfs (5)
 for more file system-specific details.
@@ -258,4 +291,5 @@ http://e2fsprogs.sourceforge.net.
 .BR lsattr (1),
 .BR btrfs (5),
 .BR ext4 (5),
+.BR mkfs.f2fs (8),
 .BR xfs (5).
diff --git a/misc/chattr.c b/misc/chattr.c
index 644ef4e9..c7382a37 100644
--- a/misc/chattr.c
+++ b/misc/chattr.c
@@ -86,7 +86,7 @@ static unsigned long sf;
 static void usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuFx] [-v version] files...\n"),
+		_("Usage: %s [-RVf] [-+=aAcCdDeijPsStTuFx] [-p project] [-v version] files...\n"),
 		program_name);
 	exit(1);
 }
-- 
2.25.1

