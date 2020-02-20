Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE0166B04
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 00:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgBTXjm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 18:39:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:34864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgBTXjl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 18:39:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 15:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="436768719"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2020 15:39:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4vPu-00034R-D9; Fri, 21 Feb 2020 07:39:38 +0800
Date:   Fri, 21 Feb 2020 07:38:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [ext4:fix-bz-206443 6/6] fs/ext4/ialloc.c:333:29: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202002210743.YkEaPRvg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git fix-bz-206443
head:   c20bac9bf82cd6560d269aa1e885e036d9e418b3
commit: c20bac9bf82cd6560d269aa1e885e036d9e418b3 [6/6] ext4: fix potential race between s_flex_groups online resizing and access
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        git checkout c20bac9bf82cd6560d269aa1e885e036d9e418b3
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/ext4/ialloc.c:333:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ialloc.c:333:29: sparse:    struct flex_groups *[noderef] <asn:4> *
>> fs/ext4/ialloc.c:333:29: sparse:    struct flex_groups **
   fs/ext4/ialloc.c:336:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ialloc.c:336:37: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/ialloc.c:336:37: sparse:    struct flex_groups **
   fs/ext4/ialloc.c:373:42: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ialloc.c:373:42: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/ialloc.c:373:42: sparse:    struct flex_groups **
   fs/ext4/ialloc.c:1060:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ialloc.c:1060:37: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/ialloc.c:1060:37: sparse:    struct flex_groups **
   fs/ext4/ialloc.c:1084:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ialloc.c:1084:29: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/ialloc.c:1084:29: sparse:    struct flex_groups **
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
--
   fs/ext4/mballoc.c:2377:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/mballoc.c:2377:9: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/mballoc.c:2377:9: sparse:    struct ext4_group_info ***
   fs/ext4/mballoc.c:3025:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/mballoc.c:3025:31: sparse:    struct flex_groups *[noderef] <asn:4> *
>> fs/ext4/mballoc.c:3025:31: sparse:    struct flex_groups **
   fs/ext4/mballoc.c:4924:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/mballoc.c:4924:31: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/mballoc.c:4924:31: sparse:    struct flex_groups **
   fs/ext4/mballoc.c:5082:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/mballoc.c:5082:31: sparse:    struct flex_groups *[noderef] <asn:4> *
   fs/ext4/mballoc.c:5082:31: sparse:    struct flex_groups **
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
--
>> fs/ext4/super.c:2422:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/super.c:2422:9: sparse:    struct flex_groups *[noderef] <asn:4> *
>> fs/ext4/super.c:2422:9: sparse:    struct flex_groups **
   fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
   fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***

