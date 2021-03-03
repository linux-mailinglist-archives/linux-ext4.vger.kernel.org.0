Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9103632BD2F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Mar 2021 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383660AbhCCPci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 10:32:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13426 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346386AbhCCNKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Mar 2021 08:10:51 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DrDpH5by9zjTHv;
        Wed,  3 Mar 2021 21:08:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Mar 2021
 21:09:54 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH v1 1/2] ext4: find old entry again if failed to rename whiteout
Date:   Wed, 3 Mar 2021 21:17:02 +0800
Message-ID: <20210303131703.330415-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If we failed to add new entry on rename whiteout, we cannot reset the
old->de entry directly, because the old->de could have moved from under
us during make indexed dir. So find the old entry again before reset is
needed, otherwise it may corrupt the filesystem as below.

  /dev/sda: Entry '00000001' in ??? (12) has deleted/unused inode 15. CLEARED.
  /dev/sda: Unattached inode 75
  /dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.

Fixes: 6b4b8e6b4ad ("ext4: fix bug for rename with RENAME_WHITEOUT")
Cc: stable@vger.kernel.org
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/namei.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..17d9400563fa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3602,6 +3602,31 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	return retval;
 }
 
+static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
+			  unsigned ino, unsigned file_type)
+{
+	struct ext4_renament old = *ent;
+	int retval = 0;
+
+	/*
+	 * old->de could have moved from under us during make indexed dir,
+	 * so the old->de may no longer valid and need to find it again
+	 * before reset old inode info.
+	 */
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	if (IS_ERR(old.bh))
+		retval = PTR_ERR(old.bh);
+	if (!old.bh)
+		retval = -ENOENT;
+	if (retval) {
+		ext4_std_error(old.dir->i_sb, retval);
+		return;
+	}
+
+	ext4_setent(handle, &old, ino, file_type);
+	brelse(old.bh);
+}
+
 static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 				  const struct qstr *d_name)
 {
@@ -3924,8 +3949,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 end_rename:
 	if (whiteout) {
 		if (retval) {
-			ext4_setent(handle, &old,
-				old.inode->i_ino, old_file_type);
+			ext4_resetent(handle, &old,
+				      old.inode->i_ino, old_file_type);
 			drop_nlink(whiteout);
 		}
 		unlock_new_inode(whiteout);
-- 
2.25.4

