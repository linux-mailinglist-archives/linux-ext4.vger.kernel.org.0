Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22C11E1C02
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgEZHTV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgEZHTV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 038D9DF6CCD7E8D1452C;
        Tue, 26 May 2020 15:19:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:07 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 02/10] fs: pick out ll_rw_one_block() helper function
Date:   Tue, 26 May 2020 15:17:46 +0800
Message-ID: <20200526071754.33819-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Pick out ll_rw_one_block() helper function from ll_rw_block() for
submitting one locked buffer for reading/writing.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/buffer.c                 | 41 ++++++++++++++++++++++---------------
 include/linux/buffer_head.h |  1 +
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..3a2226f88b2d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3081,6 +3081,29 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
+void ll_rw_one_block(int op, int op_flags, struct buffer_head *bh)
+{
+	BUG_ON(!buffer_locked(bh));
+
+	if (op == WRITE) {
+		if (test_clear_buffer_dirty(bh)) {
+			bh->b_end_io = end_buffer_write_sync;
+			get_bh(bh);
+			submit_bh(op, op_flags, bh);
+			return;
+		}
+	} else {
+		if (!buffer_uptodate(bh)) {
+			bh->b_end_io = end_buffer_read_sync;
+			get_bh(bh);
+			submit_bh(op, op_flags, bh);
+			return;
+		}
+	}
+	unlock_buffer(bh);
+}
+EXPORT_SYMBOL(ll_rw_one_block);
+
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
@@ -3116,22 +3139,8 @@ void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
 
 		if (!trylock_buffer(bh))
 			continue;
-		if (op == WRITE) {
-			if (test_clear_buffer_dirty(bh)) {
-				bh->b_end_io = end_buffer_write_sync;
-				get_bh(bh);
-				submit_bh(op, op_flags, bh);
-				continue;
-			}
-		} else {
-			if (!buffer_uptodate(bh)) {
-				bh->b_end_io = end_buffer_read_sync;
-				get_bh(bh);
-				submit_bh(op, op_flags, bh);
-				continue;
-			}
-		}
-		unlock_buffer(bh);
+
+		ll_rw_one_block(op, op_flags, bh);
 	}
 }
 EXPORT_SYMBOL(ll_rw_block);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 15b765a181b8..11aa412c0bcd 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -198,6 +198,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
 void __lock_buffer(struct buffer_head *bh);
+void ll_rw_one_block(int op, int op_flags, struct buffer_head *bh);
 void ll_rw_block(int, int, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
-- 
2.21.3

