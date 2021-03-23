Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098734542B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Mar 2021 01:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhCWAuQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 20:50:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:55384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhCWAt5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:57 -0400
IronPort-SDR: TdUT//Vnm3IDVX0MWRJfzVmJ6py1eLaceDB0wai+3EcsqhhmSNMkPTGqosoAZ5ZCc4jFSJ2P7P
 34xpxF3HU4BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189777774"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189777774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:49:55 -0700
IronPort-SDR: 60jXO64lxDn7VIBF/qfylhXz8WH/K7mlbbTxVFyGN7lyi1Yqkaf9F1WHbpF7vuW1uRfCEQ5ypc
 CQqAMsfhxg4g==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414725099"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:49:54 -0700
Date:   Mon, 22 Mar 2021 17:49:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: ext2_set_link()->ext2_put_page() question
Message-ID: <20210323004948.GR3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: iff --git a/fs/ext2/dir.c b/fs/ext2/dir.ciff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan,

Why does ext2_set_link() need to call ext2_put_page()?

I don't see any reason that we could not match up the ext2_put_page() calls
with the ext2_find_entry().

Similarly am I missing something by moving the ext2_put_page() out of
ext2_delete_entry()?

See below patch.

I'm in the process of changing the kmap() calls in ext2_[get|put]_page() into
kmap_local_page() and I noticed this imbalance.  It does not really save me
anything because I need to pass the kaddr into these calls but IMO it makes the
code a bit easier to follow.

If you agree I will get a patch together to submit with the kmap_local_page()
patch.

Thanks,
Ira


17:29:44 > git di
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 14aa45316ad2..bd572cead638 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -449,7 +449,6 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
        de->inode = cpu_to_le32(inode->i_ino);
        ext2_set_de_type(de, inode);
        err = ext2_commit_chunk(page, pos, len);
-       ext2_put_page(page);
        if (update_times)
                dir->i_mtime = dir->i_ctime = current_time(dir);
        EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
@@ -594,7 +593,6 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
        EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
        mark_inode_dirty(inode);
 out:
-       ext2_put_page(page);
        return err;
 }
 
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 3367384d344d..a841b00c6828 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -371,6 +371,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
                        goto out_dir;
                }
                ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
+               ext2_put_page(new_page);
                new_inode->i_ctime = current_time(new_inode);
                if (dir_de)
                        drop_nlink(new_inode);
@@ -391,12 +392,13 @@ static int ext2_rename (struct user_namespace * mnt_userns,
        mark_inode_dirty(old_inode);
 
        ext2_delete_entry (old_de, old_page);
+       ext2_put_page(old_page);
 
        if (dir_de) {
                if (old_dir != new_dir)
                        ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-               else
-                       ext2_put_page(dir_page);
+
+               ext2_put_page(dir_page);
                inode_dec_link_count(old_dir);
        }
        return 0;

17:35:41 > git di
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 14aa45316ad2..bd572cead638 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -449,7 +449,6 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
        de->inode = cpu_to_le32(inode->i_ino);
        ext2_set_de_type(de, inode);
        err = ext2_commit_chunk(page, pos, len);
-       ext2_put_page(page);
        if (update_times)
                dir->i_mtime = dir->i_ctime = current_time(dir);
        EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
@@ -594,7 +593,6 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
        EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
        mark_inode_dirty(inode);
 out:
-       ext2_put_page(page);
        return err;
 }
 
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 3367384d344d..7af9ab3f975e 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -294,6 +294,7 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
        }
 
        err = ext2_delete_entry (de, page);
+       ext2_put_page(page);
        if (err)
                goto out;
 
@@ -371,6 +372,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
                        goto out_dir;
                }
                ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
+               ext2_put_page(new_page);
                new_inode->i_ctime = current_time(new_inode);
                if (dir_de)
                        drop_nlink(new_inode);
@@ -391,12 +393,13 @@ static int ext2_rename (struct user_namespace * mnt_userns,
        mark_inode_dirty(old_inode);
 
        ext2_delete_entry (old_de, old_page);
+       ext2_put_page(old_page);
 
        if (dir_de) {
                if (old_dir != new_dir)
                        ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-               else
-                       ext2_put_page(dir_page);
+
+               ext2_put_page(dir_page);
                inode_dec_link_count(old_dir);
        }
        return 0;

