Return-Path: <linux-ext4+bounces-6160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4FEA17879
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C215A18843D7
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB81BD4E5;
	Tue, 21 Jan 2025 07:16:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3971B4F3F;
	Tue, 21 Jan 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443802; cv=none; b=iLsfJHHqrNw8fgbovkjRlvn3k68PkOXvGnO2skHEB/UginIiWJOqqCl/BKujbPIvbGZCNgm/t8LGjhU0H0bOHLaXoCiPz4kNO33SaJ/VzSL2rAiH1s6cS8KuoY2l1njJWpA5z17fu8oISUagL8oywz71TBGpMbDeMbASjzoBPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443802; c=relaxed/simple;
	bh=xpjTwsMLReaguQrpJ/MF2+KORN/RaYY0GGmwj2qL17o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9M3uVx0X3vEPXbku7y5G0P06bu0EsxUc+kC5SB3t/GjAA2OiGd0yQPADEMOM6wLP0CYChQ7uxdhIJ3ArEsSRmCwx5VUh1F0F9MMW7Ek+AHXfZQVGmmK3C3C1OaawCiD9fUlm+7b8AM/gIQN1JWGyVWyoZ4jMIJCo9mQ5uvhh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YcdmK0JrKz4f3jXg;
	Tue, 21 Jan 2025 15:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9E71D1A0D8B;
	Tue, 21 Jan 2025 15:16:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S9;
	Tue, 21 Jan 2025 15:16:35 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 5/8] ext4: abort journal on data writeback failure if in data_err=abort mode
Date: Tue, 21 Jan 2025 15:10:47 +0800
Message-Id: <20250121071050.3991249-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250121071050.3991249-1-libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S9
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykCF4rtr48Gw4xAF1DWrg_yoWxurW5pF
	y5uFWUKF4UX3s7urZ3AF4DXF4aga4xtrW7Cr17WFZFva9xGr98tF18tFyrXF1UCr4fCF42
	qF48Kr1Du3W5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBWeOA-NKygABsT

From: Baokun Li <libaokun1@huawei.com>

The data_err=abort was initially introduced to address users' worries
about data corruption spreading unnoticed. With direct writes, we can
rely on return values to confirm successful writes to disk. But with
buffered writes, a successful return only means the data has been written
to memory. Users have no way of knowing if the data has actually written
it to disk unless they use fsync (which impacts performance and can
sometimes miss errors).

The current data_err=abort implementation relies on the ordered data list,
but past changes have inadvertently altered its behavior. For example, if
an extent is unwritten, we do not add the inode to the ordered data list.
Therefore, jbd2 will not wait for the data write-back of that inode to
complete and check for errors in the inode mapping. Moreover, the checks
performed by jbd2 can also miss errors.

Now, all buffered writes eventually call ext4_end_bio(), where I/O errors
are checked. Therefore, we can check for the data_err=abort mode at this
point and abort the journal in a kworker (due to the interrupt context).

