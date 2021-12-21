Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE147BF98
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Dec 2021 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhLUMUi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Dec 2021 07:20:38 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30156 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhLUMUi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Dec 2021 07:20:38 -0500
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJFpx1jXTz8vxb;
        Tue, 21 Dec 2021 20:18:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 20:20:36 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: Fix remount with 'abort' option isn't effective
Date:   Tue, 21 Dec 2021 20:32:14 +0800
Message-ID: <20211221123214.2410593-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We test remount with 'abort' option as follows:
[root@localhost home]# mount  /dev/sda test
[root@localhost home]# mount | grep test
/dev/sda on /home/test type ext4 (rw,relatime)
[root@localhost home]# mount -o remount,abort test
[root@localhost home]# mount | grep test
/dev/sda on /home/test type ext4 (rw,relatime)

Obviously, remount 'abort' option isn't effective.
After 6e47a3cc68fc commit we process abort option with 'ctx_set_mount_flags':
static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int flag)
{
	ctx->mask_s_mount_flags |= flag;
	ctx->vals_s_mount_flags |= flag;
}

But we test 'abort' option with 'ext4_test_mount_flag':
static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
{
        return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
}

To solve this issue, pass (1 <<  EXT4_MF_FS_ABORTED) to 'ctx_set_mount_flags'.

Fixes:6e47a3cc68fc("ext4: get rid of super block and sbi from handle_mount_ops()")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb..071b7b3c5678 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2236,7 +2236,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			 param->key);
 		return 0;
 	case Opt_abort:
-		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
+		ctx_set_mount_flags(ctx, 1 << EXT4_MF_FS_ABORTED);
 		return 0;
 	case Opt_i_version:
 		ctx_set_flags(ctx, SB_I_VERSION);
-- 
2.31.1

