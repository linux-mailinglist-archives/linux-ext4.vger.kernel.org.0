Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356C96AFD34
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 04:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCHDDj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 22:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHDDi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 22:03:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513C5584B4;
        Tue,  7 Mar 2023 19:03:37 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PWcWg17kyznWd1;
        Wed,  8 Mar 2023 11:00:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 8 Mar
 2023 11:03:34 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] ext4: Fix WANRON caused by unconsistent boot loader inode's i_size and i_disksize
Date:   Wed, 8 Mar 2023 11:26:43 +0800
Message-ID: <20230308032643.641113-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Using corrupted ext4 image(non-zero i_size for boot loader inode) could
trigger WARNON 'i_size_read(inode) < EXT4_I(inode)->i_disksize' in
ext4_handle_inode_extension():

 WARNING: CPU: 0 PID: 2580 at fs/ext4/file.c:319
 CPU: 0 PID: 2580 Comm: bb Not tainted 6.3.0-rc1-00004-g703695902cfa
 RIP: 0010:ext4_file_write_iter+0xbc7/0xd10
 Call Trace:
  vfs_write+0x3b1/0x5c0
  ksys_write+0x77/0x160
  __x64_sys_write+0x22/0x30
  do_syscall_64+0x39/0x80

Reproducer (See Link):
 1. mount corrupted ext4 image with non-zero i_size for boot loader inode
 2. ioctl(fd, EXT4_IOC_SWAP_BOOT)
 3. write(fd)  // O_DIRECT

Fix it by setting i_disksize while first loading boot loader inode.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217159
Cc: <stable@kernel.org>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 12435d61f09e..f9a430152063 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -431,6 +431,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		ei_bl->i_flags = 0;
 		inode_set_iversion(inode_bl, 1);
 		i_size_write(inode_bl, 0);
+		EXT4_I(inode_bl)->i_disksize = inode_bl->i_size;
 		inode_bl->i_mode = S_IFREG;
 		if (ext4_has_feature_extents(sb)) {
 			ext4_set_inode_flag(inode_bl, EXT4_INODE_EXTENTS);
-- 
2.31.1

