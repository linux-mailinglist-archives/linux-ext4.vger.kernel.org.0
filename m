Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5A2F0AD4
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jan 2021 02:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAKBiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Jan 2021 20:38:15 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:59130 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAKBiP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Jan 2021 20:38:15 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210111013732epoutp0242fd65774df2f7427a25263443da81de~ZCb3DTdrr2622326223epoutp02G
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jan 2021 01:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210111013732epoutp0242fd65774df2f7427a25263443da81de~ZCb3DTdrr2622326223epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610329052;
        bh=k7uOJKC9V/GZ9lXL4zRTJOQEE5ZaazD70AM/Qkn6vVM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=oeTkwfdgT0/Kx6D1yIBzQzn7A+cPxCe5o2VjzNUurArrfowNypxcKlEDq2TlKI8Qf
         RzP4/Fvl2VwSZaTV2wyJAU0oX9+pp6EuRxKWwKadCb3vzd3dJx19ylgz/2GNTrWLdl
         RQuC0EOcC1lyPN/RN19C/M5y59uXBDA1RIxIX+c4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210111013731epcas2p42fe3fabda1b2045649a17e988dc5e6f2~ZCb2hnVOy0557805578epcas2p4B;
        Mon, 11 Jan 2021 01:37:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.190]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DDbtK6gsWz4x9QC; Mon, 11 Jan
        2021 01:37:29 +0000 (GMT)
X-AuditID: b6c32a48-4f9ff7000000cd1f-9c-5ffbabd69d73
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.83.52511.6DBABFF5; Mon, 11 Jan 2021 10:37:27 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] ext4: Change list_for_each* to list_for_each_entry*
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7@epcms2p4>
Date:   Mon, 11 Jan 2021 10:37:26 +0900
X-CMS-MailID: 20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe711b/jDc70MVt8/dLBYrHqQbjF
        ysYWJouZ8+6wWVzeNYfNorXnJ7sDm0fL5nKPnbPusns0nTnK7NG3ZRWjx+dNcgGsUTk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUD7lRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhoYFesWJucWleel6yfm5VoYGBkamQJUJORl9O+Yw
        FlyRq7j67xhLA+MVyS5GTg4JAROJR+unM3YxcnEICexglFizfBV7FyMHB6+AoMTfHcIgNcIC
        7hJTHm1gBbGFBJQk1l+cxQ4R15O49XANI4jNJqAjMf3EfbC4CMicz5ODQWxmgTqJLQt2skHs
        4pWY0f6UBcKWlti+fCsjhK0h8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8+LkbKi4p
        cWz3ByYIu15i651fYL9ICPQwShzeeYsVIqEvca1jIwvEX74Sly5JgYRZBFQlLh0+AtXrInF1
        0Q5WiJvlJba/ncMMUs4soCmxfpc+iCkhoCxx5BYLRAWfRMfhv+wwX+2Y9wRqiprEup/rmSDK
        ZSRuzYM60kOi9/13aAAGSsxbsoR5AqPCLEQwz0KydhbC2gWMzKsYxVILinPTU4uNCkyQY3YT
        IzghannsYJz99oPeIUYmDsZDjBIczEoivAt3/YgX4k1JrKxKLcqPLyrNSS0+xGgK9PBEZinR
        5HxgSs4riTc0NTIzM7A0tTA1M7JQEuctMngQLySQnliSmp2aWpBaBNPHxMEp1cCUVm0gwrP6
        YsvF98ohykUOlY8rys4qvJE68e72y5q1S0X00he7snbkOLLtPF3+Ry9VdyJL7bTAPVfNSteY
        zLKe1lSv7Sawyzf/nmztWwG9V/FRmZlzC/a5bvTP8Y82vD1rafjavvn1ARM2ns741pyzwSZQ
        +PAr39KNkxapud+8nXBXacLbD5tLdFa8iDsTeLY1wunv89B/UUk7cvYafa8RFfV7UuLOPieB
        S19jffH2lStKcldJPLi9ufqw8Ybv7A2/nQ/bN7ed3vW1e/m5+geG/uzu81pXNYYfurnsn4uj
        PUPCmaiG558NNK6fkA2YW8JkO/vxBE3HSo/Iy4c+t/HxPXe9cu6Ze/HCy8/ulcxXYinOSDTU
        Yi4qTgQAqjy4eBEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7
References: <CGME20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7@epcms2p4>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the fast_commit.c, list_for_each* + list_entry can be changed to
list_for_each_entry*. It reduces number of variables and lines.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/ext4/fast_commit.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4fcc21c25e79..b184cc2567fc 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -915,13 +915,11 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	struct super_block *sb = (struct super_block *)(journal->j_private);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
-	struct list_head *pos;
 	int ret = 0;
 
 	spin_lock(&sbi->s_fc_lock);
 	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
-	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
-		ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
+	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
 		while (atomic_read(&ei->i_fc_updates)) {
 			DEFINE_WAIT(wait);
@@ -978,17 +976,15 @@ __releases(&sbi->s_fc_lock)
 {
 	struct super_block *sb = (struct super_block *)(journal->j_private);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_fc_dentry_update *fc_dentry;
+	struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
 	struct inode *inode;
-	struct list_head *pos, *n, *fcd_pos, *fcd_n;
-	struct ext4_inode_info *ei;
+	struct ext4_inode_info *ei, *ei_n;
 	int ret;
 
 	if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
 		return 0;
-	list_for_each_safe(fcd_pos, fcd_n, &sbi->s_fc_dentry_q[FC_Q_MAIN]) {
-		fc_dentry = list_entry(fcd_pos, struct ext4_fc_dentry_update,
-					fcd_list);
+	list_for_each_entry_safe(fc_dentry, fc_dentry_n,
+				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
 			spin_unlock(&sbi->s_fc_lock);
 			if (!ext4_fc_add_dentry_tlv(
@@ -1004,8 +1000,8 @@ __releases(&sbi->s_fc_lock)
 		}
 
 		inode = NULL;
-		list_for_each_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN]) {
-			ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		list_for_each_entry_safe(ei, ei_n, &sbi->s_fc_q[FC_Q_MAIN],
+					 i_fc_list) {
 			if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
 				inode = &ei->vfs_inode;
 				break;
@@ -1057,7 +1053,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *iter;
 	struct ext4_fc_head head;
-	struct list_head *pos;
 	struct inode *inode;
 	struct blk_plug plug;
 	int ret = 0;
@@ -1099,8 +1094,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		goto out;
 	}
 
-	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
-		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		inode = &iter->vfs_inode;
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
@@ -1226,9 +1220,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_inode_info *iter;
+	struct ext4_inode_info *iter, *iter_n;
 	struct ext4_fc_dentry_update *fc_dentry;
-	struct list_head *pos, *n;
 
 	if (full && sbi->s_fc_bh)
 		sbi->s_fc_bh = NULL;
@@ -1236,8 +1229,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 	jbd2_fc_release_bufs(journal);
 
 	spin_lock(&sbi->s_fc_lock);
-	list_for_each_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN]) {
-		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
+				 i_fc_list) {
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-- 
2.25.1

