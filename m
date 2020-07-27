Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5614C22E91A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgG0JgZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 05:36:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20422 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgG0JgY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jul 2020 05:36:24 -0400
X-IronPort-AV: E=Sophos;i="5.75,401,1589212800"; 
   d="scan'208";a="96909985"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jul 2020 17:36:20 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id BB4B54CE49BD;
        Mon, 27 Jul 2020 17:36:17 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Jul 2020 17:36:21 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Jul 2020 17:36:20 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] chattr/lsattr: Support dax attribute
Date:   Mon, 27 Jul 2020 17:29:01 +0800
Message-ID: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BB4B54CE49BD.AE9BE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the letter 'x' to set/get dax attribute on a directory/file.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/e2p/pf.c         |  1 +
 lib/ext2fs/ext2_fs.h |  1 +
 misc/chattr.1.in     | 10 ++++++++--
 misc/chattr.c        |  3 ++-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
index 0c6998c4..e59cccff 100644
--- a/lib/e2p/pf.c
+++ b/lib/e2p/pf.c
@@ -44,6 +44,7 @@ static struct flags_name flags_array[] = {
 	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
 	{ EXT4_EXTENTS_FL, "e", "Extents" },
 	{ FS_NOCOW_FL, "C", "No_COW" },
+	{ FS_DAX_FL, "x", "Dax" },
 	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
 	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
 	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 6c20ea77..b5e2e42a 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -334,6 +334,7 @@ struct ext2_dx_tail {
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
+#define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
 #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
 #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */
diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index ff2fcf00..b27c8e1f 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -23,7 +23,7 @@ chattr \- change file attributes on a Linux file system
 .B chattr
 changes the file attributes on a Linux file system.
 .PP
-The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
+The format of a symbolic mode is +-=[aAcCdDeFijPsStTux].
 .PP
 The operator '+' causes the selected attributes to be added to the
 existing attributes of the files; '-' causes them to be removed; and '='
@@ -45,7 +45,8 @@ secure deletion (s),
 synchronous updates (S),
 no tail-merging (t),
 top of directory hierarchy (T),
-and undeletable (u).
+undeletable (u),
+and direct access for files (x).
 .PP
 The following attributes are read-only, and may be listed by
 .BR lsattr (1)
@@ -210,6 +211,11 @@ saved.  This allows the user to ask for its undeletion.  Note: please
 make sure to read the bugs and limitations section at the end of this
 document.
 .TP
+.B x
+A file with the 'x' attribute set is accessed directly on the memory-like
+disk(e.g. /dev/pmem) by the kernel.  Kernel will skip page cache and do
+reads/writes on the file directly.
+.TP
 .B V
 A file with the 'V' attribute set has fs-verity enabled.  It cannot be
 written to, and the filesystem will automatically verify all data read
diff --git a/misc/chattr.c b/misc/chattr.c
index a5d60170..c0337f86 100644
--- a/misc/chattr.c
+++ b/misc/chattr.c
@@ -86,7 +86,7 @@ static unsigned long sf;
 static void usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuF] [-v version] files...\n"),
+		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuFx] [-v version] files...\n"),
 		program_name);
 	exit(1);
 }
@@ -112,6 +112,7 @@ static const struct flags_char flags_array[] = {
 	{ EXT2_NOTAIL_FL, 't' },
 	{ EXT2_TOPDIR_FL, 'T' },
 	{ FS_NOCOW_FL, 'C' },
+	{ FS_DAX_FL, 'x' },
 	{ EXT4_CASEFOLD_FL, 'F' },
 	{ 0, 0 }
 };
-- 
2.21.0



