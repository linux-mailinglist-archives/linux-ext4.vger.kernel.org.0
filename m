Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D95BAEDA
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiIPOEv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiIPOEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44815802
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:42 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTbLC2bTgzNm6M;
        Fri, 16 Sep 2022 22:00:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:40 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 01/16] ext4: goto right label 'failed_mount3a'
Date:   Fri, 16 Sep 2022 22:15:12 +0800
Message-ID: <20220916141527.1012715-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916141527.1012715-1-yanaijie@huawei.com>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Before these two branches neither loaded the journal nor created the
xattr cache. So the right label to goto is 'failed_mount3a'. Although
this did not cause any issues because the error handler validated if the
pointer is null. However this still made me confused when reading
the code. So it's still worth to modify to goto the right label.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..6126da867b26 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5079,30 +5079,30 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		   ext4_has_feature_journal_needs_recovery(sb)) {
 		ext4_msg(sb, KERN_ERR, "required journal recovery "
 		       "suppressed and not mounted read-only");
-		goto failed_mount_wq;
+		goto failed_mount3a;
 	} else {
 		/* Nojournal mode, all journal mount options are illegal */
 		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "journal_checksum, fs mounted w/o journal");
-			goto failed_mount_wq;
+			goto failed_mount3a;
 		}
 		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "journal_async_commit, fs mounted w/o journal");
-			goto failed_mount_wq;
+			goto failed_mount3a;
 		}
 		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "commit=%lu, fs mounted w/o journal",
 				 sbi->s_commit_interval / HZ);
-			goto failed_mount_wq;
+			goto failed_mount3a;
 		}
 		if (EXT4_MOUNT_DATA_FLAGS &
 		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "data=, fs mounted w/o journal");
-			goto failed_mount_wq;
+			goto failed_mount3a;
 		}
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
-- 
2.31.1

