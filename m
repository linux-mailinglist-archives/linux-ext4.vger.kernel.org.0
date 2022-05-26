Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF86534AB5
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiEZHS7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 May 2022 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiEZHS5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 May 2022 03:18:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905B5AA72
        for <linux-ext4@vger.kernel.org>; Thu, 26 May 2022 00:18:55 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L7zlj2Jlgz1JC8n;
        Thu, 26 May 2022 15:17:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 15:18:52 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <lilingfeng3@huawei.com>
Subject: [PATCH] ext4: add reserved GDT blocks check
Date:   Thu, 26 May 2022 15:32:22 +0800
Message-ID: <20220526073222.380259-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We capture a NULL pointer issue when resizing a corrupt ext4 image which
is freshly clear resize_inode feature (not run e2fsck). It could be
simply reproduced by following steps. The problem is because of the
resize_inode feature was cleared, and it will convert the filesystem to
meta_bg mode in ext4_resize_fs(), but the es->s_reserved_gdt_blocks was
not reduced to zero, so could we mistakenly call reserve_backup_gdb()
and passing an uninitialized resize_inode to it when adding new group
descriptors.

 mkfs.ext4 /dev/sda 3G
 tune2fs -O ^resize_inode /dev/sda #forget to run requested e2fsck
 mount /dev/sda /mnt
 resize2fs /dev/sda 8G

 ========
 BUG: kernel NULL pointer dereference, address: 0000000000000028
 CPU: 19 PID: 3243 Comm: resize2fs Not tainted 5.18.0-rc7-00001-gfde086c5ebfd #748
 ...
 RIP: 0010:ext4_flex_group_add+0xe08/0x2570
 ...
 Call Trace:
  <TASK>
  ext4_resize_fs+0xbec/0x1660
  __ext4_ioctl+0x1749/0x24e0
  ext4_ioctl+0x12/0x20
  __x64_sys_ioctl+0xa6/0x110
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f2dd739617b
 ========

The fix is simple, add a check in ext4_resize_fs() to make sure that the
es->s_reserved_gdt_blocks is zero when the resize_inode feature is
disabled.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/resize.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 90a941d20dff..5791eb7c0761 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2031,6 +2031,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(resize_inode);
 		}
+	} else if (es->s_reserved_gdt_blocks) {
+		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
+		return -EFSCORRUPTED;
 	}
 
 	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
-- 
2.31.1

