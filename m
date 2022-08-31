Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5E5A778F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHaHfU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaHfT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 03:35:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9D54A107
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 00:35:15 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MHbTL07yDzkWbH;
        Wed, 31 Aug 2022 15:31:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 15:35:12 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <openglfreak@googlemail.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate
Date:   Wed, 31 Aug 2022 15:46:29 +0800
Message-ID: <20220831074629.3755110-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Recently we notice that ext4 filesystem occasionally fail to read
metadata from disk and report error message, but the disk and block
layer looks fine. After analyse, we lockon commit 88dbcbb3a484
("blkdev: avoid migration stalls for blkdev pages"). It provide a
migration method for the bdev, we could move page that has buffers
without extra users now, but it lock the buffers on the page, which
breaks the fragile metadata read operation on ext4 filesystem,
ext4_read_bh_lock() was copied from ll_rw_block(), it depends on the
assumption of that locked buffer means it is under IO. So it just
trylock the buffer and skip submit IO if it lock failed, after
wait_on_buffer() we conclude IO error because the buffer is not
uptodate.

This issue could be easily reproduced by add some delay just after
buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
fsstress on ext4 filesystem.

  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
  comm fsstress: reading directory lblock 0
  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
  comm fsstress: reading directory lblock 0

Fix it by removing the trylock logic in ext4_read_bh_lock(), just lock
the buffer and submit IO if it's not uptodate, and also leave over
readahead helper.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..629bba3fa99a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -205,19 +205,12 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
 
 int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 {
-	if (trylock_buffer(bh)) {
-		if (wait)
-			return ext4_read_bh(bh, op_flags, NULL);
+	lock_buffer(bh);
+	if (!wait) {
 		ext4_read_bh_nowait(bh, op_flags, NULL);
 		return 0;
 	}
-	if (wait) {
-		wait_on_buffer(bh);
-		if (buffer_uptodate(bh))
-			return 0;
-		return -EIO;
-	}
-	return 0;
+	return ext4_read_bh(bh, op_flags, NULL);
 }
 
 /*
@@ -264,7 +257,8 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
 
 	if (likely(bh)) {
-		ext4_read_bh_lock(bh, REQ_RAHEAD, false);
+		if (trylock_buffer(bh))
+			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL);
 		brelse(bh);
 	}
 }
-- 
2.31.1

