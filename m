Return-Path: <linux-ext4+bounces-8232-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0FAC7FD1
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174C54E6EF6
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DAA22ACE7;
	Thu, 29 May 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jRaj2QLF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9281219E93;
	Thu, 29 May 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529831; cv=none; b=rTkmMxq0Gj6BRGJ7pUzaKXcbfkc5MLZIgzTagWTd8kmGK6WBXx22zJQoisFvtAnTDi5Y/QlTCYlE6iLu+cUlnenWUQkCUYrffUbLCZzyFUeWpkkj27E+s8NllS1YpUTrVPOgiKtxC+om5qqIETjnhq9q/GjURDT495ct9pvTXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529831; c=relaxed/simple;
	bh=XU0oPyxZDzZDKkcXO359f69fX/bnl8KlGOXa8n56B4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhVGpbCDS+qj3bIEuliNzn/X6fn+s/G79f0LFnJAU9qVeRjkkwEa5gVgETPkuY+mb1vjqxfMZXWdldQ68YpfQIoBw3cMl//MYHy9a1YS8QLLWvlGr3V5P5nWhxp0/NOHo5cVzQBRfOUNZz8FV1fyd5ZCItPz/DIyCZ6llGePPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jRaj2QLF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qP
	ACzQdKmCGnEpy21os+Y6Anwn+AlAe9o0MJqcU0H8E=; b=jRaj2QLFmAKV+U0GUv
	VUWV5t5XGHDMP3Rg98eFXtpdjKV4wEaOCjSbnOty0BMqZ3haD0Jw/B6FwLlHEIHy
	TkPBaiGI7eGFheBjaoe5cGxZjOGU4UjnVV/mAy00DCWcz/uIMqJ/PYCurPVGlLWN
	f8q0kcRUEdhqFlABe8MMw2egM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHH6B1cjhoX2CLAQ--.10005S4;
	Thu, 29 May 2025 22:43:16 +0800 (CST)
From: David Wang <00107082@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [RFC] ext4: use kmem_cache for short fname allocation in readdir
Date: Thu, 29 May 2025 22:42:56 +0800
Message-Id: <20250529144256.4517-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHH6B1cjhoX2CLAQ--.10005S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4fuF1DXr18AF18uF43GFg_yoW7WF1UpF
	Z3KwnxGw4xXw1DuwsxJr4kZr95Z3W8Ga1UW3s2gw43XrWUZF1kXFnFya4kXa45KrWkX3W3
	XFW5Kw18ur1kKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb4SnUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0glcqmg4a3dDVAABs3

When searching files, ext4_readdir would kzalloc() a fname
object for each entry. It would be faster if a dedicated
kmem_cache is used for fname.

But fnames are of variable length.

This patch suggests using kmem_cache for fname with short
length, and resorting to kzalloc when fname needs larger buffer.
Assuming long file names are not very common.

Profiling when searching files in kernel code base, with following
command:
	# perf record -g -e cpu-clock --freq=max bash -c \
	"for i in {1..100}; do find ./linux -name notfoundatall > /dev/null; done"
And using sample counts as indicator of performance improvement.
(The faster, the less samples collected. And the tests are carried out
when system is under no memory pressure.)

Before without the change:
	1232868--ext4_readdir
		 |
		 |--839085--ext4_htree_fill_tree
		 |          |
		 |           --829223--htree_dirblock_to_tree
		 |                     |
		 |                     |--365869--ext4_htree_store_dirent
		 |                     |          |
		 |                     |          |--43169--0xffffffffa7f8d094
		 |                     |          |
		 |                     |           --21947--0xffffffffa7f8d0f7
		 |                     |
		 |                     |--213124--ext4fs_dirhash
		 |                     |          |
		 |                     |           --86339--str2hashbuf_signed
		 |                     |
		 |                     |--145839--__ext4_read_dirblock

and with the change, ~3% less samples:
	1202922--ext4_readdir
		 |
		 |--805105--ext4_htree_fill_tree
		 |          |
		 |           --795055--htree_dirblock_to_tree
		 |                     |
		 |                     |--328876--ext4_htree_store_dirent
		 |                     |          |
		 |                     |          |--123207--kmem_cache_alloc_noprof
		 |                     |          |          |
		 |                     |          |          |--26453--__alloc_tagging_slab_alloc_hook
		 |                     |          |          |
		 |                     |          |           --20413--__slab_alloc.isra.0
		 |                     |          |
		 |                     |           --31566--rb_insert_color
		 |                     |
		 |                     |--212915--ext4fs_dirhash
		 |                     |          |
		 |                     |           --86004--str2hashbuf_signed
		 |                     |
		 |                     |--149146--__ext4_read_dirblock

