Return-Path: <linux-ext4+bounces-11989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F10C781DD
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2899935C58D
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80434405D;
	Fri, 21 Nov 2025 09:17:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1683019D7;
	Fri, 21 Nov 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716622; cv=none; b=Pzpm0Pf4fkXc0eMWF3lUhfi9sdOtPZFDZHadcQ3deDQ2XcLchlePgJkmsS5Dawg99SnPBqPDjTWLBols9smrbK1ClHQ774nl7RzKjAFGmQD91PDHhVvqQ/3ewb1kU5JKDlRAWBTgFA2lbYj0DH3GiHh4q6dMgrM3RVjsa/NUJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716622; c=relaxed/simple;
	bh=5nRH6C9HPbHrAAAWo8bVZIj+b7lLZlXDwmXnibyUFPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GL459QYREg4sVf8ts+n4reeo9X1m5qGhfNv7lddP8UP3q/ASl3y+nQXiHQohpEPail1EG+qaNXsor2GpUJ7K/JRyVRHaR9GaG8kGxQr8EbJFzjaP2Io4AqB284Q//yWNRp1e3Getm52CRuROSSYQtw7qimSKw/6GMy83XZDvN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCV2P0qPxzKHMw9;
	Fri, 21 Nov 2025 17:16:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 14DCA1A1B41;
	Fri, 21 Nov 2025 17:16:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S25;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	ebiggers@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 21/24] ext4: make data=journal support large block size
Date: Fri, 21 Nov 2025 17:06:51 +0800
Message-Id: <20251121090654.631996-22-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S25
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1xWFy3AF47GF4UWF48WFg_yoW7XrWUpr
	y3Gry8t3ykZFyq9r48ta17Zr1Yg3WxK3yUZ3s3u3Z3Zw1kJ342gF4jyF1xAFWUJrZ3Ww4S
	qF40yryUCFnIk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQATBWkf35kfGwABsi

From: Baokun Li <libaokun1@huawei.com>

Currently, ext4_set_inode_mapping_order() does not set max folio order
for files with the data journalling flag. For files that already have
large folios enabled, ext4_inode_journal_mode() ignores the data
journalling flag once max folio order is set.

This is not because data journalling cannot work with large folios, but
because credit estimates will go through the roof if there are too many
blocks per folio.

Since the real constraint is blocks-per-folio, to support data=journal
under LBS, we now set max folio order to be equal to min folio order for
files with the journalling flag. When LBS is disabled, the max folio order
remains unset as before.

Therefore, before ext4_change_inode_journal_flag() switches the journalling
mode, we call truncate_pagecache() to drop all page cache for that inode,
and filemap_write_and_wait() is called unconditionally.

After that, once the journalling mode has been switched, we can safely
reset the inode mapping order, and the mapping_large_folio_support() check
in ext4_inode_journal_mode() can be removed.

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c |  3 +--
 fs/ext4/inode.c     | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index a0e66bc10093..05e5946ed9b3 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -16,8 +16,7 @@ int ext4_inode_journal_mode(struct inode *inode)
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC) &&
-	    !mapping_large_folio_support(inode->i_mapping))) {
+	    !test_opt(inode->i_sb, DELALLOC))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
 			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5499b2856f9e..fff059bfeb52 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5152,9 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
-		return false;
 	if (ext4_has_feature_verity(sb))
 		return false;
 	if (ext4_has_feature_encrypt(sb))
@@ -5172,12 +5169,20 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
 void ext4_set_inode_mapping_order(struct inode *inode)
 {
+	u32 max_order;
+
 	if (!ext4_should_enable_large_folio(inode))
 		return;
 
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
+	else
+		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
+
 	mapping_set_folio_order_range(inode->i_mapping,
 				      EXT4_SB(inode->i_sb)->s_min_folio_order,
-				      EXT4_MAX_PAGECACHE_ORDER(inode));
+				      max_order);
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -6552,14 +6557,14 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	 * dirty data which can be converted only after flushing the dirty
 	 * data (and journalled aops don't know how to handle these cases).
 	 */
-	if (val) {
-		filemap_invalidate_lock(inode->i_mapping);
-		err = filemap_write_and_wait(inode->i_mapping);
-		if (err < 0) {
-			filemap_invalidate_unlock(inode->i_mapping);
-			return err;
-		}
+	filemap_invalidate_lock(inode->i_mapping);
+	err = filemap_write_and_wait(inode->i_mapping);
+	if (err < 0) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		return err;
 	}
+	/* Before switch the inode journalling mode evict all the page cache. */
+	truncate_pagecache(inode, 0);
 
 	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 	jbd2_journal_lock_updates(journal);
@@ -6579,17 +6584,17 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
 			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
+			filemap_invalidate_unlock(inode->i_mapping);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
 	}
 	ext4_set_aops(inode);
+	ext4_set_inode_mapping_order(inode);
 
 	jbd2_journal_unlock_updates(journal);
 	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
-
-	if (val)
-		filemap_invalidate_unlock(inode->i_mapping);
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	/* Finally we can mark the inode as dirty. */
 
-- 
2.46.1


