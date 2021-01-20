Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A362FDDEE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393222AbhAUAad (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732751AbhATVbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21104C0617A5
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so3726920pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+roizGeaZAezyd2cJiLEvvtCDMJTk72uTY+/Ult8mQM=;
        b=sBcFxLQ7U79hlFchUAF1e1AfhOSNUOY936UF+4WaAI8Pw+QQX4cwyu6BZI0SW7xzjs
         O7pxazwq5JfGtdcWyGPS/WyEq8HkYikjvJR+GjXSN+1XHj255lFPlxv+AIzwFRRPhkZP
         Hfx2kVdDv703rxDflrMO8UEXdUZMhn87JXhkCk0H/IEqSD76idtxkkfyWNWtwoeDkf/f
         Q04wi0S6z/6T70Q2z6DU3MCQ8x6eJyRql4wkoK82rEfaEkvjuir+7JnulEd2PK0e9tgl
         rMl4teAFbXpnnzDe/v0qoptq6AXWqH1tlpLOtjYh1cOSi1L7hF6/ef08ZVvhuxWU5P2b
         1t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+roizGeaZAezyd2cJiLEvvtCDMJTk72uTY+/Ult8mQM=;
        b=p4a1MZ6UuOYAS2lyUgNVgJQz7amSp/cDYp4F5KRiyXBB9oVGkNRro/h/vHGbnNBOI1
         zuih2bvM0L2O/D39sI7ptdGwCwnH2knEOmqKO5m6nQNApgJZP3YobmHOYzopJV6e2Qho
         2ZUz7dK5RfWvaQjJ3GhczhYO71gkA/NV2o3R5d2+zu0iz6GlRyUOiybKNM+++FLhizGl
         Am7CavrrITEjYz105pyvvuh28ligGV5klJ1CPnYcYepUT6sVKzS93Qm4KpKeSlK9kENv
         EOtbkkjGjeH6saY2h10WzJM1Kzwrb/4syW/LV5PhIXZx4KQ37dSJORn4g1dadKNQ4m+4
         eTuw==
X-Gm-Message-State: AOAM533aoM3L7cw3/BO0HDtEV8+rIdyvu/mrSOHAmNFALZVsM0t4gCh7
        Y85of5EzMuIxkdYI7I1KzcXj3xICFBM=
X-Google-Smtp-Source: ABdhPJw0MOLLA729ubKSFBxNh8R9hZI0R7rHgAiXtn94ts6liCL8+L1umfspZjtvrDk+wbo5ciKeYA==
X-Received: by 2002:a17:90b:100f:: with SMTP id gm15mr3245154pjb.47.1611178009860;
        Wed, 20 Jan 2021 13:26:49 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:49 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 03/15] e2fsck: port fc changes from kernel's recovery.c to e2fsck
Date:   Wed, 20 Jan 2021 13:26:29 -0800
Message-Id: <20210120212641.526556-4-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch makes recovery.c identical with fast commit kernel changes.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 debugfs/journal.c       |  10 +--
 e2fsck/journal.c        |  28 ++++--
 e2fsck/recovery.c       | 190 +++++++++++++++++++++++++++++-----------
 lib/ext2fs/jfs_compat.h |  19 +++-
 lib/ext2fs/kernel-jbd.h |  16 +++-
 5 files changed, 194 insertions(+), 69 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index fa72ec57..e8872f05 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -378,7 +378,7 @@ try_backup_journal:
 				goto errout;
 		}
 
-		journal->j_maxlen = EXT2_I_SIZE(&j_inode->i_ext2) /
+		journal->j_total_len = EXT2_I_SIZE(&j_inode->i_ext2) /
 			journal->j_blocksize;
 
 #ifdef USE_INODE_IO
@@ -493,7 +493,7 @@ try_backup_journal:
 		brelse(bh);
 
 		maxlen = ext2fs_blocks_count(&jsuper);
-		journal->j_maxlen = (maxlen < 1ULL << 32) ? maxlen :
+		journal->j_total_len = (maxlen < 1ULL << 32) ? maxlen :
 				    (1ULL << 32) - 1;
 		start++;
 	}
