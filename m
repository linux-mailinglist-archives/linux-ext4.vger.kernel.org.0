Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1774122F
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjF1NVL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 09:21:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16306 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjF1NVK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 09:21:10 -0400
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QrhxL56yWzLlkr;
        Wed, 28 Jun 2023 21:19:02 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 21:21:07 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] ext4: Fix unttached inode after power cut with orphan file feature enabled
Date:   Wed, 28 Jun 2023 21:20:11 +0800
Message-ID: <20230628132011.650383-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Running generic/475(filesystem consistent tests after power cut) could
easily trigger unattached inode error while doing fsck:
  Unattached zero-length inode 39405.  Clear? no

  Unattached inode 39405
  Connect to /lost+found? no

Above inconsistence is caused by following process:
       P1                       P2
ext4_create
 inode = ext4_new_inode_start_handle  // itable records nlink=1
 ext4_add_nondir
   err = ext4_add_entry  // ENOSPC
    ext4_append
     ext4_bread
      ext4_getblk
       ext4_map_blocks // returns ENOSPC
   drop_nlink(inode) // won't be updated into disk inode
   ext4_orphan_add(handle, inode)
    ext4_orphan_file_add
 ext4_journal_stop(handle)
		      jbd2_journal_commit_transaction // commit success
              >> power cut <<
ext4_fill_super
 ext4_load_and_init_journal   // itable records nlink=1
 ext4_orphan_cleanup
  ext4_process_orphan
   if (inode->i_nlink)        // true, inode won't be deleted

Then, allocated inode will be reserved on disk and corresponds to no
dentries, so e2fsck reports 'unattached inode' problem.

The problem won't happen if orphan file feature is disabled, because
ext4_orphan_add() will update disk inode in orphan list mode. There
are several places not updating disk inode while putting inode into
orphan area, such as ext4_add_nondir(), ext4_symlink() and whiteout
in ext4_rename(). Fix it by updating inode into disk in all error
branches of these places.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217605
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..6bcc3770ee19 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2799,6 +2799,7 @@ static int ext4_add_nondir(handle_t *handle,
 		return err;
 	}
 	drop_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
 	return err;
@@ -3436,6 +3437,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 err_drop_inode:
 	clear_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
 	if (handle)
@@ -4021,6 +4023,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			ext4_resetent(handle, &old,
 				      old.inode->i_ino, old_file_type);
 			drop_nlink(whiteout);
+			ext4_mark_inode_dirty(handle, whiteout);
 			ext4_orphan_add(handle, whiteout);
 		}
 		unlock_new_inode(whiteout);
-- 
2.39.2

