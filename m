Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F6028B927
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgJLN5w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJLNnh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 09:43:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A72C0613D2
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 06:43:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so13543089pfc.7
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fl9kdnLkLr5LKx6he1xqW2Z8zAy6MnXzMOMYDp1Y1hk=;
        b=dO7PpPQChDdGVX4hfkT01DUbdaj2jJYPzn+nHHwqmZ7peZUIDhgPgtAljfe3WHHPQq
         F9zxlo8ehAEKv9lAtho9PFJDFJkrSBp8627UhP227u4HW8fCWoHsr2R0mn8gYt1752fr
         4eL0MV2vjbI+OtbclsmJSbX6wNryI4ffl2QZHvC7euS0XrJGFbHOd7O1FVlBQd4d/J7x
         xUT7Xrog09YtG8fzDKN+sUIurVSFY8x/VVwKpR/YsJS5evhhcSPGrFHRBKJ5p4zlQQms
         GsCTvr3rOLne1a5TDVRX3xqIU3HiCx1ZgQGOdONG4QfHbl7apHLGQYzWgDbhy+bfDJI/
         dskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fl9kdnLkLr5LKx6he1xqW2Z8zAy6MnXzMOMYDp1Y1hk=;
        b=ejJ1n9hLh2a06LZ6w5Z9ggezwa68bLySdDAnMNER6+zvxvlwlOAS2f3JtKRFE+L6gP
         RgOvNqnV8xr3a+StccfjKLO8JvHVJeTAcyc5/cOZPb0pHWytvSwUIDZGjy1dDkjLHO52
         91ofqHzdjnHzavqhnLg9GlXDBYMH5ubBGlCxLF6wIMAePGH9oKcAwSzJuL5N0YvviYrZ
         xlqUrQFm1nGeDF2hcv75e4pnyB9U7TMymlgwjiRKSG2LjqQjLAFEzauw8E5eVM4XRvY1
         FUUnuJhyvx0nNUvmpyurNNvCy5uZmaWpDUh7vfScPwCQEvnbGJZ0ImTniRsT7gjpSuPP
         EANA==
X-Gm-Message-State: AOAM5309UYtm+qPjkdnYoNp5+FzcCfwLuFgnMXSnTDxlZy57PiL6T7vV
        BFa6/aYnPND0pgfiqpgFInTddSVfkvFGNA==
X-Google-Smtp-Source: ABdhPJw0dYwpllvd+KWMiD7gMKDbJfXuSbGHnDQzpErdmQ9l+7a6Bpzx0/TZsaAwn2vd4ncEVzXpfg==
X-Received: by 2002:a63:e802:: with SMTP id s2mr13466581pgh.350.1602510216271;
        Mon, 12 Oct 2020 06:43:36 -0700 (PDT)
Received: from localhost.localdomain (114-43-166-182.dynamic-ip.hinet.net. [114.43.166.182])
        by smtp.googlemail.com with ESMTPSA id p62sm5373243pfb.180.2020.10.12.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:43:35 -0700 (PDT)
From:   Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@hikvision.com>
To:     tytso@mit.edu, jack@suse.cz
Cc:     adilger@dilger.ca, linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>
Subject: [PATCH] [PATCH v5]jbd2: avoid transaction reuse after reformatting
Date:   Mon, 12 Oct 2020 21:43:22 +0800
Message-Id: <20201012134322.5956-1-changfengnan@hikvision.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
 fs/jbd2/recovery.c | 97 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..4d0aff628884 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -428,6 +428,8 @@ static int do_one_pass(journal_t *journal,
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
 	int			descr_csum_size = 0;
 	int			block_error = 0;
+	bool		need_check_commit_time = false;
+	__be64		last_trans_commit_time = 0, commit_time = 0;
 
 	/*
 	 * First thing is to establish what we expect to find in the log
@@ -520,12 +522,21 @@ static int do_one_pass(journal_t *journal,
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
@@ -535,6 +546,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass != PASS_REPLAY) {
 				if (pass == PASS_SCAN &&
 				    jbd2_has_feature_checksum(journal) &&
+				    !need_check_commit_time &&
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
@@ -683,11 +695,50 @@ static int do_one_pass(journal_t *journal,
 			 *	 mentioned conditions. Hence assume
 			 *	 "Interrupted Commit".)
 			 */
-
+			/*
+			 * If need_check_commit_time is set, it means
+			 * csum verify failed before, if commit_time is
+			 * increasing, it's same journal, otherwise it
+			 * is stale journal block, just end this
+			 * recovery.
+			 */
+			if (pass == PASS_SCAN) {
+				struct commit_header *cbh =
+					(struct commit_header *)bh->b_data;
+				commit_time =
+					be64_to_cpu(cbh->h_commit_sec);
+				/*
+				 * When need check commit time, it means csum
+				 * verify failed before, if commit time is
+				 * increasing, it's same journal, otherwise
+				 * not same journal, just end this recovery.
+				 */
+				if (need_check_commit_time) {
+					if (commit_time >=
+						last_trans_commit_time) {
+						pr_err("JBD2: Invalid checksum found in transaction %u\n",
+								next_commit_ID);
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
+							next_commit_ID);
+					err = 0;
+					brelse(bh);
+					goto done;
+				}
+			}
 			/* Found an expected commit block: if checksums
 			 * are present verify them in PASS_SCAN; else not
 			 * much to do other than move on to the next sequence
-			 * number. */
+			 * number.
+			 */
 			if (pass == PASS_SCAN &&
 			    jbd2_has_feature_checksum(journal)) {
 				int chksum_err, chksum_seen;
@@ -727,6 +778,13 @@ static int do_one_pass(journal_t *journal,
 						chksum_err = 1;
 
 				if (chksum_err) {
+					if (commit_time <
+						last_trans_commit_time) {
+						jbd_debug(1, "JBD2: Invalid commit checksum ignored in transaction %u, likely stale data\n",
+							next_log_block);
+						brelse(bh);
+						goto done;
+					}
 					info->end_transaction = next_commit_ID;
 
 					if (!jbd2_has_feature_async_commit(journal)) {
@@ -741,6 +799,12 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+				if (commit_time < last_trans_commit_time) {
+					jbd_debug(1, "JBD2: Invalid commit checksum ignored in transaction %u, likely stale data\n",
+						next_log_block);
+					brelse(bh);
+					goto done;
+				}
 				info->end_transaction = next_commit_ID;
 
 				if (!jbd2_has_feature_async_commit(journal)) {
@@ -750,11 +814,25 @@ static int do_one_pass(journal_t *journal,
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
+			if (pass == PASS_SCAN) {
+				if (!jbd2_descriptor_block_csum_verify(journal,
+						bh->b_data)) {
+					jbd_debug(1, "invalid revoke block found in %lu\n",
+						next_log_block);
+					need_check_commit_time = true;
+				}
+			}
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {
@@ -822,9 +900,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 	offset = sizeof(jbd2_journal_revoke_header_t);
 	rcount = be32_to_cpu(header->r_count);
 
-	if (!jbd2_descriptor_block_csum_verify(journal, header))
-		return -EFSBADCRC;
-
 	if (jbd2_journal_has_csum_v2or3(journal))
 		csum_size = sizeof(struct jbd2_journal_block_tail);
 	if (rcount > journal->j_blocksize - csum_size)
-- 
2.25.1

