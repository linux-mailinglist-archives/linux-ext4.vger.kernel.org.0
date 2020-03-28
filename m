Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556531969DF
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Mar 2020 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgC1Woc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 18:44:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:44467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbgC1Woc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Mar 2020 18:44:32 -0400
IronPort-SDR: axISb9+YcokpRhaz1tH0SvJmovYt8nVxf+JUKOaM0mr0MywqkMddEgUPfbJfCkwjXbEoL4nHxm
 96e1lgozBDCA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 15:44:29 -0700
IronPort-SDR: Jv8bdIijmoKcr7wpPdSEcdrPiJvClg5ei1uK0nc9ZbKsmEzYG8NqidyFuNIoby+1ufgHn0omDp
 lv9TltX7fgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,318,1580803200"; 
   d="gz'50?scan'50,208,50";a="239421475"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2020 15:44:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIKBm-0008qh-IQ; Sun, 29 Mar 2020 06:44:26 +0800
Date:   Sun, 29 Mar 2020 06:44:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <202003290601.qNQWWEbQ%lkp@intel.com>
References: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Josh,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on linus/master linux/master v5.6-rc7 next-20200327]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Josh-Triplett/ext4-Fix-incorrect-group-count-in-ext4_fill_super-error-message/20200329-055606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: sh-rsk7269_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/super.c:50:
   fs/ext4/super.c: In function 'ext4_fill_super':
