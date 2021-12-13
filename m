Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724BA47212D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Dec 2021 07:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhLMGnA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Dec 2021 01:43:00 -0500
Received: from omta001.cacentral1.a.cloudfilter.net ([3.97.99.32]:55720 "EHLO
        omta001.cacentral1.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhLMGm7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Dec 2021 01:42:59 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 01:42:59 EST
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
        by cmsmtp with ESMTP
        id wUj4mXQaulW5qwewBmLRQT; Mon, 13 Dec 2021 06:35:51 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id wewAm5YtOmX1kwewAmS0i6; Mon, 13 Dec 2021 06:35:51 +0000
X-Authority-Analysis: v=2.4 cv=Fe4keby6 c=1 sm=1 tr=0 ts=61b6e9c7
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=WF838sAqkIkMLx-JracA:9 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] e2fsck: no parent lookup in disconnected dir
Date:   Sun, 12 Dec 2021 23:35:30 -0700
Message-Id: <20211213063530.38352-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFAuu2IiJGxGj1NkwjzuFk+Jxns8OeLbj3K3F/52AtUqPcQI/v/WLScaGjnwgLx6DjYXQdXaGwmT7XLLKeDRxzhCXWm5tFc2mWNUQLG41WFyskxUhsa3
 ITEQZJ6SIggZ08uhu5vpC8pc5ke+6K2zinEUz+letjUx/5l74pOKErFkfh4A4gie4CQZ+6OD4nrXyZEv9TC9ZIPbCUP0tbdhRMb2YTy0tqt6MxxwqzZnNri6
 B241b2QtBQWOpkBB2QPW8w==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't call into ext2fs_get_pathname() to do a name lookup for a
disconnected directory, since the directory block traversal in
pass1 has already scanned all of the leaf blocks and never finds
the entry, always printing "???".  If the name entry had been
found earlier, the directory would not be disconnected in pass3.

Instead, lookup ".." and print the parent name in the prompt, and
then do not search for the current directory name at all.  This
avoids a useless full directory scan for each disconnected entry,
which can potentially be slow if the parent directory is large.

Separate the recursively looped directory case to a new error code,
since it is a different problem that should use its own descriptive
text, and a proper pathname can be shown in this case.

Lustre-bug-Id: https://jira.whamcloud.com/browse/LU-15330
Change-Id: If17a92689f24f365ca1fbe5c837e7d5f383ebbe5
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 e2fsck/pass3.c                        |  19 ++++++++++++-------
 e2fsck/problem.c                      |   8 +++++++-
 e2fsck/problem.h                      |   3 +++
 tests/f_bad_encryption/expect.1       |   6 +++---
 tests/f_badroot/expect.1              |   2 +-
 tests/f_encrypted_lpf/expect.1        |   4 ++--
 tests/f_expand/expect.1.gz            | Bin 13462 -> 13461 bytes
 tests/f_lpf2/expect.1                 |   4 ++--
 tests/f_noroot/expect.1               |   4 ++--
 tests/f_orphan_dotdot_ft/expect.1     |   6 +++---
 tests/f_rebuild_csum_rootdir/expect.1 |   2 +-
 tests/f_recnect_bad/expect.1          |   2 +-
 tests/f_resize_inode_meta_bg/expect.1 |   2 +-
 13 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/e2fsck/pass3.c b/e2fsck/pass3.c
index cedaaf5a..d6b8c8b4 100644
--- a/e2fsck/pass3.c
+++ b/e2fsck/pass3.c
@@ -22,7 +22,7 @@
  * will offer to reconnect it to /lost+found.  While it is chasing
  * parent pointers up the filesystem tree, if pass3 sees a directory
  * twice, then it has detected a filesystem loop, and it will again
- * offer to reconnect the directory to /lost+found in to break the
+ * offer to reconnect the directory to /lost+found in order to break the
  * filesystem loop.
  *
  * Pass 3 also contains the subroutine, e2fsck_reconnect_file() to
