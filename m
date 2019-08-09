Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12487046
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405194AbfHIDqe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33934 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHIDqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so38927927pgc.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpt0b1KZUhGaMVUg1HH6jpR3z+8EsMhPMABTfN2nNvM=;
        b=BAZTJ/LEkQEeMJhM335/Wwzv6QnXexYVKO0oGHrG0WPMkHFGQNLKnkwnMcXKJRclwe
         M1+3D6Ov/A4GIHdHM0QyZippii/vgkf5AfZgKxslP95ltDSp4swOtJeMUT991xY5ohBe
         5/TjRTdUyhra/KArbxI4+7b76OkWkmf/r32N2mLKbJS0rZ7cULjBbPPT2Olq7VnDfhUf
         JhuJpk7i5MzQDbC5qGCN+LzGpsxEctxs2BRDXrnboJN8KD7AYtB1uG1N+lE0rGcGgVU9
         FYUGM7cn4A20dou1Qo363TGL2a5l6fn1KdXGMZodSacbyHYH0h8W0pOp8hULHmhHhvnJ
         xUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpt0b1KZUhGaMVUg1HH6jpR3z+8EsMhPMABTfN2nNvM=;
        b=GQeFTnVVZT4QzR9EeBPPtsnc5DiNpDOQ+Ly0+P9GEd16iongdnEpLMQW1NXkbYBxmG
         zvKNJBUpbHluJ5mE17SqQHrqQc7LTX2vjJQyYvDn+ftlhDN2hQ30FS2lExbkFSEeEMe2
         OpxSUDf0BTA2SHMIw7hkjytlLdEhFAdABIuKsJIJ8eHOfRTp02kXyVmAg3aadXxY+5JC
         PgUHly66Qa2DXI14O+xN42CuPCbd0zbuRV6sadK7+iD3tM5/PcSGKzjrPUCIrt0Je/l7
         zhvSu4BNja9GJaUMvvluzi9OO6ynaQW7jF4H3VgJ5snzoU73iLSsK1qCEEccEMlpzfr4
         4tYw==
X-Gm-Message-State: APjAAAVKAWMXAvgeCNH2Pq2yIvQ6vNZ5z2b0kN4gtaXf16RhBNLzZ9x1
        luu89gxyOtzckSmSMWdJBbBZNP8z
X-Google-Smtp-Source: APXvYqwjWsbuE7HtJODNkz6YbCkMTVIPkWXgr9gQRIIqteJaEMuZdGiEtX6yWryyIkCYskY6NRzi6w==
X-Received: by 2002:a17:90a:710c:: with SMTP id h12mr7226114pjk.36.1565322391608;
        Thu, 08 Aug 2019 20:46:31 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:31 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
Date:   Thu,  8 Aug 2019 20:45:45 -0700
Message-Id: <20190809034552.148629-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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

/* Wait on fast commit buffers to complete IO */
jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

---

Changelog:

V2: 1) Fixed error reported by kbuild test robot. Removed duplicate
       EXPORT_SYMBOL() call. Also, added EXPORT_SYMBOL() for the new
       APIs introduced.
    2) Changed jbd2_submit_fc_bufs() to jbd2_wait_on_fc_bufs(). This
       gives client file system to submit JBD2 buffers according to
       its own convenience.
---
 fs/jbd2/commit.c     | 32 +++++++++++++++
 fs/jbd2/journal.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/jbd2.h |  6 +++
 3 files changed, 136 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 9281814606e7..db62a53436e3 100644
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
index ab05e47ed2d4..1e15804b2c3c 100644
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
+EXPORT_SYMBOL(jbd2_fc_complete_commit);
+
 /*
  * Log buffer allocation routines:
  */
@@ -831,6 +858,77 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
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
index 535f88dff653..5362777d06f8 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -124,6 +124,7 @@ typedef struct journal_s	journal_t;	/* Journal control structure */
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
@@ -1582,6 +1583,7 @@ int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
+int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid);
 
 void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
@@ -1732,6 +1734,10 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 	return tid;
 }
 
+int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out);
+int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+
 #ifdef __KERNEL__
 
 #define buffer_trace_init(bh)	do {} while (0)
-- 
2.23.0.rc1.153.gdeed80330f-goog

