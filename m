Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5360BEED
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJXXsZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 19:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJXXrx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 19:47:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8C2FC5A3;
        Mon, 24 Oct 2022 15:06:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mwtxh3dNszKFN2;
        Mon, 24 Oct 2022 20:03:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgC3xuiJf1ZjjtV9AA--.11645S4;
        Mon, 24 Oct 2022 20:05:31 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH RFC] ext4:record error information when insert extent failed in 'ext4_split_extent_at'
Date:   Mon, 24 Oct 2022 20:27:25 +0800
Message-Id: <20221024122725.3083432-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3xuiJf1ZjjtV9AA--.11645S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfWr13Jr1UKr4UGr4DArb_yoWrWrWrpr
        Z3Cr1xGr15J3WUCrZ7AFs2gryI9a17Gw1UJFyfGr1fJFyUZrWUWFn8KF1FvFy8WrW8Ga45
        XFW8trW5WF1DCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

There's issue as follows when do test with memory fault injection:
[localhost]# fsck.ext4 -a image
image: clean, 45595/655360 files, 466841/2621440 blocks
[localhost]# fsck.ext4 -fn image
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(1457230--1457256)
Fix? no

image: ********** WARNING: Filesystem still has errors **********

image: 45595/655360 files (12.4% non-contiguous), 466841/2621440 blocks

Inject context:
 -----------------------------------------------------------
 Inject function:kmem_cache_alloc (pid:177858) (return: 0)
 Calltrace Context:
 mem_cache_allock+0x73/0xcc
 ext4_mb_new_blocks+0x32e/0x540 [ext4]
 ext4_new_meta_blocks+0xc4/0x110 [ext4]
 ext4_ext_grow_indepth+0x68/0x250 [ext4]
 ext4_ext_create_new_leaf+0xc5/0x120 [ext4]
 ext4_ext_insert_extent+0x1bf/0x670 [ext4]
 ext4_split_extent_at+0x212/0x530 [ext4]
 ext4_split_extent+0x13a/0x1a0 [ext4]
 ext4_ext_handle_unwritten_extents+0x13d/0x240 [ext4]
 ext4_ext_map_blocks+0x459/0x8f0 [ext4]
 ext4_map_blocks+0x18e/0x5a0 [ext4]
 ext4_iomap_alloc+0xb0/0x1b0 [ext4]
 ext4_iomap_begin+0xb0/0x130 [ext4]
 iomap_apply+0x95/0x2e0
 __iomap_dio_rw+0x1cc/0x4b0
 iomap_dio_rw+0xe/0x40
 ext4_dio_write_iter+0x1a9/0x390 [ext4]
 new_sync_write+0x113/0x1b0
 vfs_write+0x1b7/0x250
 ksys_write+0x5f/0xe0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Compare extent change in journal:
Start:
ee_block      ee_len        ee_start
75            32798         1457227  -> unwritten len=30
308           12            434489
355           5             442492
=>
ee_block      ee_len        ee_start
11            2             951584
74            32769         951647   -> unwritten  len=1
75            32771         1457227  -> unwritten  len=3, length decreased 27
211           15            960906
308           12            434489
355           5             442492

Acctually, above issue can repaired by 'fsck -fa'. But file system is 'clean',
'fsck' will not do deep repair.
Obviously, final lost 27 blocks. Above issue may happens as follows:
ext4_split_extent_at
...
err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags); -> return -ENOMEM
if (err != -ENOSPC && err != -EDQUOT）
	goto out; -> goto 'out' will not fix extent length, will
...
fix_extent_len:
        ex->ee_len = orig_ex.ee_len;
        /*
         * Ignore ext4_ext_dirty return value since we are already in error path
         * and err is a non-zero error code.
         */
        ext4_ext_dirty(handle, inode, path + path->p_depth);
        return err;
out:
        ext4_ext_show_leaf(inode, path);
        return err;
If 'ext4_ext_insert_extent' return '-ENOMEM' which will not fix 'ex->ee_len' by
old length. 'ext4_ext_insert_extent' will trigger extent tree merge, fix like
'ex->ee_len = orig_ex.ee_len' may lead to new issues.
To solve above issue, record error messages when 'ext4_ext_insert_extent' return
'err' not equal '(-ENOSPC && -EDQUOT)'. If filesysten is mounted with 'errors=continue'
as filesystem is not clean 'fsck' will repair issue. If filesystem is mounted with
'errors=remount-ro' filesystem will be remounted by read-only.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/extents.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1956288307f..582a7d59d6e3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3252,8 +3252,13 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT)
+	if (err != -ENOSPC && err != -EDQUOT) {
+		if (err)
+			EXT4_ERROR_INODE_ERR(inode, -err,
+			"insert extent failed block = %d len = %d",
+			ex2->ee_block, ex2->ee_len);
 		goto out;
+	}
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
-- 
2.31.1

