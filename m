Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229816BF883
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCRHns (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Mar 2023 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCRHnr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Mar 2023 03:43:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA7975D
        for <linux-ext4@vger.kernel.org>; Sat, 18 Mar 2023 00:43:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso4050149wms.1
        for <linux-ext4@vger.kernel.org>; Sat, 18 Mar 2023 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679125418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/2WZTvOIngdjOKJgPvf13lVmCmjnUXMQ8Ott2W4iUA=;
        b=T056L/dEuIAcdbyAOAUMiexYvhiIz9zUVBYBuKCC0hZ+6hfCorZTBo7BTQCEa7CSHH
         5B1YiKI+CP7Ns9Paz3S4hWIfBkhbRSNBYJFr5BSOliNVakjcYlWK3SPo3l1L1S2eyLo2
         1dtSmHfMYZ+jt8xBtechM9+V1rCZCtH2M6wEl335xtlrDhCl/2IybY5CdjoHDIrWuOrE
         b99bbprZ80kPfpt01L0G2VdDNZ/xeme92P0uBTxwm5mozsPQBbZzmL6TdP22pYY2wAx9
         GABfLKsjS+U70dpYBzi1tXj1u0O5km7q6jAi9maARh7nxYzCAjAcY1aEa4pk1gUEMrJt
         Hd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/2WZTvOIngdjOKJgPvf13lVmCmjnUXMQ8Ott2W4iUA=;
        b=AlAsUIoSfjt8p0Gm/mC3aCzRDKq+WjWQ3WsmxI/mz6lfYYFLC5HSr/+WgG7nzaQst3
         Qz9iwrfrJsj7xbpzhZPiglOsxqDbn3BSzMr09kQtenQfOPcGpqKmqoggh3gqEH1JXTvt
         UsCSu/vphld4J7sPea27PKux/6nplC3km8VMAgKdI3cbItnDTciClGi17GW1iaLMod9x
         kRXpBN5xvBSRV43sqcbV2QugkCqlbe/aCvX/SNgN8+biNh/flp1yrvqb57l5Una0fumF
         Qe4mfaGpPtomuhW7koM9zm0C+4XSGar723z3xEvxbsftJ2vWj+DXYh2g2pKngT+7l22n
         v2JQ==
X-Gm-Message-State: AO0yUKXEhXkz0QrW/H/MFOt/aFAbh4jR3fdM/VTDu+F3SNlU/RTjsnFG
        cVNr/DOHasQItpJjIlSg1aI=
X-Google-Smtp-Source: AK7set9sKYTwiQtLQdASyGKGYAMz10RZbFAtdmTNxJC1L+/miSaCAPxYp1Ow8oC5WpuIf1ZGj76okA==
X-Received: by 2002:a05:600c:c6:b0:3ed:5cf9:9f16 with SMTP id u6-20020a05600c00c600b003ed5cf99f16mr4770649wmm.16.1679125417814;
        Sat, 18 Mar 2023 00:43:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc009000000b003ed3084669asm9963888wmb.14.2023.03.18.00.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 00:43:37 -0700 (PDT)
Date:   Sat, 18 Mar 2023 10:43:31 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [tytso-ext4:dev 16/43] fs/ext4/balloc.c:153
 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.
Message-ID: <0ba2ac34-19f4-4c98-b3f0-1dcf2bf962f6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   da8c7d2105be0c0028cfad712da9e17adf9a26eb
commit: e3c70113e2cbeb3dadb3768964920337eff290f6 [16/43] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
config: ia64-randconfig-m031-20230312 (https://download.01.org/0day-ci/archive/20230317/202303171446.eLEhZzAu-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303171446.eLEhZzAu-lkp@intel.com/

smatch warnings:
fs/ext4/balloc.c:153 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.

vim +/block_cluster +153 fs/ext4/balloc.c

c197855ea14175a Stephen Hemminger 2014-05-12   87  static unsigned ext4_num_overhead_clusters(struct super_block *sb,
e187c6588d6ef31 Theodore Ts'o     2009-02-06   88  					   ext4_group_t block_group,
e187c6588d6ef31 Theodore Ts'o     2009-02-06   89  					   struct ext4_group_desc *gdp)
0bf7e8379ce7e01 Jose R. Santos    2008-06-03   90  {
e3c70113e2cbeb3 Kemeng Shi        2023-02-21   91  	unsigned base_clusters, num_clusters;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21   92  	int block_cluster, inode_cluster;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21   93  	int itbl_cluster_start = -1, itbl_cluster_end = -1;
d5b8f31007a9377 Theodore Ts'o     2011-09-09   94  	ext4_fsblk_t start = ext4_group_first_block_no(sb, block_group);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21   95  	ext4_fsblk_t end = start + EXT4_BLOCKS_PER_GROUP(sb) - 1;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21   96  	ext4_fsblk_t itbl_blk_start, itbl_blk_end;
0bf7e8379ce7e01 Jose R. Santos    2008-06-03   97  	struct ext4_sb_info *sbi = EXT4_SB(sb);
0bf7e8379ce7e01 Jose R. Santos    2008-06-03   98  
d5b8f31007a9377 Theodore Ts'o     2011-09-09   99  	/* This is the number of clusters used by the superblock,
d5b8f31007a9377 Theodore Ts'o     2011-09-09  100  	 * block group descriptors, and reserved block group
d5b8f31007a9377 Theodore Ts'o     2011-09-09  101  	 * descriptor blocks */
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  102  	base_clusters = ext4_num_base_meta_clusters(sb, block_group);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  103  	num_clusters = base_clusters;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  104  
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  105  	/*
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  106  	 * Account and record inode table clusters if any cluster
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  107  	 * is in the block group, or inode table cluster range is
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  108  	 * [-1, -1] and won't overlap with block/inode bitmap cluster
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  109  	 * accounted below.
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  110  	 */
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  111  	itbl_blk_start = ext4_inode_table(sb, gdp);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  112  	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  113  	if (itbl_blk_start <= end && itbl_blk_end >= start) {
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  114  		itbl_blk_start = itbl_blk_start >= start ?
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  115  			itbl_blk_start : start;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  116  		itbl_blk_end = itbl_blk_end <= end ?
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  117  			itbl_blk_end : end;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  118  
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  119  		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  120  		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  121  
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  122  		num_clusters += itbl_cluster_end - itbl_cluster_start + 1;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  123  		/* check if border cluster is overlapped */
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  124  		if (itbl_cluster_start == base_clusters - 1)
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  125  			num_clusters--;
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  126  	}
0bf7e8379ce7e01 Jose R. Santos    2008-06-03  127  
d5b8f31007a9377 Theodore Ts'o     2011-09-09  128  	/*
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  129  	 * For the allocation bitmaps, we first need to check to see
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  130  	 * if the block is in the block group.  If it is, then check
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  131  	 * to see if the cluster is already accounted for in the clusters
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  132  	 * used for the base metadata cluster and inode tables cluster.
d5b8f31007a9377 Theodore Ts'o     2011-09-09  133  	 * Normally all of these blocks are contiguous, so the special
d5b8f31007a9377 Theodore Ts'o     2011-09-09  134  	 * case handling shouldn't be necessary except for *very*
d5b8f31007a9377 Theodore Ts'o     2011-09-09  135  	 * unusual file system layouts.
d5b8f31007a9377 Theodore Ts'o     2011-09-09  136  	 */
d5b8f31007a9377 Theodore Ts'o     2011-09-09  137  	if (ext4_block_in_group(sb, ext4_block_bitmap(sb, gdp), block_group)) {
b0dd6b70f0fda17 Theodore Ts'o     2012-06-07  138  		block_cluster = EXT4_B2C(sbi,
b0dd6b70f0fda17 Theodore Ts'o     2012-06-07  139  					 ext4_block_bitmap(sb, gdp) - start);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  140  		if (block_cluster >= base_clusters &&
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  141  		    (block_cluster < itbl_cluster_start ||
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  142  		    block_cluster > itbl_cluster_end))
d5b8f31007a9377 Theodore Ts'o     2011-09-09  143  			num_clusters++;
d5b8f31007a9377 Theodore Ts'o     2011-09-09  144  	}

block_cluster not initialized on else path.  We discussed this in the
past but I don't see on lore if it was actually fixed.

d5b8f31007a9377 Theodore Ts'o     2011-09-09  145  
d5b8f31007a9377 Theodore Ts'o     2011-09-09  146  	if (ext4_block_in_group(sb, ext4_inode_bitmap(sb, gdp), block_group)) {
d5b8f31007a9377 Theodore Ts'o     2011-09-09  147  		inode_cluster = EXT4_B2C(sbi,
b0dd6b70f0fda17 Theodore Ts'o     2012-06-07  148  					 ext4_inode_bitmap(sb, gdp) - start);
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  149  		/*
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  150  		 * Additional check if inode bitmap is in just accounted
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  151  		 * block_cluster
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  152  		 */
e3c70113e2cbeb3 Kemeng Shi        2023-02-21 @153  		if (inode_cluster != block_cluster &&
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  154  		    inode_cluster >= base_clusters &&
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  155  		    (inode_cluster < itbl_cluster_start ||
e3c70113e2cbeb3 Kemeng Shi        2023-02-21  156  		    inode_cluster > itbl_cluster_end))
d5b8f31007a9377 Theodore Ts'o     2011-09-09  157  			num_clusters++;
0bf7e8379ce7e01 Jose R. Santos    2008-06-03  158  	}
d5b8f31007a9377 Theodore Ts'o     2011-09-09  159  
d5b8f31007a9377 Theodore Ts'o     2011-09-09  160  	return num_clusters;
0bf7e8379ce7e01 Jose R. Santos    2008-06-03  161  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

