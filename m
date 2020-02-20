Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69571664E1
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 18:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBTRbx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 12:31:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:61617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTRbw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 12:31:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 09:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="436664413"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2020 09:31:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4pfy-000G1M-In; Fri, 21 Feb 2020 01:31:50 +0800
Date:   Fri, 21 Feb 2020 01:31:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org
Subject: [ext4:fix-bz-206443 3/6] fs/ext4/balloc.c:285:16: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202002210111.FeIR4Px6%lkp@intel.com>
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
commit: cd19e90e29ccc914b52eeb53afef676edaac911c [3/6] ext4: fix potential race between online resizing and write operations
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        git checkout cd19e90e29ccc914b52eeb53afef676edaac911c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/ext4/balloc.c:285:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/balloc.c:285:16: sparse:    struct buffer_head *[noderef] <asn:4> *
>> fs/ext4/balloc.c:285:16: sparse:    struct buffer_head **
--
>> fs/ext4/resize.c:894:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/resize.c:894:9: sparse:    struct buffer_head *[noderef] <asn:4> *
>> fs/ext4/resize.c:894:9: sparse:    struct buffer_head **
   fs/ext4/resize.c:952:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/resize.c:952:9: sparse:    struct buffer_head *[noderef] <asn:4> *
   fs/ext4/resize.c:952:9: sparse:    struct buffer_head **

vim +285 fs/ext4/balloc.c

   245	
   246	/*
   247	 * The free blocks are managed by bitmaps.  A file system contains several
   248	 * blocks groups.  Each group contains 1 bitmap block for blocks, 1 bitmap
   249	 * block for inodes, N blocks for the inode table and data blocks.
   250	 *
   251	 * The file system contains group descriptors which are located after the
   252	 * super block.  Each descriptor contains the number of the bitmap block and
   253	 * the free blocks count in the block.  The descriptors are loaded in memory
   254	 * when a file system is mounted (see ext4_fill_super).
   255	 */
   256	
   257	/**
   258	 * ext4_get_group_desc() -- load group descriptor from disk
   259	 * @sb:			super block
   260	 * @block_group:	given block group
   261	 * @bh:			pointer to the buffer head to store the block
   262	 *			group descriptor
   263	 */
   264	struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
   265						     ext4_group_t block_group,
   266						     struct buffer_head **bh)
   267	{
   268		unsigned int group_desc;
   269		unsigned int offset;
   270		ext4_group_t ngroups = ext4_get_groups_count(sb);
   271		struct ext4_group_desc *desc;
   272		struct ext4_sb_info *sbi = EXT4_SB(sb);
   273		struct buffer_head *bh_p;
   274	
   275		if (block_group >= ngroups) {
   276			ext4_error(sb, "block_group >= groups_count - block_group = %u,"
   277				   " groups_count = %u", block_group, ngroups);
   278	
   279			return NULL;
   280		}
   281	
   282		group_desc = block_group >> EXT4_DESC_PER_BLOCK_BITS(sb);
   283		offset = block_group & (EXT4_DESC_PER_BLOCK(sb) - 1);
   284		rcu_read_lock();
 > 285		bh_p = rcu_dereference(sbi->s_group_desc)[group_desc];
   286		/*
   287		 * We can unlock here since the pointer being dereferenced won't be
   288		 * dereferenced again. By looking at the usage in add_new_gdb() the
   289		 * value isn't modified, just the pointer, and so it remains valid.
   290		 */
   291		rcu_read_unlock();
   292		if (!bh_p) {
   293			ext4_error(sb, "Group descriptor not loaded - "
   294				   "block_group = %u, group_desc = %u, desc = %u",
   295				   block_group, group_desc, offset);
   296			return NULL;
   297		}
   298	
   299		desc = (struct ext4_group_desc *)(
   300			(__u8 *)bh_p->b_data +
   301			offset * EXT4_DESC_SIZE(sb));
   302		if (bh)
   303			*bh = bh_p;
   304		return desc;
   305	}
   306	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