@@ -629,9 +629,9 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	if (jsb->s_blocksize != htonl(journal->j_blocksize))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
-	if (ntohl(jsb->s_maxlen) < journal->j_maxlen)
-		journal->j_maxlen = ntohl(jsb->s_maxlen);
-	else if (ntohl(jsb->s_maxlen) > journal->j_maxlen)
+	if (ntohl(jsb->s_maxlen) < journal->j_total_len)
+		journal->j_total_len = ntohl(jsb->s_maxlen);
+	else if (ntohl(jsb->s_maxlen) > journal->j_total_len)
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
 	journal->j_tail_sequence = ntohl(jsb->s_sequence);
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 7d9f1b40..2adef76a 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -379,7 +379,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 				goto errout;
 		}
 
-		journal->j_maxlen = EXT2_I_SIZE(&j_inode->i_ext2) /
+		journal->j_total_len = EXT2_I_SIZE(&j_inode->i_ext2) /
 			journal->j_blocksize;
 
 #ifdef USE_INODE_IO
@@ -503,7 +503,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		brelse(bh);
 
 		maxlen = ext2fs_blocks_count(&jsuper);
-		journal->j_maxlen = (maxlen < 1ULL << 32) ? maxlen : (1ULL << 32) - 1;
+		journal->j_total_len = (maxlen < 1ULL << 32) ? maxlen : (1ULL << 32) - 1;
 		start++;
 	}
 
@@ -675,9 +675,9 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 	}
 
-	if (ntohl(jsb->s_maxlen) < journal->j_maxlen)
-		journal->j_maxlen = ntohl(jsb->s_maxlen);
-	else if (ntohl(jsb->s_maxlen) > journal->j_maxlen) {
+	if (ntohl(jsb->s_maxlen) < journal->j_total_len)
+		journal->j_total_len = ntohl(jsb->s_maxlen);
+	else if (ntohl(jsb->s_maxlen) > journal->j_total_len) {
 		com_err(ctx->program_name, EXT2_ET_CORRUPT_JOURNAL_SB,
 			_("%s: journal too short\n"),
 			ctx->device_name);
@@ -688,7 +688,21 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	journal->j_transaction_sequence = journal->j_tail_sequence;
 	journal->j_tail = ntohl(jsb->s_start);
 	journal->j_first = ntohl(jsb->s_first);
-	journal->j_last = ntohl(jsb->s_maxlen);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		if (ntohl(jsb->s_maxlen) - jbd_get_num_fc_blks(jsb)
+			< JBD2_MIN_JOURNAL_BLOCKS) {
+			com_err(ctx->program_name, EXT2_ET_CORRUPT_JOURNAL_SB,
+				_("%s: incorrect fast commit blocks\n"),
+				ctx->device_name);
+			return EXT2_ET_CORRUPT_JOURNAL_SB;
+		}
+		journal->j_fc_last = ntohl(jsb->s_maxlen);
+		journal->j_last = journal->j_fc_last -
+					jbd_get_num_fc_blks(jsb);
+		journal->j_fc_first = journal->j_last + 1;
+	} else {
+		journal->j_last = ntohl(jsb->s_maxlen);
+	}
 
 	return 0;
 }
@@ -720,7 +734,7 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	memset (p, 0, ctx->fs->blocksize-sizeof(journal_header_t));
 
 	jsb->s_blocksize = htonl(ctx->fs->blocksize);
-	jsb->s_maxlen = htonl(journal->j_maxlen);
+	jsb->s_maxlen = htonl(journal->j_total_len);
 	jsb->s_first = htonl(1);
 
 	/* Initialize the journal sequence number so that there is "no"
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 6c3b7bb4..dc0694fc 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -75,8 +74,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
 
 	/* Do up to 128K of readahead */
 	max = start + (128 * 1024 / journal->j_blocksize);
-	if (max > journal->j_maxlen)
-		max = journal->j_maxlen;
+	if (max > journal->j_total_len)
+		max = journal->j_total_len;
 
 	/* Do the readahead itself.  We'll submit MAXBUF buffer_heads at
 	 * a time to the block device IO layer. */
@@ -135,7 +134,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 
 	*bhp = NULL;
 