>> fs/ext4/super.c:4297:30: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
    4297 |   ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4298 |          "(block count %llu, first data block %u, "
    4299 |          "blocks per group %lu)", blocks_count,
         |                                   ~~~~~~~~~~~~
         |                                   |
         |                                   __u64 {aka long long unsigned int}
   fs/ext4/ext4.h:2829:24: note: in definition of macro 'ext4_msg'
    2829 |  __ext4_msg(sb, level, fmt, ##__VA_ARGS__)
         |                        ^~~
   fs/ext4/super.c:4297:56: note: format string is defined here
    4297 |   ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
         |                                                       ~^
         |                                                        |
         |                                                        unsigned int
         |                                                       %llu

vim +4297 fs/ext4/super.c

c83ad55eaa91c8 Gabriel Krisman Bertazi 2019-04-25  3972  
56889787cfa77d Theodore Ts'o           2011-09-03  3973  	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
244adf6426ee31 Theodore Ts'o           2020-01-23  3974  		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!\n");
244adf6426ee31 Theodore Ts'o           2020-01-23  3975  		clear_opt(sb, DIOREAD_NOLOCK);
56889787cfa77d Theodore Ts'o           2011-09-03  3976  		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
56889787cfa77d Theodore Ts'o           2011-09-03  3977  			ext4_msg(sb, KERN_ERR, "can't mount with "
56889787cfa77d Theodore Ts'o           2011-09-03  3978  				 "both data=journal and delalloc");
56889787cfa77d Theodore Ts'o           2011-09-03  3979  			goto failed_mount;
56889787cfa77d Theodore Ts'o           2011-09-03  3980  		}
56889787cfa77d Theodore Ts'o           2011-09-03  3981  		if (test_opt(sb, DIOREAD_NOLOCK)) {
56889787cfa77d Theodore Ts'o           2011-09-03  3982  			ext4_msg(sb, KERN_ERR, "can't mount with "
6ae6514b33f941 Piotr Sarna             2013-08-08  3983  				 "both data=journal and dioread_nolock");
56889787cfa77d Theodore Ts'o           2011-09-03  3984  			goto failed_mount;
56889787cfa77d Theodore Ts'o           2011-09-03  3985  		}
923ae0ff925043 Ross Zwisler            2015-02-16  3986  		if (test_opt(sb, DAX)) {
923ae0ff925043 Ross Zwisler            2015-02-16  3987  			ext4_msg(sb, KERN_ERR, "can't mount with "
923ae0ff925043 Ross Zwisler            2015-02-16  3988  				 "both data=journal and dax");
923ae0ff925043 Ross Zwisler            2015-02-16  3989  			goto failed_mount;
923ae0ff925043 Ross Zwisler            2015-02-16  3990  		}
73b92a2a5e97d1 Sergey Karamov          2016-12-10  3991  		if (ext4_has_feature_encrypt(sb)) {
73b92a2a5e97d1 Sergey Karamov          2016-12-10  3992  			ext4_msg(sb, KERN_WARNING,
73b92a2a5e97d1 Sergey Karamov          2016-12-10  3993  				 "encrypted files will use data=ordered "
73b92a2a5e97d1 Sergey Karamov          2016-12-10  3994  				 "instead of data journaling mode");
73b92a2a5e97d1 Sergey Karamov          2016-12-10  3995  		}
56889787cfa77d Theodore Ts'o           2011-09-03  3996  		if (test_opt(sb, DELALLOC))
56889787cfa77d Theodore Ts'o           2011-09-03  3997  			clear_opt(sb, DELALLOC);
001e4a8775f6e8 Tejun Heo               2015-07-21  3998  	} else {
001e4a8775f6e8 Tejun Heo               2015-07-21  3999  		sb->s_iflags |= SB_I_CGROUPWB;
56889787cfa77d Theodore Ts'o           2011-09-03  4000  	}
56889787cfa77d Theodore Ts'o           2011-09-03  4001  
1751e8a6cb935e Linus Torvalds          2017-11-27  4002  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
1751e8a6cb935e Linus Torvalds          2017-11-27  4003  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4004  
617ba13b31fbf5 Mingming Cao            2006-10-11  4005  	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
e2b911c53584a9 Darrick J. Wong         2015-10-17  4006  	    (ext4_has_compat_features(sb) ||
e2b911c53584a9 Darrick J. Wong         2015-10-17  4007  	     ext4_has_ro_compat_features(sb) ||
e2b911c53584a9 Darrick J. Wong         2015-10-17  4008  	     ext4_has_incompat_features(sb)))
b31e15527a9bb7 Eric Sandeen            2009-06-04  4009  		ext4_msg(sb, KERN_WARNING,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4010  		       "feature flags set on rev 0 fs, "
b31e15527a9bb7 Eric Sandeen            2009-06-04  4011  		       "running e2fsck is recommended");
469108ff3dcbc0 Theodore Tso            2008-02-10  4012  
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4013  	if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4014  		set_opt2(sb, HURD_COMPAT);
e2b911c53584a9 Darrick J. Wong         2015-10-17  4015  		if (ext4_has_feature_64bit(sb)) {
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4016  			ext4_msg(sb, KERN_ERR,
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4017  				 "The Hurd can't support 64-bit file systems");
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4018  			goto failed_mount;
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4019  		}
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4020  
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4021  		/*
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4022  		 * ea_inode feature uses l_i_version field which is not
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4023  		 * available in HURD_COMPAT mode.
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4024  		 */
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4025  		if (ext4_has_feature_ea_inode(sb)) {
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4026  			ext4_msg(sb, KERN_ERR,
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4027  				 "ea_inode feature is not supported for Hurd");
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4028  			goto failed_mount;
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4029  		}
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4030  	}
ed3654eb981fd4 Theodore Ts'o           2014-03-24  4031  
2035e776050aea Theodore Ts'o           2011-04-18  4032  	if (IS_EXT2_SB(sb)) {
2035e776050aea Theodore Ts'o           2011-04-18  4033  		if (ext2_feature_set_ok(sb))
2035e776050aea Theodore Ts'o           2011-04-18  4034  			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
2035e776050aea Theodore Ts'o           2011-04-18  4035  				 "using the ext4 subsystem");
2035e776050aea Theodore Ts'o           2011-04-18  4036  		else {
0d9366d67bcf06 Eric Sandeen            2018-03-22  4037  			/*
0d9366d67bcf06 Eric Sandeen            2018-03-22  4038  			 * If we're probing be silent, if this looks like
0d9366d67bcf06 Eric Sandeen            2018-03-22  4039  			 * it's actually an ext[34] filesystem.
0d9366d67bcf06 Eric Sandeen            2018-03-22  4040  			 */
0d9366d67bcf06 Eric Sandeen            2018-03-22  4041  			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
0d9366d67bcf06 Eric Sandeen            2018-03-22  4042  				goto failed_mount;
2035e776050aea Theodore Ts'o           2011-04-18  4043  			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
2035e776050aea Theodore Ts'o           2011-04-18  4044  				 "to feature incompatibilities");
2035e776050aea Theodore Ts'o           2011-04-18  4045  			goto failed_mount;
2035e776050aea Theodore Ts'o           2011-04-18  4046  		}
2035e776050aea Theodore Ts'o           2011-04-18  4047  	}
2035e776050aea Theodore Ts'o           2011-04-18  4048  
2035e776050aea Theodore Ts'o           2011-04-18  4049  	if (IS_EXT3_SB(sb)) {
2035e776050aea Theodore Ts'o           2011-04-18  4050  		if (ext3_feature_set_ok(sb))
2035e776050aea Theodore Ts'o           2011-04-18  4051  			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
2035e776050aea Theodore Ts'o           2011-04-18  4052  				 "using the ext4 subsystem");
2035e776050aea Theodore Ts'o           2011-04-18  4053  		else {
0d9366d67bcf06 Eric Sandeen            2018-03-22  4054  			/*
0d9366d67bcf06 Eric Sandeen            2018-03-22  4055  			 * If we're probing be silent, if this looks like
0d9366d67bcf06 Eric Sandeen            2018-03-22  4056  			 * it's actually an ext4 filesystem.
0d9366d67bcf06 Eric Sandeen            2018-03-22  4057  			 */
0d9366d67bcf06 Eric Sandeen            2018-03-22  4058  			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
0d9366d67bcf06 Eric Sandeen            2018-03-22  4059  				goto failed_mount;
2035e776050aea Theodore Ts'o           2011-04-18  4060  			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
2035e776050aea Theodore Ts'o           2011-04-18  4061  				 "to feature incompatibilities");
2035e776050aea Theodore Ts'o           2011-04-18  4062  			goto failed_mount;
2035e776050aea Theodore Ts'o           2011-04-18  4063  		}
2035e776050aea Theodore Ts'o           2011-04-18  4064  	}
2035e776050aea Theodore Ts'o           2011-04-18  4065  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4066  	/*
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4067  	 * Check feature flags regardless of the revision level, since we
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4068  	 * previously didn't change the revision level when setting the flags,
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4069  	 * so there is a chance incompat flags are set on a rev 0 filesystem.
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4070  	 */
bc98a42c1f7d0f David Howells           2017-07-17  4071  	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4072  		goto failed_mount;
a13fb1a4533f26 Eric Sandeen            2009-08-18  4073  
8cdf3372fe8368 Theodore Ts'o           2016-11-18  4074  	if (le32_to_cpu(es->s_log_block_size) >
8cdf3372fe8368 Theodore Ts'o           2016-11-18  4075  	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
8cdf3372fe8368 Theodore Ts'o           2016-11-18  4076  		ext4_msg(sb, KERN_ERR,
8cdf3372fe8368 Theodore Ts'o           2016-11-18  4077  			 "Invalid log block size: %u",
8cdf3372fe8368 Theodore Ts'o           2016-11-18  4078  			 le32_to_cpu(es->s_log_block_size));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4079  		goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4080  	}
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4081  	if (le32_to_cpu(es->s_log_cluster_size) >
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4082  	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4083  		ext4_msg(sb, KERN_ERR,
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4084  			 "Invalid log cluster size: %u",
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4085  			 le32_to_cpu(es->s_log_cluster_size));
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4086  		goto failed_mount;
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4087  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4088  
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4089  	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4090  		ext4_msg(sb, KERN_ERR,
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4091  			 "Number of reserved GDT blocks insanely large: %d",
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4092  			 le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks));
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4093  		goto failed_mount;
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4094  	}
5b9554dc5bf008 Theodore Ts'o           2016-07-05  4095  
923ae0ff925043 Ross Zwisler            2015-02-16  4096  	if (sbi->s_mount_opt & EXT4_MOUNT_DAX) {
559db4c6d784ce Ross Zwisler            2017-10-12  4097  		if (ext4_has_feature_inline_data(sb)) {
559db4c6d784ce Ross Zwisler            2017-10-12  4098  			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
559db4c6d784ce Ross Zwisler            2017-10-12  4099  					" that may contain inline data");
361d24d40657d2 Eric Sandeen            2018-12-04  4100  			goto failed_mount;
559db4c6d784ce Ross Zwisler            2017-10-12  4101  		}
80660f20252d6f Dave Jiang              2018-05-30  4102  		if (!bdev_dax_supported(sb->s_bdev, blocksize)) {
24f3478d664b1e Dan Williams            2017-12-21  4103  			ext4_msg(sb, KERN_ERR,
361d24d40657d2 Eric Sandeen            2018-12-04  4104  				"DAX unsupported by block device.");
361d24d40657d2 Eric Sandeen            2018-12-04  4105  			goto failed_mount;
24f3478d664b1e Dan Williams            2017-12-21  4106  		}
923ae0ff925043 Ross Zwisler            2015-02-16  4107  	}
923ae0ff925043 Ross Zwisler            2015-02-16  4108  
e2b911c53584a9 Darrick J. Wong         2015-10-17  4109  	if (ext4_has_feature_encrypt(sb) && es->s_encryption_level) {
6ddb2447846a8e Theodore Ts'o           2015-04-16  4110  		ext4_msg(sb, KERN_ERR, "Unsupported encryption level %d",
6ddb2447846a8e Theodore Ts'o           2015-04-16  4111  			 es->s_encryption_level);
6ddb2447846a8e Theodore Ts'o           2015-04-16  4112  		goto failed_mount;
6ddb2447846a8e Theodore Ts'o           2015-04-16  4113  	}
6ddb2447846a8e Theodore Ts'o           2015-04-16  4114  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4115  	if (sb->s_blocksize != blocksize) {
ce40733ce93de4 Aneesh Kumar K.V        2008-01-28  4116  		/* Validate the filesystem blocksize */
ce40733ce93de4 Aneesh Kumar K.V        2008-01-28  4117  		if (!sb_set_blocksize(sb, blocksize)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4118  			ext4_msg(sb, KERN_ERR, "bad block size %d",
ce40733ce93de4 Aneesh Kumar K.V        2008-01-28  4119  					blocksize);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4120  			goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4121  		}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4122  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4123  		brelse(bh);
70bbb3e0a07c1f Andrew Morton           2006-10-11  4124  		logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
70bbb3e0a07c1f Andrew Morton           2006-10-11  4125  		offset = do_div(logical_sb_block, blocksize);
a8ac900b816370 Gioh Kim                2014-09-04  4126  		bh = sb_bread_unmovable(sb, logical_sb_block);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4127  		if (!bh) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4128  			ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4129  			       "Can't read superblock on 2nd try");
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4130  			goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4131  		}
2716b80284c5ca Theodore Ts'o           2012-05-28  4132  		es = (struct ext4_super_block *)(bh->b_data + offset);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4133  		sbi->s_es = es;
617ba13b31fbf5 Mingming Cao            2006-10-11  4134  		if (es->s_magic != cpu_to_le16(EXT4_SUPER_MAGIC)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4135  			ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4136  			       "Magic mismatch, very weird!");
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4137  			goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4138  		}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4139  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4140  
e2b911c53584a9 Darrick J. Wong         2015-10-17  4141  	has_huge_files = ext4_has_feature_huge_file(sb);
f287a1a56130be Theodore Ts'o           2008-10-16  4142  	sbi->s_bitmap_maxbytes = ext4_max_bitmap_size(sb->s_blocksize_bits,
f287a1a56130be Theodore Ts'o           2008-10-16  4143  						      has_huge_files);
f287a1a56130be Theodore Ts'o           2008-10-16  4144  	sb->s_maxbytes = ext4_max_size(sb->s_blocksize_bits, has_huge_files);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4145  
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4146  	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
e2b911c53584a9 Darrick J. Wong         2015-10-17  4147  	if (ext4_has_feature_64bit(sb)) {
8fadc14323684c Alexandre Ratchov       2006-10-11  4148  		if (sbi->s_desc_size < EXT4_MIN_DESC_SIZE_64BIT ||
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4149  		    sbi->s_desc_size > EXT4_MAX_DESC_SIZE ||
d8ea6cf8999100 vignesh babu            2007-10-16  4150  		    !is_power_of_2(sbi->s_desc_size)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4151  			ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4152  			       "unsupported descriptor size %lu",
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4153  			       sbi->s_desc_size);
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4154  			goto failed_mount;
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4155  		}
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4156  	} else
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4157  		sbi->s_desc_size = EXT4_MIN_DESC_SIZE;
0b8e58a140cae2 Andreas Dilger          2009-06-03  4158  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4159  	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4160  	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
0b8e58a140cae2 Andreas Dilger          2009-06-03  4161  
617ba13b31fbf5 Mingming Cao            2006-10-11  4162  	sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4163  	if (sbi->s_inodes_per_block == 0)
617ba13b31fbf5 Mingming Cao            2006-10-11  4164  		goto cantfind_ext4;
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4165  	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4166  	    sbi->s_inodes_per_group > blocksize * 8) {
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4167  		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4168  			 sbi->s_blocks_per_group);
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4169  		goto failed_mount;
cd6bb35bf7f6d7 Theodore Ts'o           2016-11-18  4170  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4171  	sbi->s_itb_per_group = sbi->s_inodes_per_group /
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4172  					sbi->s_inodes_per_block;
0d1ee42f27d30e Alexandre Ratchov       2006-10-11  4173  	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4174  	sbi->s_sbh = bh;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4175  	sbi->s_mount_state = le16_to_cpu(es->s_state);
e57aa839cea138 Fengguang Wu            2007-10-16  4176  	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
e57aa839cea138 Fengguang Wu            2007-10-16  4177  	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
0b8e58a140cae2 Andreas Dilger          2009-06-03  4178  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4179  	for (i = 0; i < 4; i++)
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4180  		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4181  	sbi->s_def_hash_version = es->s_def_hash_version;
e2b911c53584a9 Darrick J. Wong         2015-10-17  4182  	if (ext4_has_feature_dir_index(sb)) {
f99b25897a86fc Theodore Ts'o           2008-10-28  4183  		i = le32_to_cpu(es->s_flags);
f99b25897a86fc Theodore Ts'o           2008-10-28  4184  		if (i & EXT2_FLAGS_UNSIGNED_HASH)
f99b25897a86fc Theodore Ts'o           2008-10-28  4185  			sbi->s_hash_unsigned = 3;
f99b25897a86fc Theodore Ts'o           2008-10-28  4186  		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
f99b25897a86fc Theodore Ts'o           2008-10-28  4187  #ifdef __CHAR_UNSIGNED__
bc98a42c1f7d0f David Howells           2017-07-17  4188  			if (!sb_rdonly(sb))
23301410972330 Theodore Ts'o           2014-02-12  4189  				es->s_flags |=
23301410972330 Theodore Ts'o           2014-02-12  4190  					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
f99b25897a86fc Theodore Ts'o           2008-10-28  4191  			sbi->s_hash_unsigned = 3;
f99b25897a86fc Theodore Ts'o           2008-10-28  4192  #else
bc98a42c1f7d0f David Howells           2017-07-17  4193  			if (!sb_rdonly(sb))
23301410972330 Theodore Ts'o           2014-02-12  4194  				es->s_flags |=
23301410972330 Theodore Ts'o           2014-02-12  4195  					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
f99b25897a86fc Theodore Ts'o           2008-10-28  4196  #endif
f99b25897a86fc Theodore Ts'o           2008-10-28  4197  		}
23301410972330 Theodore Ts'o           2014-02-12  4198  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4199  
281b59959707df Theodore Ts'o           2011-09-09  4200  	/* Handle clustersize */
281b59959707df Theodore Ts'o           2011-09-09  4201  	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
e2b911c53584a9 Darrick J. Wong         2015-10-17  4202  	has_bigalloc = ext4_has_feature_bigalloc(sb);
281b59959707df Theodore Ts'o           2011-09-09  4203  	if (has_bigalloc) {
281b59959707df Theodore Ts'o           2011-09-09  4204  		if (clustersize < blocksize) {
281b59959707df Theodore Ts'o           2011-09-09  4205  			ext4_msg(sb, KERN_ERR,
281b59959707df Theodore Ts'o           2011-09-09  4206  				 "cluster size (%d) smaller than "
281b59959707df Theodore Ts'o           2011-09-09  4207  				 "block size (%d)", clustersize, blocksize);
281b59959707df Theodore Ts'o           2011-09-09  4208  			goto failed_mount;
281b59959707df Theodore Ts'o           2011-09-09  4209  		}
281b59959707df Theodore Ts'o           2011-09-09  4210  		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
281b59959707df Theodore Ts'o           2011-09-09  4211  			le32_to_cpu(es->s_log_block_size);
281b59959707df Theodore Ts'o           2011-09-09  4212  		sbi->s_clusters_per_group =
281b59959707df Theodore Ts'o           2011-09-09  4213  			le32_to_cpu(es->s_clusters_per_group);
281b59959707df Theodore Ts'o           2011-09-09  4214  		if (sbi->s_clusters_per_group > blocksize * 8) {
281b59959707df Theodore Ts'o           2011-09-09  4215  			ext4_msg(sb, KERN_ERR,
281b59959707df Theodore Ts'o           2011-09-09  4216  				 "#clusters per group too big: %lu",
281b59959707df Theodore Ts'o           2011-09-09  4217  				 sbi->s_clusters_per_group);
281b59959707df Theodore Ts'o           2011-09-09  4218  			goto failed_mount;
281b59959707df Theodore Ts'o           2011-09-09  4219  		}
281b59959707df Theodore Ts'o           2011-09-09  4220  		if (sbi->s_blocks_per_group !=
281b59959707df Theodore Ts'o           2011-09-09  4221  		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
281b59959707df Theodore Ts'o           2011-09-09  4222  			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
281b59959707df Theodore Ts'o           2011-09-09  4223  				 "clusters per group (%lu) inconsistent",
281b59959707df Theodore Ts'o           2011-09-09  4224  				 sbi->s_blocks_per_group,
281b59959707df Theodore Ts'o           2011-09-09  4225  				 sbi->s_clusters_per_group);
281b59959707df Theodore Ts'o           2011-09-09  4226  			goto failed_mount;
281b59959707df Theodore Ts'o           2011-09-09  4227  		}
281b59959707df Theodore Ts'o           2011-09-09  4228  	} else {
281b59959707df Theodore Ts'o           2011-09-09  4229  		if (clustersize != blocksize) {
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4230  			ext4_msg(sb, KERN_ERR,
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4231  				 "fragment/cluster size (%d) != "
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4232  				 "block size (%d)", clustersize, blocksize);
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4233  			goto failed_mount;
281b59959707df Theodore Ts'o           2011-09-09  4234  		}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4235  		if (sbi->s_blocks_per_group > blocksize * 8) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4236  			ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4237  				 "#blocks per group too big: %lu",
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4238  				 sbi->s_blocks_per_group);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4239  			goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4240  		}
281b59959707df Theodore Ts'o           2011-09-09  4241  		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
281b59959707df Theodore Ts'o           2011-09-09  4242  		sbi->s_cluster_bits = 0;
281b59959707df Theodore Ts'o           2011-09-09  4243  	}
281b59959707df Theodore Ts'o           2011-09-09  4244  	sbi->s_cluster_ratio = clustersize / blocksize;
281b59959707df Theodore Ts'o           2011-09-09  4245  
960fd856fdc3b0 Theodore Ts'o           2013-07-05  4246  	/* Do we have standard group size of clustersize * 8 blocks ? */
960fd856fdc3b0 Theodore Ts'o           2013-07-05  4247  	if (sbi->s_blocks_per_group == clustersize << 3)
960fd856fdc3b0 Theodore Ts'o           2013-07-05  4248  		set_opt2(sb, STD_GROUP_SIZE);
960fd856fdc3b0 Theodore Ts'o           2013-07-05  4249  
bf43d84b185e2f Eric Sandeen            2009-08-17  4250  	/*
bf43d84b185e2f Eric Sandeen            2009-08-17  4251  	 * Test whether we have more sectors than will fit in sector_t,
bf43d84b185e2f Eric Sandeen            2009-08-17  4252  	 * and whether the max offset is addressable by the page cache.
bf43d84b185e2f Eric Sandeen            2009-08-17  4253  	 */
5a9ae68a349aa0 Darrick J. Wong         2010-11-19  4254  	err = generic_check_addressable(sb->s_blocksize_bits,
30ca22c70e3ef0 Patrick J. LoPresti     2010-07-22  4255  					ext4_blocks_count(es));
5a9ae68a349aa0 Darrick J. Wong         2010-11-19  4256  	if (err) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4257  		ext4_msg(sb, KERN_ERR, "filesystem"
bf43d84b185e2f Eric Sandeen            2009-08-17  4258  			 " too large to mount safely on this system");
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4259  		goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4260  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4261  
617ba13b31fbf5 Mingming Cao            2006-10-11  4262  	if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
617ba13b31fbf5 Mingming Cao            2006-10-11  4263  		goto cantfind_ext4;
e7c95593001cb9 Eric Sandeen            2008-01-28  4264  
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4265  	/* check blocks count against device size */
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4266  	blocks_count = sb->s_bdev->bd_inode->i_size >> sb->s_blocksize_bits;
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4267  	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4268  		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
b31e15527a9bb7 Eric Sandeen            2009-06-04  4269  		       "exceeds size of device (%llu blocks)",
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4270  		       ext4_blocks_count(es), blocks_count);
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4271  		goto failed_mount;
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4272  	}
0f2ddca66d70c8 From: Thiemo Nagel      2009-04-07  4273  
4ec11028137982 Theodore Ts'o           2009-01-06  4274  	/*
4ec11028137982 Theodore Ts'o           2009-01-06  4275  	 * It makes no sense for the first data block to be beyond the end
4ec11028137982 Theodore Ts'o           2009-01-06  4276  	 * of the filesystem.
4ec11028137982 Theodore Ts'o           2009-01-06  4277  	 */
4ec11028137982 Theodore Ts'o           2009-01-06  4278  	if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4279  		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
b31e15527a9bb7 Eric Sandeen            2009-06-04  4280  			 "block %u is beyond end of filesystem (%llu)",
e7c95593001cb9 Eric Sandeen            2008-01-28  4281  			 le32_to_cpu(es->s_first_data_block),
4ec11028137982 Theodore Ts'o           2009-01-06  4282  			 ext4_blocks_count(es));
e7c95593001cb9 Eric Sandeen            2008-01-28  4283  		goto failed_mount;
e7c95593001cb9 Eric Sandeen            2008-01-28  4284  	}
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4285  	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4286  	    (sbi->s_cluster_ratio == 1)) {
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4287  		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4288  			 "block is 0 with a 1k block and cluster size");
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4289  		goto failed_mount;
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4290  	}
bfe0a5f47ada40 Theodore Ts'o           2018-06-17  4291  
bd81d8eec04309 Laurent Vivier          2006-10-11  4292  	blocks_count = (ext4_blocks_count(es) -
bd81d8eec04309 Laurent Vivier          2006-10-11  4293  			le32_to_cpu(es->s_first_data_block) +
bd81d8eec04309 Laurent Vivier          2006-10-11  4294  			EXT4_BLOCKS_PER_GROUP(sb) - 1);
bd81d8eec04309 Laurent Vivier          2006-10-11  4295  	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
4ec11028137982 Theodore Ts'o           2009-01-06  4296  	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04 @4297  		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
4ec11028137982 Theodore Ts'o           2009-01-06  4298  		       "(block count %llu, first data block %u, "
871ff0cd66878b Josh Triplett           2020-03-28  4299  		       "blocks per group %lu)", blocks_count,
4ec11028137982 Theodore Ts'o           2009-01-06  4300  		       ext4_blocks_count(es),
4ec11028137982 Theodore Ts'o           2009-01-06  4301  		       le32_to_cpu(es->s_first_data_block),
4ec11028137982 Theodore Ts'o           2009-01-06  4302  		       EXT4_BLOCKS_PER_GROUP(sb));
4ec11028137982 Theodore Ts'o           2009-01-06  4303  		goto failed_mount;
4ec11028137982 Theodore Ts'o           2009-01-06  4304  	}
bd81d8eec04309 Laurent Vivier          2006-10-11  4305  	sbi->s_groups_count = blocks_count;
fb0a387dcdcd21 Eric Sandeen            2009-09-16  4306  	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
fb0a387dcdcd21 Eric Sandeen            2009-09-16  4307  			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
9e463084cdb22e Theodore Ts'o           2018-11-07  4308  	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
9e463084cdb22e Theodore Ts'o           2018-11-07  4309  	    le32_to_cpu(es->s_inodes_count)) {
9e463084cdb22e Theodore Ts'o           2018-11-07  4310  		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
9e463084cdb22e Theodore Ts'o           2018-11-07  4311  			 le32_to_cpu(es->s_inodes_count),
9e463084cdb22e Theodore Ts'o           2018-11-07  4312  			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
9e463084cdb22e Theodore Ts'o           2018-11-07  4313  		ret = -EINVAL;
9e463084cdb22e Theodore Ts'o           2018-11-07  4314  		goto failed_mount;
9e463084cdb22e Theodore Ts'o           2018-11-07  4315  	}
617ba13b31fbf5 Mingming Cao            2006-10-11  4316  	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
617ba13b31fbf5 Mingming Cao            2006-10-11  4317  		   EXT4_DESC_PER_BLOCK(sb);
3a4b77cd47bb83 Eryu Guan               2016-12-01  4318  	if (ext4_has_feature_meta_bg(sb)) {
2ba3e6e8afc9b6 Theodore Ts'o           2017-02-15  4319  		if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
3a4b77cd47bb83 Eryu Guan               2016-12-01  4320  			ext4_msg(sb, KERN_WARNING,
3a4b77cd47bb83 Eryu Guan               2016-12-01  4321  				 "first meta block group too large: %u "
3a4b77cd47bb83 Eryu Guan               2016-12-01  4322  				 "(group descriptor block count %u)",
3a4b77cd47bb83 Eryu Guan               2016-12-01  4323  				 le32_to_cpu(es->s_first_meta_bg), db_count);
3a4b77cd47bb83 Eryu Guan               2016-12-01  4324  			goto failed_mount;
3a4b77cd47bb83 Eryu Guan               2016-12-01  4325  		}
3a4b77cd47bb83 Eryu Guan               2016-12-01  4326  	}
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4327  	rcu_assign_pointer(sbi->s_group_desc,
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4328  			   kvmalloc_array(db_count,
f18a5f21c25707 Theodore Ts'o           2011-08-01  4329  					  sizeof(struct buffer_head *),
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4330  					  GFP_KERNEL));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4331  	if (sbi->s_group_desc == NULL) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4332  		ext4_msg(sb, KERN_ERR, "not enough memory");
2cde417de013b2 Theodore Ts'o           2012-05-28  4333  		ret = -ENOMEM;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4334  		goto failed_mount;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4335  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4336  
705895b61133ef Pekka Enberg            2009-02-15  4337  	bgl_lock_init(sbi->s_blockgroup_lock);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4338  
85c8f176a6111e Andrew Perepechko       2017-04-30  4339  	/* Pre-read the descriptors into the buffer cache */
85c8f176a6111e Andrew Perepechko       2017-04-30  4340  	for (i = 0; i < db_count; i++) {
85c8f176a6111e Andrew Perepechko       2017-04-30  4341  		block = descriptor_loc(sb, logical_sb_block, i);
85c8f176a6111e Andrew Perepechko       2017-04-30  4342  		sb_breadahead(sb, block);
85c8f176a6111e Andrew Perepechko       2017-04-30  4343  	}
85c8f176a6111e Andrew Perepechko       2017-04-30  4344  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4345  	for (i = 0; i < db_count; i++) {
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4346  		struct buffer_head *bh;
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4347  
70bbb3e0a07c1f Andrew Morton           2006-10-11  4348  		block = descriptor_loc(sb, logical_sb_block, i);
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4349  		bh = sb_bread_unmovable(sb, block);
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4350  		if (!bh) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4351  			ext4_msg(sb, KERN_ERR,
b31e15527a9bb7 Eric Sandeen            2009-06-04  4352  			       "can't read group descriptor %d", i);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4353  			db_count = i;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4354  			goto failed_mount2;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4355  		}
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4356  		rcu_read_lock();
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4357  		rcu_dereference(sbi->s_group_desc)[i] = bh;
1d0c3924a92e69 Theodore Ts'o           2020-02-15  4358  		rcu_read_unlock();
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4359  	}
44de022c438254 Theodore Ts'o           2018-07-08  4360  	sbi->s_gdb_count = db_count;
829fa70dddadf9 Theodore Ts'o           2016-08-01  4361  	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4362  		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
6a797d27378389 Darrick J. Wong         2015-10-17  4363  		ret = -EFSCORRUPTED;
f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  4364  		goto failed_mount2;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4365  	}
772cb7c83ba256 Jose R. Santos          2008-07-11  4366  
235699a8f457ed Kees Cook               2017-10-18  4367  	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
0449641130f565 Tao Ma                  2011-04-05  4368  
a75ae78f087f93 Dmitry Monakhov         2013-04-03  4369  	/* Register extent status tree shrinker */
eb68d0e2fc5a4e Zheng Liu               2014-09-01  4370  	if (ext4_es_register_shrinker(sbi))
ce7e010aef63dc Theodore Ts'o           2010-11-03  4371  		goto failed_mount3;
ce7e010aef63dc Theodore Ts'o           2010-11-03  4372  
c9de560ded61fa Alex Tomas              2008-01-29  4373  	sbi->s_stripe = ext4_get_stripe_size(sbi);
67a5da564f97f3 Zheng Liu               2012-08-17  4374  	sbi->s_extent_max_zeroout_kb = 32;
c9de560ded61fa Alex Tomas              2008-01-29  4375  
f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  4376  	/*
f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  4377  	 * set up enough so that it can read an inode
f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  4378  	 */
f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  4379  	sb->s_op = &ext4_sops;
617ba13b31fbf5 Mingming Cao            2006-10-11  4380  	sb->s_export_op = &ext4_export_ops;
617ba13b31fbf5 Mingming Cao            2006-10-11  4381  	sb->s_xattr = ext4_xattr_handlers;
643fa9612bf1a2 Chandan Rajendra        2018-12-12  4382  #ifdef CONFIG_FS_ENCRYPTION
a7550b30ab709f Jaegeuk Kim             2016-07-10  4383  	sb->s_cop = &ext4_cryptops;
ffcc41829ae043 Eric Biggers            2017-10-09  4384  #endif
c93d8f88580921 Eric Biggers            2019-07-22  4385  #ifdef CONFIG_FS_VERITY
c93d8f88580921 Eric Biggers            2019-07-22  4386  	sb->s_vop = &ext4_verityops;
c93d8f88580921 Eric Biggers            2019-07-22  4387  #endif
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4388  #ifdef CONFIG_QUOTA
617ba13b31fbf5 Mingming Cao            2006-10-11  4389  	sb->dq_op = &ext4_quota_operations;
e2b911c53584a9 Darrick J. Wong         2015-10-17  4390  	if (ext4_has_feature_quota(sb))
1fa5efe3622db5 Jan Kara                2014-10-08  4391  		sb->s_qcop = &dquot_quotactl_sysfile_ops;
262b4662f42787 Jan Kara                2013-03-02  4392  	else
262b4662f42787 Jan Kara                2013-03-02  4393  		sb->s_qcop = &ext4_qctl_operations;
689c958cbe6be4 Li Xi                   2016-01-08  4394  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4395  #endif
85787090a21eb7 Christoph Hellwig       2017-05-10  4396  	memcpy(&sb->s_uuid, es->s_uuid, sizeof(es->s_uuid));
f2fa2ffc2046fd Aneesh Kumar K.V        2011-01-29  4397  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4398  	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
3b9d4ed2668077 Theodore Ts'o           2009-04-25  4399  	mutex_init(&sbi->s_orphan_lock);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4400  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4401  	sb->s_root = NULL;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4402  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4403  	needs_recovery = (es->s_last_orphan != 0 ||
e2b911c53584a9 Darrick J. Wong         2015-10-17  4404  			  ext4_has_feature_journal_needs_recovery(sb));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4405  
bc98a42c1f7d0f David Howells           2017-07-17  4406  	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
c5e06d101aaf72 Johann Lombardi         2011-05-24  4407  		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
50460fe8c6d1d9 Darrick J. Wong         2014-10-30  4408  			goto failed_mount3a;
c5e06d101aaf72 Johann Lombardi         2011-05-24  4409  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4410  	/*
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4411  	 * The first inode we look at is the journal inode.  Don't try
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4412  	 * root first: it may be modified in the journal!
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4413  	 */
e2b911c53584a9 Darrick J. Wong         2015-10-17  4414  	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
4753d8a24d4588 Theodore Ts'o           2017-02-05  4415  		err = ext4_load_journal(sb, es, journal_devnum);
4753d8a24d4588 Theodore Ts'o           2017-02-05  4416  		if (err)
50460fe8c6d1d9 Darrick J. Wong         2014-10-30  4417  			goto failed_mount3a;
bc98a42c1f7d0f David Howells           2017-07-17  4418  	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
e2b911c53584a9 Darrick J. Wong         2015-10-17  4419  		   ext4_has_feature_journal_needs_recovery(sb)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4420  		ext4_msg(sb, KERN_ERR, "required journal recovery "
b31e15527a9bb7 Eric Sandeen            2009-06-04  4421  		       "suppressed and not mounted read-only");
744692dc059845 Jiaying Zhang           2010-03-04  4422  		goto failed_mount_wq;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4423  	} else {
1e381f60dad913 Dmitry Monakhov         2015-10-18  4424  		/* Nojournal mode, all journal mount options are illegal */
1e381f60dad913 Dmitry Monakhov         2015-10-18  4425  		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
1e381f60dad913 Dmitry Monakhov         2015-10-18  4426  			ext4_msg(sb, KERN_ERR, "can't mount with "
1e381f60dad913 Dmitry Monakhov         2015-10-18  4427  				 "journal_checksum, fs mounted w/o journal");
1e381f60dad913 Dmitry Monakhov         2015-10-18  4428  			goto failed_mount_wq;
1e381f60dad913 Dmitry Monakhov         2015-10-18  4429  		}
1e381f60dad913 Dmitry Monakhov         2015-10-18  4430  		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
1e381f60dad913 Dmitry Monakhov         2015-10-18  4431  			ext4_msg(sb, KERN_ERR, "can't mount with "
1e381f60dad913 Dmitry Monakhov         2015-10-18  4432  				 "journal_async_commit, fs mounted w/o journal");
1e381f60dad913 Dmitry Monakhov         2015-10-18  4433  			goto failed_mount_wq;
1e381f60dad913 Dmitry Monakhov         2015-10-18  4434  		}
1e381f60dad913 Dmitry Monakhov         2015-10-18  4435  		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
1e381f60dad913 Dmitry Monakhov         2015-10-18  4436  			ext4_msg(sb, KERN_ERR, "can't mount with "
1e381f60dad913 Dmitry Monakhov         2015-10-18  4437  				 "commit=%lu, fs mounted w/o journal",
1e381f60dad913 Dmitry Monakhov         2015-10-18  4438  				 sbi->s_commit_interval / HZ);
1e381f60dad913 Dmitry Monakhov         2015-10-18  4439  			goto failed_mount_wq;
1e381f60dad913 Dmitry Monakhov         2015-10-18  4440  		}
1e381f60dad913 Dmitry Monakhov         2015-10-18  4441  		if (EXT4_MOUNT_DATA_FLAGS &
1e381f60dad913 Dmitry Monakhov         2015-10-18  4442  		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
1e381f60dad913 Dmitry Monakhov         2015-10-18  4443  			ext4_msg(sb, KERN_ERR, "can't mount with "
1e381f60dad913 Dmitry Monakhov         2015-10-18  4444  				 "data=, fs mounted w/o journal");
1e381f60dad913 Dmitry Monakhov         2015-10-18  4445  			goto failed_mount_wq;
1e381f60dad913 Dmitry Monakhov         2015-10-18  4446  		}
50b29d8f033a7c Debabrata Banerjee      2019-04-30  4447  		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
1e381f60dad913 Dmitry Monakhov         2015-10-18  4448  		clear_opt(sb, JOURNAL_CHECKSUM);
fd8c37eccdda21 Theodore Ts'o           2010-12-15  4449  		clear_opt(sb, DATA_FLAGS);
0390131ba84fd3 Frank Mayhar            2009-01-07  4450  		sbi->s_journal = NULL;
0390131ba84fd3 Frank Mayhar            2009-01-07  4451  		needs_recovery = 0;
0390131ba84fd3 Frank Mayhar            2009-01-07  4452  		goto no_journal;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4453  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4454  
e2b911c53584a9 Darrick J. Wong         2015-10-17  4455  	if (ext4_has_feature_64bit(sb) &&
eb40a09c679d7f Jose R. Santos          2007-07-18  4456  	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
eb40a09c679d7f Jose R. Santos          2007-07-18  4457  				       JBD2_FEATURE_INCOMPAT_64BIT)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4458  		ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
744692dc059845 Jiaying Zhang           2010-03-04  4459  		goto failed_mount_wq;
eb40a09c679d7f Jose R. Santos          2007-07-18  4460  	}
eb40a09c679d7f Jose R. Santos          2007-07-18  4461  
25ed6e8a54df90 Darrick J. Wong         2012-05-27  4462  	if (!set_journal_csum_feature_set(sb)) {
25ed6e8a54df90 Darrick J. Wong         2012-05-27  4463  		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
25ed6e8a54df90 Darrick J. Wong         2012-05-27  4464  			 "feature set");
25ed6e8a54df90 Darrick J. Wong         2012-05-27  4465  		goto failed_mount_wq;
d4da6c9ccf648f Linus Torvalds          2009-11-02  4466  	}
818d276ceb83aa Girish Shilamkar        2008-01-28  4467  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4468  	/* We have now updated the journal if required, so we can
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4469  	 * validate the data journaling mode. */
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4470  	switch (test_opt(sb, DATA_FLAGS)) {
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4471  	case 0:
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4472  		/* No mode set, assume a default based on the journal
63f5793351d821 Andrew Morton           2006-10-11  4473  		 * capabilities: ORDERED_DATA if the journal can
63f5793351d821 Andrew Morton           2006-10-11  4474  		 * cope, else JOURNAL_DATA
63f5793351d821 Andrew Morton           2006-10-11  4475  		 */
dab291af8d6307 Mingming Cao            2006-10-11  4476  		if (jbd2_journal_check_available_features
27f394a7718d00 Tyson Nottingham        2018-03-30  4477  		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
fd8c37eccdda21 Theodore Ts'o           2010-12-15  4478  			set_opt(sb, ORDERED_DATA);
27f394a7718d00 Tyson Nottingham        2018-03-30  4479  			sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
27f394a7718d00 Tyson Nottingham        2018-03-30  4480  		} else {
fd8c37eccdda21 Theodore Ts'o           2010-12-15  4481  			set_opt(sb, JOURNAL_DATA);
27f394a7718d00 Tyson Nottingham        2018-03-30  4482  			sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
27f394a7718d00 Tyson Nottingham        2018-03-30  4483  		}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4484  		break;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4485  
617ba13b31fbf5 Mingming Cao            2006-10-11  4486  	case EXT4_MOUNT_ORDERED_DATA:
617ba13b31fbf5 Mingming Cao            2006-10-11  4487  	case EXT4_MOUNT_WRITEBACK_DATA:
dab291af8d6307 Mingming Cao            2006-10-11  4488  		if (!jbd2_journal_check_available_features
dab291af8d6307 Mingming Cao            2006-10-11  4489  		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4490  			ext4_msg(sb, KERN_ERR, "Journal does not support "
b31e15527a9bb7 Eric Sandeen            2009-06-04  4491  			       "requested data journaling mode");
744692dc059845 Jiaying Zhang           2010-03-04  4492  			goto failed_mount_wq;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4493  		}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4494  	default:
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4495  		break;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4496  	}
ab04df78181b27 Jan Kara                2016-12-03  4497  
ab04df78181b27 Jan Kara                2016-12-03  4498  	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
ab04df78181b27 Jan Kara                2016-12-03  4499  	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
ab04df78181b27 Jan Kara                2016-12-03  4500  		ext4_msg(sb, KERN_ERR, "can't mount with "
ab04df78181b27 Jan Kara                2016-12-03  4501  			"journal_async_commit in data=ordered mode");
ab04df78181b27 Jan Kara                2016-12-03  4502  		goto failed_mount_wq;
ab04df78181b27 Jan Kara                2016-12-03  4503  	}
ab04df78181b27 Jan Kara                2016-12-03  4504  
b3881f74b31b7d Theodore Ts'o           2009-01-05  4505  	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4506  
18aadd47f88464 Bobi Jam                2012-02-20  4507  	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
18aadd47f88464 Bobi Jam                2012-02-20  4508  
ce7e010aef63dc Theodore Ts'o           2010-11-03  4509  no_journal:
cdb7ee4c632759 Tahsin Erdogan          2017-06-22  4510  	if (!test_opt(sb, NO_MBCACHE)) {
47387409ee2e09 Tahsin Erdogan          2017-06-22  4511  		sbi->s_ea_block_cache = ext4_xattr_create_cache();
47387409ee2e09 Tahsin Erdogan          2017-06-22  4512  		if (!sbi->s_ea_block_cache) {
cdb7ee4c632759 Tahsin Erdogan          2017-06-22  4513  			ext4_msg(sb, KERN_ERR,
cdb7ee4c632759 Tahsin Erdogan          2017-06-22  4514  				 "Failed to create ea_block_cache");
9c191f701ce9f9 T Makphaibulchoke       2014-03-18  4515  			goto failed_mount_wq;
9c191f701ce9f9 T Makphaibulchoke       2014-03-18  4516  		}
9c191f701ce9f9 T Makphaibulchoke       2014-03-18  4517  
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4518  		if (ext4_has_feature_ea_inode(sb)) {
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4519  			sbi->s_ea_inode_cache = ext4_xattr_create_cache();
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4520  			if (!sbi->s_ea_inode_cache) {
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4521  				ext4_msg(sb, KERN_ERR,
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4522  					 "Failed to create ea_inode_cache");
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4523  				goto failed_mount_wq;
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4524  			}
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4525  		}
cdb7ee4c632759 Tahsin Erdogan          2017-06-22  4526  	}
dec214d00e0d78 Tahsin Erdogan          2017-06-22  4527  
c93d8f88580921 Eric Biggers            2019-07-22  4528  	if (ext4_has_feature_verity(sb) && blocksize != PAGE_SIZE) {
c93d8f88580921 Eric Biggers            2019-07-22  4529  		ext4_msg(sb, KERN_ERR, "Unsupported blocksize for fs-verity");
c93d8f88580921 Eric Biggers            2019-07-22  4530  		goto failed_mount_wq;
c93d8f88580921 Eric Biggers            2019-07-22  4531  	}
c93d8f88580921 Eric Biggers            2019-07-22  4532  
bc98a42c1f7d0f David Howells           2017-07-17  4533  	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
e2b911c53584a9 Darrick J. Wong         2015-10-17  4534  	    !ext4_has_feature_encrypt(sb)) {
e2b911c53584a9 Darrick J. Wong         2015-10-17  4535  		ext4_set_feature_encrypt(sb);
6ddb2447846a8e Theodore Ts'o           2015-04-16  4536  		ext4_commit_super(sb, 1);
6ddb2447846a8e Theodore Ts'o           2015-04-16  4537  	}
6ddb2447846a8e Theodore Ts'o           2015-04-16  4538  
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4539  	/*
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4540  	 * Get the # of file system overhead blocks from the
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4541  	 * superblock if present.
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4542  	 */
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4543  	if (es->s_overhead_clusters)
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4544  		sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4545  	else {
07aa2ea13814ea Lukas Czerner           2012-11-08  4546  		err = ext4_calculate_overhead(sb);
07aa2ea13814ea Lukas Czerner           2012-11-08  4547  		if (err)
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4548  			goto failed_mount_wq;
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4549  	}
952fc18ef9ec70 Theodore Ts'o           2012-07-09  4550  
fd89d5f2030ac8 Tejun Heo               2011-02-01  4551  	/*
fd89d5f2030ac8 Tejun Heo               2011-02-01  4552  	 * The maximum number of concurrent works can be high and
fd89d5f2030ac8 Tejun Heo               2011-02-01  4553  	 * concurrency isn't really necessary.  Limit it to 1.
fd89d5f2030ac8 Tejun Heo               2011-02-01  4554  	 */
2e8fa54e3b48e4 Jan Kara                2013-06-04  4555  	EXT4_SB(sb)->rsv_conversion_wq =
2e8fa54e3b48e4 Jan Kara                2013-06-04  4556  		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
2e8fa54e3b48e4 Jan Kara                2013-06-04  4557  	if (!EXT4_SB(sb)->rsv_conversion_wq) {
2e8fa54e3b48e4 Jan Kara                2013-06-04  4558  		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
07aa2ea13814ea Lukas Czerner           2012-11-08  4559  		ret = -ENOMEM;
2e8fa54e3b48e4 Jan Kara                2013-06-04  4560  		goto failed_mount4;
2e8fa54e3b48e4 Jan Kara                2013-06-04  4561  	}
2e8fa54e3b48e4 Jan Kara                2013-06-04  4562  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4563  	/*
dab291af8d6307 Mingming Cao            2006-10-11  4564  	 * The jbd2_journal_load will have done any necessary log recovery,
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4565  	 * so we can safely mount the rest of the filesystem now.
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4566  	 */
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4567  
8a363970d1dc38 Theodore Ts'o           2018-12-19  4568  	root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
1d1fe1ee02b9ac David Howells           2008-02-07  4569  	if (IS_ERR(root)) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4570  		ext4_msg(sb, KERN_ERR, "get root inode failed");
1d1fe1ee02b9ac David Howells           2008-02-07  4571  		ret = PTR_ERR(root);
32a9bb57d7c1fd Manish Katiyar          2011-02-27  4572  		root = NULL;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4573  		goto failed_mount4;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4574  	}
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4575  	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
b31e15527a9bb7 Eric Sandeen            2009-06-04  4576  		ext4_msg(sb, KERN_ERR, "corrupt root inode, run e2fsck");
94bf608a18fa44 Al Viro                 2012-01-09  4577  		iput(root);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4578  		goto failed_mount4;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  4579  	}
b886ee3e778ec2 Gabriel Krisman Bertazi 2019-04-25  4580  

:::::: The code at line 4297 was first introduced by commit
:::::: b31e15527a9bb71b6a11a425d17ce139a62f5af5 ext4: Change all super.c messages to print the device

:::::: TO: Eric Sandeen <sandeen@redhat.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wPQ8y7Rx7v8Am7S2VLW8AAA=

--tThc/1wpZn/ma/RB--
