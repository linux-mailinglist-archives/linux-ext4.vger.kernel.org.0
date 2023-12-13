Return-Path: <linux-ext4+bounces-417-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBF8107DA
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C03B20FC2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E210EA;
	Wed, 13 Dec 2023 01:51:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB0AF
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:51:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SqdK11h0Nz1L9lh;
	Wed, 13 Dec 2023 09:32:53 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 597E21800C9;
	Wed, 13 Dec 2023 09:33:58 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:57 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 1/5] jbd2: Add errseq to detect client fs's bdev writeback error
Date: Wed, 13 Dec 2023 09:32:20 +0800
Message-ID: <20231213013224.2100050-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Add errseq in journal, so that JBD2 can detect whether metadata is
successfully written to fs bdev. This patch adds detection in recovery
process to replace original solution(using local variable wb_err).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    |  1 +
 fs/jbd2/recovery.c   |  7 +------
 include/linux/jbd2.h | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 206cb53ef2b0..559938a82379 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1534,6 +1534,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_fs_dev = fs_dev;
 	journal->j_blk_offset = start;
 	journal->j_total_len = len;
+	jbd2_init_fs_dev_write_error(journal);
 
 	err = journal_load_superblock(journal);
 	if (err)
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 01f744cb97a4..1f7664984d6e 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -289,8 +289,6 @@ int jbd2_journal_recover(journal_t *journal)
 	journal_superblock_t *	sb;
 
 	struct recovery_info	info;
-	errseq_t		wb_err;
-	struct address_space	*mapping;
 
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
@@ -308,9 +306,6 @@ int jbd2_journal_recover(journal_t *journal)
 		return 0;
 	}
 
-	wb_err = 0;
-	mapping = journal->j_fs_dev->bd_inode->i_mapping;
-	errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -334,7 +329,7 @@ int jbd2_journal_recover(journal_t *journal)
 	err2 = sync_blockdev(journal->j_fs_dev);
 	if (!err)
 		err = err2;
-	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
+	err2 = jbd2_check_fs_dev_write_error(journal);
 	if (!err)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index beb30719ee16..cea1aa70ae36 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -998,6 +998,13 @@ struct journal_s
 	 */
 	struct block_device	*j_fs_dev;
 
+	/**
+	 * @j_fs_dev_wb_err:
+	 *
+	 * Records the errseq of the client fs's backing block device.
+	 */
+	errseq_t		j_fs_dev_wb_err;
+
 	/**
 	 * @j_total_len: Total maximum capacity of the journal region on disk.
 	 */
@@ -1698,6 +1705,25 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
 	handle->h_aborted = 1;
 }
 
+static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
+{
+	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+
+	/*
+	 * Save the original wb_err value of client fs's bdev mapping which
+	 * could be used to detect the client fs's metadata async write error.
+	 */
+	errseq_check_and_advance(&mapping->wb_err, &journal->j_fs_dev_wb_err);
+}
+
+static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
+{
+	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+
+	return errseq_check(&mapping->wb_err,
+			    READ_ONCE(journal->j_fs_dev_wb_err));
+}
+
 #endif /* __KERNEL__   */
 
 /* Comparison functions for transaction IDs: perform comparisons using
-- 
2.39.2


