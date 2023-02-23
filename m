Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C06A01AF
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Feb 2023 05:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjBWEEn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 23:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjBWEEm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 23:04:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E642360BD;
        Wed, 22 Feb 2023 20:04:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so1988087wms.1;
        Wed, 22 Feb 2023 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8To/H78yTZd9LcMUadl3BIzH4V/slxywotjiMrN3r4=;
        b=o1HfscIQJCjgVCd5hYUh26OcPHizZ5M2fUPOAzI2VhcOC/xLKjGGbFhBjD6r4NN691
         ksofcihZiLa/50yf+G3ytaKA22JrL4aVoiS0d6xvhYkTKkunv0nKyfxAe9ITNAL4uiw4
         0E7ktlJk7Eq/eN7Q5oejnu/sNlw7qq5RtfdlP6YNJYPTqtA7dA1Yp9jybYGUwgaT2BMR
         rer5IJhQGfkn+Dnd25z6rfEakUF1uhPIfF1TPZoguC9KaEfDtr69TIQgkPpNKZgHLdtH
         /YUZPS5Zgcfa7Q66RpJE+DMrWarAQGm7sewJSdCio3cmTmgBa+IgToVgr8g82OunuKzy
         Ei9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8To/H78yTZd9LcMUadl3BIzH4V/slxywotjiMrN3r4=;
        b=mzLiNLpZUrNhjtz19efJsd3lJdaKmMboOmZ+Kzj3uA2uElKV2Tgl6KFwHnBywo6k8H
         tfKv24Kx9d3qLQCM/DUwZxo8cK35VjvmAo4Qd9XQfdci+XVKNjsK2pel0SYQ2s75vFh0
         clAvCAi0iXXbgUBAGiNvf+q6jEDVph5xf3KdBq48+6oFQd6Xe67V8S17YQnAetGgEX1C
         Z7gKKL/28LjHOolXO+LvwtnmUWqjX+yuzLVsUnug6MJTb5PtTjWr8T6Evm9/dXd2Kmqf
         n0vD/scujO9CNNwFPKD7OoaT0nqMxhLIkj46qZrn3/p8V3/TMXAKuMT5ciG3aRr4R3Xq
         fGYw==
X-Gm-Message-State: AO0yUKXWfIJkdZHdIXnDh/m/GHRbATt2XdI+ea4XZwDND5ghAa1wJVZY
        h9t//7rKpninsx8JmC6ucHE=
X-Google-Smtp-Source: AK7set8lUfwhlzbXCtwlmrIXwAi6xDALa5tCJgndDsO1par4fyPiz+VkoSeL+uaFG8HiH9ECUi9obw==
X-Received: by 2002:a05:600c:2ad6:b0:3e8:fade:3795 with SMTP id t22-20020a05600c2ad600b003e8fade3795mr3343342wme.17.1677125079485;
        Wed, 22 Feb 2023 20:04:39 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc411000000b003dfee43863fsm8986413wmi.26.2023.02.22.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:04:38 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:04:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     oe-kbuild@lists.linux.dev, tytso@mit.edu, adilger.kernel@dilger.ca,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ext4: improve inode table blocks counting in
 ext4_num_overhead_clusters
Message-ID: <Y/bl05WBDNT8FPoi@kadam>
References: <202302222219.u328sqfs-lkp@intel.com>
 <1802222f-9c10-9ea3-93fb-6fce086e201a@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1802222f-9c10-9ea3-93fb-6fce086e201a@huaweicloud.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 23, 2023 at 09:31:54AM +0800, Kemeng Shi wrote:
> 
> 
> on 2/22/2023 11:13 PM, Dan Carpenter wrote:
> > Hi Kemeng,
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-properly-handle-error-of-ext4_init_block_bitmap-in-ext4_read_block_bitmap_nowait/20230221-115830
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > patch link:    https://lore.kernel.org/r/20230221115919.1918161-8-shikemeng%40huaweicloud.com
> > patch subject: [PATCH 7/7] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
> > config: riscv-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230222/202302222219.u328sqfs-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202302222219.u328sqfs-lkp@intel.com/
> > 
> > New smatch warnings:
> > fs/ext4/balloc.c:153 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.
> > 
> > vim +/block_cluster +153 fs/ext4/balloc.c
> [...]
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  128  	/*
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  129  	 * For the allocation bitmaps, we first need to check to see
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  130  	 * if the block is in the block group.  If it is, then check
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  131  	 * to see if the cluster is already accounted for in the clusters
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  132  	 * used for the base metadata cluster and inode tables cluster.
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  133  	 * Normally all of these blocks are contiguous, so the special
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  134  	 * case handling shouldn't be necessary except for *very*
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  135  	 * unusual file system layouts.
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  136  	 */
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  137  	if (ext4_block_in_group(sb, ext4_block_bitmap(sb, gdp), block_group)) {
> > b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  138  		block_cluster = EXT4_B2C(sbi,
> > b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  139  					 ext4_block_bitmap(sb, gdp) - start);
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  140  		if (block_cluster >= base_clusters &&
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  141  		    (block_cluster < itbl_cluster_start ||
> > 2b59a2fd93873a Kemeng Shi        2023-02-21  142  		    block_cluster > itbl_cluster_end))
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  143  			num_clusters++;
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  144  	}
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  145  
> > d5b8f31007a937 Theodore Ts'o     2011-09-09  146  	if (ext4_block_in_group(sb, ext4_inode_bitmap(sb, gdp), block_group)) {
> > 
> > These two conditions are exactly the same so I don't see why they can't
> > be combined into one condition.  I have read the comment, but I guess I
> > don't understand ext4 well enough to really understand it.
> These two conditions check two kinds of bitmap block: *block* bitmap block
> and *inode* bitmap block.

Ah right.  When I was reviewing this code, I copy and pasted the if
conditions so they were exactly lined up with each other and I still
didn't see the block vs inode difference until you pointed it out.  :P

Thanks!

regards,
dan carpenter

