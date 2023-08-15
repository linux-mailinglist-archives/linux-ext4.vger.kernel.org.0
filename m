Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFEE77CC05
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjHOLuG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjHOLtf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 07:49:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0571BF0;
        Tue, 15 Aug 2023 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692100162; x=1723636162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPtoka+vHk+g0c/C9uH5Pt/tuntLXJwjnPUH2OERbi0=;
  b=bLTFtH8cfWwunC82ZmqiRfS7tvFRo0IXLxYS5HbubEXcvOnKQGC6eyBh
   O9eVw+CH6b9py+meo9HgbSUXcTfpOMdlXa3+Fgw3dQD3Lc0SDtCOlQyWW
   DYcbgjq6C+g61bjbT+71frl62cOqfFeX8BaS/zw1zlBbo0fFPz2Oku9S9
   nbtgW0IT4Vq26CvM7aeWFmALX5sNuCguV2qYMF0HKwGwwdtVbb4cPw73j
   CzHNhoGRuiDsRXrbMap7r413TG2WPAFiR+O6wCrOc1C9RekExBZbumETw
   UK+223V3sjenmxOOri/PpRIZDeiO3ylPYlfr44H4DBPuugGhY2+HnNJwZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403239471"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403239471"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683629594"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683629594"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 04:49:18 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVsY2-0000vX-20;
        Tue, 15 Aug 2023 11:49:18 +0000
Date:   Tue, 15 Aug 2023 19:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Georg Ottinger <g.ottinger@gmx.at>, jack@suse.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.ottinger@gmx.at
Subject: Re: [PATCH v1] ext2: fix datatype of block number in
 ext2_xattr_set2()