-	if (offset >= journal->j_maxlen) {
+	if (offset >= journal->j_total_len) {
 		printk(KERN_ERR "JBD2: corrupted journal superblock\n");
 		return -EFSCORRUPTED;
 	}
@@ -180,7 +179,7 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return 1;
 
-	tail = (struct jbd2_journal_block_tail *)((char *)buf + j->j_blocksize -
+	tail = (struct jbd2_journal_block_tail *)(buf + j->j_blocksize -
 			sizeof(struct jbd2_journal_block_tail));
 	provided = tail->t_checksum;
 	tail->t_checksum = 0;
@@ -225,10 +224,51 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	if (var >= (journal)->j_last)					\
-		var -= ((journal)->j_last - (journal)->j_first);	\
+	unsigned long _wrap_last =					\
+		jbd2_has_feature_fast_commit(journal) ?			\
+			(journal)->j_fc_last : (journal)->j_last;	\
+									\
+	if (var >= _wrap_last)						\
+		var -= (_wrap_last - (journal)->j_first);		\
 } while (0)
 
+static int fc_do_one_pass(journal_t *journal,
+			  struct recovery_info *info, enum passtype pass)
+{
+	unsigned int expected_commit_id = info->end_transaction;
+	unsigned long next_fc_block;
+	struct buffer_head *bh;
+	int err = 0;
+
+	next_fc_block = journal->j_fc_first;
+	if (!journal->j_fc_replay_callback)
+		return 0;
+
+	while (next_fc_block <= journal->j_fc_last) {
+		jbd_debug(3, "Fast commit replay: next block %ld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err) {
+			jbd_debug(3, "Fast commit replay: read error");
+			break;
+		}
+
+		jbd_debug(3, "Processing fast commit blk with seq %d");
+		err = journal->j_fc_replay_callback(journal, bh, pass,
+					next_fc_block - journal->j_fc_first,
+					expected_commit_id);
+		next_fc_block++;
+		if (err < 0 || err == JBD2_FC_REPLAY_STOP)
+			break;
+		err = 0;
+	}
+
+	if (err)
+		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+
+	return err;
+}
+
 /**
  * jbd2_journal_recover - recovers a on-disk journal
  * @journal: the journal to recover
@@ -286,7 +326,7 @@ int jbd2_journal_recover(journal_t *journal)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
 	if (journal->j_flags & JBD2_BARRIER) {
-		err2 = blkdev_issue_flush(journal->j_fs_dev, GFP_KERNEL, NULL);
+		err2 = blkdev_issue_flush(journal->j_fs_dev, GFP_KERNEL);
 		if (!err)
 			err = err2;
 	}
@@ -428,6 +468,8 @@ static int do_one_pass(journal_t *journal,
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
 	int			descr_csum_size = 0;
 	int			block_error = 0;
+	bool			need_check_commit_time = false;
+	__u64			last_trans_commit_time = 0, commit_time;
 
 	/*
 	 * First thing is to establish what we expect to find in the log
@@ -470,7 +512,9 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block,
+			  jbd2_has_feature_fast_commit(journal) ?
+			  journal->j_fc_last : journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -520,9 +564,21 @@ static int do_one_pass(journal_t *journal,
 			if (descr_csum_size > 0 &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				err = -EFSBADCRC;
-				brelse(bh);
-				goto failed;
+				/*
+				 * PASS_SCAN can see stale blocks due to lazy
+				 * journal init. Don't error out on those yet.
+				 */
+				if (pass != PASS_SCAN) {
+					pr_err("JBD2: Invalid checksum recovering block %lu in log\n",
+					       next_log_block);
+					err = -EFSBADCRC;
+					brelse(bh);
+					goto failed;
+				}
+				need_check_commit_time = true;
+				jbd_debug(1,
+					"invalid descriptor block found in %lu\n",
+					next_log_block);
 			}
 
 			/* If it is a valid descriptor block, replay it
@@ -532,6 +588,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass != PASS_REPLAY) {
 				if (pass == PASS_SCAN &&
 				    jbd2_has_feature_checksum(journal) &&
+				    !need_check_commit_time &&
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
@@ -663,7 +720,7 @@ static int do_one_pass(journal_t *journal,
 			 *		| GO TO NEXT    "Journal Corruption"
 			 *		| TRANSACTION
 			 *		|
-			 * {(n+1)th transaction}
+			 * {(n+1)th transanction}
 			 *		|
 			 * 	 _______|______________
 			 * 	|	 	      |
@@ -680,21 +737,48 @@ static int do_one_pass(journal_t *journal,
 			 *	 mentioned conditions. Hence assume
 			 *	 "Interrupted Commit".)
 			 */
