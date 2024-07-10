Return-Path: <linux-ext4+bounces-3156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894892C991
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413EF1F242C0
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA53768FD;
	Wed, 10 Jul 2024 04:09:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B53D96D;
	Wed, 10 Jul 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584558; cv=none; b=iJzHUEMfdrPFDFMreOXf+vBkNS6/yZJfN0lM2JmNw3CL1D8HjDNJJnDzLAxt//5NX+Wy3pHwFpAxeDuzwxKegqKkGmKbEcOFJNR3petNctbfaVs/yJLcnPDnZMP5tOWMTqECEq1gar4WR2PpU2eljzxlDnTP75VhB1srM7E9HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584558; c=relaxed/simple;
	bh=dG9CFH2mnaAi3k/Ik6GZklICo+ygmHf+tl6LKKkgQko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKI+DJjXbnc9pC9mZyU8WlwcsAziVE6mZTRnly3s5ekTpMXObXt0vfIKsGOJg9AMAlN4Jglbtjt80VVWYfm2QFMWVlTPGaQyxW2OGAmUftA/wJQuubtX0TyOPYZE4yOn/Wvqed8bOQV5g6CxhpzC0piEuA9B5Vv67RNGMwFUJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJkrB238Lz4f3kp6;
	Wed, 10 Jul 2024 12:08:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E21C21A0CE8;
	Wed, 10 Jul 2024 12:09:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S7;
	Wed, 10 Jul 2024 12:09:05 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: [PATCH 03/20] ext4: fix double brelse() the buffer of the extents path
Date: Wed, 10 Jul 2024 12:06:37 +0800
Message-Id: <20240710040654.1714672-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710040654.1714672-1-libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWF43AFyfJw1rWr48XFyftFb_yoW5Gw1rpr
	sIkryxGr1rt3yq9FWDXa1UWr18C3W7Gw47JFWfG3WjkFyDAr4kXFyxt3WFvFyUuFW8uFWY
	vrW8t34UW3Z8Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUOOJ5UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IIgAAs9

From: Baokun Li <libaokun1@huawei.com>

In ext4_ext_try_to_merge_up(), set path[1].p_bh to NULL after it has been
released, otherwise it may be released twice.

An example of what triggers this is as follows:

  split2    map    split1
|--------|-------|--------|

ext4_ext_map_blocks
 ext4_ext_handle_unwritten_extents
  ext4_split_convert_extents
   // path->p_depth == 0
   ext4_split_extent
     // 1. do split1
     ext4_split_extent_at
       ext4_ext_insert_extent
         ext4_ext_create_new_leaf
           ext4_ext_grow_indepth
             le16_add_cpu(&neh->eh_depth, 1)
           ext4_find_extent
             path->p_depth = 1
         ext4_ext_try_to_merge
           ext4_ext_try_to_merge_up
             path->p_depth = 0
             brelse(path[1].p_bh)  ---> not set to NULL here
     // 2. update path
     ext4_find_extent
     // 3. do split2
     ext4_split_extent_at
       ext4_ext_insert_extent
         ext4_ext_create_new_leaf
           ext4_ext_grow_indepth
             le16_add_cpu(&neh->eh_depth, 1)
           ext4_find_extent
             path[0].p_bh = NULL;
             path->p_depth = 1
             read_extent_tree_block  ---> return err
             // path[1].p_bh is still the old value
 ext4_free_ext_path
  ext4_ext_drop_refs
   // path->p_depth == 1
   brelse(path[1].p_bh)  ---> brelse a buffer twice

Finally got the following WARRNING when removing the buffer from lru:

============================================
VFS: brelse: Trying to free free buffer
WARNING: CPU: 2 PID: 72 at fs/buffer.c:1241 __brelse+0x58/0x90
CPU: 2 PID: 72 Comm: kworker/u19:1 Not tainted 6.9.0-dirty #716
RIP: 0010:__brelse+0x58/0x90
Call Trace:
 <TASK>
 __find_get_block+0x6e7/0x810
 bdev_getblk+0x2b/0x480
 __ext4_get_inode_loc+0x48a/0x1240
 ext4_get_inode_loc+0xb2/0x150
 ext4_reserve_inode_write+0xb7/0x230
 __ext4_mark_inode_dirty+0x144/0x6a0
 ext4_ext_insert_extent+0x9c8/0x3230
 ext4_ext_map_blocks+0xf45/0x2dc0
 ext4_map_blocks+0x724/0x1700
 ext4_do_writepages+0x12d6/0x2a70
[...]
============================================

Fixes: ecb94f5fdf4b ("ext4: collapse a single extent tree block into the inode if possible")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4d589d34b30e..657baf3991c1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1888,6 +1888,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
 	brelse(path[1].p_bh);
+	path[1].p_bh = NULL;
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }
-- 
2.39.2


