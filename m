Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30969284A56
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 12:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFKb6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 06:31:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFKb6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Oct 2020 06:31:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA5A9AD21;
        Tue,  6 Oct 2020 10:31:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0BE431E1305; Tue,  6 Oct 2020 12:31:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Fengnan Chang <changfengnan@hikvision.com>,
        changfengnan <fengnanchang@foxmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] jbd2: avoid transaction reuse after reformatting
Date:   Tue,  6 Oct 2020 12:31:54 +0200
Message-Id: <20201006103154.7130-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: changfengnan <fengnanchang@foxmail.com>

When ext4 is formatted with lazy_journal_init=1 and transactions from
the previous filesystem are still on disk, it is possible that they are
considered during a recovery after a crash. Because the checksum seed
has changed, the CRC check will fail, and the journal recovery fails
with checksum error although the journal is otherwise perfectly valid.
Fix the problem by checking commit block time stamps to determine
whether the data in the journal block is just stale or whether it is
indeed corrupt.

Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 77 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 12 deletions(-)

Ted, Fengnan,

I've fixed up some mangled characters, whitespace, and coding style of
Fengnan's v2 submission. I also removed the additional check that commit
timestamps never go backwards - that could cause potential trouble e.g. when
system time gets moved backwards. Quick smoke test looks fine but Fengnan
please verify this patch works for you as well.

								Honza

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index faa97d748474..3f352a20c122 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -428,6 +428,8 @@ static int do_one_pass(journal_t *journal,
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
 	int			descr_csum_size = 0;
 	int			block_error = 0;
+	bool			need_check_commit_time = false;
+	__be64			last_trans_commit_time = 0;
 
 	/*
 	 * First thing is to establish what we expect to find in the log
@@ -520,12 +522,22 @@ static int do_one_pass(journal_t *journal,
 			if (descr_csum_size > 0 &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				printk(KERN_ERR "JBD2: Invalid checksum "
-				       "recovering block %lu in log\n",
-				       next_log_block);
-				err = -EFSBADCRC;
-				brelse(bh);
-				goto failed;
+				/*
+				 * PASS_SCAN can see stale blocks due to lazy
+ 				 * journal init. Don't error out on those yet.
+				 */
+				if (pass != PASS_SCAN) {
+					pr_err("JBD2: Invalid checksum "
+					       "recovering block %lu in log\n",
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
@@ -535,6 +547,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass != PASS_REPLAY) {
 				if (pass == PASS_SCAN &&
 				    jbd2_has_feature_checksum(journal) &&
+				    !need_check_commit_time &&
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
@@ -684,16 +697,20 @@ static int do_one_pass(journal_t *journal,
 			 *	 "Interrupted Commit".)
 			 */
 
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
 				struct commit_header *cbh =
 					(struct commit_header *)bh->b_data;
 				unsigned found_chksum =
 					be32_to_cpu(cbh->h_chksum[0]);
+				__be64 commit_time =
+					be64_to_cpu(cbh->h_commit_sec);
 
 				if (info->end_transaction) {
 					journal->j_failed_commit =
@@ -702,6 +719,33 @@ static int do_one_pass(journal_t *journal,
 					break;
 				}
 
+				/*
+				 * If need_check_commit_time is set, it means
+				 * csum verify failed before, if commit_time is
+				 * increasing, it's same journal, otherwise it
+				 * is stale journal block, just end this
+				 * recovery.
+				 */
+				if (need_check_commit_time) {
+					if (commit_time >= last_trans_commit_time) {
+						pr_err("JBD2: Invalid checksum found in transaction %u\n",
+						       next_commit_ID);
+						err = -EFSBADCRC;
+						brelse(bh);
+						goto failed;
+					}
+					/*
+					 * It likely does not belong to same
+					 * journal, just end this recovery with
+					 * success.
+					 */
+					jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
+						  next_commit_ID);
+					err = 0;
+					brelse(bh);
+					goto done;
+				}
+
 				/* Neither checksum match nor unused? */
 				if (!((crc32_sum == found_chksum &&
 				       cbh->h_chksum_type ==
@@ -714,6 +758,7 @@ static int do_one_pass(journal_t *journal,
 					goto chksum_error;
 
 				crc32_sum = ~0;
+				last_trans_commit_time = commit_time;
 			}
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
@@ -733,6 +778,17 @@ static int do_one_pass(journal_t *journal,
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
@@ -800,9 +856,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 	offset = sizeof(jbd2_journal_revoke_header_t);
 	rcount = be32_to_cpu(header->r_count);
 
-	if (!jbd2_descriptor_block_csum_verify(journal, header))
-		return -EFSBADCRC;
-
 	if (jbd2_journal_has_csum_v2or3(journal))
 		csum_size = sizeof(struct jbd2_journal_block_tail);
 	if (rcount > journal->j_blocksize - csum_size)
-- 
2.16.4

