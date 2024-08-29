Return-Path: <linux-ext4+bounces-3965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12C96428A
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5716FB26E91
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F99018FDAB;
	Thu, 29 Aug 2024 11:03:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A018CBE5
	for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2024 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929422; cv=none; b=NnEbB0DgVqYbCyFJicD3dOl/zsT71DurEsWSal0WbA9LVEQ/FQ+ZM0I8pdhqM8q6uHSHZy9Vfvv9AFeCZFePg72BAzxCKvX+wrPBtCByrX3dHNm0PBWqssBYLgH3DfLnWXN+MSLvHL8uECKfPdEENB47Laz0ZRdSIo/XJS7QTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929422; c=relaxed/simple;
	bh=rHZzxpLWsOMyNO3l+kBa2RcG/iZSl3GSYCdhDmGzE/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sd6Aj5yqZO4LvKYtxVbeKHj1qzklBxQhMOdAJL+Fu/0tRHRYO5qcpRIrKEvzC1q3QjQ6tHnzlrfszbp5kOYTgnMN674+1gP4SsH8G5JGJ26IXXVH5wvAzT1BsCsIRF87n2o7nXEYQy9nGU88DsCeUMDwWFg8aymnqLjJGN4ol1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvdgF38KDz4f3nTm
	for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2024 19:03:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EFB651A07BA
	for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2024 19:03:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHboSDVdBmfhEuDA--.14296S4;
	Thu, 29 Aug 2024 19:03:36 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2] ext4: dax: keep orphan list before truncate overflow allocated blocks
Date: Thu, 29 Aug 2024 19:02:22 +0800
Message-Id: <20240829110222.126685-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboSDVdBmfhEuDA--.14296S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDurWUtr1DCF4xWw13twb_yoW5Cr1fpr
	y3KFy5Cw1vvas2grWvkF1UZr1Fka1xGayxJrWkK3s7ZasxAr1SqF1jyF1rKFW5JrWrW3Wj
	gr4v9ryDZa1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: yangerkun <yangerkun@huawei.com>

Any extending write for ext4 requires the inode to be placed on the
orphan list before the actual write. In addition, the inode can be
actually removed from the orphan list only after all writes are
completed. Otherwise we'd leave allocated blocks beyond i_disksize if we
could not copy all the data into allocated block and e2fsck would
complain.

Currently, direct IO and buffered IO comply with this logic(buffered
IO will truncate all overflow allocated blocks that has not been
written successfully, and direct IO will truncate all allocated blocks
when error occurs). However, dax write break this since dax write will
remove the inode from the orphan list by calling
ext4_handle_inode_extension unconditionally during extending write.

We add a argument to help determine does we do a fully write, and for
the case not fully write, we leave the inode on the orphan list, and the
latter ext4_inode_extension_cleanup will help us truncate the overflow
allocated blocks, and then remove the inode from the orphan list.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index be061bb64067..f14aed14b9cf 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -306,7 +306,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 }
 
 static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
-					   ssize_t count)
+					   ssize_t written, ssize_t count)
 {
 	handle_t *handle;
 
@@ -315,7 +315,7 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (ext4_update_inode_size(inode, offset + count)) {
+	if (ext4_update_inode_size(inode, offset + written)) {
 		int ret = ext4_mark_inode_dirty(handle, inode);
 		if (unlikely(ret)) {
 			ext4_journal_stop(handle);
@@ -323,11 +323,11 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 		}
 	}
 
-	if (inode->i_nlink)
+	if ((written == count) && inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 	ext4_journal_stop(handle);
 
-	return count;
+	return written;
 }
 
 /*
@@ -393,7 +393,7 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
 	    pos + size <= i_size_read(inode))
 		return size;
-	return ext4_handle_inode_extension(inode, pos, size);
+	return ext4_handle_inode_extension(inode, pos, size, size);
 }
 
 static const struct iomap_dio_ops ext4_dio_write_ops = {
@@ -669,7 +669,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
 	if (extend) {
-		ret = ext4_handle_inode_extension(inode, offset, ret);
+		ret = ext4_handle_inode_extension(inode, offset, ret, count);
 		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
 	}
 out:
-- 
2.39.2


