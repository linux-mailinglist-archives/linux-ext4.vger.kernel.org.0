Return-Path: <linux-ext4+bounces-6131-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A23A1308A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 02:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEBA3A5403
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52A208A9;
	Thu, 16 Jan 2025 01:13:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CFC139
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990020; cv=none; b=YIGr0M0V3Es4R0GlJGJR6ePTprgDaKMRR3S/QYgwpjgyFAagnWVJldBTK5fRA/IzynldlFMxsEEBoh0rwVklp73ey3XWZ2HzHGrhOfp1WCwY9ZqpZAVA77G6tvt6FHsenfUbwuMb1GzQ3NoLBr50Bdl8QZVsQU7KOqXV3IMh9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990020; c=relaxed/simple;
	bh=R9Or3O8TWPQuNaY8nqsMSfTPoskcSYapZwCozeD9PSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1OuNFwu8OM17Hcgx91xc9qMWlpnJL37Sy13+grpUtwreaQAt6wREOYAbuRZzpG25xdpyn96Lsa+JtKcGKc0o8yZ7ht6OasF4oSvgun8ynt3XRYtg8iTQTdVtnO4uk6OA15Z4zurbhhzyQh3YNqFPDgxu3rKBe3SuR8TyiPmAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=whamcloud.com; spf=fail smtp.mailfrom=whamcloud.com; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=whamcloud.com
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id Y5e1tILMbxv7PYEQZtJCRW; Thu, 16 Jan 2025 01:12:07 +0000
Received: from localhost.localdomain ([70.77.200.158])
	by cmsmtp with ESMTP
	id YEQRt2t64l5eGYEQYtGCQe; Thu, 16 Jan 2025 01:12:07 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=67885ce7
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=ySfo2T4IAAAA:8
 a=lB0dNpNiAAAA:8 a=znbH37hXTXGaWeUHEycA:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=c-ZiYqmG3AbHTdtsH08C:22
From: Andreas Dilger <adilger@whamcloud.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@whamcloud.com>,
	Alex Zhuravlev <bzzz@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH 2/2] journal: increase revoke block hash size
Date: Wed, 15 Jan 2025 18:11:50 -0700
Message-Id: <20250116011150.55313-2-adilger@whamcloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250116011150.55313-1-adilger@whamcloud.com>
References: <20250116011150.55313-1-adilger@whamcloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMyYvTvZUX/SGc4USOtpqWHRMB42P8ULmiXRDjRZYz9jEDfR8h78MPLV7Jvv5qVhffBLjnWsIyUBbnEVxdXfuwOUgIqjKdmyeUXWcB1x5EpnupECwxuF
 +e21kTifbYSq6Z9422z6IBQF8Jz0Yzr+DKJ8uxlvRZzMO9yB45VXeMWKzqQb3Ik8Lb2wA+UAWrd3cQsxSrFvud9KpFvvrGmtAbDXNrS3IIEuoxKoRgCzFH7D
 KYk+hfQ5UCe2NJyMiHLdf5x8Dqe26TR5mhjOaVv3fPvUauaU776XhyYlGrXvEj+U/sPLPStQSODEm0qf7q0uaE6cczR3UICtFiEfQ0vUoJ8=

Increase the size of the revoke block hash table to scale with the
size of the journal, so that we don't get long hash chains if there
are a large number of revoke blocks in the journal to replay.

The new hash size will default to 1/16 of the blocks in the journal.
This is about 1 byte per block in the hash table, but there are two
allocated.  The total amount of memory allocated for revoke blocks
depends much more on how many are in the journal, and not on the size
of the hash table.  The system is regularly using this much memory
for the journal blocks, so the hash table size is not a big factor.

Consolidate duplicate code between recover_ext3_journal() and
ext2fs_open_ext3_journal() in debugfs.c to avoid duplicating logic.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Change-Id: Ibadf2a28c2f42fa92601f9da39a6ff73a43ebbe5
Reviewed-on: https://review.whamcloud.com/52386
---
 debugfs/journal.c       | 68 +++++++++++++----------------------------
 e2fsck/jfs_user.h       |  2 +-
 e2fsck/journal.c        | 12 +++++++-
 lib/ext2fs/jfs_compat.h |  1 +
 lib/ext2fs/kernel-jbd.h |  1 +
 misc/util.c             | 21 +++++++------
 6 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 04611acf76..a6d8d4c5ad 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -738,10 +738,12 @@ err:
 	return retval;
 }
 
