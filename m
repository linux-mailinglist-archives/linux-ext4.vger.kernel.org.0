Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DBA1A2B86
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDHVz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33517 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgDHVzz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id c138so3733871pfc.0
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpBJs4b8LdhljW/mbELyC+7Lt7EHv44g0hNPCugQeCA=;
        b=Cco/J1RAjpj/6AjOuwb55YBbAacUCjs9l0lz3mgG3dj4Nw97onQrhKlzu9V32YmaSO
         AXXBlxa6lrMKy//aiJvr+DmzbQK+RCwkhJa4TwtSayVEXAVDhjtoboGDvcU06FwHRmeg
         EREiEyvcrNjjqzQvYuKPy+fCWAKNwSWWeSGkNPB3GIMda6tHUAWmNXkD+vV/TDS9dhg9
         JqlV9ZTLHgdqKKwgR74Vqpd5U6pPOPL3WlByOsyzEfggeOf71OKbUjTDruzLhaInd9BL
         XR+oIGXQzTUySpI86BOKM1ja6PPGtoT7Fck9GhuV9aru7xTvmcYgQL7/q/HLmv8RV207
         XN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpBJs4b8LdhljW/mbELyC+7Lt7EHv44g0hNPCugQeCA=;
        b=FB+/4fhulJlTBjd+g20mMM6h4o9a82RS/QVt089efbZ3z9uJ0fP1NenugQM7ccgmi+
         jPqEzmJ2W/sqJ980mN3aiBOsHJBakhnHBgGNTSW/S/nRd7TyTrIryvlMzHPznpz9Rbw2
         eQGHl4fl0S8Wo00/ZhtLQgtEU4VKPyaXErQOIINETc3gRY+f7Nsv2qLqQQV5TH6V7782
         twWOfGR/eGZQQiGwBmAXGatG7RG9mO5do7z5CopVHXQPSypg8nW/3vOafwOLF1R+bJpP
         CzVN0TOpw/sS3xyzcC0yaC0B5sI9Sy1v7orbLVKUlSJCIPN5CyHYYahm/cVdCA70xmiO
         EhgQ==
X-Gm-Message-State: AGi0PuYLL01LT1X3RE80rfTEC9ZhY9nbhVdkPAO40A8y79031Hr39R5X
        nWZYZcPqZLNSoH1T1bz5v6w/1pJD
X-Google-Smtp-Source: APiQypLTSWSMQg33yOSOnyHy9AuA8n4wYOGR9TivDenZDOi0i+jqBpxj4Psyt1vYvwRtzRM7NDx0Iw==
X-Received: by 2002:a63:721a:: with SMTP id n26mr8883861pgc.386.1586382953746;
        Wed, 08 Apr 2020 14:55:53 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:53 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 13/20] jbd2: add new APIs for commit path of fast commits
Date:   Wed,  8 Apr 2020 14:55:23 -0700
Message-Id: <20200408215530.25649-13-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add following helpers for commit path:
- jbd2_map_fc_buf() - allocates fast commit buffers for caller
- jbd2_wait_on_fc_bufs() - waits on fast commit buffers allocated
			   using jbd2_map_fc_buf()
- jbd2_submit_inode_data() - submit data buffers for one inode
- jbd2_wait_inode_data() - wait for inode data

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c     | 40 +++++++++++++++++++++++
 fs/jbd2/journal.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/jbd2.h |  6 ++++
 3 files changed, 122 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 280d11591bcb..2ef2dfb029e4 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -202,6 +202,46 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
 	return ret;
 }
 
+/* Send all the data buffers related to an inode */
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
+{
+	struct address_space *mapping;
+	loff_t dirty_start;
+	loff_t dirty_end;
+	int ret;
+
+	if (!jinode)
+		return 0;
+
+	dirty_start = jinode->i_dirty_start;
+	dirty_end = jinode->i_dirty_end;
+
+	if (!(jinode->i_flags & JI_WRITE_DATA))
+		return 0;
+
+	dirty_start = jinode->i_dirty_start;
+	dirty_end = jinode->i_dirty_end;
+
+	mapping = jinode->i_vfs_inode->i_mapping;
+
+	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
+	ret = journal_submit_inode_data_buffers(mapping, dirty_start,
+						dirty_end);
+
+	return ret;
+}
+EXPORT_SYMBOL(jbd2_submit_inode_data);
+
+int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
+{
+	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA))
+		return 0;
+	return filemap_fdatawait_range_keep_errors(
+		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
+		jinode->i_dirty_end);
+}
+EXPORT_SYMBOL(jbd2_wait_inode_data);
+
 /*
  * Submit all the data buffers of inode associated with the transaction to
  * disk.
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d3897d155fb9..e4e0b55dd077 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -864,6 +864,82 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
 	return jbd2_journal_bmap(journal, blocknr, retp);
 }
 
+/* Map one fast commit buffer for use by the file system */
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
+/*
+ * Wait on fast commit buffers that were allocated by jbd2_map_fc_buf
+ * for completion.
+ */
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
index 0a4d9d484528..599113bef67f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -123,6 +123,7 @@ typedef struct journal_s	journal_t;	/* Journal control structure */
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
@@ -1562,6 +1563,11 @@ int jbd2_start_async_fc_nowait(journal_t *journal, tid_t tid);
 int jbd2_start_async_fc_wait(journal_t *journal, tid_t tid);
 void jbd2_stop_async_fc(journal_t *journal, tid_t tid);
 void jbd2_init_fast_commit(journal_t *journal, int num_fc_blks);
+int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out);
+int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+
 /*
  * is_journal_abort
  *
-- 
2.26.0.110.g2183baf09c-goog

