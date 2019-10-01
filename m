Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5CC2E56
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfJAHmG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34610 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfJAHmF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so9029855pgl.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bz+rdl11Fft4nus7aI+CndEpiy5sIXJpnFCsdgrzL78=;
        b=J/v2WAn6fHJPJUdPrARnwP+7PiV5Sqlfs7/H/B+irldozDbseaE633P/+vBaVAXWbl
         Aazj954Frn8lgxc7ynQALMxyd8sD5PukIIS9R0UVC4c4nDoORrEppMfeAwjV3cV21Q6O
         UHkOCiOYFdrCk5DxXYwUF3RtOlgwV1FZ3OHrPV6oG4NL6Q4yv1rkDtX0OEkr5rrv2+WC
         Wc3KoOPbiynlpWLr/ZNAyMxRyyMC4pk9B3err7qas8Bq3Go4SXNaxzrzQ0nPgUnpLD/P
         UydrVsnvHKkrEKiQhxrTBDLix2tHqhQjeALyrN47Ig1+phq2xtHkjrv/bgO1v4+/+pzS
         U2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bz+rdl11Fft4nus7aI+CndEpiy5sIXJpnFCsdgrzL78=;
        b=sU9aEAnNlZUb3ty2AzBf3AqjQYZ4E070IkIJI3zA2mZrMSS8ALwXKDfdz660P/ptkn
         ueWUr790YH+yucB8470ROCoGHVeOLtlog3x94CqfVquKbpcz+vtJj35vxBdfSQLH2mAM
         kNiZFkvx1NfnGH6i6rgr/sv2+7xN+23IZQ91X4Uld3sGzsvUxTfbGA4xfLlbOBJM/l4O
         HiLP768dErNyI/bRA5xDUDQ12A6u5vI8vc7e1lvClhA0QfdatTCS4l7PHNbr6b+SWiJn
         IRLSJ7z5AKzZm8tgx0PMlRCX26EhtG2eZh7kUGpRTcs5QRtD0vqk2q+pgvB6/DpLAdwR
         t1og==
X-Gm-Message-State: APjAAAWY5BI2uQLrrByGvcm6hRzwBaV+o8PoCguJO/d71/eaQKIaUJVo
        EG8b0pRzzkuLpkpH/CyUCCNdAVpwZXE=
X-Google-Smtp-Source: APXvYqy2mEV7ILpD2faGuOcploLj4Nc9oKApAgmyhOly5atCRfn3Duh7GKFkeiCALwwvsLElVmZTLg==
X-Received: by 2002:a62:be01:: with SMTP id l1mr26372219pff.236.1569915724262;
        Tue, 01 Oct 2019 00:42:04 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:03 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 04/13] jbd2: fast-commit commit path new APIs
Date:   Tue,  1 Oct 2019 00:40:53 -0700
Message-Id: <20191001074101.256523-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
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
			                tid_t subtid)

/* Send all the data buffers related to an inode */
int journal_submit_inode_data(journal_t *journal,
			                  struct jbd2_inode *jinode)

/* Map one fast commit buffer for use by the file system */
int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)

/* Wait on fast commit buffers to complete IO */
jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)

/*
 * Returns 1 if transaction identified by tid:subtid is already
 * committed.
 */
int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid)

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c     |  32 +++++++++++++
 fs/jbd2/journal.c    | 110 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/jbd2.h |   8 ++++
 3 files changed, 150 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7db3e2b6336d..e85f51e1cc70 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -202,6 +202,38 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
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
+EXPORT_SYMBOL(jbd2_submit_inode_data);
+
 /*
  * Submit all the data buffers of inode associated with the transaction to
  * disk.
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6853064605ff..14d549445418 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -781,6 +781,18 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	return __jbd2_log_wait_commit(journal, tid, 0);
 }
 
+int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid)
+{
+	if (journal->j_commit_sequence >= tid)
+		return 1;
+	if (!journal->j_running_transaction)
+		return 0;
+	if (journal->j_running_transaction->t_tid > tid)
+		return 1;
+	if (journal->j_running_transaction->t_subtid > subtid)
+		return 1;
+	return 0;
+}
 
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
@@ -830,6 +842,33 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid)
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
+		if (tid_geq(journal->j_fc_sequence, subtid))
+			need_to_wait = 0;
+		if (journal->j_commit_request != tid) {
+			/* transaction not yet started, so request it */
+			read_unlock(&journal->j_state_lock);
+			jbd2_log_start_commit_fast(journal, tid);
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
+EXPORT_SYMBOL(jbd2_fc_complete_commit);
+
 /*
  * Log buffer allocation routines:
  */
@@ -850,6 +889,77 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
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
+EXPORT_SYMBOL(jbd2_map_fc_buf);
+
+int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks)
+{
+	struct buffer_head *bh;
+	int i, j_fc_off;
+
+	read_lock(&journal->j_state_lock);
+	j_fc_off = journal->j_fc_off;
+	read_unlock(&journal->j_state_lock);
+
+	/*
+	 * Wait in reverse order to minimize chances of us being woken up before
+	 * all IOs have completed
+	 */
+	for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
+		bh = journal->j_fc_wbuf[i];
+		wait_on_buffer(bh);
+		if (unlikely(!buffer_uptodate(bh)))
+			return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(jbd2_wait_on_fc_bufs);
+
 /*
  * Conversion of logical to physical block numbers for the journal
  *
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 41315f648c0f..c6a2b82de4cf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -124,6 +124,7 @@ typedef struct journal_s	journal_t;	/* Journal control structure */
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
@@ -1579,6 +1580,7 @@ int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
+int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid);
 
 void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
@@ -1729,6 +1731,12 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 	return tid;
 }
 
+/* Fast commit related APIs */
+int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out);
+int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid);
+
 #ifdef __KERNEL__
 
 #define buffer_trace_init(bh)	do {} while (0)
-- 
2.23.0.444.g18eeb5a265-goog

