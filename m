Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC0129EDC
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLXIPA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXIO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so9328505pfo.10
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OY6uQgGO3NmWOuzgDsuJ4inTLL6C7nmvrTsLnBkyUWI=;
        b=Bb/YVLedOrSj1Yv348P6Fk5+Ftcg/xnTJ0wPAfPGplWv+Sm6CPaWbIlVbJxdimrC0W
         4Q+vMUJEeRQVYa8tf5sKN+CCYuwgINMoFDtbOLKRZLhZuxCdw4otVAfPNxeXouHA2ooK
         4zqyQ0fSRDkdwvHGzEKtWruHOPnWGu9QRICPXkhetOw4I72JbOVBxo5USkDFCB3T1GjN
         0nrejJn+TwtXhxFqDem0Faz7xc8bkgzb2xtvnBUo+7Bu/x/6bH9pbCJqSnaWrVt9oh2U
         oaDCjBH83PTbd+fntTHYLJ5MEHqX+YdleQh2izl+t8MHzM+3AlpcLbJDK2rREaOHoJCL
         bU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OY6uQgGO3NmWOuzgDsuJ4inTLL6C7nmvrTsLnBkyUWI=;
        b=ulnQAl9PUdPpxGJw7RYpXFAx9SvHqKBduBODjThE4lwXwEZ0Us2aEUfQx/3gckY+6r
         SzdHVjWkttLSV5dJC7rA8eXyBC0/5rfeL7zwrVczuBnKVkUTtqospl2L4QSH4BscyjAr
         Cs2djMf02u9XCeUsEDGjh9UTuTVFKCrcqSk8VPCdMNVydCbmFnjbqdmj/YTX0VBYS8ke
         qUt0WzwwvF6njMDK32t94e263k7k/bmxDAyQ5VTVnipLNvyRC3kcTYkfL6fncOPZmYSg
         Wuuln1l1VqPDm3tGsuuVDqd/o6Cw6yvdLb/kLFqspxoFeUedH3IO/hGcgRTJ4QH4k0Rf
         ET/g==
X-Gm-Message-State: APjAAAVfGdBp7T/XaHQikdj+cmnyZTl7MVuQQ7M5iHj0/gU07zQKHg7s
        ShMzwP7lFqyq3ZbCAoHAU3p0pGFs
X-Google-Smtp-Source: APXvYqwf/d9UcLsLyynpGv+LiRWOhq3+6zsEfi7rKRX4OVAQSkyEctXfQl/Vx2hzXp9Cmwno0VuajQ==
X-Received: by 2002:a63:554c:: with SMTP id f12mr36693420pgm.23.1577175298395;
        Tue, 24 Dec 2019 00:14:58 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:58 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 13/20] jbd2: add new APIs for commit path of fast commits
Date:   Tue, 24 Dec 2019 00:13:17 -0800
Message-Id: <20191224081324.95807-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index ffbea070582c..20a1bd955784 100644
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
index bd6ab127f0d9..e0b2e8934fa4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -865,6 +865,82 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
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
index 99b0f50ceb50..d450dcb93e51 100644
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
2.24.1.735.g03f4e72817-goog

