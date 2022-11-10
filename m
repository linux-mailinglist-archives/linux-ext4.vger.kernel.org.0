Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD9623988
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiKJCFQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiKJCEj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:04:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFAD11F
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:04:37 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N74n26pD8zpWCv;
        Thu, 10 Nov 2022 10:00:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:04:35 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 11/12] ext4: add journal related fault injection
Date:   Thu, 10 Nov 2022 10:25:57 +0800
Message-ID: <20221110022558.7844-12-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110022558.7844-1-yi.zhang@huawei.com>
References: <20221110022558.7844-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add journal start, getting create/write access, and dirty metadata fault
injection. The journal start fault injections return -ENOMEM directly,
other 3 injections will abort the journal and return -EROFS.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      | 12 ++++++++++++
 fs/ext4/ext4_jbd2.c | 22 ++++++++++++++++------
 fs/ext4/ext4_jbd2.h |  5 +++++
 fs/ext4/sysfs.c     |  5 +++++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 813127cfd3c0..96b805992ea5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1526,6 +1526,12 @@ enum ext4_fault_bits {
 	EXT4_FAULT_DIRBLOCK_EIO,	/* directory block */
 	EXT4_FAULT_XATTR_EIO,		/* xattr block */
 	EXT4_FAULT_SYMLINK_EIO,		/* symlink block */
+	/* journal error */
+	EXT4_FAULT_JOURNAL_START,	/* journal start inode */
+	EXT4_FAULT_JOURNAL_START_SB,	/* journal start sb */
+	EXT4_FAULT_JOURNAL_CREATE_ACCESS,	/* journal get create access */
+	EXT4_FAULT_JOURNAL_WRITE_ACCESS,	/* journal get write access */
+	EXT4_FAULT_JOURNAL_DIRTY_METADATA,	/* journal dirty meta data */
 	EXT4_FAULT_MAX
 };
 
@@ -1633,6 +1639,12 @@ EXT4_FAULT_INODE_LBLOCK_FN(DIRBLOCK_EIO, dirblock_io, -EIO)
 EXT4_FAULT_INODE_FN(XATTR_EIO, xattr_io, -EIO)
 EXT4_FAULT_INODE_FN(SYMLINK_EIO, symlink_io, -EIO)
 
+EXT4_FAULT_INODE_FN(JOURNAL_START, journal_start, -ENOMEM)
+EXT4_FAULT_FN(JOURNAL_START_SB, journal_start_sb, -ENOMEM)
+EXT4_FAULT_INODE_PBLOCK_FN(JOURNAL_CREATE_ACCESS, journal_create_access, -EROFS)
+EXT4_FAULT_INODE_PBLOCK_FN(JOURNAL_WRITE_ACCESS, journal_write_access, -EROFS)
+EXT4_FAULT_INODE_PBLOCK_FN(JOURNAL_DIRTY_METADATA, journal_dirty_metadata, -EROFS)
+
 /*
  * fourth extended-fs super-block data in memory
  */
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 8e1fb18f465e..e0972dea7463 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -95,6 +95,9 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 
 	trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
 				 _RET_IP_);
+	err = ext4_fault_journal_start_sb(sb);
+	if (err)
+		return ERR_PTR(err);
 	err = ext4_journal_check_start(sb);
 	if (err < 0)
 		return ERR_PTR(err);
@@ -232,7 +235,9 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 		ext4_check_bdev_write_error(bh->b_bdev->bd_super);
 
 	if (ext4_handle_valid(handle)) {
-		err = jbd2_journal_get_write_access(handle, bh);
+		err = ext4_fault_journal_write_access(sb, 0, bh->b_blocknr);
+		if (!err)
+			err = jbd2_journal_get_write_access(handle, bh);
 		if (err) {
 			ext4_journal_abort_handle(where, line, __func__, bh,
 						  handle, err);
@@ -320,7 +325,9 @@ int __ext4_journal_get_create_access(const char *where, unsigned int line,
 	if (!ext4_handle_valid(handle))
 		return 0;
 
-	err = jbd2_journal_get_create_access(handle, bh);
+	err = ext4_fault_journal_create_access(sb, 0, bh->b_blocknr);
+	if (!err)
+		err = jbd2_journal_get_create_access(handle, bh);
 	if (err) {
 		ext4_journal_abort_handle(where, line, __func__, bh, handle,
 					  err);
@@ -338,7 +345,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				 handle_t *handle, struct inode *inode,
 				 struct buffer_head *bh)
 {
-	int err = 0;
+	int err = 0, fa_err = 0;
 
 	might_sleep();
 
@@ -346,9 +353,12 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 	set_buffer_prio(bh);
 	set_buffer_uptodate(bh);
 	if (ext4_handle_valid(handle)) {
-		err = jbd2_journal_dirty_metadata(handle, bh);
-		/* Errors can only happen due to aborted journal or a nasty bug */
-		if (!is_handle_aborted(handle) && WARN_ON_ONCE(err)) {
+		if (bh->b_bdev->bd_super)
+			fa_err = ext4_fault_journal_dirty_metadata(bh->b_bdev->bd_super,
+						0, bh->b_blocknr);
+		if (!fa_err)
+			err = jbd2_journal_dirty_metadata(handle, bh);
+		if (!is_handle_aborted(handle) && (WARN_ON_ONCE(err) || fa_err)) {
 			ext4_journal_abort_handle(where, line, __func__, bh,
 						  handle, err);
 			if (inode == NULL) {
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index db2ae4a2b38d..b0a996f306bb 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -323,6 +323,11 @@ static inline handle_t *__ext4_journal_start(struct inode *inode,
 					     int blocks, int rsv_blocks,
 					     int revoke_creds)
 {
+	int err;
+
+	err = ext4_fault_journal_start(inode->i_sb, inode->i_ino);
+	if (err)
+		return ERR_PTR(err);
 	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
 				       rsv_blocks, revoke_creds);
 }
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index dfccd9f04fbb..da725e128c89 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -585,6 +585,11 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"dir_block_eio",		/* EXT4_FAULT_DIRBLOCK_EIO */
 	"xattr_block_eio",		/* EXT4_FAULT_XATTR_EIO */
 	"symlink_block_eio",		/* EXT4_FAULT_SYMLINK_EIO */
+	"journal_start",		/* EXT4_FAULT_JOURNAL_START */
+	"journal_start_sb",		/* EXT4_FAULT_JOURNAL_START_SB */
+	"journal_get_create_access",	/* EXT4_FAULT_JOURNAL_CREATE_ACCESS */
+	"journal_get_write_access",	/* EXT4_FAULT_JOURNAL_WRITE_ACCESS */
+	"journal_dirty_metadata",	/* EXT4_FAULT_JOURNAL_DIRTY_METADATA */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

