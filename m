Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372D03E5D5A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhHJOSw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 10:18:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13302 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbhHJORK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 10:17:10 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GkZdF6jnXz7tH8;
        Tue, 10 Aug 2021 22:11:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 10
 Aug 2021 22:16:43 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 3/3] ext4: prevent getting empty inode buffer
Date:   Tue, 10 Aug 2021 22:27:22 +0800
Message-ID: <20210810142722.923175-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810142722.923175-1-yi.zhang@huawei.com>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
inode buffer when the inode monopolize an inode block for performance
reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
buffer to make it fine, but we could miss this call if something bad
happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
empty inode buffer and trigger ext4 error.

For example, if we remove a nonexistent xattr on inode A,
ext4_xattr_set_handle() will return ENODATA before invoking
ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
will get checksum error message in ext4_iget() when getting inode again.

  EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid

Even worse, if we allocate another inode B at the same inode block, it
will corrupt the inode A on disk when write back inode B.

So this patch clear uptodate flag and mark buffer new if we get an empty
buffer, clear it after we fill inode data or making read IO.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eae1b2d0b550..1f36289e9ef6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4292,6 +4292,18 @@ int ext4_truncate(struct inode *inode)
 	return err;
 }
 
+static void ext4_end_inode_loc_read(struct buffer_head *bh, int uptodate)
+{
+	if (buffer_new(bh))
+		clear_buffer_new(bh);
+	if (uptodate)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
+	unlock_buffer(bh);
+	put_bh(bh);
+}
+
 /*
  * ext4_get_inode_loc returns with an extra refcount against the inode's
  * underlying buffer_head on success. If 'in_mem' is true, we have all
@@ -4367,9 +4379,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		}
 		brelse(bitmap_bh);
 		if (i == start + inodes_per_block) {
-			/* all other inodes are free, so skip I/O */
-			memset(bh->b_data, 0, bh->b_size);
-			set_buffer_uptodate(bh);
+			if (!buffer_new(bh)) {
+				/* all other inodes are free, so skip I/O */
+				memset(bh->b_data, 0, bh->b_size);
+				set_buffer_new(bh);
+			}
 			unlock_buffer(bh);
 			goto has_buffer;
 		}
@@ -4408,7 +4422,7 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	 * Read the block from disk.
 	 */
 	trace_ext4_load_inode(sb, ino);
-	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
+	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, ext4_end_inode_loc_read);
 	blk_finish_plug(&plug);
 	wait_on_buffer(bh);
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
@@ -5132,6 +5146,11 @@ static int ext4_do_update_inode(handle_t *handle,
 	if (err)
 		goto out_brelse;
 	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
+	if (buffer_new(bh)) {
+		clear_buffer_new(bh);
+		set_buffer_uptodate(bh);
+	}
+
 	if (set_large_file) {
 		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
 		err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
-- 
2.31.1

