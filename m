Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D011C132
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 06:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENETX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 00:19:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbfENETW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 May 2019 00:19:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90CB874CE27CF099816A;
        Tue, 14 May 2019 12:19:20 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 May 2019 12:19:10 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] ext4: Fix entry corruption when disk online and offline frequently
Date:   Tue, 14 May 2019 12:23:37 +0800
Message-ID: <1557807817-121893-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I got some errors when I repair an ext4 volume which stacked by an
iscsi target:
    Entry 'test60' in / (2) has deleted/unused inode 73750.  Clear?
It can be reproduced when the network not good enough.

When I debug this I found ext4 will read entry buffer from disk and
the buffer is marked with write_io_error.

If the buffer is marked with write_io_error, it means it already
wroten to journal, and not checked out to disk. IOW, the journal
is newer than the data in disk.
If this journal record 'delete test60', it means the 'test60' still
on the disk metadata.

In this case, if we read the buffer from disk successfully and create
file continue, the new journal record will overwrite the journal
which record 'delete test60', then the entry corruptioned.

So, use the buffer rather than read from disk if the buffer marked
with write_io_error

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/ext4/ext4.h  | 13 +++++++++++++
 fs/ext4/inode.c |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb6785..5ebb36d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3301,6 +3301,19 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 
 extern const struct iomap_ops ext4_iomap_ops;
 
+static inline int ext4_buffer_uptodate(struct buffer_head *bh)
+{
+	/*
+	 * If the buffer has the write error flag, we have failed
+	 * to write out data in the block.  In this  case, we don't
+	 * have to read the block because we may read the old data
+	 * successfully.
+	 */
+	if (!buffer_uptodate(bh) && buffer_write_io_error(bh))
+		set_buffer_uptodate(bh);
+	return buffer_uptodate(bh);
+}
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82298c6..3546388 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1018,7 +1018,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 	bh = ext4_getblk(handle, inode, block, map_flags);
 	if (IS_ERR(bh))
 		return bh;
-	if (!bh || buffer_uptodate(bh))
+	if (!bh || ext4_buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
 	wait_on_buffer(bh);
@@ -1045,7 +1045,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !buffer_uptodate(bhs[i]))
+		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
 			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
 				    &bhs[i]);
 
-- 
2.7.4

