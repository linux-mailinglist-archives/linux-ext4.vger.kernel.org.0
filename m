Return-Path: <linux-ext4+bounces-6158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CFDA17874
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6A7A1537
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1FD1B4255;
	Tue, 21 Jan 2025 07:16:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65151891AB;
	Tue, 21 Jan 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443800; cv=none; b=tmWD78cpdUz+c07j1jWrWXwogSWn8HrgwxhLr8TY6ww+GF864IvbvdaOTlqUpc5mroXEd1m5fwGZGfryjKeNkPMGDxkkMi464EGmCY7d0Me3f51VBhDBr1G3OamCCC27iYmdfzbK9ejWP3u3DP76rc4trxnTnDeDxIWpD0kXZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443800; c=relaxed/simple;
	bh=hZpvbfq9OM4ZwJDlxNDgyJH37/lvzaUAIUboP2stpM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmLC8mYwWKRdaEHf/Lrn4VCoAt3mHcRAh4rB1qMYi6q9/gQ4l8oUbJm+kPHAm60EngbUgXpCKZd93G4HFQaraas/F56VYnlrkn/iFbuG1T9XNneV5UXNhjLz1L4KkbVN/TSHTlRYGlhVw7Akzyw6zQdOOZB0fko8OChSiR8lJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YcdmF6rHHz4f3jXr;
	Tue, 21 Jan 2025 15:16:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 891391A0C49;
	Tue, 21 Jan 2025 15:16:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S6;
	Tue, 21 Jan 2025 15:16:34 +0800 (CST)
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
Subject: [PATCH v2 2/8] ext4: do not convert the unwritten extents if data writeback fails
Date: Tue, 21 Jan 2025 15:10:44 +0800
Message-Id: <20250121071050.3991249-3-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45Aw1rCw4fAw4xtFy3twb_yoW5WFyfpF
	ZxCFWUGF4jqay29ay3AFykXF17Ka4xKr47Zry7GFWYvasxXF95ta4IgFWrXF1UCrW7AF1x
	XF40yryDCFsrJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfU1lkVUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBWeOA-NKyAABsR

From: Baokun Li <libaokun1@huawei.com>

When dioread_nolock is turned on (the default), it will convert unwritten
extents to written at ext4_end_io_end(), even if the data writeback fails.

It leads to the possibility that stale data may be exposed when the
physical block corresponding to the file data is read-only (i.e., writes
return -EIO, but reads are normal).

Therefore a new ext4_io_end->flags EXT4_IO_END_FAILED is added, which
indicates that some bio write-back failed in the current ext4_io_end.
When this flag is set, the unwritten to written conversion is no longer
performed. Users can read the data normally until the caches are dropped,
after that, the failed extents can only be read to all 0.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  3 ++-
 fs/ext4/page-io.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4e7de7eaa374..9da0e32af02a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -278,7 +278,8 @@ struct ext4_system_blocks {
 /*
  * Flags for ext4_io_end->flags
  */
-#define	EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_END_FAILED	0x0002
 
 struct ext4_io_end_vec {
 	struct list_head list;		/* list of io_end_vec */
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f53b018ea259..6054ec27fb48 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -181,14 +181,25 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		   "list->prev 0x%p\n",
 		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
 
-	io_end->handle = NULL;	/* Following call will use up the handle */
-	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
+	/*
+	 * Do not convert the unwritten extents if data writeback fails,
+	 * or stale data may be exposed.
+	 */
+	io_end->handle = NULL;  /* Following call will use up the handle */
+	if (unlikely(io_end->flag & EXT4_IO_END_FAILED)) {
+		ret = -EIO;
+		if (handle)
+			jbd2_journal_free_reserved(handle);
+	} else {
+		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
+	}
 	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
 			 "(inode %lu, error %d)", inode->i_ino, ret);
 	}
+
 	ext4_clear_io_unwritten_flag(io_end);
 	ext4_release_io_end(io_end);
 	return ret;
@@ -339,6 +350,7 @@ static void ext4_end_bio(struct bio *bio)
 			     bio->bi_status, inode->i_ino,
 			     (unsigned long long)
 			     bi_sector >> (inode->i_blkbits - 9));
+		io_end->flag |= EXT4_IO_END_FAILED;
 		mapping_set_error(inode->i_mapping,
 				blk_status_to_errno(bio->bi_status));
 	}
-- 
2.39.2


