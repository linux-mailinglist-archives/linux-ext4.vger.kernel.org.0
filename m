Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE781CECFF
	for <lists+linux-ext4@lfdr.de>; Tue, 12 May 2020 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgELG1F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 May 2020 02:27:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:28076 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELG1F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 May 2020 02:27:05 -0400
IronPort-SDR: oX1VIBE3mbVkFOGBbrhD83G7zK01HRbx438GEdcQ52wgn+NIv/YaDxNwjC6mr8r0hzs0ksWCzO
 hDhqJFbD5+pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 23:27:04 -0700
IronPort-SDR: RtAoL+9yVVO2KlOk47kZQRPzQlhWG8+vgQK1l5bEjVMchEZJlFdnMJC6RFfiPvIfz8YxO2rQr3
 Yf6vRzpPHVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,382,1583222400"; 
   d="scan'208";a="306392145"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2020 23:27:01 -0700
Date:   Tue, 12 May 2020 14:37:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Anna Pendleton <pendleton@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Anna Pendleton <pendleton@google.com>
Subject: Re: [PATCH] ext4: avoid ext4_error()'s caused by ENOMEM in the
 truncate path
Message-ID: <20200512063703.GA20612@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507175028.15061-1-pendleton@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Anna,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on tytso-fscrypt/master v5.7-rc4 next-20200508]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Anna-Pendleton/ext4-avoid-ext4_error-s-caused-by-ENOMEM-in-the-truncate-path/20200508-062229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
reproduce:
        # apt-get install sparse
        # sparse version: 
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
:::::: branch date: 22 hours ago
:::::: commit date: 22 hours ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/ext4/extents.c:493:67: sparse: warning: incorrect type in initializer (different base types)
>> fs/ext4/extents.c:493:67: sparse:    expected int gfp_flags
>> fs/ext4/extents.c:493:67: sparse:    got restricted gfp_t
   fs/ext4/extents.c:496:27: sparse: warning: invalid assignment: |=
>> fs/ext4/extents.c:496:27: sparse:    left side has type int
>> fs/ext4/extents.c:496:27: sparse:    right side has type restricted gfp_t
   fs/ext4/extents.c:498:47: sparse: warning: incorrect type in argument 3 (different base types)
>> fs/ext4/extents.c:498:47: sparse:    expected restricted gfp_t [usertype] gfp
>> fs/ext4/extents.c:498:47: sparse:    got int gfp_flags
   fs/ext4/extents.c:848:25: sparse: warning: incorrect type in initializer (different base types)
   fs/ext4/extents.c:848:25: sparse:    expected int gfp_flags
   fs/ext4/extents.c:848:25: sparse:    got restricted gfp_t
   fs/ext4/extents.c:851:27: sparse: warning: invalid assignment: |=
   fs/ext4/extents.c:851:27: sparse:    left side has type int
   fs/ext4/extents.c:851:27: sparse:    right side has type restricted gfp_t
   fs/ext4/extents.c:872:33: sparse: warning: incorrect type in argument 3 (different base types)
>> fs/ext4/extents.c:872:33: sparse:    expected restricted gfp_t [usertype] flags
   fs/ext4/extents.c:872:33: sparse:    got int gfp_flags
   fs/ext4/extents.c:1022:25: sparse: warning: incorrect type in initializer (different base types)
   fs/ext4/extents.c:1022:25: sparse:    expected int gfp_flags
   fs/ext4/extents.c:1022:25: sparse:    got restricted gfp_t
   fs/ext4/extents.c:1027:27: sparse: warning: invalid assignment: |=
   fs/ext4/extents.c:1027:27: sparse:    left side has type int
   fs/ext4/extents.c:1027:27: sparse:    right side has type restricted gfp_t
   fs/ext4/extents.c:1062:56: sparse: warning: incorrect type in argument 3 (different base types)
   fs/ext4/extents.c:1062:56: sparse:    expected restricted gfp_t [usertype] flags
   fs/ext4/extents.c:1062:56: sparse:    got int gfp_flags

# https://github.com/0day-ci/linux/commit/7d07f7d72800b68a55822a5705514d3c3bc82b63
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 7d07f7d72800b68a55822a5705514d3c3bc82b63
vim +493 fs/ext4/extents.c

4068664e3cd231 Dmitry Monakhov 2019-11-06  485  
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  486  static struct buffer_head *
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  487  __read_extent_tree_block(const char *function, unsigned int line,
107a7bd31ac003 Theodore Ts'o   2013-08-16  488  			 struct inode *inode, ext4_fsblk_t pblk, int depth,
107a7bd31ac003 Theodore Ts'o   2013-08-16  489  			 int flags)
f84891289e62a7 Darrick J. Wong 2012-04-29  490  {
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  491  	struct buffer_head		*bh;
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  492  	int				err;
7d07f7d72800b6 Theodore Ts'o   2020-05-07 @493  	int				gfp_flags = __GFP_MOVABLE | GFP_NOFS;
f84891289e62a7 Darrick J. Wong 2012-04-29  494  
7d07f7d72800b6 Theodore Ts'o   2020-05-07  495  	if (flags & EXT4_EX_NOFAIL)
7d07f7d72800b6 Theodore Ts'o   2020-05-07 @496  		gfp_flags |= __GFP_NOFAIL;
7d07f7d72800b6 Theodore Ts'o   2020-05-07  497  
7d07f7d72800b6 Theodore Ts'o   2020-05-07 @498  	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  499  	if (unlikely(!bh))
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  500  		return ERR_PTR(-ENOMEM);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  501  
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  502  	if (!bh_uptodate_or_lock(bh)) {
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  503  		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  504  		err = bh_submit_read(bh);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  505  		if (err < 0)
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  506  			goto errout;
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  507  	}
7869a4a6c5caa7 Theodore Ts'o   2013-08-16  508  	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  509  		return bh;
0a944e8a6c66ca Theodore Ts'o   2019-05-22  510  	if (!ext4_has_feature_journal(inode->i_sb) ||
0a944e8a6c66ca Theodore Ts'o   2019-05-22  511  	    (inode->i_ino !=
0a944e8a6c66ca Theodore Ts'o   2019-05-22  512  	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum))) {
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  513  		err = __ext4_ext_check(function, line, inode,
c349179b4808f7 Theodore Ts'o   2013-08-16  514  				       ext_block_hdr(bh), depth, pblk);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  515  		if (err)
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  516  			goto errout;
0a944e8a6c66ca Theodore Ts'o   2019-05-22  517  	}
f84891289e62a7 Darrick J. Wong 2012-04-29  518  	set_buffer_verified(bh);
107a7bd31ac003 Theodore Ts'o   2013-08-16  519  	/*
107a7bd31ac003 Theodore Ts'o   2013-08-16  520  	 * If this is a leaf block, cache all of its entries
107a7bd31ac003 Theodore Ts'o   2013-08-16  521  	 */
107a7bd31ac003 Theodore Ts'o   2013-08-16  522  	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
107a7bd31ac003 Theodore Ts'o   2013-08-16  523  		struct ext4_extent_header *eh = ext_block_hdr(bh);
4068664e3cd231 Dmitry Monakhov 2019-11-06  524  		ext4_cache_extents(inode, eh);
107a7bd31ac003 Theodore Ts'o   2013-08-16  525  	}
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  526  	return bh;
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  527  errout:
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  528  	put_bh(bh);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  529  	return ERR_PTR(err);
7d7ea89e756ea1 Theodore Ts'o   2013-08-16  530  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

