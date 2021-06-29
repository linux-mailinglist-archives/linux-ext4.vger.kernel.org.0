Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912103B744A
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jun 2021 16:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhF2O36 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Jun 2021 10:29:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6023 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhF2O3x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Jun 2021 10:29:53 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GDmrY1gLvzXmVb;
        Tue, 29 Jun 2021 22:22:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 29
 Jun 2021 22:27:23 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH 2/2] ext4: Fix potential uas-after-free about sbi->s_mmp_tsk when kmmpd kthread exit before set sbi->s_mmp_tsk
Date:   Tue, 29 Jun 2021 22:36:03 +0800
Message-ID: <20210629143603.2166962-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629143603.2166962-1-yebin10@huawei.com>
References: <20210629143603.2166962-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now sbi->s_mmp_tsk is created with kthread_run, then kmmpd maybe
already running and even exit as exception. Even though we set
sbi->s_mmp_tsk with NULL before kmmpd kthread exit, but
"sbi->s_mmp_tsk=kthread_run(XX)" may set after set with NULL.
   mount                     kmmpd
     |                         |
     |-call kthread_run        |
     |                         |-kmmpd runing
     |                         |-kmmpd exit sbi->s_mmp_tsk=NULL
     |                         |
     |-kthread_run return      |
     | and set sbi->s_mmp_tsk  |
     |                         |
     |-then we get wild ptr"sbi->s_mmp_tsk" and later trigger UAF

This patch is base on previous "ext4: Fix use-after-free about sbi->s_mmp_tsk".
Previous patch ensure kmmpd kthread exit by itself will set sbi->s_mmp_tsk with
NULL. We can create kthread first, and then wakeup kmmpd kthread later.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index fc18a8c205c7..6ec1ea182cc0 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -394,16 +394,18 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
 	 */
-	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb, "kmmpd-%.*s",
-					     (int)sizeof(mmp->mmp_bdevname),
-					     bdevname(bh->b_bdev,
-						      mmp->mmp_bdevname));
+	EXT4_SB(sb)->s_mmp_tsk = kthread_create(kmmpd, sb, "kmmpd-%.*s",
+						(int)sizeof(mmp->mmp_bdevname),
+						bdevname(bh->b_bdev,
+							 mmp->mmp_bdevname));
+
 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
 		goto failed;
 	}
+	wake_up_process(EXT4_SB(sb)->s_mmp_tsk);
 
 	return 0;
 
-- 
2.31.1

