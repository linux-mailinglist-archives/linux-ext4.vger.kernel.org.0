Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0AD3FFA4F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbhICGSs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 02:18:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15285 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbhICGSp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 02:18:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H16yl0c0Sz8DRC;
        Fri,  3 Sep 2021 14:17:19 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 14:17:43 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 3 Sep 2021 14:17:42 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 3/3] ext4: stop use path once restart journal in ext4_ext_shift_path_extents
Date:   Fri, 3 Sep 2021 14:27:48 +0800
Message-ID: <20210903062748.4118886-4-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903062748.4118886-1-yangerkun@huawei.com>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We get a BUG as follow:

[52117.465187] ------------[ cut here ]------------
[52117.465686] kernel BUG at fs/ext4/extents.c:1756!
...
[52117.478306] Call Trace:
[52117.478565]  ext4_ext_shift_extents+0x3ee/0x710
[52117.479020]  ext4_fallocate+0x139c/0x1b40
[52117.479405]  ? __do_sys_newfstat+0x6b/0x80
[52117.479805]  vfs_fallocate+0x151/0x4b0
[52117.480177]  ksys_fallocate+0x4a/0xa0
[52117.480533]  __x64_sys_fallocate+0x22/0x30
[52117.480930]  do_syscall_64+0x35/0x80
[52117.481277]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[52117.481769] RIP: 0033:0x7fa062f855ca

static int ext4_ext_try_to_merge_right(struct inode *inode,
                                 struct ext4_ext_path *path,
                                 struct ext4_extent *ex)
{
        struct ext4_extent_header *eh;
        unsigned int depth, len;
        int merge_done = 0, unwritten;

        depth = ext_depth(inode);
        BUG_ON(path[depth].p_hdr == NULL); <=== trigger here
        eh = path[depth].p_hdr;

Normally, we protect extent tree with i_data_sem, and once we really
need drop i_data_sem, we should reload the ext4_ext_path array after we
recatch i_data_sem since extent tree may has changed, the 'again' in
ext4_ext_remove_space give us a sample. But the other case
ext4_ext_shift_path_extents seems forget to do this(ext4_access_path may
drop i_data_sem and recatch it with not enough credits), and will lead
the upper BUG when there is a parallel extents split which will grow the
extent tree.

Fix it by introduce the again in ext4_ext_shift_extents.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a6fb0350f062..0aa14f6ca914 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5009,8 +5009,11 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 			restart_credits = ext4_writepage_trans_blocks(inode);
 			err = ext4_datasem_ensure_credits(handle, inode, credits,
 					restart_credits, 0);
-			if (err)
+			if (err) {
+				if (err > 0)
+					err = -EAGAIN;
 				goto out;
+			}
 
 			err = ext4_ext_get_access(handle, inode, path + depth);
 			if (err)
@@ -5084,6 +5087,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	int ret = 0, depth;
 	struct ext4_extent *extent;
 	ext4_lblk_t stop, *iterator, ex_start, ex_end;
+	ext4_lblk_t tmp = EXT_MAX_BLOCKS;
 
 	/* Let path point to the last extent */
 	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
@@ -5137,11 +5141,15 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	 * till we reach stop. In case of right shift, iterator points to stop
 	 * and it is decreased till we reach start.
 	 */
+again:
 	if (SHIFT == SHIFT_LEFT)
 		iterator = &start;
 	else
 		iterator = &stop;
 
+	if (tmp != EXT_MAX_BLOCKS)
+		*iterator = tmp;
+
 	/*
 	 * Its safe to start updating extents.  Start and stop are unsigned, so
 	 * in case of right shift if extent with 0 block is reached, iterator
@@ -5170,6 +5178,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 			}
 		}
 
+		tmp = *iterator;
 		if (SHIFT == SHIFT_LEFT) {
 			extent = EXT_LAST_EXTENT(path[depth].p_hdr);
 			*iterator = le32_to_cpu(extent->ee_block) +
@@ -5188,6 +5197,9 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 		}
 		ret = ext4_ext_shift_path_extents(path, shift, inode,
 				handle, SHIFT);
+		/* iterator can be NULL which means we should break */
+		if (ret == -EAGAIN)
+			goto again;
 		if (ret)
 			break;
 	}
-- 
2.31.1