+			commit_time = be64_to_cpu(
+				((struct commit_header *)bh->b_data)->h_commit_sec);
+			/*
+			 * If need_check_commit_time is set, it means we are in
+			 * PASS_SCAN and csum verify failed before. If
+			 * commit_time is increasing, it's the same journal,
+			 * otherwise it is stale journal block, just end this
+			 * recovery.
+			 */
+			if (need_check_commit_time) {
+				if (commit_time >= last_trans_commit_time) {
+					pr_err("JBD2: Invalid checksum found in transaction %u\n",
+					       next_commit_ID);
+					err = -EFSBADCRC;
+					brelse(bh);
+					goto failed;
+				}
+			ignore_crc_mismatch:
+				/*
+				 * It likely does not belong to same journal,
+				 * just end this recovery with success.
+				 */
+				jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
+					  next_commit_ID);
+				err = 0;
+				brelse(bh);
+				goto done;
+			}
 
-			/* Found an expected commit block: if checksums
-			 * are present verify them in PASS_SCAN; else not
+			/*
+			 * Found an expected commit block: if checksums
+			 * are present, verify them in PASS_SCAN; else not
 			 * much to do other than move on to the next sequence
-			 * number. */
+			 * number.
+			 */
 			if (pass == PASS_SCAN &&
 			    jbd2_has_feature_checksum(journal)) {
-				int chksum_err, chksum_seen;
 				struct commit_header *cbh =
 					(struct commit_header *)bh->b_data;
 				unsigned found_chksum =
 					be32_to_cpu(cbh->h_chksum[0]);
 
-				chksum_err = chksum_seen = 0;
-
 				if (info->end_transaction) {
 					journal->j_failed_commit =
 						info->end_transaction;
@@ -702,42 +786,25 @@ static int do_one_pass(journal_t *journal,
 					break;
 				}
 
-				if (crc32_sum == found_chksum &&
-				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
-				    cbh->h_chksum_size ==
-						JBD2_CRC32_CHKSUM_SIZE)
-				       chksum_seen = 1;
-				else if (!(cbh->h_chksum_type == 0 &&
-					     cbh->h_chksum_size == 0 &&
-					     found_chksum == 0 &&
-					     !chksum_seen))
-				/*
-				 * If fs is mounted using an old kernel and then
-				 * kernel with journal_chksum is used then we
-				 * get a situation where the journal flag has
-				 * checksum flag set but checksums are not
-				 * present i.e chksum = 0, in the individual
-				 * commit blocks.
-				 * Hence to avoid checksum failures, in this
-				 * situation, this extra check is added.
-				 */
-						chksum_err = 1;
-
-				if (chksum_err) {
-					info->end_transaction = next_commit_ID;
+				/* Neither checksum match nor unused? */
+				if (!((crc32_sum == found_chksum &&
+				       cbh->h_chksum_type ==
+						JBD2_CRC32_CHKSUM &&
+				       cbh->h_chksum_size ==
+						JBD2_CRC32_CHKSUM_SIZE) ||
+				      (cbh->h_chksum_type == 0 &&
+				       cbh->h_chksum_size == 0 &&
+				       found_chksum == 0)))
+					goto chksum_error;
 
-					if (!jbd2_has_feature_async_commit(journal)) {
-						journal->j_failed_commit =
-							next_commit_ID;
-						brelse(bh);
-						break;
-					}
-				}
 				crc32_sum = ~0;
 			}
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+			chksum_error:
+				if (commit_time < last_trans_commit_time)
+					goto ignore_crc_mismatch;
 				info->end_transaction = next_commit_ID;
 
 				if (!jbd2_has_feature_async_commit(journal)) {
@@ -747,11 +814,24 @@ static int do_one_pass(journal_t *journal,
 					break;
 				}
 			}
+			if (pass == PASS_SCAN)
+				last_trans_commit_time = commit_time;
 			brelse(bh);
 			next_commit_ID++;
 			continue;
 
 		case JBD2_REVOKE_BLOCK:
+			/*
+			 * Check revoke block crc in pass_scan, if csum verify
+			 * failed, check commit block time later.
+			 */
+			if (pass == PASS_SCAN &&
+			    !jbd2_descriptor_block_csum_verify(journal,
+							       bh->b_data)) {
+				jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
+					  next_log_block);
+				need_check_commit_time = true;
+			}
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {
@@ -796,6 +876,13 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) &&  pass != PASS_REVOKE) {
+		err = fc_do_one_pass(journal, info, pass);
+		if (err)
+			success = err;
+	}
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
@@ -811,7 +898,7 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
-	unsigned csum_size = 0;
+	int csum_size = 0;
 	__u32 rcount;
 	int record_len = 4;
 