Message-ID: <202308151929.QmgakA1l-lkp@intel.com>
References: <20230815100340.22121-1-g.ottinger@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815100340.22121-1-g.ottinger@gmx.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Georg,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Georg-Ottinger/ext2-fix-datatype-of-block-number-in-ext2_xattr_set2/20230815-180605
base:   linus/master
patch link:    https://lore.kernel.org/r/20230815100340.22121-1-g.ottinger%40gmx.at
patch subject: [PATCH v1] ext2: fix datatype of block number in ext2_xattr_set2()
config: hexagon-randconfig-r005-20230815 (https://download.01.org/0day-ci/archive/20230815/202308151929.QmgakA1l-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151929.QmgakA1l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151929.QmgakA1l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext2/xattr.c:57:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/ext2/xattr.c:57:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/ext2/xattr.c:57:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> fs/ext2/xattr.c:748:42: warning: format specifies type 'int' but the argument has type 'ext2_fsblk_t' (aka 'unsigned long') [-Wformat]
     748 |                         ea_idebug(inode, "creating block %d", block);
         |                                                          ~~   ^~~~~
         |                                                          %lu
   fs/ext2/xattr.c:88:43: note: expanded from macro 'ea_idebug'
      88 | # define ea_idebug(inode, f...) no_printk(f)
         |                                           ^
   include/linux/printk.h:129:17: note: expanded from macro 'no_printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   7 warnings generated.


vim +748 fs/ext2/xattr.c

90ae40d243d46f Jan Kara          2022-07-12  701  
^1da177e4c3f41 Linus Torvalds    2005-04-16  702  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  703   * Second half of ext2_xattr_set(): Update the file system.
^1da177e4c3f41 Linus Torvalds    2005-04-16  704   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  705  static int
^1da177e4c3f41 Linus Torvalds    2005-04-16  706  ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
^1da177e4c3f41 Linus Torvalds    2005-04-16  707  		struct ext2_xattr_header *header)
^1da177e4c3f41 Linus Torvalds    2005-04-16  708  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  709  	struct super_block *sb = inode->i_sb;
^1da177e4c3f41 Linus Torvalds    2005-04-16  710  	struct buffer_head *new_bh = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  711  	int error;
47387409ee2e09 Tahsin Erdogan    2017-06-22  712  	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
^1da177e4c3f41 Linus Torvalds    2005-04-16  713  
^1da177e4c3f41 Linus Torvalds    2005-04-16  714  	if (header) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  715  		new_bh = ext2_xattr_cache_find(inode, header);
^1da177e4c3f41 Linus Torvalds    2005-04-16  716  		if (new_bh) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  717  			/* We found an identical block in the cache. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  718  			if (new_bh == old_bh) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  719  				ea_bdebug(new_bh, "keeping this block");
^1da177e4c3f41 Linus Torvalds    2005-04-16  720  			} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  721  				/* The old block is released after updating
^1da177e4c3f41 Linus Torvalds    2005-04-16  722  				   the inode.  */
^1da177e4c3f41 Linus Torvalds    2005-04-16  723  				ea_bdebug(new_bh, "reusing block");
^1da177e4c3f41 Linus Torvalds    2005-04-16  724  
5dd4056db84387 Christoph Hellwig 2010-03-03  725  				error = dquot_alloc_block(inode, 1);
5dd4056db84387 Christoph Hellwig 2010-03-03  726  				if (error) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  727  					unlock_buffer(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  728  					goto cleanup;
^1da177e4c3f41 Linus Torvalds    2005-04-16  729  				}
fba4d3997f4c3d Marcin Slusarz    2008-04-28  730  				le32_add_cpu(&HDR(new_bh)->h_refcount, 1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  731  				ea_bdebug(new_bh, "refcount now=%d",
^1da177e4c3f41 Linus Torvalds    2005-04-16  732  					le32_to_cpu(HDR(new_bh)->h_refcount));
^1da177e4c3f41 Linus Torvalds    2005-04-16  733  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  734  			unlock_buffer(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  735  		} else if (old_bh && header == HDR(old_bh)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  736  			/* Keep this block. No need to lock the block as we
^1da177e4c3f41 Linus Torvalds    2005-04-16  737  			   don't need to change the reference count. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  738  			new_bh = old_bh;
^1da177e4c3f41 Linus Torvalds    2005-04-16  739  			get_bh(new_bh);
47387409ee2e09 Tahsin Erdogan    2017-06-22  740  			ext2_xattr_cache_insert(ea_block_cache, new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  741  		} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  742  			/* We need to allocate a new block */
24097d12efbb97 Akinobu Mita      2008-04-28  743  			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
24097d12efbb97 Akinobu Mita      2008-04-28  744  						EXT2_I(inode)->i_block_group);
2a9807b4e5f804 Georg Ottinger    2023-08-15  745  			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
^1da177e4c3f41 Linus Torvalds    2005-04-16  746  			if (error)
^1da177e4c3f41 Linus Torvalds    2005-04-16  747  				goto cleanup;
^1da177e4c3f41 Linus Torvalds    2005-04-16 @748  			ea_idebug(inode, "creating block %d", block);
^1da177e4c3f41 Linus Torvalds    2005-04-16  749  
^1da177e4c3f41 Linus Torvalds    2005-04-16  750  			new_bh = sb_getblk(sb, block);
2b0542a4a0d9b8 Wang Shilong      2013-01-12  751  			if (unlikely(!new_bh)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  752  				ext2_free_blocks(inode, block, 1);
addacc7d6f0f0b Al Viro           2010-07-22  753  				mark_inode_dirty(inode);
ab6a773dbcbd2b Wang Shilong      2013-01-15  754  				error = -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  755  				goto cleanup;
^1da177e4c3f41 Linus Torvalds    2005-04-16  756  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  757  			lock_buffer(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  758  			memcpy(new_bh->b_data, header, new_bh->b_size);
^1da177e4c3f41 Linus Torvalds    2005-04-16  759  			set_buffer_uptodate(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  760  			unlock_buffer(new_bh);
47387409ee2e09 Tahsin Erdogan    2017-06-22  761  			ext2_xattr_cache_insert(ea_block_cache, new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  762  			
^1da177e4c3f41 Linus Torvalds    2005-04-16  763  			ext2_xattr_update_super_block(sb);
^1da177e4c3f41 Linus Torvalds    2005-04-16  764  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  765  		mark_buffer_dirty(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  766  		if (IS_SYNC(inode)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  767  			sync_dirty_buffer(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  768  			error = -EIO;
^1da177e4c3f41 Linus Torvalds    2005-04-16  769  			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
^1da177e4c3f41 Linus Torvalds    2005-04-16  770  				goto cleanup;
^1da177e4c3f41 Linus Torvalds    2005-04-16  771  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  772  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  773  
^1da177e4c3f41 Linus Torvalds    2005-04-16  774  	/* Update the inode. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  775  	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
02027d42c3f747 Deepa Dinamani    2016-09-14  776  	inode->i_ctime = current_time(inode);
^1da177e4c3f41 Linus Torvalds    2005-04-16  777  	if (IS_SYNC(inode)) {
c37650161a53c0 Christoph Hellwig 2010-10-06  778  		error = sync_inode_metadata(inode, 1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  779  		/* In case sync failed due to ENOSPC the inode was actually
^1da177e4c3f41 Linus Torvalds    2005-04-16  780  		 * written (only some dirty data were not) so we just proceed
^1da177e4c3f41 Linus Torvalds    2005-04-16  781  		 * as if nothing happened and cleanup the unused block */
^1da177e4c3f41 Linus Torvalds    2005-04-16  782  		if (error && error != -ENOSPC) {
3889717d2851bf Al Viro           2010-07-22  783  			if (new_bh && new_bh != old_bh) {
3889717d2851bf Al Viro           2010-07-22  784  				dquot_free_block_nodirty(inode, 1);
3889717d2851bf Al Viro           2010-07-22  785  				mark_inode_dirty(inode);
3889717d2851bf Al Viro           2010-07-22  786  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  787  			goto cleanup;
^1da177e4c3f41 Linus Torvalds    2005-04-16  788  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  789  	} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  790  		mark_inode_dirty(inode);
^1da177e4c3f41 Linus Torvalds    2005-04-16  791  
^1da177e4c3f41 Linus Torvalds    2005-04-16  792  	error = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  793  	if (old_bh && old_bh != new_bh) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  794  		/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  795  		 * If there was an old block and we are no longer using it,
^1da177e4c3f41 Linus Torvalds    2005-04-16  796  		 * release the old block.
^1da177e4c3f41 Linus Torvalds    2005-04-16  797  		 */
90ae40d243d46f Jan Kara          2022-07-12  798  		ext2_xattr_release_block(inode, old_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  799  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  800  
^1da177e4c3f41 Linus Torvalds    2005-04-16  801  cleanup:
^1da177e4c3f41 Linus Torvalds    2005-04-16  802  	brelse(new_bh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  803  
^1da177e4c3f41 Linus Torvalds    2005-04-16  804  	return error;
^1da177e4c3f41 Linus Torvalds    2005-04-16  805  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  806  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
