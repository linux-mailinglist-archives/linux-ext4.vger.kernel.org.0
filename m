Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66A95BFEF4
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIUNbg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIUNbf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 09:31:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20128A7EC;
        Wed, 21 Sep 2022 06:31:33 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXfQV1SXLzHp5r;
        Wed, 21 Sep 2022 21:29:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:31:31 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH] ext4: fix use-after-free in ext4_ext_shift_extents
Date:   Wed, 21 Sep 2022 21:42:18 +0800
Message-ID: <20220921134218.3577001-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the starting position of our insert range happens to be in the hole
between the two ext4_extent_idx, because the lblk of the ext4_extent in
the previous ext4_extent_idx is always less than the start, which leads
to the "extent" variable access across the boundary, the following UAF is
triggered:
==================================================================
BUG: KASAN: use-after-free in ext4_ext_shift_extents+0x257/0x790
Read of size 4 at addr ffff88819807a008 by task fallocate/8010
CPU: 3 PID: 8010 Comm: fallocate Tainted: G            E     5.10.0+ #492
Call Trace:
 dump_stack+0x7d/0xa3
 print_address_description.constprop.0+0x1e/0x220
 kasan_report.cold+0x67/0x7f
 ext4_ext_shift_extents+0x257/0x790
 ext4_insert_range+0x5b6/0x700
 ext4_fallocate+0x39e/0x3d0
 vfs_fallocate+0x26f/0x470
 ksys_fallocate+0x3a/0x70
 __x64_sys_fallocate+0x4f/0x60
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
==================================================================

To solve this issue, when the ee_block of the last extent is less than
the start, exit the loop in advance to avoid UAF.

Fixes: 331573febb6a ("ext4: Add support FALLOC_FL_INSERT_RANGE for fallocate")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
We can try to reproduce this problem by following the steps below:
1. Create an ext4 containing two ext4_extent_idx
 mkfs.ext4 -F -O ^resize_inode,meta_bg,^sparse_super,^has_journal,^metadata_csum,quota,ea_inode -b 1024 -I 128 /dev/sda 4G
 mount /dev/sda /tmp/test
 touch file
 dd if=/dev/urandom of=/tmp/test/file bs=1k count=800000
 sync
 echo 3 > /proc/sys/vm/drop_caches

2. Create a hole between two ext4_extent_idx, 528482304 is the starting position of idx2
 fallocate -i -o 528482304 -l 10M /tmp/test/file

3. Keep moving right to make variable extent out of bounds
 for i in `seq 0 500000`; do fallocate -i -o $[ 533725184 + 5242880 * i ] -l 10M /tmp/test/file ;done

4. Execute "drop_caches" in another window try to trigger UAF
 echo 3 > /proc/sys/vm/drop_caches

 fs/ext4/extents.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..25fc1f4b35a5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5216,11 +5216,18 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 		}
 
 		tmp = *iterator;
+		extent = EXT_LAST_EXTENT(path[depth].p_hdr);
 		if (SHIFT == SHIFT_LEFT) {
-			extent = EXT_LAST_EXTENT(path[depth].p_hdr);
 			*iterator = le32_to_cpu(extent->ee_block) +
 					ext4_ext_get_actual_len(extent);
 		} else {
+			/*
+			 * start happens to be in the hole between
+			 * the two ext4_extent_idx.
+			 */
+			if (le32_to_cpu(extent->ee_block) < start)
+				break;
+
 			extent = EXT_FIRST_EXTENT(path[depth].p_hdr);
 			if (le32_to_cpu(extent->ee_block) > 0)
 				*iterator = le32_to_cpu(extent->ee_block) - 1;
-- 
2.31.1

