Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FA5B9C3E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIONp4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIONpi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 09:45:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5CA74BAE;
        Thu, 15 Sep 2022 06:45:18 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSyyH1HFTzNmDX;
        Thu, 15 Sep 2022 21:40:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 21:45:15 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 1/2] ext4: factor out ext4_fc_disabled()
Date:   Thu, 15 Sep 2022 21:56:10 +0800
Message-ID: <20220915135611.3040776-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220915135611.3040776-1-yebin10@huawei.com>
References: <20220915135611.3040776-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_fc_disabled(). No functional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b7414a5812f6..eadab945b856 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -229,6 +229,12 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
 	finish_wait(wq, &wait.wq_entry);
 }
 
+static bool ext4_fc_disabled(struct super_block *sb)
+{
+	return (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
+		(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY));
+}
+
 /*
  * Inform Ext4's fast about start of an inode update
  *
@@ -240,8 +246,7 @@ void ext4_fc_start_update(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 restart:
@@ -265,8 +270,7 @@ void ext4_fc_stop_update(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (atomic_dec_and_test(&ei->i_fc_updates))
@@ -283,8 +287,7 @@ void ext4_fc_del(struct inode *inode)
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_fc_dentry_update *fc_dentry;
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 restart:
@@ -337,8 +340,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	tid_t tid;
 
-	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(sb))
 		return;
 
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
@@ -493,10 +495,8 @@ void __ext4_fc_track_unlink(handle_t *handle,
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
@@ -522,10 +522,8 @@ void __ext4_fc_track_link(handle_t *handle,
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
@@ -551,10 +549,8 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
@@ -576,7 +572,6 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -588,8 +583,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
@@ -634,15 +628,13 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct __track_range_args args;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
 		return;
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
-- 
2.31.1

