Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2E862D3DE
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 08:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiKQHOr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 02:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKQHOq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 02:14:46 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24C25C71;
        Wed, 16 Nov 2022 23:14:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NCWPn4sGSz4f3m6Y;
        Thu, 17 Nov 2022 15:14:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDXgK9g33VjzCGGAg--.707S4;
        Thu, 17 Nov 2022 15:14:40 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix uninit-value in 'ext4_evict_inode'
Date:   Thu, 17 Nov 2022 15:36:03 +0800
Message-Id: <20221117073603.2598882-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXgK9g33VjzCGGAg--.707S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxuFWxGr4UAr17Ww1ftFb_yoWrGFyUp3
        9xJryfZF1UuryDC3yxKr4vqFy8ZasxWFWUGr4fKr1DZFy7Xw1agFyktF45W3WfuFWrCryr
        XF1DAr4UZr4rA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
=====================================================
BUG: KMSAN: uninit-value in ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
 ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
 evict+0x365/0x9a0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x985/0xdd0 fs/inode.c:1773
 __ext4_new_inode+0xe54/0x7ec0 fs/ext4/ialloc.c:1361
 ext4_mknod+0x376/0x840 fs/ext4/namei.c:2844
 vfs_mknod+0x79d/0x830 fs/namei.c:3914
 do_mknodat+0x47d/0xaa0
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __ia32_sys_mknodat+0xeb/0x150 fs/namei.c:3989
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5578
 alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x1b5/0x1010 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 ext4_alloc_inode+0x5f/0x860 fs/ext4/super.c:1321
 alloc_inode+0x83/0x440 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x3b/0x430 fs/inode.c:1046
 __ext4_new_inode+0x2a7/0x7ec0 fs/ext4/ialloc.c:959
 ext4_mkdir+0x4d5/0x1560 fs/ext4/namei.c:2992
 vfs_mkdir+0x62a/0x870 fs/namei.c:4035
 do_mkdirat+0x466/0x7b0 fs/namei.c:4060
 __do_sys_mkdirat fs/namei.c:4075 [inline]
 __se_sys_mkdirat fs/namei.c:4073 [inline]
 __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4073
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 4625 Comm: syz-executor.2 Not tainted 6.1.0-rc4-syzkaller-62821-gcb231e2f67ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================

Now, 'ext4_alloc_inode()' didn't init 'ei->i_flags'. If new inode failed
before set 'ei->i_flags' in '__ext4_new_inode()', then do 'iput()'. As after
6bc0d63dad7f commit will access 'ei->i_flags' in 'ext4_evict_inode()' which
will lead to access uninit-value.
To solve above issue just init 'ei->i_flags' in 'ext4_alloc_inode()'.

Reported-by: syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com
Fixes:6bc0d63dad7f("ext4: remove EA inode entry from mbcache on inode eviction")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ae433e1337ed..cd2590489392 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1323,6 +1323,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	inode_set_iversion(&ei->vfs_inode, 1);
+	ei->i_flags = 0;
 	spin_lock_init(&ei->i_raw_lock);
 	INIT_LIST_HEAD(&ei->i_prealloc_list);
 	atomic_set(&ei->i_prealloc_active, 0);
-- 
2.31.1

