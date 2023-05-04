Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685FC6F6C3F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEDMrc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDMra (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 08:47:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830216199;
        Thu,  4 May 2023 05:47:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24B1B339F7;
        Thu,  4 May 2023 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683204448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5RWZgmt65EvQQ9SnvxJXgBr4Yy3/jR76QNwBEGJZwDM=;
        b=kRUcMKEXro/cccjoSgpHrEEjNjHz8q1ZEi3o+wZIX9Ykn2cMpJSJZnujublo1oUmUPV0z9
        aGEGqjOh8xMtZAB5YXqXofkyYA5IKse3B2mYN5jp8A5Flpks7g9+626ReBwvU6ipq9u3eZ
        lfzARG1YjyyT5+KVaUgW0GACkTz8Cbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683204448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5RWZgmt65EvQQ9SnvxJXgBr4Yy3/jR76QNwBEGJZwDM=;
        b=24tjr1tLmNI6AJ/t+pT6rcKRMUJvQmv/hHf5uwOypjJN2vOMMMubrinasqqw2Dhyu4CcKp
        qZsecBYAhhfpRrAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1695E133F7;
        Thu,  4 May 2023 12:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9nN3BWCpU2QySAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 04 May 2023 12:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9816BA0722; Thu,  4 May 2023 14:47:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] ext4: Avoid deadlock in fs reclaim with page writeback
Date:   Thu,  4 May 2023 14:47:23 +0200
Message-Id: <20230504124723.20205-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7473; i=jack@suse.cz; h=from:subject; bh=Os/asTFcpmq1tr508GZtivKMorYYfPZdbHuB8lq/Ox8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkU6lVsi0+zH/v0QWLR3pbyC+GgbR1VepaeXDMof+2 DlWWhGCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZFOpVQAKCRCcnaoHP2RA2XQiB/ sETcoR3PYc4YL0uWvHGmepf9e53Ua8abHHWWfb7KG+96K2rFX1RGwMpvN1LOi9et35i+AjtJG82OmT JPmNQe4ndPXxRz1c/hmF3kT4wznwUEl7oCXrWGC2sOfYLKORhkgjz9wxsXqZ6P2OmrjpJf+k/O6YNf kra/JlPpf0qZkGLEtm710sriMgQus+6lRINSt66AVOEgMQO9g+o1ig8adafiMp22g4La7aF/rjkKUO fy+wDaEG4g4XKTHYRjVE7Yy9Yuf1RTReuflvronFRsRbscTfX4wD80kKLCzjkTsVg/uAZ2CdRw4Bof I7qXZDtuAq47MXu1UvMRqlV4Mb4KJn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4 has a filesystem wide lock protecting ext4_writepages() calls to
avoid races with switching of journalled data flag or inode format. This
lock can however cause a deadlock like:

CPU0                            CPU1

ext4_writepages()
  percpu_down_read(sbi->s_writepages_rwsem);
                                ext4_change_inode_journal_flag()
                                  percpu_down_write(sbi->s_writepages_rwsem);
                                    - blocks, all readers block from now on
  ext4_do_writepages()
    ext4_init_io_end()
      kmem_cache_zalloc(io_end_cachep, GFP_KERNEL)
        fs_reclaim frees dentry...
          dentry_unlink_inode()
            iput() - last ref =>
              iput_final() - inode dirty =>
                write_inode_now()...
                  ext4_writepages() tries to acquire sbi->s_writepages_rwsem
                    and blocks forever

Make sure we cannot recurse into filesystem reclaim from writeback code
to avoid the deadlock.

Reported-by: syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000004c66b405fa108e27@google.com
Fixes: c8585c6fcaf2 ("ext4: fix races between changing inode journal mode and ext4_writepages")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 24 ++++++++++++++++++++++++
 fs/ext4/inode.c   | 18 ++++++++++--------
 fs/ext4/migrate.c | 11 ++++++-----
 3 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18cb2680dc39..92df861227dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1684,6 +1684,30 @@ static inline struct ext4_inode_info *EXT4_I(struct inode *inode)
 	return container_of(inode, struct ext4_inode_info, vfs_inode);
 }
 
+static inline int ext4_writepages_down_read(struct super_block *sb)
+{
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_read(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
+static inline int ext4_writepages_down_write(struct super_block *sb)
+{
+	percpu_down_write(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_write(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_write(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 {
 	return ino == EXT4_ROOT_INO ||
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ffbbd9626bd8..b6dc795b61ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2783,11 +2783,12 @@ static int ext4_writepages(struct address_space *mapping,
 		.can_map = 1,
 	};
 	int ret;
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return -EIO;
 
-	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(sb);
 	ret = ext4_do_writepages(&mpd);
 	/*
 	 * For data=journal writeback we could have come across pages marked
@@ -2796,7 +2797,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 */
 	if (!ret && mpd.journalled_more_data)
 		ret = ext4_do_writepages(&mpd);
-	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ext4_writepages_up_read(sb, alloc_ctx);
 
 	return ret;
 }
@@ -2824,17 +2825,18 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	long nr_to_write = wbc->nr_to_write;
 	struct inode *inode = mapping->host;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_read(inode->i_sb, alloc_ctx);
 	return ret;
 }
 
@@ -5925,7 +5927,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	journal_t *journal;
 	handle_t *handle;
 	int err;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int alloc_ctx;
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -5963,7 +5965,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		}
 	}
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -5980,7 +5982,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = jbd2_journal_flush(journal, 0);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_writepages_rwsem);
+			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -5988,7 +5990,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 
 	if (val)
 		filemap_invalidate_unlock(inode->i_mapping);
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index a19a9661646e..d98ac2af8199 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -408,7 +408,6 @@ static int free_ext_block(handle_t *handle, struct inode *inode)
 
 int ext4_ext_migrate(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
@@ -418,6 +417,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unsigned long max_entries;
 	__u32 goal, tmp_csum_seed;
 	uid_t owner[2];
+	int alloc_ctx;
 
 	/*
 	 * If the filesystem does not support extents, or the inode
@@ -434,7 +434,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 */
 		return retval;
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	/*
 	 * Worst case we can touch the allocation bitmaps and a block
@@ -586,7 +586,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unlock_new_inode(tmp_inode);
 	iput(tmp_inode);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return retval;
 }
 
@@ -605,6 +605,7 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_fsblk_t			blk;
 	handle_t			*handle;
 	int				ret, ret2 = 0;
+	int				alloc_ctx;
 
 	if (!ext4_has_feature_extents(inode->i_sb) ||
 	    (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
@@ -621,7 +622,7 @@ int ext4_ind_migrate(struct inode *inode)
 	if (test_opt(inode->i_sb, DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
@@ -665,6 +666,6 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
 }
-- 
2.35.3

