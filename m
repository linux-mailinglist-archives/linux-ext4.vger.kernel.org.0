Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF55A0AB9
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiHYHuh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 03:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiHYHu3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 03:50:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6464F8;
        Thu, 25 Aug 2022 00:50:26 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCw7t6PWVzGpp5;
        Thu, 25 Aug 2022 15:48:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 15:50:22 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 15:50:21 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <akpm@linux-foundation.org>,
        <jack@suse.cz>, <mgorman@suse.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] mm: migrate: buffer_migrate_folio_norefs() fallback migrate not uptodate pages
Date:   Thu, 25 Aug 2022 16:01:46 +0800
Message-ID: <20220825080146.2021641-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Recently we notice that ext4 filesystem occasionally fail to read
metadata from disk and report error message, but the disk and block
layer looks fine. After analyse, we lockon commit 88dbcbb3a484
("blkdev: avoid migration stalls for blkdev pages"). It provide a
migration method for the bdev, we could move page that has buffers
without extra users now, but it will lock the buffers on the page, which
breaks a lot of current filesystem's fragile metadata read operations,
like ll_rw_block() for common usage and ext4_read_bh_lock() for ext4,
these helpers just trylock the buffer and skip submit IO if it lock
failed, many callers just wait_on_buffer() and conclude IO error if the
buffer is not uptodate after buffer unlocked.

This issue could be easily reproduced by add some delay just after
buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
fsstress on ext4 filesystem.

  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
  comm fsstress: reading directory lblock 0
  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
  comm fsstress: reading directory lblock 0

Something like ll_rw_block() should be used carefully and seems could
only be safely used for the readahead case. So the best way is to fix
the read operations in filesystem in the long run, but now let us avoid
this issue first. This patch avoid this issue by fallback to migrate
pages that are not uotodate like fallback_migrate_folio(), those pages
that has buffers may probably do read operation soon.

Fixes: 88dbcbb3a484 ("blkdev: avoid migration stalls for blkdev pages")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 mm/migrate.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..bded69867619 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -691,6 +691,38 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	if (!head)
 		return migrate_folio(mapping, dst, src, mode);
 
+	/*
+	 * If the mapped buffers on the page are not uptodate and has refcount,
+	 * some others may propably try to lock the buffer and submit read IO
+	 * through ll_rw_block(), but it will not submit IO once it failed to
+	 * lock the buffer, so try to fallback to migrate_folio() to prevent
+	 * false positive EIO.
+	 */
+	if (check_refs) {
+		bool uptodate = true;
+		bool invalidate = false;
+
+		bh = head;
+		do {
+			if (buffer_mapped(bh) && !buffer_uptodate(bh)) {
+				uptodate = false;
+				if (atomic_read(&bh->b_count)) {
+					invalidate = true;
+					break;
+				}
+			}
+			bh = bh->b_this_page;
+		} while (bh != head);
+
+		if (!uptodate) {
+			if (invalidate)
+				invalidate_bh_lrus();
+			if (filemap_release_folio(src, GFP_KERNEL))
+				return migrate_folio(mapping, dst, src, mode);
+			return -EAGAIN;
+		}
+	}
+
 	/* Check whether page does not have extra refs before we do more work */
 	expected_count = folio_expected_refs(mapping, src);
 	if (folio_ref_count(src) != expected_count)
-- 
2.31.1

