Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00763F72B
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiLASLH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 13:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLASLF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 13:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD4B7DC1
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 10:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669918207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RRSBXKEuMTARerk08P46GOMkWlFJsfYfNR8FUKMSw4=;
        b=PkaFgqlJZ4u2SqIuMVIg5vQLUaMPtgwgcDwmCai/RSOvNAKz+mezbCMbCJKHT0dk7jtude
        WcFzVERqhTQwA8XJt1xMj3D7ml8XwjCqeht43yclipbx6t0nr1DiygxfNjR/6aT7G9LvaH
        Gz8+2/pgOzHwG0JoU6LSB0Om+dIZoy8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-1HJZEzCnOxqwKhT49I0i9w-1; Thu, 01 Dec 2022 13:10:05 -0500
X-MC-Unique: 1HJZEzCnOxqwKhT49I0i9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48A8B2A5955C;
        Thu,  1 Dec 2022 18:10:03 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-141.brq.redhat.com [10.40.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B25CC15BB4;
        Thu,  1 Dec 2022 18:10:00 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v2 1/3] fs: Add folio_may_straddle_isize helper
Date:   Thu,  1 Dec 2022 19:09:55 +0100
Message-Id: <20221201180957.1268079-2-agruenba@redhat.com>
In-Reply-To: <20221201160619.1247788-1-agruenba@redhat.com>
References: <20221201160619.1247788-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a folio_may_straddle_isize() helper as a replacement for
pagecache_isize_extended() when we have a locked folio.

Use the new helper in generic_write_end(), iomap_write_end(),
ext4_write_end(), and ext4_journalled_write_end().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/buffer.c            |  5 ++---
 fs/ext4/inode.c        | 13 ++++++-------
 fs/iomap/buffered-io.c |  5 +----
 include/linux/mm.h     |  2 ++
 mm/truncate.c          | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dd..bbae1437994b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2164,16 +2164,15 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 	 * But it's important to update i_size while still holding page lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos + copied > inode->i_size) {
+	if (pos + copied > old_size) {
 		i_size_write(inode, pos + copied);
 		i_size_changed = true;
+		folio_may_straddle_isize(inode, page_folio(page), old_size, pos);
 	}
 
 	unlock_page(page);
 	put_page(page);
 
-	if (old_size < pos)
-		pagecache_isize_extended(inode, old_size, pos);
 	/*
 	 * Don't mark the inode dirty under page lock. First, it unnecessarily
 	 * makes the holding time of page lock longer. Second, it forces lock
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..48e6b4716415 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1320,13 +1320,13 @@ static int ext4_write_end(struct file *file,
 	 * If FS_IOC_ENABLE_VERITY is running on this inode, then Merkle tree
 	 * blocks are being written past EOF, so skip the i_size update.
 	 */
-	if (!verity)
+	if (!verity) {
 		i_size_changed = ext4_update_inode_size(inode, pos + copied);
+		folio_may_straddle_isize(inode, page_folio(page), old_size, pos);
+	}
 	unlock_page(page);
 	put_page(page);
 
-	if (old_size < pos && !verity)
-		pagecache_isize_extended(inode, old_size, pos);
 	/*
 	 * Don't mark the inode dirty under page lock. First, it unnecessarily
 	 * makes the holding time of page lock longer. Second, it forces lock
@@ -1432,16 +1432,15 @@ static int ext4_journalled_write_end(struct file *file,
 		if (!partial)
 			SetPageUptodate(page);
 	}
-	if (!verity)
+	if (!verity) {
 		size_changed = ext4_update_inode_size(inode, pos + copied);
+		folio_may_straddle_isize(inode, page_folio(page), old_size, pos);
+	}
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 	unlock_page(page);
 	put_page(page);
 
-	if (old_size < pos && !verity)
-		pagecache_isize_extended(inode, old_size, pos);
-
 	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (!ret)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 91ee0b308e13..96e643de32a0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -713,15 +713,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	if (pos + ret > old_size) {
 		i_size_write(iter->inode, pos + ret);
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+		folio_may_straddle_isize(iter->inode, folio, old_size, pos);
 	}
 	folio_unlock(folio);
-
-	if (old_size < pos)
-		pagecache_isize_extended(iter->inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
 		page_ops->page_done(iter->inode, pos, ret, &folio->page);
 	folio_put(folio);
-
 	if (ret < len)
 		iomap_write_failed(iter->inode, pos + ret, len - ret);
 	return ret;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..e1f03c9ed8df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1890,6 +1890,8 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 
 extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
+void folio_may_straddle_isize(struct inode *inode, struct folio *folio,
+			      loff_t old_size, loff_t start);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
diff --git a/mm/truncate.c b/mm/truncate.c
index c0be77e5c008..9a5d3c3c12d0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -779,6 +779,40 @@ void truncate_setsize(struct inode *inode, loff_t newsize)
 }
 EXPORT_SYMBOL(truncate_setsize);
 
+/**
+ * folio_may_straddle_isize - update pagecache after extending i_size
+ * @inode:	inode for which i_size was extended
+ * @folio:	folio to maybe mark read-only
+ * @old_size:	original inode size
+ * @start:	start of the write
+ *
+ * Handle extending an inode by a write that starts behind the old inode size.
+ * If a block-aligned hole exists between the old inode size and the start of
+ * the write, we mark the folio read-only so that page_mkwrite() is called on
+ * the nearest write access to the page.  That way, the filesystem can be sure
+ * that page_mkwrite() is called on the page before a user writes to the page
+ * via mmap.
+ *
+ * This function must be called while we still hold i_rwsem - this not only
+ * makes sure i_size is stable but also that userspace cannot observe the new
+ * i_size value before we are prepared to handle mmap writes there.
+ */
+void folio_may_straddle_isize(struct inode *inode, struct folio *folio,
+			      loff_t old_size, loff_t start)
+{
+	unsigned int blocksize = i_blocksize(inode);
+
+	if (round_up(old_size, blocksize) >= round_down(start, blocksize))
+		return;
+
+	/*
+	 * See clear_page_dirty_for_io() for details why folio_set_dirty()
+	 * is needed.
+	 */
+	if (folio_mkclean(folio))
+		folio_set_dirty(folio);
+}
+
 /**
  * pagecache_isize_extended - update pagecache after extension of i_size
  * @inode:	inode for which i_size was extended
-- 
2.38.1