@@ -819,9 +906,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 	offset = sizeof(jbd2_journal_revoke_header_t);
 	rcount = be32_to_cpu(header->r_count);
 
-	if (!jbd2_descriptor_block_csum_verify(journal, header))
-		return -EFSBADCRC;
-
 	if (jbd2_journal_has_csum_v2or3(journal))
 		csum_size = sizeof(struct jbd2_journal_block_tail);
 	if (rcount > journal->j_blocksize - csum_size)
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 63ebef99..96fe34a4 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -12,6 +12,7 @@
 #else
 #include <arpa/inet.h>
 #endif
+#include <stdbool.h>
 
 #define printk printf
 #define KERN_ERR ""
@@ -66,9 +67,15 @@ static inline __u32 jbd2_chksum(journal_t *j EXT2FS_ATTR((unused)),
                 sizeof(struct __struct), __alignof__(struct __struct),\
                 (__flags), NULL)
 
-#define blkdev_issue_flush(kdev, a, b)	sync_blockdev(kdev)
+#define blkdev_issue_flush(kdev, a)	sync_blockdev(kdev)
 #define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
 #define pr_emerg(fmt)
+#define pr_err(...)
+
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
+#define JBD2_FC_REPLAY_STOP		0
+#define JBD2_FC_REPLAY_CONTINUE		1
 
 struct journal_s
 {
@@ -79,13 +86,16 @@ struct journal_s
 	int			j_format_version;
 	unsigned long		j_head;
 	unsigned long		j_tail;
+	unsigned long		j_fc_first;
+	unsigned long		j_fc_off;
+	unsigned long		j_fc_last;
 	unsigned long		j_free;
 	unsigned long		j_first, j_last;
 	kdev_t			j_dev;
 	kdev_t			j_fs_dev;
 	int			j_blocksize;
 	unsigned int		j_blk_offset;
-	unsigned int		j_maxlen;
+	unsigned int		j_total_len;
 	struct inode *		j_inode;
 	tid_t			j_tail_sequence;
 	tid_t			j_transaction_sequence;
@@ -94,6 +104,11 @@ struct journal_s
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 	tid_t			j_failed_commit;
 	__u32			j_csum_seed;
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh,
+				    enum passtype pass, int off,
+				    tid_t expected_tid);
+
 };
 
 #define is_journal_abort(x) 0
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index cb1bc308..6ec1a8c9 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -72,8 +72,13 @@ extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), 1)
+#define jbd_get_num_fc_blks(jsb)					\
+	(be32_to_cpu((jsb)->s_num_fc_blks) ?				\
+	 be32_to_cpu((jsb)->s_num_fc_blks) : JBD2_DEFAULT_FAST_COMMIT_BLOCKS)
+
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
 
 /*
  * Internal structures used by the logging mechanism:
@@ -94,6 +99,7 @@ extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
@@ -233,7 +239,10 @@ typedef struct journal_superblock_s
 /* 0x0050 */
 	__u8	s_checksum_type;	/* checksum type */
 	__u8	s_padding2[3];
-	__be32	s_padding[42];
+/* 0x0054 */
+	__be32	s_num_fc_blks;		/* Number of fast commit blocks */
+/* 0x0058 */
+	__be32	s_padding[41];
 	__be32	s_checksum;		/* crc32c(superblock) */
 
 /* 0x0100 */
@@ -259,6 +268,7 @@ typedef struct journal_superblock_s
 #define JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT	0x00000004
 #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
 #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
+#define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
 
 /* Features known to this kernel version: */
 #define JBD2_KNOWN_COMPAT_FEATURES	0
@@ -267,7 +277,8 @@ typedef struct journal_superblock_s
 					 JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT| \
 					 JBD2_FEATURE_INCOMPAT_64BIT|\
 					 JBD2_FEATURE_INCOMPAT_CSUM_V2|	\
-					 JBD2_FEATURE_INCOMPAT_CSUM_V3)
+					 JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
+					 JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
 
 #ifdef NO_INLINE_FUNCS
 extern size_t journal_tag_bytes(journal_t *journal);
@@ -384,6 +395,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 #if (defined(E2FSCK_INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
 /*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

