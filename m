Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CA646795
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 04:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLHDNn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 22:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLHDNi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 22:13:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DA25C746;
        Wed,  7 Dec 2022 19:13:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSK3v6T9dz4f3kpC;
        Thu,  8 Dec 2022 11:13:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgAn0a9cVpFjvYz4Bg--.16330S7;
        Thu, 08 Dec 2022 11:13:34 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: [PATCH v4 3/3] ext4: add check pending tree when evict inode
Date:   Thu,  8 Dec 2022 11:34:26 +0800
Message-Id: <20221208033426.1832460-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221208033426.1832460-1-yebin@huaweicloud.com>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAn0a9cVpFjvYz4Bg--.16330S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxAF1kKw4DJr1UAF4rGrg_yoW5Jw1rp3
        4UGw15Cr4kur1DCF4ftF15Jr13Wa1vkF4UJrWrKr1jqFy8Ja4xtFnrtr1agF4UJrZxur1Y
        qF18Cr9YqrW8G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
        oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU8-zVUUUUUU==
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

Above issue fixed by
commit 1b8f787ef547 ("ext4: fix warning in 'ext4_da_release_space'")
in this scene. To make things better add check pending tree when evict
inode.
According to Eric Whitney's suggestion, bigalloc + inline is still in
development so we just add test for this situation, there isn't need to
add code to free pending tree entry.

Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4b2d257d3845..15b6634975e7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1391,6 +1391,11 @@ static void ext4_destroy_inode(struct inode *inode)
 			   "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
 			   inode->i_ino, EXT4_I(inode),
 			   EXT4_I(inode)->i_reserved_data_blocks);
+
+	if (!RB_EMPTY_ROOT(&EXT4_I(inode)->i_pending_tree.root))
+		ext4_error(inode->i_sb,
+			   "Inode %lu (%p): i_pending_tree not empty!",
+			   inode->i_ino, EXT4_I(inode));
 }
 
 static void init_once(void *foo)
-- 
2.31.1