readdir() would have sigfinicant improvement, but the overall
improvements for searching files is only ~0.5%, might be more
sigfinicant if the system is under some memory pressures.

The slab stats after the test:
ext4_dir_fname      1242   1242    176   23    1 : tunables    0    0    0 : slabdata     54     54      0

Signed-off-by: David Wang <00107082@163.com>
---
 fs/ext4/dir.c   | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/ext4.h  |  4 ++++
 fs/ext4/super.c |  3 +++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index d4164c507a90..3adfa0d038cd 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -424,6 +424,48 @@ struct fname {
 	char		name[] __counted_by(name_len);
 };
 
+#define EXT4_DIR_FNAME_SHORT_LENGTH 127
+static struct kmem_cache *ext4_dir_fname_cachep;
+
+void __init ext4_init_dir(void)
+{
+	ext4_dir_fname_cachep = kmem_cache_create_usercopy("ext4_dir_fname",
+			struct_size_t(struct fname, name,  EXT4_DIR_FNAME_SHORT_LENGTH + 1),
+			0, SLAB_RECLAIM_ACCOUNT,
+			offsetof(struct fname, name), EXT4_DIR_FNAME_SHORT_LENGTH + 1,
+			NULL);
+}
+
+void ext4_exit_dir(void)
+{
+	if (ext4_dir_fname_cachep)
+		kmem_cache_destroy(ext4_dir_fname_cachep);
+}
+
+static struct fname *rb_node_fname_zalloc(__u8 name_len)
+{
+	struct fname *p;
+	if (ext4_dir_fname_cachep && name_len <= EXT4_DIR_FNAME_SHORT_LENGTH)
+		p = kmem_cache_alloc(ext4_dir_fname_cachep, GFP_KERNEL);
+	else
+		p = kmalloc(struct_size(p, name, name_len + 1), GFP_KERNEL);
+	if (p) {
+		/* no need to fill name with zeroes*/
+		memset(p, 0, offsetof(struct fname, name));
+		p->name[name_len] = 0;
+	}
+	return p;
+}
+
+static void rb_node_fname_free(struct fname *p) {
+	if (!p)
+		return;
+	if (ext4_dir_fname_cachep && p->name_len <= EXT4_DIR_FNAME_SHORT_LENGTH)
+		kmem_cache_free(ext4_dir_fname_cachep, p);
+	else
+		kfree(p);
+}
+
 /*
  * This function implements a non-recursive way of freeing all of the
  * nodes in the red-black tree.
@@ -436,7 +478,7 @@ static void free_rb_tree_fname(struct rb_root *root)
 		while (fname) {
 			struct fname *old = fname;
 			fname = fname->next;
-			kfree(old);
+			rb_node_fname_free(old);
 		}
 
 	*root = RB_ROOT;
@@ -479,8 +521,7 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 	p = &info->root.rb_node;
 
 	/* Create and allocate the fname structure */
-	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
-			 GFP_KERNEL);
+	new_fn = rb_node_fname_zalloc(ent_name->len);
 	if (!new_fn)
 		return -ENOMEM;
 	new_fn->hash = hash;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..33ab97143000 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3795,6 +3795,10 @@ extern void ext4_orphan_file_block_trigger(
 				struct buffer_head *bh,
 				void *data, size_t size);
 
+/* dir.c */
+extern void __init ext4_init_dir(void);
+extern void ext4_exit_dir(void);
+
 /*
  * Add new method to test whether block and inode bitmaps are properly
  * initialized. With uninit_bg reading the block from disk is not enough
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..21ce3d78912a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7457,6 +7457,8 @@ static int __init ext4_init_fs(void)
 	if (err)
 		goto out;
 
+	ext4_init_dir();
+
 	return 0;
 out:
 	unregister_as_ext2();
@@ -7497,6 +7499,7 @@ static void __exit ext4_exit_fs(void)
 	ext4_exit_post_read_processing();
 	ext4_exit_es();
 	ext4_exit_pending();
+	ext4_exit_dir();
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
-- 
2.39.2


