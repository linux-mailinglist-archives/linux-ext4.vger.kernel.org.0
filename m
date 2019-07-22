Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04A66F82E
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfGVECU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37464 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfGVECT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so16711445pfa.4
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sk56q6hVxexib06TURhoa2TWAOhd6OYvXJ71m97AbPY=;
        b=PwtfYhi3RRiw7K+jXa7BebuzeQi5vMl/+XxL9ej5c7V3JDxX5hgWfOo+XQI2saGGCF
         5uLqVpegS+nICGRuwmjU8lTSq2wq1aH5eISFH+pzgWrsqDiH8vOknHfN5R64G3SB6eKh
         p1qehpRst6wpBvUN7+xSsJprtDvsZYm6ZXI6wqLGCTMwmWXXuZ+vuxVCs9Cy3xCglmPu
         XLdC5NCCfDo5HXshIddSJf3eaxXd1yrrmZmZD1Ks7w/fYr8HDCOEEPTelffLEIQpcN1O
         L2FH3oJ+7BhysjNHIX/RBr/+yxggL7A5ejDLPiNOTMMQptHgJPLTi8Eoq4HCu4mR3vOA
         ePzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sk56q6hVxexib06TURhoa2TWAOhd6OYvXJ71m97AbPY=;
        b=lPNc55r0j4LBqj4UgMCQBvFRv0NI7GFut4Gk5PzutwGnMcDfj51XJa0SnjtQBxTITz
         60YrBb93p6RDP0Zn8/QKsIa66gA67siZCCAZfaZk4YPgh3540Y4bMrn2zYkBOklcvsmh
         Gfqf8fFTlq3ZPNUfhVkzo7qgBq5RqYVXulmfEO6W8u5ha8mbdnarkG8qDmb0xs4RPj4m
         X+XS18JVF7+owdJiPP4Alib++u9Mgp2CjyQ2RJvG0GOSjALELmeREYJJvcXTYFmqMA28
         LzG1/+XsQjx6MayGyIpupQxGcHeeVN1mBs/t8Na/cDcOqhGYziNLCVAOgNRSw11Ns8cO
         BoOQ==
X-Gm-Message-State: APjAAAWJBp3hoLVTlLIDgWMmPlMMshqNFnldMRPVVI20FgqXPzOfKxWc
        GSxD3U2/fHKvGfsTFvOJX5iSp+Cm
X-Google-Smtp-Source: APXvYqwsxcZmA26mf/MtaE9Mjp3FrzAogYc9IImwRH91Kevr6N+6TArbZjf+z3sz3iTB38MH0fy7CQ==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr73342167pjp.105.1563768138266;
        Sun, 21 Jul 2019 21:02:18 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 05/11] jbd2: fast-commit commit path new APIs
Date:   Sun, 21 Jul 2019 21:00:05 -0700
Message-Id: <20190722040011.18892-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds new helper APIs that ext4 needs for fast
commits. These new fast commit APIs are used by subsequent fast commit
patches to implement fast commits. Following new APIs are added:

/*
 * Returns when either a full commit or a fast commit
 * completes
 */
int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
			    tid_t tid, tid_t subtid)

/* Send all the data buffers related to an inode */
int journal_submit_inode_data(journal_t *journal,
			      struct jbd2_inode *jinode)

/* Map one fast commit buffer for use by the file system */
int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)

