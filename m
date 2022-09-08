Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706F25B260D
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiIHSor (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiIHSop (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 14:44:45 -0400
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 11:44:41 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67EC619C3E
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VuNiI
        jpXJZ/U4iospotIbmz4to3dxA6L0z3t919m1ig=; b=elOOJpJU7Ud3H80sYZbCF
        JGoJgro9VcCsDY4tULJXIlrUBIivnc8OfRp+G/8HjPC0hCy0wmC3T9b68YMroFCu
        T2v1FWJ7gsK/tURJ01b06zKEjXgJuP6QCOZdiFohrDyQEnuw1EQf3GggVe6Mq+LQ
        Kjv69LgCEQdH7HNGRVLXaY=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp14 (Coremail) with SMTP id EsCowAB3UwFnNBpjMnYLEg--.56859S4;
        Fri, 09 Sep 2022 02:29:14 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] ext4: Fix some checkpatch complained in namei.c file
Date:   Fri,  9 Sep 2022 02:28:53 +0800
Message-Id: <20220908182853.75783-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAB3UwFnNBpjMnYLEg--.56859S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfAryUCryrXw13XryxWr1rJFb_yoW8tr18uo
        WxWw1DXw18Cry2yayfG3WkGFyUZayDGayrAr1Fyrs8Wa13A34UC343ur13u3WfWw4rGFZr
        AFyIqw4UXF4xAw4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR0zuHUUUUU
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoAJ2F1zmWH-F7gAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 fs/ext4/namei.c | 211 ++++++++++++++++++++++++------------------------
 1 file changed, 106 insertions(+), 105 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..7d78c4375905 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -212,22 +212,19 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 #define dxtrace(command)
 #endif
 
-struct fake_dirent
-{
+struct fake_dirent {
 	__le32 inode;
 	__le16 rec_len;
 	u8 name_len;
 	u8 file_type;
 };
 
-struct dx_countlimit
-{
+struct dx_countlimit {
 	__le16 limit;
 	__le16 count;
 };
 
-struct dx_entry
-{
+struct dx_entry {
 	__le32 hash;
 	__le32 block;
 };
@@ -238,14 +235,12 @@ struct dx_entry
  * hash version mod 4 should never be 0.  Sincerely, the paranoia department.
  */
 
-struct dx_root
-{
+struct dx_root {
 	struct fake_dirent dot;
 	char dot_name[4];
 	struct fake_dirent dotdot;
 	char dotdot_name[4];
-	struct dx_root_info
-	{
+	struct dx_root_info {
 		__le32 reserved_zero;
 		u8 hash_version;
 		u8 info_length; /* 8 */
@@ -256,22 +251,19 @@ struct dx_root
 	struct dx_entry	entries[];
 };
 
-struct dx_node
-{
+struct dx_node {
 	struct fake_dirent fake;
 	struct dx_entry	entries[];
 };
 
 
-struct dx_frame
-{
+struct dx_frame {
 	struct buffer_head *bh;
 	struct dx_entry *entries;
 	struct dx_entry *at;
 };
 
-struct dx_map_entry
-{
+struct dx_map_entry {
 	u32 hash;
 	u16 offs;
 	u16 size;
@@ -287,14 +279,14 @@ struct dx_tail {
 
 static inline ext4_lblk_t dx_get_block(struct dx_entry *entry);
 static void dx_set_block(struct dx_entry *entry, ext4_lblk_t value);
-static inline unsigned dx_get_hash(struct dx_entry *entry);
-static void dx_set_hash(struct dx_entry *entry, unsigned value);
-static unsigned dx_get_count(struct dx_entry *entries);
-static unsigned dx_get_limit(struct dx_entry *entries);
-static void dx_set_count(struct dx_entry *entries, unsigned value);
-static void dx_set_limit(struct dx_entry *entries, unsigned value);
-static unsigned dx_root_limit(struct inode *dir, unsigned infosize);
-static unsigned dx_node_limit(struct inode *dir);
+static inline unsigned int dx_get_hash(struct dx_entry *entry);
+static void dx_set_hash(struct dx_entry *entry, unsigned int value);
+static unsigned int dx_get_count(struct dx_entry *entries);
+static unsigned int dx_get_limit(struct dx_entry *entries);
+static void dx_set_count(struct dx_entry *entries, unsigned int value);
+static void dx_set_limit(struct dx_entry *entries, unsigned int value);
+static unsigned int dx_root_limit(struct inode *dir, unsigned int infosize);
+static unsigned int dx_node_limit(struct inode *dir);
 static struct dx_frame *dx_probe(struct ext4_filename *fname,
 				 struct inode *dir,
 				 struct dx_hash_info *hinfo,
@@ -303,7 +295,7 @@ static void dx_release(struct dx_frame *frames);
 static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 		       struct dx_hash_info *hinfo,
 		       struct dx_map_entry *map_tail);
-static void dx_sort_map(struct dx_map_entry *map, unsigned count);
+static void dx_sort_map(struct dx_map_entry *map, unsigned int count);
 static struct ext4_dir_entry_2 *dx_move_dirents(struct inode *dir, char *from,
 					char *to, struct dx_map_entry *offsets,
 					int count, unsigned int blocksize);
@@ -315,7 +307,7 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
 				 struct dx_frame *frames,
 				 __u32 *start_hash);
-static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
+static struct buffer_head *ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
 		struct ext4_dir_entry_2 **res_dir);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
@@ -568,37 +560,37 @@ static inline void dx_set_block(struct dx_entry *entry, ext4_lblk_t value)
 	entry->block = cpu_to_le32(value);
 }
 
-static inline unsigned dx_get_hash(struct dx_entry *entry)
+static inline unsigned int dx_get_hash(struct dx_entry *entry)
 {
 	return le32_to_cpu(entry->hash);
 }
 
-static inline void dx_set_hash(struct dx_entry *entry, unsigned value)
+static inline void dx_set_hash(struct dx_entry *entry, unsigned int value)
 {
 	entry->hash = cpu_to_le32(value);
 }
 
-static inline unsigned dx_get_count(struct dx_entry *entries)
+static inline unsigned int dx_get_count(struct dx_entry *entries)
 {
 	return le16_to_cpu(((struct dx_countlimit *) entries)->count);
 }
 
-static inline unsigned dx_get_limit(struct dx_entry *entries)
+static inline unsigned int dx_get_limit(struct dx_entry *entries)
 {
 	return le16_to_cpu(((struct dx_countlimit *) entries)->limit);
 }
 
-static inline void dx_set_count(struct dx_entry *entries, unsigned value)
+static inline void dx_set_count(struct dx_entry *entries, unsigned int value)
 {
 	((struct dx_countlimit *) entries)->count = cpu_to_le16(value);
 }
 
-static inline void dx_set_limit(struct dx_entry *entries, unsigned value)
+static inline void dx_set_limit(struct dx_entry *entries, unsigned int value)
 {
 	((struct dx_countlimit *) entries)->limit = cpu_to_le16(value);
 }
 
-static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
+static inline unsigned int dx_root_limit(struct inode *dir, unsigned int infosize)
 {
 	unsigned int entry_space = dir->i_sb->s_blocksize -
 			ext4_dir_rec_len(1, NULL) -
@@ -609,7 +601,7 @@ static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 	return entry_space / sizeof(struct dx_entry);
 }
 
-static inline unsigned dx_node_limit(struct inode *dir)
+static inline unsigned int dx_node_limit(struct inode *dir)
 {
 	unsigned int entry_space = dir->i_sb->s_blocksize -
 			ext4_dir_rec_len(0, dir);
@@ -623,9 +615,10 @@ static inline unsigned dx_node_limit(struct inode *dir)
  * Debug
  */
 #ifdef DX_DEBUG
-static void dx_show_index(char * label, struct dx_entry *entries)
+static void dx_show_index(char *label, struct dx_entry *entries)
 {
-	int i, n = dx_get_count (entries);
+	int i, n = dx_get_count(entries);
+
 	printk(KERN_DEBUG "%s index", label);
 	for (i = 0; i < n; i++) {
 		printk(KERN_CONT " %x->%lu",
@@ -635,11 +628,10 @@ static void dx_show_index(char * label, struct dx_entry *entries)
 	printk(KERN_CONT "\n");
 }
 
-struct stats
-{
-	unsigned names;
-	unsigned space;
-	unsigned bcount;
+struct stats {
+	unsigned int names;
+	unsigned int space;
+	unsigned int bcount;
 };
 
 static struct stats dx_show_leaf(struct inode *dir,
@@ -647,17 +639,14 @@ static struct stats dx_show_leaf(struct inode *dir,
 				struct ext4_dir_entry_2 *de,
 				int size, int show_names)
 {
-	unsigned names = 0, space = 0;
+	unsigned int names = 0, space = 0;
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
 
 	printk("names: ");
-	while ((char *) de < base + size)
-	{
-		if (de->inode)
-		{
-			if (show_names)
-			{
+	while ((char *) de < base + size) {
+		if (de->inode) {
+			if (show_names) {
 #ifdef CONFIG_FS_ENCRYPTION
 				int len;
 				char *name;
@@ -673,7 +662,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
-					       (unsigned) ((char *) de
+					       (unsigned int) ((char *) de
 							   - base));
 				} else {
 					struct fscrypt_str de_name =
@@ -707,7 +696,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 						ext4fs_dirhash(dir, de->name,
 						       de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
-					       h.hash, (unsigned) ((char *) de
+					       h.hash, (unsigned int) ((char *) de
 								   - base));
 					fscrypt_fname_free_buffer(
 							&fname_crypto_str);
@@ -715,9 +704,10 @@ static struct stats dx_show_leaf(struct inode *dir,
 #else
 				int len = de->name_len;
 				char *name = de->name;
+
 				ext4fs_dirhash(dir, de->name, de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
-				       (unsigned) ((char *) de - base));
+				       (unsigned int) ((char *) de - base));
 #endif
 			}
 			space += ext4_dir_rec_len(de->name_len, dir);
@@ -732,23 +722,24 @@ static struct stats dx_show_leaf(struct inode *dir,
 struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 			     struct dx_entry *entries, int levels)
 {
-	unsigned blocksize = dir->i_sb->s_blocksize;
-	unsigned count = dx_get_count(entries), names = 0, space = 0, i;
-	unsigned bcount = 0;
+	unsigned int blocksize = dir->i_sb->s_blocksize;
+	unsigned int count = dx_get_count(entries), names = 0, space = 0, i;
+	unsigned int bcount = 0;
 	struct buffer_head *bh;
+
 	printk("%i indexed blocks...\n", count);
-	for (i = 0; i < count; i++, entries++)
-	{
+	for (i = 0; i < count; i++, entries++) {
 		ext4_lblk_t block = dx_get_block(entries);
-		ext4_lblk_t hash  = i ? dx_get_hash(entries): 0;
-		u32 range = i < count - 1? (dx_get_hash(entries + 1) - hash): ~hash;
+		ext4_lblk_t hash  = i ? dx_get_hash(entries) : 0;
+		u32 range = i < count - 1 ? (dx_get_hash(entries + 1) - hash) : ~hash;
 		struct stats stats;
-		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
-		bh = ext4_bread(NULL,dir, block, 0);
+
+		printk("%s%3u:%03u hash %8x/%8x ", levels?"":"   ", i, block, hash, range);
+		bh = ext4_bread(NULL, dir, block, 0);
 		if (!bh || IS_ERR(bh))
 			continue;
-		stats = levels?
-		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries, levels - 1):
+		stats = levels ?
+		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries, levels - 1) :
 		   dx_show_leaf(dir, hinfo, (struct ext4_dir_entry_2 *)
 			bh->b_data, blocksize, 0);
 		names += stats.names;
@@ -800,7 +791,7 @@ static struct dx_frame *
 dx_probe(struct ext4_filename *fname, struct inode *dir,
 	 struct dx_hash_info *hinfo, struct dx_frame *frame_in)
 {
-	unsigned count, indirect, level, i;
+	unsigned int count, indirect, level, i;
 	struct dx_entry *at, *entries, *p, *q, *m;
 	struct dx_root *root;
 	struct dx_frame *frame = frame_in;
@@ -1187,6 +1178,7 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 		hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 		if (ext4_has_inline_data(dir)) {
 			int has_inline_data = 1;
+
 			count = ext4_inlinedir_to_tree(dir_file, dir, 0,
 						       &hinfo, start_hash,
 						       start_minor_hash,
@@ -1218,7 +1210,7 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 			goto errout;
 		count++;
 	}
-	if (start_hash < 2 || (start_hash ==2 && start_minor_hash==0)) {
+	if (start_hash < 2 || (start_hash == 2 && start_minor_hash == 0)) {
 		de = (struct ext4_dir_entry_2 *) frames[0].bh->b_data;
 		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
 		tmp_str.name = de->name;
@@ -1267,7 +1259,7 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 	return count;
 errout:
 	dx_release(frames);
-	return (err);
+	return err;
 }
 
 static inline int search_dirblock(struct buffer_head *bh,
@@ -1323,7 +1315,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 }
 
 /* Sort map by hash value */
-static void dx_sort_map (struct dx_map_entry *map, unsigned count)
+static void dx_sort_map(struct dx_map_entry *map, unsigned int count)
 {
 	struct dx_map_entry *p, *q, *top = map + count - 1;
 	int more;
@@ -1346,7 +1338,7 @@ static void dx_sort_map (struct dx_map_entry *map, unsigned count)
 			swap(*(q+1), *q);
 			more = 1;
 		}
-	} while(more);
+	} while (more);
 }
 
 static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
@@ -1440,7 +1432,7 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		kfree(cf_name->name);
 		cf_name->name = NULL;
 	}
-	cf_name->len = (unsigned) len;
+	cf_name->len = (unsigned int) len;
 	if (!IS_ENCRYPTED(dir))
 		return 0;
 
@@ -1506,8 +1498,8 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
 		    unsigned int offset, struct ext4_dir_entry_2 **res_dir)
 {
-	struct ext4_dir_entry_2 * de;
-	char * dlimit;
+	struct ext4_dir_entry_2 *de;
+	char *dlimit;
 	int de_len;
 
 	de = (struct ext4_dir_entry_2 *)search_buf;
@@ -1517,8 +1509,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		/* do minimal checking `by hand' */
 		if (de->name + de->name_len <= dlimit &&
 		    ext4_match(dir, fname, de)) {
-			/* found a match - just to be sure, do
-			 * a full check */
+			/* found a match - just to be sure, do a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
 				return -1;
@@ -1574,9 +1565,9 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 	ext4_lblk_t start, block;
 	const u8 *name = fname->usr_fname->name;
 	size_t ra_max = 0;	/* Number of bh's in the readahead
-				   buffer, bh_use[] */
-	size_t ra_ptr = 0;	/* Current index into readahead
-				   buffer */
+				 * buffer, bh_use[]
+				 */
+	size_t ra_ptr = 0;	/* Current index into readahead buffer */
 	ext4_lblk_t  nblocks;
 	int i, namelen, retval;
 
@@ -1588,6 +1579,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 
 	if (ext4_has_inline_data(dir)) {
 		int has_inline_data = 1;
+
 		ret = ext4_find_inline_entry(dir, fname, res_dir,
 					     &has_inline_data);
 		if (has_inline_data) {
@@ -1651,7 +1643,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 				goto cleanup_and_exit;
 			}
 		}
-		if ((bh = bh_use[ra_ptr++]) == NULL)
+		bh = bh_use[ra_ptr++];
+		if (bh == NULL)
 			goto next;
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
@@ -1750,11 +1743,11 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	return bh;
 }
 
-static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
+static struct buffer_head *ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
 			struct ext4_dir_entry_2 **res_dir)
 {
-	struct super_block * sb = dir->i_sb;
+	struct super_block *sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
 	struct buffer_head *bh;
 	ext4_lblk_t block;
@@ -1863,7 +1856,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 struct dentry *ext4_get_parent(struct dentry *child)
 {
 	__u32 ino;
-	struct ext4_dir_entry_2 * de;
+	struct ext4_dir_entry_2 *de;
 	struct buffer_head *bh;
 
 	bh = ext4_find_entry(d_inode(child), &dotdot_name, &de, NULL);
@@ -1890,16 +1883,16 @@ struct dentry *ext4_get_parent(struct dentry *child)
 static struct ext4_dir_entry_2 *
 dx_move_dirents(struct inode *dir, char *from, char *to,
 		struct dx_map_entry *map, int count,
-		unsigned blocksize)
+		unsigned int blocksize)
 {
-	unsigned rec_len = 0;
+	unsigned int rec_len = 0;
 
 	while (count--) {
 		struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)
 						(from + (map->offs<<2));
 		rec_len = ext4_dir_rec_len(de->name_len, dir);
 
-		memcpy (to, de, rec_len);
+		memcpy(to, de, rec_len);
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
 
@@ -1924,10 +1917,10 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
 							unsigned int blocksize)
 {
 	struct ext4_dir_entry_2 *next, *to, *prev, *de = (struct ext4_dir_entry_2 *) base;
-	unsigned rec_len = 0;
+	unsigned int rec_len = 0;
 
 	prev = to = de;
-	while ((char*)de < base + blocksize) {
+	while ((char *)de < base + blocksize) {
 		next = ext4_next_entry(de, blocksize);
 		if (de->inode && de->name_len) {
 			rec_len = ext4_dir_rec_len(de->name_len, dir);
@@ -1948,18 +1941,18 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
  * Returns pointer to de in block into which the new entry will be inserted.
  */
 static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
-			struct buffer_head **bh,struct dx_frame *frame,
+			struct buffer_head **bh, struct dx_frame *frame,
 			struct dx_hash_info *hinfo)
 {
-	unsigned blocksize = dir->i_sb->s_blocksize;
-	unsigned continued;
+	unsigned int blocksize = dir->i_sb->s_blocksize;
+	unsigned int continued;
 	int count;
 	struct buffer_head *bh2;
 	ext4_lblk_t newblock;
 	u32 hash2;
 	struct dx_map_entry *map;
 	char *data1 = (*bh)->b_data, *data2;
-	unsigned split, move, size;
+	unsigned int split, move, size;
 	struct ext4_dir_entry_2 *de = NULL, *de2;
 	int	csum_size = 0;
 	int	err = 0, i;
@@ -2208,9 +2201,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	struct dx_entry *entries;
 	struct ext4_dir_entry_2	*de, *de2;
 	char		*data2, *top;
-	unsigned	len;
+	unsigned int len;
 	int		retval;
-	unsigned	blocksize;
+	unsigned int blocksize;
 	ext4_lblk_t  block;
 	struct fake_dirent *fde;
 	int csum_size = 0;
@@ -2303,7 +2296,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (retval)
 		goto out_frames;
 
-	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
+	de = do_split(handle, dir, &bh2, frame, &fname->hinfo);
 	if (IS_ERR(de)) {
 		retval = PTR_ERR(de);
 		goto out_frames;
@@ -2342,8 +2335,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	struct super_block *sb;
 	struct ext4_filename fname;
 	int	retval;
-	int	dx_fallback=0;
-	unsigned blocksize;
+	int	dx_fallback = 0;
+	unsigned int blocksize;
 	ext4_lblk_t block, blocks;
 	int	csum_size = 0;
 
@@ -2536,8 +2529,9 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		if (err)
 			goto journal_error;
 		if (!add_level) {
-			unsigned icount1 = icount/2, icount2 = icount - icount1;
-			unsigned hash2 = dx_get_hash(entries + icount1);
+			unsigned int icount1 = icount/2, icount2 = icount - icount1;
+			unsigned int hash2 = dx_get_hash(entries + icount1);
+
 			dxtrace(printk(KERN_DEBUG "Split index %i/%i\n",
 				       icount1, icount2));
 
@@ -2567,7 +2561,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
 			if (err)
 				goto journal_error;
-			brelse (bh2);
+			brelse(bh2);
 			err = ext4_handle_dirty_dx_node(handle, dir,
 						   (frame - 1)->bh);
 			if (err)
@@ -2578,6 +2572,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				goto journal_error;
 		} else {
 			struct dx_root *dxroot;
+
 			memcpy((char *) entries2, (char *) entries,
 			       icount * sizeof(struct dx_entry));
 			dx_set_limit(entries2, dx_node_limit(dir));
@@ -2683,6 +2678,7 @@ static int ext4_delete_entry(handle_t *handle,
 
 	if (ext4_has_inline_data(dir)) {
 		int has_inline_data = 1;
+
 		err = ext4_delete_inline_entry(handle, dir, de_del, bh,
 					       &has_inline_data);
 		if (has_inline_data)
@@ -2757,6 +2753,7 @@ static int ext4_add_nondir(handle_t *handle,
 	struct inode *dir = d_inode(dentry->d_parent);
 	struct inode *inode = *inodep;
 	int err = ext4_add_entry(handle, dentry, inode);
+
 	if (!err) {
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_DIRSYNC(dir))
@@ -3077,6 +3074,7 @@ bool ext4_empty_dir(struct inode *inode)
 	while (offset < inode->i_size) {
 		if (!(offset & (sb->s_blocksize - 1))) {
 			unsigned int lblock;
+
 			brelse(bh);
 			lblock = offset >> EXT4_BLOCK_SIZE_BITS(sb);
 			bh = ext4_read_dirblock(inode, lblock, EITHER);
@@ -3113,7 +3111,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return -EIO;
 
 	/* Initialize quotas before so that eventual writes go in
-	 * separate transaction */
+	 * separate transaction
+	 */
 	retval = dquot_initialize(dir);
 	if (retval)
 		return retval;
@@ -3160,8 +3159,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(inode);
 	clear_nlink(inode);
 	/* There's no need to set i_disksize: the fact that i_nlink is
-	 * zero will ensure that the right thing happens during any
-	 * recovery. */
+	 * zero will ensure that the right thing happens during any recovery.
+	 */
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
@@ -3565,7 +3564,7 @@ static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent)
 }
 
 static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
-				  unsigned dir_ino)
+				  unsigned int dir_ino)
 {
 	int retval;
 
@@ -3591,7 +3590,7 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
 }
 
 static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
-		       unsigned ino, unsigned file_type)
+		       unsigned int ino, unsigned int file_type)
 {
 	int retval, retval2;
 
@@ -3619,7 +3618,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 }
 
 static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
-			  unsigned ino, unsigned file_type)
+			  unsigned int ino, unsigned int file_type)
 {
 	struct ext4_renament old = *ent;
 	int retval = 0;
@@ -3786,7 +3785,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		return retval;
 
 	/* Initialize quotas before so that eventual writes go
-	 * in separate transaction */
+	 * in separate transaction
+	 */
 	if (new.inode) {
 		retval = dquot_initialize(new.inode);
 		if (retval)
@@ -3925,7 +3925,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		if (new.inode) {
 			/* checked ext4_empty_dir above, can't have another
 			 * parent, ext4_dec_count() won't work for many-linked
-			 * dirs */
+			 * dirs
+			 */
 			clear_nlink(new.inode);
 		} else {
 			ext4_inc_count(new.dir);
@@ -3942,7 +3943,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	if (S_ISDIR(old.inode->i_mode)) {
 		/*
 		 * We disable fast commits here that's because the
-		 * replay code is not yet capable of changing dot dot
+		 * replay code is not yet capable of changing dot
 		 * dirents in directories.
 		 */
 		ext4_fc_mark_ineligible(old.inode->i_sb,

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

