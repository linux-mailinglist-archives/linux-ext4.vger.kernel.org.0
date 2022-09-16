Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17805BAEDC
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiIPOEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiIPOEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0F15828
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:44 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTbNR1FPgznVGM;
        Fri, 16 Sep 2022 22:01:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:42 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 05/16] ext4: factor out ext4_fast_commit_init()
Date:   Fri, 16 Sep 2022 22:15:16 +0800
Message-ID: <20220916141527.1012715-6-yanaijie@huawei.com>
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

Factor out ext4_fast_commit_init(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 09b3c51d472b..3d58c2d889d5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4424,6 +4424,30 @@ static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
 	return 0;
 }
 
+static void ext4_fast_commit_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	/* Initialize fast commit stuff */
+	atomic_set(&sbi->s_fc_subtid, 0);
+	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
+	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
+	sbi->s_fc_bytes = 0;
+	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	sbi->s_fc_ineligible_tid = 0;
+	spin_lock_init(&sbi->s_fc_lock);
+	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
+	sbi->s_fc_replay_state.fc_regions = NULL;
+	sbi->s_fc_replay_state.fc_regions_size = 0;
+	sbi->s_fc_replay_state.fc_regions_used = 0;
+	sbi->s_fc_replay_state.fc_regions_valid = 0;
+	sbi->s_fc_replay_state.fc_modified_inodes = NULL;
+	sbi->s_fc_replay_state.fc_modified_inodes_size = 0;
+	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -5059,24 +5083,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
-	/* Initialize fast commit stuff */
-	atomic_set(&sbi->s_fc_subtid, 0);
-	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
-	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
-	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
-	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
-	sbi->s_fc_bytes = 0;
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	sbi->s_fc_ineligible_tid = 0;
-	spin_lock_init(&sbi->s_fc_lock);
-	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
-	sbi->s_fc_replay_state.fc_regions = NULL;
-	sbi->s_fc_replay_state.fc_regions_size = 0;
-	sbi->s_fc_replay_state.fc_regions_used = 0;
-	sbi->s_fc_replay_state.fc_regions_valid = 0;
-	sbi->s_fc_replay_state.fc_modified_inodes = NULL;
-	sbi->s_fc_replay_state.fc_modified_inodes_size = 0;
-	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
+	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
 
-- 
2.31.1

