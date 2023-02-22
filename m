Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829E669F777
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBVPON (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 10:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjBVPON (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 10:14:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD5125E34;
        Wed, 22 Feb 2023 07:14:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so6596617wms.1;
        Wed, 22 Feb 2023 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkaxeYhyJCWKI+iCl7pvg7H2rt01JeowCIL7n4FAO0Q=;
        b=AguK+BWlwz3zrXlQyvM2aiRghQwbl5dyMcNVkMjmecRjnOHdoL/QIXr8OoqFTLfalY
         1VYfvve8fefZrlGO0rouPRQvXyLe6W/NjA0tw+n4/mzrLrm5lNfBj6x2ar8wQ+A3OMHH
         XOcSNMryFp336zqTbVWuFoGBX6DzK93mkUmUW37CUiVLbYP7uyAdo+03E/J6bblXQECk
         oH4E/x7eDThJkimkOtww0d6EpQcxg/MiBxVq2hxMB1/M1hO3pRctDinIuYPlIuskNPTd
         cNZdX5Y75u+w+UfexlvZv64fxvshX4zwFliJWpxXVmRaqgC0wQD++h7g7TMJvPw8UbUk
         EPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkaxeYhyJCWKI+iCl7pvg7H2rt01JeowCIL7n4FAO0Q=;
        b=GFL+d6J2tQGM6K036nrKc9i25EiGumTKgxkIe1A+LAxipP4u1LS5apgL6VB2QX6WGZ
         p0E3gkGMpiX3aWco4Ucd4GXD7X1ETl28O2cqRNriIyrKDjY64mGdDG5QJLKQacBJStk+
         5dPbpNv8j4rv0XmziFPEwJNj3ScvAOhfzoNLVUN2iPXoV8t9+K/eNdFr8NtyYJxyLDSp
         U85qAIb2baArLr5N6EEKfHMi42kZjZ49ihm+zXx6Qm4+98yN6CGXjHOVztv5mXPTfANr
         3tzhFAG7MWukp1ekx5she9PScjvNBEGiM8bC7D7CseE2Ky1phLbmttyNIzfFfJoAKGbq
         KZ4g==
X-Gm-Message-State: AO0yUKWeTurtx4zBBFWj1i/gI5e69W9iXLiWlqh1fDarGZ9HIoy0Aj8G
        ooGBCFd8YN1Z6HRn9qrrD7o=
X-Google-Smtp-Source: AK7set+ltF+ZntzbSmcyHqL7HMnw2q2Vf54UvAMiQB932c0IKSyLIFdRxk3wK9yrEfB8UMHAmDWDaQ==
X-Received: by 2002:a05:600c:755:b0:3dc:59ee:7978 with SMTP id j21-20020a05600c075500b003dc59ee7978mr6944055wmn.38.1677078841354;
        Wed, 22 Feb 2023 07:14:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c42c700b003db012d49b7sm2630173wme.2.2023.02.22.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:14:00 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:13:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH 7/7] ext4: improve inode table blocks counting in
 ext4_num_overhead_clusters
Message-ID: <202302222219.u328sqfs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221115919.1918161-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Kemeng,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-properly-handle-error-of-ext4_init_block_bitmap-in-ext4_read_block_bitmap_nowait/20230221-115830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230221115919.1918161-8-shikemeng%40huaweicloud.com
patch subject: [PATCH 7/7] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
config: riscv-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230222/202302222219.u328sqfs-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302222219.u328sqfs-lkp@intel.com/

New smatch warnings:
fs/ext4/balloc.c:153 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.

vim +/block_cluster +153 fs/ext4/balloc.c

c197855ea14175 Stephen Hemminger 2014-05-12   87  static unsigned ext4_num_overhead_clusters(struct super_block *sb,
e187c6588d6ef3 Theodore Ts'o     2009-02-06   88  					   ext4_group_t block_group,
e187c6588d6ef3 Theodore Ts'o     2009-02-06   89  					   struct ext4_group_desc *gdp)
0bf7e8379ce7e0 Jose R. Santos    2008-06-03   90  {
2b59a2fd93873a Kemeng Shi        2023-02-21   91  	unsigned base_clusters, num_clusters;
2b59a2fd93873a Kemeng Shi        2023-02-21   92  	int block_cluster, inode_cluster;
2b59a2fd93873a Kemeng Shi        2023-02-21   93  	int itbl_cluster_start = -1, itbl_cluster_end = -1;
d5b8f31007a937 Theodore Ts'o     2011-09-09   94  	ext4_fsblk_t start = ext4_group_first_block_no(sb, block_group);
2b59a2fd93873a Kemeng Shi        2023-02-21   95  	ext4_fsblk_t end = start + EXT4_BLOCKS_PER_GROUP(sb) - 1;
2b59a2fd93873a Kemeng Shi        2023-02-21   96  	ext4_fsblk_t itbl_blk_start, itbl_blk_end;
0bf7e8379ce7e0 Jose R. Santos    2008-06-03   97  	struct ext4_sb_info *sbi = EXT4_SB(sb);
0bf7e8379ce7e0 Jose R. Santos    2008-06-03   98  
d5b8f31007a937 Theodore Ts'o     2011-09-09   99  	/* This is the number of clusters used by the superblock,
d5b8f31007a937 Theodore Ts'o     2011-09-09  100  	 * block group descriptors, and reserved block group
d5b8f31007a937 Theodore Ts'o     2011-09-09  101  	 * descriptor blocks */
2b59a2fd93873a Kemeng Shi        2023-02-21  102  	base_clusters = ext4_num_base_meta_clusters(sb, block_group);
2b59a2fd93873a Kemeng Shi        2023-02-21  103  	num_clusters = base_clusters;
2b59a2fd93873a Kemeng Shi        2023-02-21  104  
2b59a2fd93873a Kemeng Shi        2023-02-21  105  	/*
2b59a2fd93873a Kemeng Shi        2023-02-21  106  	 * Account and record inode table clusters if any cluster
2b59a2fd93873a Kemeng Shi        2023-02-21  107  	 * is in the block group, or inode table cluster range is
2b59a2fd93873a Kemeng Shi        2023-02-21  108  	 * [-1, -1] and won't overlap with block/inode bitmap cluster
2b59a2fd93873a Kemeng Shi        2023-02-21  109  	 * accounted below.
2b59a2fd93873a Kemeng Shi        2023-02-21  110  	 */
2b59a2fd93873a Kemeng Shi        2023-02-21  111  	itbl_blk_start = ext4_inode_table(sb, gdp);
2b59a2fd93873a Kemeng Shi        2023-02-21  112  	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
2b59a2fd93873a Kemeng Shi        2023-02-21  113  	if (itbl_blk_start <= end && itbl_blk_end >= start) {
2b59a2fd93873a Kemeng Shi        2023-02-21  114  		itbl_blk_start = itbl_blk_start >= start ?
2b59a2fd93873a Kemeng Shi        2023-02-21  115  			itbl_blk_start : start;
2b59a2fd93873a Kemeng Shi        2023-02-21  116  		itbl_blk_end = itbl_blk_end <= end ?
2b59a2fd93873a Kemeng Shi        2023-02-21  117  			itbl_blk_end : end;
2b59a2fd93873a Kemeng Shi        2023-02-21  118  
2b59a2fd93873a Kemeng Shi        2023-02-21  119  		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
2b59a2fd93873a Kemeng Shi        2023-02-21  120  		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
2b59a2fd93873a Kemeng Shi        2023-02-21  121  
2b59a2fd93873a Kemeng Shi        2023-02-21  122  		num_clusters += itbl_cluster_end - itbl_cluster_start + 1;
2b59a2fd93873a Kemeng Shi        2023-02-21  123  		/* check if border cluster is overlapped */
2b59a2fd93873a Kemeng Shi        2023-02-21  124  		if (itbl_cluster_start == base_clusters - 1)
2b59a2fd93873a Kemeng Shi        2023-02-21  125  			num_clusters--;
2b59a2fd93873a Kemeng Shi        2023-02-21  126  	}
0bf7e8379ce7e0 Jose R. Santos    2008-06-03  127  
d5b8f31007a937 Theodore Ts'o     2011-09-09  128  	/*
2b59a2fd93873a Kemeng Shi        2023-02-21  129  	 * For the allocation bitmaps, we first need to check to see
2b59a2fd93873a Kemeng Shi        2023-02-21  130  	 * if the block is in the block group.  If it is, then check
2b59a2fd93873a Kemeng Shi        2023-02-21  131  	 * to see if the cluster is already accounted for in the clusters
2b59a2fd93873a Kemeng Shi        2023-02-21  132  	 * used for the base metadata cluster and inode tables cluster.
d5b8f31007a937 Theodore Ts'o     2011-09-09  133  	 * Normally all of these blocks are contiguous, so the special
d5b8f31007a937 Theodore Ts'o     2011-09-09  134  	 * case handling shouldn't be necessary except for *very*
d5b8f31007a937 Theodore Ts'o     2011-09-09  135  	 * unusual file system layouts.
d5b8f31007a937 Theodore Ts'o     2011-09-09  136  	 */
d5b8f31007a937 Theodore Ts'o     2011-09-09  137  	if (ext4_block_in_group(sb, ext4_block_bitmap(sb, gdp), block_group)) {
b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  138  		block_cluster = EXT4_B2C(sbi,
b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  139  					 ext4_block_bitmap(sb, gdp) - start);
2b59a2fd93873a Kemeng Shi        2023-02-21  140  		if (block_cluster >= base_clusters &&
2b59a2fd93873a Kemeng Shi        2023-02-21  141  		    (block_cluster < itbl_cluster_start ||
2b59a2fd93873a Kemeng Shi        2023-02-21  142  		    block_cluster > itbl_cluster_end))
d5b8f31007a937 Theodore Ts'o     2011-09-09  143  			num_clusters++;
d5b8f31007a937 Theodore Ts'o     2011-09-09  144  	}
d5b8f31007a937 Theodore Ts'o     2011-09-09  145  
d5b8f31007a937 Theodore Ts'o     2011-09-09  146  	if (ext4_block_in_group(sb, ext4_inode_bitmap(sb, gdp), block_group)) {

These two conditions are exactly the same so I don't see why they can't
be combined into one condition.  I have read the comment, but I guess I
don't understand ext4 well enough to really understand it.

d5b8f31007a937 Theodore Ts'o     2011-09-09  147  		inode_cluster = EXT4_B2C(sbi,
b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  148  					 ext4_inode_bitmap(sb, gdp) - start);
2b59a2fd93873a Kemeng Shi        2023-02-21  149  		/*
2b59a2fd93873a Kemeng Shi        2023-02-21  150  		 * Additional check if inode bitmap is in just accounted
2b59a2fd93873a Kemeng Shi        2023-02-21  151  		 * block_cluster
2b59a2fd93873a Kemeng Shi        2023-02-21  152  		 */
2b59a2fd93873a Kemeng Shi        2023-02-21 @153  		if (inode_cluster != block_cluster &&

So this seems like a false positive to me.  But the code is puzzling for
a human or for a static checker.

2b59a2fd93873a Kemeng Shi        2023-02-21  154  		    inode_cluster >= base_clusters &&
2b59a2fd93873a Kemeng Shi        2023-02-21  155  		    (inode_cluster < itbl_cluster_start ||
2b59a2fd93873a Kemeng Shi        2023-02-21  156  		    inode_cluster > itbl_cluster_end))
d5b8f31007a937 Theodore Ts'o     2011-09-09  157  			num_clusters++;
0bf7e8379ce7e0 Jose R. Santos    2008-06-03  158  	}
d5b8f31007a937 Theodore Ts'o     2011-09-09  159  
d5b8f31007a937 Theodore Ts'o     2011-09-09  160  	return num_clusters;
0bf7e8379ce7e0 Jose R. Santos    2008-06-03  161  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

