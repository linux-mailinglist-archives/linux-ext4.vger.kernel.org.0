Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE72400A1
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHJBC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHJBC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:26 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCl-00070s-Tw
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:24 +0000
Received: by mail-qk1-f198.google.com with SMTP id a130so6092500qkg.9
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTgRyPr4ATTOsKSC00sYGFwp4YxQtlbP2Mw6EU51Lz4=;
        b=qxt6M4wURNJPQt7XcA6RZWz3zgAe6Z9khINE4eKIzEuBjuRPKaW6SZQZwUBUBCO7qh
         IuVzhA6gUtENVAuQDyvAwYfUiHNUfJ1kaXKJK6qxrU6A19H7sA0KLDr7fpWRer+PtLVG
         /fhbBR4AQ8I1fg9pGrYV1ulxYO5D2Y+dmk7V2/Ib8snKLnIEjCi7TcQPPw+wfbG7DeEI
         HkmBpZtc8uLTcH7cFzywJHXVSp52BUPLE5QceS11bznYisTd5Y3/xDgKiujMKwjnKkRp
         MP+iSdjRD0ZyPuU768RizlP48ZU9eZW7dIgLFPHpT0eG8XM+xere0Z3vzVLQ+UwsJ3Re
         ZKFQ==
X-Gm-Message-State: AOAM531JvpdDosWeft0TWyjktv1tl5iEj1kbqAoFUnR07uhvsY6Jq+gG
        WCRJIjNooQ2xB1yPMpDvKZlKMugT1CtQy0xapKiORn1NJQ/LT6mS2WckQLAjJmDwTy+JgnXnZYP
        ubbiWwyIP4bJ2Hx+rqBCEUpVe+PQpnpPrhqR4Tlk=
X-Received: by 2002:ae9:ebd0:: with SMTP id b199mr22706347qkg.294.1597021342975;
        Sun, 09 Aug 2020 18:02:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJAmBaN3Mtp9AQd1vCl1OREa6PJqmBWU7zPcC8hLAKNd8L+F8/MqiMR7XTbNaGGtq5cijPBg==
X-Received: by 2002:ae9:ebd0:: with SMTP id b199mr22706331qkg.294.1597021342641;
        Sun, 09 Aug 2020 18:02:22 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:22 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 3/5] ext4: data=journal: write-protect pages on submit inode data buffers callback
Date:   Sun,  9 Aug 2020 22:02:06 -0300
Message-Id: <20200810010210.3305322-4-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This implements the journal's j_submit_inode_data_buffers() callback
to write-protect the inode's pages with write_cache_pages(), and use
a writepage callback to redirty pages with buffers that are not part
of the committing transaction or the next transaction.

And set a no-op function as j_finish_inode_data_buffers() callback
(nothing needed other than the write-protect above.)

Currently, the inode is added to the transaction's inode list in the
__ext4_journalled_writepage() function.
---
 fs/ext4/inode.c |  4 +++
 fs/ext4/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..978ccde8454f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1911,6 +1911,10 @@ static int __ext4_journalled_writepage(struct page *page,
 		err = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
 					     write_end_fn);
 	}
+	if (ret == 0)
+		ret = err;
+	// XXX: is this correct for inline data inodes?
+	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..38aaac6572ea 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -472,6 +472,66 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	spin_unlock(&sbi->s_md_lock);
 }
 
+/*
+ * This writepage callback for write_cache_pages()
+ * takes care of a few cases after page cleaning.
+ *
+ * write_cache_pages() already checks for dirty pages
+ * and calls clear_page_dirty_for_io(), which we want,
+ * to write protect the pages.
+ *
+ * However, we have to redirty a page in two cases:
+ * 1) some buffer is not part of the committing transaction
+ * 2) some buffer already has b_next_transaction set
+ */
+
+static int ext4_journalled_writepage_callback(struct page *page,
+					      struct writeback_control *wbc,
+					      void *data)
+{
+	transaction_t *transaction = (transaction_t *) data;
+	struct buffer_head *bh, *head;
+	struct journal_head *jh;
+
+	// XXX: any chance of !bh here?
+	bh = head = page_buffers(page);
+	do {
+		jh = bh2jh(bh);
+		if (!jh || jh->b_transaction != transaction ||
+		    jh->b_next_transaction) {
+			redirty_page_for_writepage(wbc, page);
+			goto out;
+		}
+	} while ((bh = bh->b_this_page) != head);
+
+out:
+	return AOP_WRITEPAGE_ACTIVATE;
+}
+
+static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	transaction_t *transaction = jinode->i_transaction;
+	loff_t dirty_start = jinode->i_dirty_start;
+	loff_t dirty_end = jinode->i_dirty_end;
+
+	struct writeback_control wbc = {
+		.sync_mode =  WB_SYNC_ALL,
+		.nr_to_write = mapping->nrpages * 2,
+		.range_start = dirty_start,
+		.range_end = dirty_end,
+        };
+
+	return write_cache_pages(mapping, &wbc,
+				 ext4_journalled_writepage_callback,
+				 transaction);
+}
+
+static int ext4_journalled_finish_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	return 0;
+}
+
 static bool system_going_down(void)
 {
 	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
@@ -4599,6 +4659,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_ERR, "can't mount with "
 			"journal_async_commit in data=ordered mode");
 		goto failed_mount_wq;
+	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
+		sbi->s_journal->j_submit_inode_data_buffers =
+			ext4_journalled_submit_inode_data_buffers;
+		sbi->s_journal->j_finish_inode_data_buffers =
+			ext4_journalled_finish_inode_data_buffers;
 	}
 
 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
-- 
2.17.1