@@ -304,7 +304,7 @@ static int check_directory(e2fsck_t ctx, ext2_ino_t dir,
 		 * If it was marked done already, then we've reached a
 		 * parent we've already checked.
 		 */
-	  	if (ext2fs_mark_inode_bitmap2(inode_done_map, ino))
+		if (ext2fs_mark_inode_bitmap2(inode_done_map, ino))
 			break;
 
 		if (e2fsck_dir_info_get_parent(ctx, ino, &parent)) {
@@ -319,13 +319,18 @@ static int check_directory(e2fsck_t ctx, ext2_ino_t dir,
 		 */
 		if (!parent ||
 		    (loop_pass &&
-		     (ext2fs_test_inode_bitmap2(inode_loop_detect,
-					       parent)))) {
+		     ext2fs_test_inode_bitmap2(inode_loop_detect, parent))) {
 			pctx->ino = ino;
-			if (fix_problem(ctx, PR_3_UNCONNECTED_DIR, pctx)) {
-				if (e2fsck_reconnect_file(ctx, pctx->ino))
+			if (parent)
+				pctx->dir = parent;
+			else
+				ext2fs_lookup(fs, ino, "..", 2, NULL,
+					      &pctx->dir);
+			if (fix_problem(ctx, !parent ? PR_3_UNCONNECTED_DIR :
+						       PR_3_LOOPED_DIR, pctx)) {
+				if (e2fsck_reconnect_file(ctx, pctx->ino)) {
 					ext2fs_unmark_valid(fs);
-				else {
+				} else {
 					fix_dotdot(ctx, pctx->ino,
 						   ctx->lost_and_found);
 					parent = ctx->lost_and_found;
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 757b5d56..66c9ae94 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1852,7 +1852,7 @@ static struct e2fsck_problem problem_table[] = {
 	/* Unconnected directory inode */
 	{ PR_3_UNCONNECTED_DIR,
 	  /* xgettext:no-c-format */
-	  N_("Unconnected @d @i %i (%p)\n"),
+	  N_("Unconnected @d @i %i (was in %q)\n"),
 	  PROMPT_CONNECT, 0, 0, 0, 0 },
 
 	/* /lost+found not found */
@@ -1989,6 +1989,12 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("/@l is encrypted\n"),
 	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
+	/* Recursively looped directory inode */
+	{ PR_3_LOOPED_DIR,
+	  /* xgettext:no-c-format */
+	  N_("Recursively looped @d @i %i (%p)\n"),
+	  PROMPT_CONNECT, 0, 0, 0, 0 },
+
 	/* Pass 3A Directory Optimization	*/
 
 	/* Pass 3A: Optimizing directories */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 24cdcf9b..e86bc889 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -1132,6 +1132,9 @@ struct problem_context {
 /* Lost+found is encrypted */
 #define PR_3_LPF_ENCRYPTED		0x03001B
 
+/* Recursively looped directory inode */
+#define PR_3_LOOPED_DIR			0x03001D
+
 /*
  * Pass 3a --- rehashing directories
  */
diff --git a/tests/f_bad_encryption/expect.1 b/tests/f_bad_encryption/expect.1
index d743e66f..70270959 100644
--- a/tests/f_bad_encryption/expect.1
+++ b/tests/f_bad_encryption/expect.1
@@ -54,13 +54,13 @@ Encrypted entry '\M-ggCeM-/?M-^BM-{(M-^OM-9M-^QQAM-^N=M-c^Mo' in /edir (12) refe
 Clear? yes
 
 Pass 3: Checking directory connectivity
-Unconnected directory inode 18 (/edir/???)
+Unconnected directory inode 18 (was in /edir)
 Connect to /lost+found? yes
 
-Unconnected directory inode 24 (/edir/???)
+Unconnected directory inode 24 (was in /edir)
 Connect to /lost+found? yes
 
-Unconnected directory inode 27 (/edir/???)
+Unconnected directory inode 27 (was in /edir)
 Connect to /lost+found? yes
 
 Pass 4: Checking reference counts
diff --git a/tests/f_badroot/expect.1 b/tests/f_badroot/expect.1
index f9d01e57..ff924268 100644
--- a/tests/f_badroot/expect.1
+++ b/tests/f_badroot/expect.1
@@ -9,7 +9,7 @@ Entry '..' in <2>/<11> (11) has deleted/unused inode 2.  Clear? yes
 Pass 3: Checking directory connectivity
 Root inode not allocated.  Allocate? yes
 
-Unconnected directory inode 11 (...)
+Unconnected directory inode 11 (was in /)
 Connect to /lost+found? yes
 
 /lost+found not found.  Create? yes
diff --git a/tests/f_encrypted_lpf/expect.1 b/tests/f_encrypted_lpf/expect.1
index 7e215b7d..63ac5f3b 100644
--- a/tests/f_encrypted_lpf/expect.1
+++ b/tests/f_encrypted_lpf/expect.1
@@ -1,7 +1,7 @@
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
-Unconnected directory inode 12 (/???)
+Unconnected directory inode 12 (was in /)
 Connect to /lost+found? yes
 
 /lost+found is encrypted
@@ -13,7 +13,7 @@ Restarting e2fsck from the beginning...
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
-Unconnected directory inode 11 (/???)
+Unconnected directory inode 11 (was in /)
 Connect to /lost+found? yes
 
 Pass 3A: Optimizing directories
diff --git a/tests/f_expand/expect.1.gz b/tests/f_expand/expect.1.gz
index 1015e155ca93f1aea0edfad09be6e795c0ab1898..81fe7dd67f81dd64100b5fdfe2884fab129ab721 100644
GIT binary patch
literal 13461
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

literal 13462
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

diff --git a/tests/f_lpf2/expect.1 b/tests/f_lpf2/expect.1
index 633586cc..ab5d9ba3 100644
--- a/tests/f_lpf2/expect.1
+++ b/tests/f_lpf2/expect.1
@@ -1,12 +1,12 @@
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
-Unconnected directory inode 12 (/???)
+Unconnected directory inode 12 (was in /)
 Connect to /lost+found? yes
 
 /lost+found not found.  Create? yes
 
-Unconnected directory inode 13 (/???)
+Unconnected directory inode 13 (was in /)
 Connect to /lost+found? yes
 
 Pass 4: Checking reference counts
diff --git a/tests/f_noroot/expect.1 b/tests/f_noroot/expect.1
index 7bdd7cba..f8f652ec 100644
--- a/tests/f_noroot/expect.1
+++ b/tests/f_noroot/expect.1
@@ -11,12 +11,12 @@ Entry '..' in /foo (12) has deleted/unused inode 2.  Clear? yes
 Pass 3: Checking directory connectivity
 Root inode not allocated.  Allocate? yes
 
-Unconnected directory inode 11 (...)
+Unconnected directory inode 11 (was in /)
 Connect to /lost+found? yes
 
 /lost+found not found.  Create? yes
 
-Unconnected directory inode 12 (...)
+Unconnected directory inode 12 (was in /lost+found)
 Connect to /lost+found? yes
 
 Pass 4: Checking reference counts
diff --git a/tests/f_orphan_dotdot_ft/expect.1 b/tests/f_orphan_dotdot_ft/expect.1
index 6a1373f2..60924958 100644
--- a/tests/f_orphan_dotdot_ft/expect.1
+++ b/tests/f_orphan_dotdot_ft/expect.1
@@ -17,13 +17,13 @@ Entry '..' in <12>/<15> (15) has an incorrect filetype (was 2, should be 6).
 Fix? yes
 
 Pass 3: Checking directory connectivity
-Unconnected directory inode 13 (<12>/<13>)
+Unconnected directory inode 13 (was in <12>)
 Connect to /lost+found? yes
 
-Unconnected directory inode 14 (<12>/<14>)
+Unconnected directory inode 14 (was in <12>)
 Connect to /lost+found? yes
 
-Unconnected directory inode 15 (<12>/<15>)
+Unconnected directory inode 15 (was in <12>)
 Connect to /lost+found? yes
 
 Pass 4: Checking reference counts
diff --git a/tests/f_rebuild_csum_rootdir/expect.1 b/tests/f_rebuild_csum_rootdir/expect.1
index 91e6027d..063fb8cc 100644
--- a/tests/f_rebuild_csum_rootdir/expect.1
+++ b/tests/f_rebuild_csum_rootdir/expect.1
@@ -13,7 +13,7 @@ Pass 3: Checking directory connectivity
 '..' in / (2) is <The NULL inode> (0), should be / (2).
 Fix? yes
 
-Unconnected directory inode 11 (/???)
+Unconnected directory inode 11 (was in /)
 Connect to /lost+found? yes
 
 /lost+found not found.  Create? yes
diff --git a/tests/f_recnect_bad/expect.1 b/tests/f_recnect_bad/expect.1
index 97ffcc52..685eedfe 100644
--- a/tests/f_recnect_bad/expect.1
+++ b/tests/f_recnect_bad/expect.1
@@ -12,7 +12,7 @@ i_faddr for inode 13 (/test/???) is 12, should be zero.
 Clear? yes
 
 Pass 3: Checking directory connectivity
-Unconnected directory inode 13 (/test/???)
+Unconnected directory inode 13 (was in /test)
 Connect to /lost+found? yes
 
 Pass 4: Checking reference counts
diff --git a/tests/f_resize_inode_meta_bg/expect.1 b/tests/f_resize_inode_meta_bg/expect.1
index 769f71ae..e248083f 100644
--- a/tests/f_resize_inode_meta_bg/expect.1
+++ b/tests/f_resize_inode_meta_bg/expect.1
@@ -45,7 +45,7 @@ Pass 3: Checking directory connectivity
 '..' in / (2) is <The NULL inode> (0), should be / (2).
 Fix? yes
 
-Unconnected directory inode 11 (/???)
+Unconnected directory inode 11 (was in /)
 Connect to /lost+found? yes
 
 /lost+found not found.  Create? yes
-- 
2.25.1

