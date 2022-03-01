Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992334C7F0A
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 01:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiCAAN0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 19:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCAANZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 19:13:25 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 16:12:45 PST
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EA19C11
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 16:12:45 -0800 (PST)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id OjtTn3d9L43SgOq6knSfNR; Tue, 01 Mar 2022 00:11:14 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id Oq6jn8WNiqyysOq6jnSwp4; Tue, 01 Mar 2022 00:11:14 +0000
X-Authority-Analysis: v=2.4 cv=Y6brDzSN c=1 sm=1 tr=0 ts=621d64a2
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=FP58Ms26AAAA:8 a=xDA5UoXM69o270h-HjUA:9 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH RESEND] misc: fix chattr usage message for project ID
Date:   Mon, 28 Feb 2022 17:11:07 -0700
Message-Id: <20220301001107.73639-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNPwfY0F7H6/5le2wWadrJVhlixwOXYHlYoBQWU82lSnkOG/DTIYxaUZI2uXa5h2MtVLARwPnjN5atfrtj5TMIEjyyqUkwvEyMk6ztfBsD18tM2Q1wtH
 q2E/3xrIJxzTNMy2opyLs2nKKa7LYJoR2P5frCE3Clhc9p4b2zf1doGCgFcJ9C+mLtANeq9xVmrunMBuspwyuga5M2SKL+LlDH6D8BJfwOZY+Itx7Ahsw9Wp
 h3A7HB054XK4j1RFI0EeBA==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the "chattr -h" usage message to properly document that the
"-p" option takes a project argument, like "-v" takes a version.

Update the man page formatting to emphasize literal strings.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
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