/* Submit all mapped fast commit buffers */
jbd2_submit_fc_bufs(journal_t *journal, bh_end_io_t *end_io)

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c     |  31 +++++++++++++
 fs/jbd2/journal.c    | 107 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/jbd2.h |   6 +++
 3 files changed, 144 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 241581c23aa3..1713aebcf38d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -202,6 +202,37 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
 	return ret;
 }
 
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
+{
+	struct address_space *mapping;
+	loff_t dirty_start = jinode->i_dirty_start;
+	loff_t dirty_end = jinode->i_dirty_end;
+	int ret;
+
+	if (!jinode)
+		return 0;
+
+	if (!(jinode->i_flags & JI_WRITE_DATA))
+		return 0;
+
+	dirty_start = jinode->i_dirty_start;
+	dirty_end = jinode->i_dirty_end;
+
+	mapping = jinode->i_vfs_inode->i_mapping;
+	jinode->i_flags |= JI_COMMIT_RUNNING;
+
+	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
+	ret = journal_submit_inode_data_buffers(mapping, dirty_start,
+						dirty_end);
+
+	jinode->i_flags &= ~JI_COMMIT_RUNNING;
+	/* Protect JI_COMMIT_RUNNING flag */
+	smp_mb();
+	wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
+
+	return ret;
+}
+
 /*
  * Submit all the data buffers of inode associated with the transaction to
  * disk.
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6fad7a15ea82..cbe6e72a25e6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -811,6 +811,33 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid)
 }
 EXPORT_SYMBOL(jbd2_complete_transaction);
 
+int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid)
+{
+	int	need_to_wait = 1;
+
+	read_lock(&journal->j_state_lock);
+	if (journal->j_running_transaction &&
+	    journal->j_running_transaction->t_tid == tid) {
+		/* Check if fast commit was already done */
+		if (journal->j_subtid > subtid)
+			need_to_wait = 0;
+		if (journal->j_commit_request != tid) {
+			/* transaction not yet started, so request it */
+			read_unlock(&journal->j_state_lock);
+			jbd2_log_start_commit(journal, tid, false);
+			goto wait_commit;
+		}
+	} else if (!(journal->j_committing_transaction &&
+		     journal->j_committing_transaction->t_tid == tid))
+		need_to_wait = 0;
+	read_unlock(&journal->j_state_lock);
+	if (!need_to_wait)
+		return 0;
+wait_commit:
+	return __jbd2_log_wait_commit(journal, tid, subtid);
+}
+EXPORT_SYMBOL(jbd2_complete_transaction);
+
 /*
  * Log buffer allocation routines:
  */
@@ -831,6 +858,86 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
 	return jbd2_journal_bmap(journal, blocknr, retp);
 }
 
+int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
+{
+	unsigned long long pblock;
+	unsigned long blocknr;
+	int ret = 0;
+	struct buffer_head *bh;
+	int fc_off;
+	journal_header_t *jhdr;
+
+	write_lock(&journal->j_state_lock);
+
+	if (journal->j_fc_off + journal->j_first_fc < journal->j_last_fc) {
+		fc_off = journal->j_fc_off;
+		blocknr = journal->j_first_fc + fc_off;
+		journal->j_fc_off++;
+	} else {
+		ret = -EINVAL;
+	}
+	write_unlock(&journal->j_state_lock);
+
+	if (ret)
+		return ret;
+
+	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
+	if (ret)
+		return ret;
+
+	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
+	if (!bh)
+		return -ENOMEM;
+
+	lock_buffer(bh);
+	jhdr = (journal_header_t *)bh->b_data;
+	jhdr->h_magic = cpu_to_be32(JBD2_MAGIC_NUMBER);
+	jhdr->h_blocktype = cpu_to_be32(JBD2_FC_BLOCK);
+	jhdr->h_sequence = cpu_to_be32(journal->j_running_transaction->t_tid);
+
+	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
+	journal->j_fc_wbuf[fc_off] = bh;
+
+	*bh_out = bh;
+
+	return 0;
+}
+
+int jbd2_submit_fc_bufs(journal_t *journal, bh_end_io_t *end_io)
+{
+	struct buffer_head *bh;
+	int ret, i, j_fc_off;
+
+	read_lock(&journal->j_state_lock);
+	j_fc_off = journal->j_fc_off;
+	read_unlock(&journal->j_state_lock);
+
+	for (i = 0; i < j_fc_off; i++) {
+		bh = journal->j_fc_wbuf[i];
+
+		if (!bh)
+			return -ENOMEM;
+
+		lock_buffer(bh);
+		clear_buffer_dirty(bh);
+		set_buffer_uptodate(bh);
+		bh->b_end_io = end_io;
+		if (journal->j_flags & JBD2_BARRIER &&
+		    !jbd2_has_feature_async_commit(journal))
+			ret = submit_bh(REQ_OP_WRITE,
+					REQ_SYNC | REQ_PREFLUSH | REQ_FUA,
+					bh);
+		else
+			ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+		wait_on_buffer(bh);
+		if (ret || !buffer_uptodate(bh))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * Conversion of logical to physical block numbers for the journal
  *
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 7f832283e4b9..1bf979b7cdc0 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -124,6 +124,7 @@ typedef struct journal_s	journal_t;	/* Journal control structure */
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
@@ -1580,6 +1581,7 @@ int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
+int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid);
 
 void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
@@ -1730,6 +1732,10 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 	return tid;
 }
 
+int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out);
+int jbd2_submit_fc_bufs(journal_t *journal, bh_end_io_t *end_io);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+
 #ifdef __KERNEL__
 
 #define buffer_trace_init(bh)	do {} while (0)
-- 
2.22.0.657.g960e92d24f-goog

