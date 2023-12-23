Return-Path: <linux-ext4+bounces-553-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7986781D3AF
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E071F22605
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FAD278;
	Sat, 23 Dec 2023 11:04:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE9CA63
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sy1X01XxKz4f3l22
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 818581A01C1
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDX5UW6voZlWeceEg--.27538S6;
	Sat, 23 Dec 2023 19:04:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v2 2/6] ext4: convert to exclusive lock while inserting delalloc extents
Date: Sat, 23 Dec 2023 19:02:19 +0800
Message-Id: <20231223110223.3650717-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223110223.3650717-1-yi.zhang@huaweicloud.com>
References: <20231223110223.3650717-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX5UW6voZlWeceEg--.27538S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4DZFy8uF4kXr1fZry3XFb_yoW5Cw13pr
	ZIkFyfCr15Ww4kuayIqr17XF1xG3WUJFWUGFZxGF4UZFyUAFnaqF1jyF1aqFyftrWxAF4Y
	qFW0qry5uayUCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIzuJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_da_map_blocks() only hold i_data_sem in shared mode and i_rwsem
when inserting delalloc extents, it could be raced by another querying
path of ext4_map_blocks() without i_rwsem, .e.g buffered read path.
Suppose we buffered read a file containing just a hole, and without any
cached extents tree, then it is raced by another delayed buffered write
to the same area or the near area belongs to the same hole, and the new
delalloc extent could be overwritten to a hole extent.

 pread()                           pwrite()
  filemap_read_folio()
   ext4_mpage_readpages()
    ext4_map_blocks()
     down_read(i_data_sem)
     ext4_ext_determine_hole()
     //find hole
     ext4_ext_put_gap_in_cache()
      ext4_es_find_extent_range()
      //no delalloc extent
                                    ext4_da_map_blocks()
                                     down_read(i_data_sem)
                                     ext4_insert_delayed_block()
                                     //insert delalloc extent
      ext4_es_insert_extent()
      //overwrite delalloc extent to hole

This race could lead to inconsistent delalloc extents tree and
incorrect reserved space counter. Fix this by converting to hold
i_data_sem in exclusive mode when adding a new delalloc extent in
ext4_da_map_blocks().

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b0d3075be12..142c67f5c7fc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1703,10 +1703,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
 		/*
 		 * Delayed extent could be allocated by fallocate.
@@ -1748,8 +1746,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-	if (retval < 0)
-		goto out_unlock;
+	if (retval < 0) {
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
+	}
 	if (retval > 0) {
 		unsigned int status;
 
@@ -1765,24 +1765,21 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
-		goto out_unlock;
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
 	}
+	up_read(&EXT4_I(inode)->i_data_sem);
 
 add_delayed:
-	/*
-	 * XXX: __block_prepare_write() unmaps passed block,
-	 * is it OK?
-	 */
+	down_write(&EXT4_I(inode)->i_data_sem);
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
 	map_bh(bh, inode->i_sb, invalid_block);
 	set_buffer_new(bh);
 	set_buffer_delay(bh);
-
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
 	return retval;
 }
 
-- 
2.39.2