-static errcode_t recover_ext3_journal(ext2_filsys fs)
+#define recover_ext3_journal(fs) ext2fs_open_journal(fs, NULL)
+errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j)
 {
 	journal_t *journal;
 	errcode_t retval;
+	long hash_size;
 
 	retval = jbd2_journal_init_revoke_record_cache();
 	if (retval)
@@ -759,19 +761,34 @@ static errcode_t recover_ext3_journal(ext2_filsys fs)
 	if (retval)
 		goto errout;
 
-	retval = jbd2_journal_init_revoke(journal, 1024);
+	/* The hash table defaults to 2 bytes per journal block (average of
+	 * 8 entries in a hash bucket in absolute worst case), but the total
+	 * memory usage depends on the number of revoke blocks.  The system
+	 * should be able to handle this much RAM usage, since it uses at
+	 * least this much memory for the journal when running.  The max limit
+	 * check is to avoid problems if the journal size is wrong somehow. */
+	hash_size = roundup_power_of_two(journal->j_superblock->s_maxlen / 16);
+	if (hash_size > JBD2_MAX_JOURNAL_BLOCKS / 16)
+		hash_size = roundup_power_of_two(JBD2_MAX_JOURNAL_BLOCKS / 16);
+	retval = jbd2_journal_init_revoke(journal, hash_size);
 	if (retval)
 		goto errout;
 
-	retval = -jbd2_journal_recover(journal);
-	if (retval)
-		goto errout;
+	if (!j) {
+		retval = -jbd2_journal_recover(journal);
+		if (retval)
+			goto errout;
+	}
 
 	if (journal->j_failed_commit) {
 		journal->j_superblock->s_errno = -EINVAL;
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
+	if (j) {
+		*j = journal;
+		return 0;
+	}
 	journal->j_tail_sequence = journal->j_transaction_sequence;
 
 errout:
@@ -853,47 +870,6 @@ outfree:
 	return retval ? retval : recover_retval;
 }
 
-errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j)
-{
-	journal_t *journal;
-	errcode_t retval;
-
-	retval = jbd2_journal_init_revoke_record_cache();
-	if (retval)
-		return retval;
-
-	retval = jbd2_journal_init_revoke_table_cache();
-	if (retval)
-		return retval;
-
-	retval = ext2fs_get_journal(fs, &journal);
-	if (retval)
-		return retval;
-
-	retval = ext2fs_journal_load(journal);
-	if (retval)
-		goto errout;
-
-	retval = jbd2_journal_init_revoke(journal, 1024);
-	if (retval)
-		goto errout;
-
-	if (journal->j_failed_commit) {
-		journal->j_superblock->s_errno = -EINVAL;
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-
-	*j = journal;
-	return 0;
-
-errout:
-	jbd2_journal_destroy_revoke(journal);
-	jbd2_journal_destroy_revoke_record_cache();
-	jbd2_journal_destroy_revoke_table_cache();
-	ext2fs_journal_release(fs, journal, 1, 0);
-	return retval;
-}
-
 errcode_t ext2fs_close_journal(ext2_filsys fs, journal_t **j)
 {
 	journal_t *journal = *j;
diff --git a/e2fsck/jfs_user.h b/e2fsck/jfs_user.h
index 5928a8a8ed..804b19a7ba 100644
--- a/e2fsck/jfs_user.h
+++ b/e2fsck/jfs_user.h
@@ -306,7 +306,7 @@ extern int	jbd2_journal_recover    (journal_t *journal);
 extern int	jbd2_journal_skip_recovery (journal_t *);
 
 /* revoke.c */
-extern int	jbd2_journal_init_revoke(journal_t *, int);
+extern int	jbd2_journal_init_revoke(journal_t *, int hash_size);
 extern void	jbd2_journal_destroy_revoke(journal_t *);
 extern void	jbd2_journal_destroy_revoke_record_cache(void);
 extern void	jbd2_journal_destroy_revoke_table_cache(void);
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 19d68b4306..d25d60492c 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1632,6 +1632,7 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	struct problem_context	pctx;
 	journal_t *journal;
 	errcode_t retval;
+	long hash_size;
 
 	clear_problem_context(&pctx);
 
@@ -1651,7 +1652,16 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	if (retval)
 		goto errout;
 
-	retval = jbd2_journal_init_revoke(journal, 1024);
+	/* The hash table defaults to 2 bytes per journal block (average of
+	 * 8 entries in a hash chain in absolute worst case), but the total
+	 * memory usage depends on the number of revoke blocks.  The system
+	 * should be able to handle this much RAM usage, since it uses at
+	 * least this much memory for the journal when running.  The max limit
+	 * check is to avoid problems if the journal size is wrong somehow. */
+	hash_size = roundup_power_of_two(journal->j_superblock->s_maxlen / 16);
+	if (hash_size > JBD2_MAX_JOURNAL_BLOCKS / 16)
+		hash_size = roundup_power_of_two(JBD2_MAX_JOURNAL_BLOCKS / 16);
+	retval = jbd2_journal_init_revoke(journal, hash_size);
 	if (retval)
 		goto errout;
 
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 0e96b56c15..ed20b63ee7 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -59,6 +59,7 @@ typedef __u64 u64;
 
 #define blkdev_issue_flush(kdev)	sync_blockdev(kdev)
 #define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
+#define roundup_power_of_two(n)		(1UL << (ext2fs_log2((n) - 1) + 1))
 #define pr_emerg(fmt)
 #define pr_err(...)
 
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index e569500632..4923a78d46 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -58,6 +58,7 @@ extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), 1)
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_MAX_JOURNAL_BLOCKS (JBD2_MIN_JOURNAL_BLOCKS * 10000)
 #define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
 
 /*
diff --git a/misc/util.c b/misc/util.c
index 3e83169f11..01c9c5fa1f 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -49,6 +49,7 @@
 #include "e2p/e2p.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
+#include "ext2fs/kernel-jbd.h"
 #include "support/nls-enable.h"
 #include "support/devname.h"
 #include "blkid/blkid.h"
@@ -266,7 +267,7 @@ static inline int fcsize_to_blks(ext2_filsys fs, int size)
 void figure_journal_size(struct ext2fs_journal_params *jparams,
 		int requested_j_size, int requested_fc_size, ext2_filsys fs)
 {
-	int total_blocks, ret;
+	int ret;
 
 	ret = ext2fs_get_journal_params(jparams, fs);
 	if (ret) {
@@ -275,7 +276,9 @@ void figure_journal_size(struct ext2fs_journal_params *jparams,
 	}
 
 	if (requested_j_size > 0 ||
-		(ext2fs_has_feature_fast_commit(fs->super) && requested_fc_size > 0)) {
+	    (ext2fs_has_feature_fast_commit(fs->super) && requested_fc_size > 0)) {
+		unsigned int total_blocks;
+
 		if (requested_j_size > 0)
 			jparams->num_journal_blocks =
 				jsize_to_blks(fs, requested_j_size);
@@ -286,15 +289,15 @@ void figure_journal_size(struct ext2fs_journal_params *jparams,
 		else if (!ext2fs_has_feature_fast_commit(fs->super))
 			jparams->num_fc_blocks = 0;
 		total_blocks = jparams->num_journal_blocks + jparams->num_fc_blocks;
-		if (total_blocks < 1024 || total_blocks > 10240000) {
-			fprintf(stderr, _("\nThe total requested journal "
-				"size is %d blocks; it must be\n"
-				"between 1024 and 10240000 blocks.  "
-				"Aborting.\n"),
-				total_blocks);
+		if (total_blocks < JBD2_MIN_JOURNAL_BLOCKS ||
+		    total_blocks > JBD2_MAX_JOURNAL_BLOCKS) {
+			fprintf(stderr,
+				_("\nThe total requested journal size is %d blocks;\nit must be between %d and %u blocks.  Aborting.\n"),
+				total_blocks, JBD2_MIN_JOURNAL_BLOCKS,
+				JBD2_MAX_JOURNAL_BLOCKS);
 			exit(1);
 		}
-		if ((unsigned int) total_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
+		if (total_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
 			fputs(_("\nTotal journal size too big for filesystem.\n"),
 			      stderr);
 			exit(1);
-- 
2.39.5 (Apple Git-154)


