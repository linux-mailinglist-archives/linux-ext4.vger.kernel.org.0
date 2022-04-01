Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41E4EE9A0
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiDAIPT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDAIPS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 04:15:18 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49B4F3D483;
        Fri,  1 Apr 2022 01:13:27 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id ADDC31E80CC5;
        Fri,  1 Apr 2022 16:12:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EeoxtMlUqkTN; Fri,  1 Apr 2022 16:12:55 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 6296C1E80C85;
        Fri,  1 Apr 2022 16:12:55 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] ext4: remove unnecessary type castings
Date:   Fri,  1 Apr 2022 01:13:21 -0700
Message-Id: <20220401081321.73735-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/ext4/dir.c         |  2 +-
 fs/ext4/fast_commit.c | 10 +++++-----
 fs/ext4/inline.c      |  6 +++---
 fs/ext4/mballoc.c     |  2 +-
 fs/ext4/mmp.c         |  2 +-
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index a6bb86f52b9a..fc982d2dc071 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -648,7 +648,7 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
 	unsigned int offset = 0;
 	char *top;
 
-	de = (struct ext4_dir_entry_2 *)buf;
+	de = buf;
 	top = buf + buf_size;
 	while ((char *) de < top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3d72565ec6e8..7b0b57be8615 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -970,7 +970,7 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 /* Submit data for all the fast commit inodes */
 static int ext4_fc_submit_inode_data_all(journal_t *journal)
 {
-	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
 	int ret = 0;
@@ -1004,7 +1004,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 /* Wait for completion of data for all the fast commit inodes */
 static int ext4_fc_wait_inode_data_all(journal_t *journal)
 {
-	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *pos, *n;
 	int ret = 0;
@@ -1031,7 +1031,7 @@ static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
 __acquires(&sbi->s_fc_lock)
 __releases(&sbi->s_fc_lock)
 {
-	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
 	struct inode *inode;
@@ -1093,7 +1093,7 @@ __releases(&sbi->s_fc_lock)
 
 static int ext4_fc_perform_commit(journal_t *journal)
 {
-	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *iter;
 	struct ext4_fc_head head;
@@ -1198,7 +1198,7 @@ static void ext4_fc_update_stats(struct super_block *sb, int status,
  */
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 {
-	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int nblks = 0, ret, bsize = journal->j_blocksize;
 	int subtid = atomic_read(&sbi->s_fc_subtid);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9c076262770d..13a63e3639b1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1083,14 +1083,14 @@ static void ext4_update_final_de(void *de_buf, int old_size, int new_size)
 	void *limit;
 	int de_len;
 
-	de = (struct ext4_dir_entry_2 *)de_buf;
+	de = de_buf;
 	if (old_size) {
 		limit = de_buf + old_size;
 		do {
 			prev_de = de;
 			de_len = ext4_rec_len_from_disk(de->rec_len, old_size);
 			de_buf += de_len;
-			de = (struct ext4_dir_entry_2 *)de_buf;
+			de = de_buf;
 		} while (de_buf < limit);
 
 		prev_de->rec_len = ext4_rec_len_to_disk(de_len + new_size -
@@ -1155,7 +1155,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 	 * First create "." and ".." and then copy the dir information
 	 * back to the block.
 	 */
-	de = (struct ext4_dir_entry_2 *)target;
+	de = target;
 	de = ext4_init_dot_dotdot(inode, de,
 		inode->i_sb->s_blocksize, csum_size,
 		le32_to_cpu(((struct ext4_dir_entry_2 *)buf)->inode), 1);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 252c168454c7..dcb81352b864 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2919,7 +2919,7 @@ const struct seq_operations ext4_mb_seq_groups_ops = {
 
 int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 {
-	struct super_block *sb = (struct super_block *)seq->private;
+	struct super_block *sb = seq->private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	seq_puts(seq, "mballoc:\n");
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index cebea4270817..79d05e464c43 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -127,7 +127,7 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
  */
 static int kmmpd(void *data)
 {
-	struct super_block *sb = (struct super_block *) data;
+	struct super_block *sb = data;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
 	struct mmp_struct *mmp;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e37da8d5cd0c..b6bbc4dd6d63 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2031,7 +2031,7 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	unsigned int offset = 0;
 	char *top;
 
-	de = (struct ext4_dir_entry_2 *)buf;
+	de = buf;
 	top = buf + buf_size - reclen;
 	while ((char *) de <= top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
@@ -2587,7 +2587,7 @@ int ext4_generic_delete_entry(struct inode *dir,
 
 	i = 0;
 	pde = NULL;
-	de = (struct ext4_dir_entry_2 *)entry_buf;
+	de = entry_buf;
 	while (i < buf_size - csum_size) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
 					 entry_buf, buf_size, i))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..56dfa6ab28a6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1392,7 +1392,7 @@ static void ext4_destroy_inode(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct ext4_inode_info *ei = (struct ext4_inode_info *) foo;
+	struct ext4_inode_info *ei = foo;
 
 	INIT_LIST_HEAD(&ei->i_orphan);
 	init_rwsem(&ei->xattr_sem);
@@ -3832,7 +3832,7 @@ static struct task_struct *ext4_lazyinit_task;
  */
 static int ext4_lazyinit_thread(void *arg)
 {
-	struct ext4_lazy_init *eli = (struct ext4_lazy_init *)arg;
+	struct ext4_lazy_init *eli = arg;
 	struct list_head *pos, *n;
 	struct ext4_li_request *elr;
 	unsigned long next_wakeup, cur;
-- 
2.25.1

