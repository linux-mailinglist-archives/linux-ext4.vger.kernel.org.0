Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E100C17D98E
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCIHGH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45731 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgCIHGG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id b22so3596044pls.12
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Yg9h/BkCqAyVyurqEvoUEPZLCnxc1sQkpwyXtdPG6o=;
        b=oO/LETFOv/6htTAW0yDtzicdYHV6rDzc5oRF3P1DJj9m1bm6o5J53Yf7DhddPEGIom
         2kTxEz147jpJOfrx6lMgaqg86kefq11RaexCHMuiw35WuPtxHTdo7gsews5c+mYKt+71
         Vvru6BGs8f9qocGe1cT79QO9e0V4sUJVzSdHGljjeTpMcHM4drsIYIfo2bSauov40eoF
         Fk1szwoEACTPbWll9NslmOOI8ioELamhkDKgWpxZrYfY4x8Oj/HJyK7JYep4nbSol+SB
         uDipSjbqZgBSj7FrE40iHVGYjOvdDULCMVrwa0DlccAxVkW4xQvtHu55YLoghM2TU2wp
         VEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Yg9h/BkCqAyVyurqEvoUEPZLCnxc1sQkpwyXtdPG6o=;
        b=qqjZBWE6ALzDLCApiIecNjVojeJiTwaZin86ilfS65jex1LexEww7HBwUSkWr7iDfG
         VtsA0+HZ+eeLSEyiYHW9qDpo/SDoOZMgYou8NRsb69JBtRlaFVxwG6/E7Wjbcu/gaaG6
         bb0HtQhhe8f7aU1PwDxkgSwAMJW34cQ90j6h8VwgQs+jp+YF+1UEzTV/7dr27ZcR0b4A
         Cawu+RcV5ZGZ/L6qB9qd2nvUJr94wp7477xA0L1h6m2kz1mV7b+5Td6ocvhqZ/knmkc7
         Iy1Fr++MO7V7+185QlH4Hw7sY6flBRTVcc1614MZ3PNwSid5AajgPRwXK59+u02tbZmG
         PqXw==
X-Gm-Message-State: ANhLgQ1t0p6dXWjFGU1G1cn6UszN7MSKaHR4gpeJQMdUspLZ/x58RgIz
        4nBGjNXs70llGftd6HGwUodRSuPa
X-Google-Smtp-Source: ADFU+vvOL3jMqujhRNgEmeRW6p2Rt0yyIPRXH0vtXbqKAXjpTOYGs5hjuNegZLwmkilQh8cVP3/C0A==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr17603787pjs.21.1583737565235;
        Mon, 09 Mar 2020 00:06:05 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:04 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 13/20] jbd2: add new APIs for commit path of fast commits
Date:   Mon,  9 Mar 2020 00:05:19 -0700
Message-Id: <20200309070526.218202-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index 869fe193fbe3..a4c4c6717674 100644
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
2.25.1.481.gfbce0eb801-goog

