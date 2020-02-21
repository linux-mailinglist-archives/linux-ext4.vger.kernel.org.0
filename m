Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9692166F34
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 06:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBUFfV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 00:35:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59711 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgBUFfU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 00:35:20 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01L5Z8AJ022067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 00:35:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 536944211F1; Fri, 21 Feb 2020 00:35:08 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Suraj Jitindar Singh <surajjs@amazon.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Balbir Singh <sblbir@amazon.com>,
        stable@kernel.org
Subject: [PATCH 2/3] ext4: fix potential race between s_group_info online resizing and access
Date:   Fri, 21 Feb 2020 00:34:57 -0500
Message-Id: <20200221053458.730016-3-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221053458.730016-1-tytso@mit.edu>
References: <20200221053458.730016-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Suraj Jitindar Singh <surajjs@amazon.com>

During an online resize an array of pointers to s_group_info gets replaced
so it can get enlarged. If there is a concurrent access to the array in
ext4_get_group_info() and this memory has been reused then this can lead to
an invalid memory access.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206443
Previous-Patch-Link: https://lore.kernel.org/r/20200219030851.2678-3-surajjs@amazon.com
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Balbir Singh <sblbir@amazon.com>
Cc: stable@kernel.org
---
 fs/ext4/ext4.h    |  8 ++++----
 fs/ext4/mballoc.c | 52 +++++++++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b51003f75568..b1ece5329738 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1462,7 +1462,7 @@ struct ext4_sb_info {
 #endif
 
 	/* for buddy allocator */
-	struct ext4_group_info ***s_group_info;
+	struct ext4_group_info ** __rcu *s_group_info;
 	struct inode *s_buddy_cache;
 	spinlock_t s_md_lock;
 	unsigned short *s_mb_offsets;
@@ -2994,13 +2994,13 @@ static inline
 struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
 					    ext4_group_t group)
 {
-	 struct ext4_group_info ***grp_info;
+	 struct ext4_group_info **grp_info;
 	 long indexv, indexh;
 	 BUG_ON(group >= EXT4_SB(sb)->s_groups_count);
-	 grp_info = EXT4_SB(sb)->s_group_info;
 	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
 	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 return grp_info[indexv][indexh];
+	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	 return grp_info[indexh];
 }
 
 /*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f64838187559..1b46fb63692a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2356,7 +2356,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned size;
-	struct ext4_group_info ***new_groupinfo;
+	struct ext4_group_info ***old_groupinfo, ***new_groupinfo;
 
 	size = (ngroups + EXT4_DESC_PER_BLOCK(sb) - 1) >>
 		EXT4_DESC_PER_BLOCK_BITS(sb);
@@ -2369,13 +2369,16 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 		ext4_msg(sb, KERN_ERR, "can't allocate buddy meta group");
 		return -ENOMEM;
 	}
-	if (sbi->s_group_info) {
-		memcpy(new_groupinfo, sbi->s_group_info,
+	rcu_read_lock();
+	old_groupinfo = rcu_dereference(sbi->s_group_info);
+	if (old_groupinfo)
+		memcpy(new_groupinfo, old_groupinfo,
 		       sbi->s_group_info_size * sizeof(*sbi->s_group_info));
-		kvfree(sbi->s_group_info);
-	}
-	sbi->s_group_info = new_groupinfo;
+	rcu_read_unlock();
+	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
+	if (old_groupinfo)
+		ext4_kvfree_array_rcu(old_groupinfo);
 	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n", 
 		   sbi->s_group_info_size);
 	return 0;
@@ -2387,6 +2390,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 {
 	int i;
 	int metalen = 0;
+	int idx = group >> EXT4_DESC_PER_BLOCK_BITS(sb);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_group_info **meta_group_info;
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
@@ -2405,12 +2409,12 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 				 "for a buddy group");
 			goto exit_meta_group_info;
 		}
-		sbi->s_group_info[group >> EXT4_DESC_PER_BLOCK_BITS(sb)] =
-			meta_group_info;
+		rcu_read_lock();
+		rcu_dereference(sbi->s_group_info)[idx] = meta_group_info;
+		rcu_read_unlock();
 	}
 
-	meta_group_info =
-		sbi->s_group_info[group >> EXT4_DESC_PER_BLOCK_BITS(sb)];
+	meta_group_info = sbi_array_rcu_deref(sbi, s_group_info, idx);
 	i = group & (EXT4_DESC_PER_BLOCK(sb) - 1);
 
 	meta_group_info[i] = kmem_cache_zalloc(cachep, GFP_NOFS);
@@ -2458,8 +2462,13 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 exit_group_info:
 	/* If a meta_group_info table has been allocated, release it now */
 	if (group % EXT4_DESC_PER_BLOCK(sb) == 0) {
-		kfree(sbi->s_group_info[group >> EXT4_DESC_PER_BLOCK_BITS(sb)]);
-		sbi->s_group_info[group >> EXT4_DESC_PER_BLOCK_BITS(sb)] = NULL;
+		struct ext4_group_info ***group_info;
+
+		rcu_read_lock();
+		group_info = rcu_dereference(sbi->s_group_info);
+		kfree(group_info[idx]);
+		group_info[idx] = NULL;
+		rcu_read_unlock();
 	}
 exit_meta_group_info:
 	return -ENOMEM;
@@ -2472,6 +2481,7 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 	struct ext4_group_desc *desc;
+	struct ext4_group_info ***group_info;
 	struct kmem_cache *cachep;
 
 	err = ext4_mb_alloc_groupinfo(sb, ngroups);
@@ -2507,11 +2517,16 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	while (i-- > 0)
 		kmem_cache_free(cachep, ext4_get_group_info(sb, i));
 	i = sbi->s_group_info_size;
+	rcu_read_lock();
+	group_info = rcu_dereference(sbi->s_group_info);
 	while (i-- > 0)
-		kfree(sbi->s_group_info[i]);
+		kfree(group_info[i]);
+	rcu_read_unlock();
 	iput(sbi->s_buddy_cache);
 err_freesgi:
-	kvfree(sbi->s_group_info);
+	rcu_read_lock();
+	kvfree(rcu_dereference(sbi->s_group_info));
+	rcu_read_unlock();
 	return -ENOMEM;
 }
 
@@ -2700,7 +2715,7 @@ int ext4_mb_release(struct super_block *sb)
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	ext4_group_t i;
 	int num_meta_group_infos;
-	struct ext4_group_info *grinfo;
+	struct ext4_group_info *grinfo, ***group_info;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
 
@@ -2719,9 +2734,12 @@ int ext4_mb_release(struct super_block *sb)
 		num_meta_group_infos = (ngroups +
 				EXT4_DESC_PER_BLOCK(sb) - 1) >>
 			EXT4_DESC_PER_BLOCK_BITS(sb);
+		rcu_read_lock();
+		group_info = rcu_dereference(sbi->s_group_info);
 		for (i = 0; i < num_meta_group_infos; i++)
-			kfree(sbi->s_group_info[i]);
-		kvfree(sbi->s_group_info);
+			kfree(group_info[i]);
+		kvfree(group_info);
+		rcu_read_unlock();
 	}
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
-- 
2.24.1

