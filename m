Return-Path: <linux-ext4+bounces-3338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D99D9381EB
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1361C1C217A0
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997001339B1;
	Sat, 20 Jul 2024 15:54:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933221304AB;
	Sat, 20 Jul 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490845; cv=none; b=IgTweyJ0xBLjecC+KU25/f0/yiUuROPSxHB9jfTQ4HY1gAFRwh3r+gqGErVYEj+tuLPpaWnXZszlmGoYCIziIFlJkoYTc/GPjvPSfUEfLOIjqRkj5OXzDeleBSwd3+GCydVss17QpHeynJzJZlgGO4y8uXpUou25OnKkR6mxzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490845; c=relaxed/simple;
	bh=ASqIES6++m92AgyexXOlf4J/I58Gx+7DeLpgxJ8XiwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhOC6A3Z2e+orCF7IYuI8AaVnVbuuryZto9AS/NjI9B5NY41LZC02lMVvx7cOIyxqOgFIOL6gfvwmYJBTW3VCs9j0llIARAzkYonzh0pntRcFv3TJihvaKqkotJydJlI/KzpBN7bJ14tb+mnag+CbLy5BKSugILKzy65UL7aJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp84t1721490827tw10nrh6
X-QQ-Originating-IP: 8uoSa04W3GuV3+k34ZjDKWM/mdVIS9m0g2pONpgQ5aI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Jul 2024 23:53:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15371377549656536565
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yi.zhang@huawei.com
Cc: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	niecheng1@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 4/4] ext4: drop unnecessary journal handle in delalloc write
Date: Sat, 20 Jul 2024 23:52:03 +0800
Message-ID: <E6958513B9DFDCD0+20240720155234.573790-5-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240720155234.573790-1-wangyuli@uniontech.com>
References: <20240720155234.573790-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Zhang Yi <yi.zhang@huawei.com>

After we factor out the inline data write procedure from
ext4_da_write_end(), we don't need to start journal handle for the cases
of both buffer overwrite and append-write. If we need to update
i_disksize, mark_inode_dirty() do start handle and update inode buffer.
So we could just remove all the journal handle codes in the delalloc
write procedure.

After this patch, we could get a lot of performance improvement. Below
is the Unixbench comparison data test on my machine with 'Intel Xeon
Gold 5120' CPU and nvme SSD backend.

Test cmd:

  ./Run -c 56 -i 3 fstime fsbuffer fsdisk

Before this patch:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     422965.0   1068.1
  File Copy 256 bufsize 500 maxblocks         1655.0     105077.0   634.9
  File Copy 4096 bufsize 8000 maxblocks       5800.0    1429092.0   2464.0
                                                                    ======
  System Benchmarks Index Score (Partial Only)                      1186.6

After this patch:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     732716.0   1850.3
  File Copy 256 bufsize 500 maxblocks         1655.0     184940.0   1117.5
  File Copy 4096 bufsize 8000 maxblocks       5800.0    2427152.0   4184.7
                                                                    ======
  System Benchmarks Index Score (Partial Only)                      2053.0

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20210716122024.1105856-5-yi.zhang@huawei.com
Reviewed-by: Cheng Nie <niecheng1@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/ext4/inode.c | 60 +++++--------------------------------------------
 1 file changed, 5 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1e6753084a00..597c2f49c889 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3032,19 +3032,6 @@ static int ext4_nonda_switch(struct super_block *sb)
 	return 0;
 }
 
-/* We always reserve for an inode update; the superblock could be there too */
-static int ext4_da_write_credits(struct inode *inode, loff_t pos, unsigned len)
-{
-	if (likely(ext4_has_feature_large_file(inode->i_sb)))
-		return 1;
-
-	if (pos + len <= 0x7fffffffULL)
-		return 1;
-
-	/* We might need to update the superblock to set LARGE_FILE */
-	return 2;
-}
-
 static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			       loff_t pos, unsigned len, unsigned flags,
 			       struct page **pagep, void **fsdata)
@@ -3053,7 +3040,6 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	struct page *page;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
-	handle_t *handle;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -3079,41 +3065,11 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			return 0;
 	}
 
-	/*
-	 * grab_cache_page_write_begin() can take a long time if the
-	 * system is thrashing due to memory pressure, or if the page
-	 * is being written back.  So grab it first before we start
-	 * the transaction handle.  This also allows us to allocate
-	 * the page (if needed) without using GFP_NOFS.
-	 */
-retry_grab:
+retry:
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;
-	unlock_page(page);
-
-	/*
-	 * With delayed allocation, we don't log the i_disksize update
-	 * if there is delayed block allocation. But we still need
-	 * to journalling the i_disksize update if writes to the end
-	 * of file which has an already mapped buffer.
-	 */
-retry_journal:
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				ext4_da_write_credits(inode, pos, len));
-	if (IS_ERR(handle)) {
-		put_page(page);
-		return PTR_ERR(handle);
-	}
 
-	lock_page(page);
-	if (page->mapping != mapping) {
-		/* The page got truncated from under us */
-		unlock_page(page);
-		put_page(page);
-		ext4_journal_stop(handle);
-		goto retry_grab;
-	}
 	/* In case writeback began while the page was unlocked */
 	wait_for_stable_page(page);
 
@@ -3125,20 +3081,18 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 #endif
 	if (ret < 0) {
 		unlock_page(page);
-		ext4_journal_stop(handle);
+		put_page(page);
 		/*
 		 * block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
-		 * i_size_read because we hold i_mutex.
+		 * i_size_read because we hold inode lock.
 		 */
 		if (pos + len > inode->i_size)
 			ext4_truncate_failed_write(inode);
 
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
-			goto retry_journal;
-
-		put_page(page);
+			goto retry;
 		return ret;
 	}
 
@@ -3175,8 +3129,6 @@ static int ext4_da_write_end(struct file *file,
 			     struct page *page, void *fsdata)
 {
 	struct inode *inode = mapping->host;
-	int ret;
-	handle_t *handle = ext4_journal_current_handle();
 	loff_t new_i_size;
 	unsigned long start, end;
 	int write_mode = (int)(unsigned long)fsdata;
@@ -3215,9 +3167,7 @@ static int ext4_da_write_end(struct file *file,
 	    ext4_da_should_update_i_disksize(page, end))
 		ext4_update_i_disksize(inode, new_i_size);
 
-	copied = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
-	ret = ext4_journal_stop(handle);
-	return ret ? ret : copied;
+	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
 }
 
 static void ext4_da_invalidatepage(struct page *page, unsigned int offset,
-- 
2.43.4