vim +333 fs/ext4/ialloc.c

   217	
   218	/*
   219	 * NOTE! When we get the inode, we're the only people
   220	 * that have access to it, and as such there are no
   221	 * race conditions we have to worry about. The inode
   222	 * is not on the hash-lists, and it cannot be reached
   223	 * through the filesystem because the directory entry
   224	 * has been deleted earlier.
   225	 *
   226	 * HOWEVER: we must make sure that we get no aliases,
   227	 * which means that we have to call "clear_inode()"
   228	 * _before_ we mark the inode not in use in the inode
   229	 * bitmaps. Otherwise a newly created file might use
   230	 * the same inode number (not actually the same pointer
   231	 * though), and then we'd have two inodes sharing the
   232	 * same inode number and space on the harddisk.
   233	 */
   234	void ext4_free_inode(handle_t *handle, struct inode *inode)
   235	{
   236		struct super_block *sb = inode->i_sb;
   237		int is_directory;
   238		unsigned long ino;
   239		struct buffer_head *bitmap_bh = NULL;
   240		struct buffer_head *bh2;
   241		ext4_group_t block_group;
   242		unsigned long bit;
   243		struct ext4_group_desc *gdp;
   244		struct ext4_super_block *es;
   245		struct ext4_sb_info *sbi;
   246		int fatal = 0, err, count, cleared;
   247		struct ext4_group_info *grp;
   248	
   249		if (!sb) {
   250			printk(KERN_ERR "EXT4-fs: %s:%d: inode on "
   251			       "nonexistent device\n", __func__, __LINE__);
   252			return;
   253		}
   254		if (atomic_read(&inode->i_count) > 1) {
   255			ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=%d",
   256				 __func__, __LINE__, inode->i_ino,
   257				 atomic_read(&inode->i_count));
   258			return;
   259		}
   260		if (inode->i_nlink) {
   261			ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: nlink=%d\n",
   262				 __func__, __LINE__, inode->i_ino, inode->i_nlink);
   263			return;
   264		}
   265		sbi = EXT4_SB(sb);
   266	
   267		ino = inode->i_ino;
   268		ext4_debug("freeing inode %lu\n", ino);
   269		trace_ext4_free_inode(inode);
   270	
   271		dquot_initialize(inode);
   272		dquot_free_inode(inode);
   273	
   274		is_directory = S_ISDIR(inode->i_mode);
   275	
   276		/* Do this BEFORE marking the inode not in use or returning an error */
   277		ext4_clear_inode(inode);
   278	
   279		es = sbi->s_es;
   280		if (ino < EXT4_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
   281			ext4_error(sb, "reserved or nonexistent inode %lu", ino);
   282			goto error_return;
   283		}
   284		block_group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
   285		bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
   286		bitmap_bh = ext4_read_inode_bitmap(sb, block_group);
   287		/* Don't bother if the inode bitmap is corrupt. */
   288		grp = ext4_get_group_info(sb, block_group);
   289		if (IS_ERR(bitmap_bh)) {
   290			fatal = PTR_ERR(bitmap_bh);
   291			bitmap_bh = NULL;
   292			goto error_return;
   293		}
   294		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
   295			fatal = -EFSCORRUPTED;
   296			goto error_return;
   297		}
   298	
   299		BUFFER_TRACE(bitmap_bh, "get_write_access");
   300		fatal = ext4_journal_get_write_access(handle, bitmap_bh);
   301		if (fatal)
   302			goto error_return;
   303	
   304		fatal = -ESRCH;
   305		gdp = ext4_get_group_desc(sb, block_group, &bh2);
   306		if (gdp) {
   307			BUFFER_TRACE(bh2, "get_write_access");
   308			fatal = ext4_journal_get_write_access(handle, bh2);
   309		}
   310		ext4_lock_group(sb, block_group);
   311		cleared = ext4_test_and_clear_bit(bit, bitmap_bh->b_data);
   312		if (fatal || !cleared) {
   313			ext4_unlock_group(sb, block_group);
   314			goto out;
   315		}
   316	
   317		count = ext4_free_inodes_count(sb, gdp) + 1;
   318		ext4_free_inodes_set(sb, gdp, count);
   319		if (is_directory) {
   320			count = ext4_used_dirs_count(sb, gdp) - 1;
   321			ext4_used_dirs_set(sb, gdp, count);
   322			percpu_counter_dec(&sbi->s_dirs_counter);
   323		}
   324		ext4_inode_bitmap_csum_set(sb, block_group, gdp, bitmap_bh,
   325					   EXT4_INODES_PER_GROUP(sb) / 8);
   326		ext4_group_desc_csum_set(sb, block_group, gdp);
   327		ext4_unlock_group(sb, block_group);
   328	
   329		percpu_counter_inc(&sbi->s_freeinodes_counter);
   330		if (sbi->s_log_groups_per_flex) {
   331			ext4_group_t f = ext4_flex_group(sbi, block_group);
   332	
 > 333			atomic_inc(&sbi_array_rcu_deref(sbi, s_flex_groups,
   334							f)->free_inodes);
   335			if (is_directory)
   336				atomic_dec(&sbi_array_rcu_deref(sbi, s_flex_groups,
   337								f)->used_dirs);
   338		}
   339		BUFFER_TRACE(bh2, "call ext4_handle_dirty_metadata");
   340		fatal = ext4_handle_dirty_metadata(handle, NULL, bh2);
   341	out:
   342		if (cleared) {
   343			BUFFER_TRACE(bitmap_bh, "call ext4_handle_dirty_metadata");
   344			err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
   345			if (!fatal)
   346				fatal = err;
   347		} else {
   348			ext4_error(sb, "bit already cleared for inode %lu", ino);
   349			ext4_mark_group_bitmap_corrupted(sb, block_group,
   350						EXT4_GROUP_INFO_IBITMAP_CORRUPT);
   351		}
   352	
   353	error_return:
   354		brelse(bitmap_bh);
   355		ext4_std_error(sb, fatal);
   356	}
   357	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
