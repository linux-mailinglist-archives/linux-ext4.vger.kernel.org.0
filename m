Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDEB641393
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Dec 2022 03:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiLCCiu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 21:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiLCCiq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 21:38:46 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00BEC091;
        Fri,  2 Dec 2022 18:38:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NPDWz4GBzz4f3v7B;
        Sat,  3 Dec 2022 10:38:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNavtopjXug+Bg--.58501S7;
        Sat, 03 Dec 2022 10:38:42 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: [PATCH v3 3/3] ext4: add check pending tree when evict inode
Date:   Sat,  3 Dec 2022 10:59:41 +0800
Message-Id: <20221203025941.2661302-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221203025941.2661302-1-yebin@huaweicloud.com>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXSNavtopjXug+Bg--.58501S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xtryUGF48Zr45ZF18Xwb_yoW5JFW7p3
        45Gw15Gr4kur1DCF43tF15Jr13Wa1vkFWUJrWrKr1jqFy8Ja4xtFnrtr1agF4UJrZxCr1Y
        qF18Cr9Yqry8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2PEfUUUUU
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

Syzbot found the following issue:
BUG: memory leak
unreferenced object 0xffff8881bde17420 (size 32):
  comm "rep", pid 2327, jiffies 4295381963 (age 32.265s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ac6d38f8>] __insert_pending+0x13c/0x2d0
    [<00000000d717de3b>] ext4_es_insert_delayed_block+0x399/0x4e0
    [<000000004be03913>] ext4_da_map_blocks.constprop.0+0x739/0xfa0
    [<00000000885a832a>] ext4_da_get_block_prep+0x10c/0x440
    [<0000000029b7f8ef>] __block_write_begin_int+0x28d/0x860
    [<00000000e182ebc3>] ext4_da_write_inline_data_begin+0x2d1/0xf30
    [<00000000ced0c8a2>] ext4_da_write_begin+0x612/0x860
    [<000000008d5f27fa>] generic_perform_write+0x215/0x4d0
    [<00000000552c1cde>] ext4_buffered_write_iter+0x101/0x3b0
    [<0000000052177ae8>] do_iter_readv_writev+0x19f/0x340
    [<000000004b9de834>] do_iter_write+0x13b/0x650
    [<00000000e2401b9b>] iter_file_splice_write+0x5a5/0xab0
    [<0000000023aa5d90>] direct_splice_actor+0x103/0x1e0
    [<0000000089e00fc1>] splice_direct_to_actor+0x2c9/0x7b0
    [<000000004386851e>] do_splice_direct+0x159/0x280
    [<00000000b567e609>] do_sendfile+0x932/0x1200

Above issue fixed by 1b8f787ef547 "ext4: fix warning in 'ext4_da_release_space'"
in this scene. To make things better add check pending tree when evit inode.
According to Eric Whitney's suggestion, bigalloc + inline is still in development
so we just add test for this situation, there isn't need to add code to free
pending tree entry.

Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 41413338c05b..2e2fbc4a832c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1391,6 +1391,11 @@ static void ext4_destroy_inode(struct inode *inode)
 			"Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
 			inode->i_ino, EXT4_I(inode),
 			EXT4_I(inode)->i_reserved_data_blocks);
+
+	if (!RB_EMPTY_ROOT(&EXT4_I(inode)->i_pending_tree.root))
+		ext4_error(inode->i_sb,
+			"Inode %lu (%p): i_pending_tree not empty!",
+			inode->i_ino, EXT4_I(inode));
 }
 
 static void init_once(void *foo)
-- 
2.31.1