Therefore, when data_err=abort is enabled, the journal is aborted in
ext4_end_io_end() when an I/O error is detected in ext4_end_bio() to make
users who are concerned about the contents of the file happy.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/c7ab26f3-85ad-4b31-b132-0afb0e07bf79@huawei.com
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/page-io.c | 48 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9da0e32af02a..e0b536df8872 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -281,6 +281,8 @@ struct ext4_system_blocks {
 #define EXT4_IO_END_UNWRITTEN	0x0001
 #define EXT4_IO_END_FAILED	0x0002
 
+#define EXT4_IO_END_NEED_COMPLETION (EXT4_IO_END_UNWRITTEN | EXT4_IO_END_FAILED)
+
 struct ext4_io_end_vec {
 	struct list_head list;		/* list of io_end_vec */
 	loff_t offset;			/* offset in the file */
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 6054ec27fb48..5dbd3ff188a3 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -164,7 +164,8 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
 }
 
 /*
- * Check a range of space and convert unwritten extents to written. Note that
+ * On successful IO, check a range of space and convert unwritten extents to
+ * written. On IO failure, check if journal abort is needed. Note that
  * we are protected from truncate touching same part of extent tree by the
  * fact that truncate code waits for all DIO to finish (thus exclusion from
  * direct IO is achieved) and also waits for PageWriteback bits. Thus we
@@ -175,6 +176,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 {
 	struct inode *inode = io_end->inode;
 	handle_t *handle = io_end->handle;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
 
 	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
@@ -190,11 +192,15 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		ret = -EIO;
 		if (handle)
 			jbd2_journal_free_reserved(handle);
+
+		if (test_opt(sb, DATA_ERR_ABORT))
+			jbd2_journal_abort(EXT4_SB(sb)->s_journal, ret);
 	} else {
 		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
 	}
-	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
-		ext4_msg(inode->i_sb, KERN_EMERG,
+	if (ret < 0 && !ext4_forced_shutdown(sb) &&
+	    io_end->flag & EXT4_IO_END_UNWRITTEN) {
+		ext4_msg(sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
 			 "(inode %lu, error %d)", inode->i_ino, ret);
@@ -228,6 +234,16 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 #endif
 }
 
+static bool ext4_io_end_need_completion(ext4_io_end_t *io_end)
+{
+	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
+		return true;
+	if (test_opt(io_end->inode->i_sb, DATA_ERR_ABORT) &&
+	    io_end->flag & EXT4_IO_END_FAILED)
+		return true;
+	return false;
+}
+
 /* Add the io_end to per-inode completed end_io list. */
 static void ext4_add_complete_io(ext4_io_end_t *io_end)
 {
@@ -236,9 +252,11 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	struct workqueue_struct *wq;
 	unsigned long flags;
 
-	/* Only reserved conversions from writeback should enter here */
-	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
-	WARN_ON(!io_end->handle && sbi->s_journal);
+	/* Only reserved conversions or pending IO errors will enter here. */
+	WARN_ON(!(io_end->flag & EXT4_IO_END_NEED_COMPLETION));
+	WARN_ON(io_end->flag & EXT4_IO_END_UNWRITTEN &&
+		!io_end->handle && sbi->s_journal);
+
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
 	wq = sbi->rsv_conversion_wq;
 	if (list_empty(&ei->i_rsv_conversion_list))
@@ -263,7 +281,7 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 
 	while (!list_empty(&unwritten)) {
 		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
-		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
+		BUG_ON(!(io_end->flag & EXT4_IO_END_NEED_COMPLETION));
 		list_del_init(&io_end->list);
 
 		err = ext4_end_io_end(io_end);
@@ -274,7 +292,8 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 }
 
 /*
- * work on completed IO, to convert unwritten extents to extents
+ * Used to convert unwritten extents to written extents upon IO completion,
+ * or used to abort the journal upon IO errors.
  */
 void ext4_end_io_rsv_work(struct work_struct *work)
 {
@@ -299,19 +318,20 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
 	if (refcount_dec_and_test(&io_end->count)) {
-		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
-				list_empty(&io_end->list_vec)) {
-			ext4_release_io_end(io_end);
+		if (io_end->flag & EXT4_IO_END_FAILED ||
+		    (io_end->flag & EXT4_IO_END_UNWRITTEN &&
+		     !list_empty(&io_end->list_vec))) {
+			ext4_add_complete_io(io_end);
 			return;
 		}
-		ext4_add_complete_io(io_end);
+		ext4_release_io_end(io_end);
 	}
 }
 
 int ext4_put_io_end(ext4_io_end_t *io_end)
 {
 	if (refcount_dec_and_test(&io_end->count)) {
-		if (io_end->flag & EXT4_IO_END_UNWRITTEN)
+		if (ext4_io_end_need_completion(io_end))
 			return ext4_end_io_end(io_end);
 
 		ext4_release_io_end(io_end);
@@ -355,7 +375,7 @@ static void ext4_end_bio(struct bio *bio)
 				blk_status_to_errno(bio->bi_status));
 	}
 
-	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
+	if (ext4_io_end_need_completion(io_end)) {
 		/*
 		 * Link bio into list hanging from io_end. We have to do it
 		 * atomically as bio completions can be racing against each
-- 
2.39.2


