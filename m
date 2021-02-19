Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355A031FCCF
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBSQJ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 11:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBSQIs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 11:08:48 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7098C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 08:08:07 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id dr7so2832712qvb.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2rKOBiDaABnMI00E0h/RsMYj1/PZb8ergMEpUfFcGvo=;
        b=fQ3r/0p0s897RS6t96qoneDpKYai/lxxJ8Z4Y5AUhp+T3Ssw+ZnsY5yRr2mRi18BCO
         7+S7+sEF+1bNj0rAHa6nkJTz66jGHlU2Xjo81JjeOQuyu+jgQ104YinW4r5J9h7LpXVo
         ccPPhdMqCvuZ75rs8sfYH+AbuQ+rrjndsN4k2m0xmpWU65hdpLvmdaTznaq8VqUbSvwJ
         PUEcUb0W2gIbSs1ODpG8dIYx0WrywH/RNut2NCW3jnA6evk1242Ver7vhfmEpXRhT80A
         TIFfn4aU9/0nBAKABAMKfi4mC481RyFKBoiH8TI7K21hDQ5hZetj9CO1NafIemuNOzgg
         qodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2rKOBiDaABnMI00E0h/RsMYj1/PZb8ergMEpUfFcGvo=;
        b=G+hCT5bX7B3aXq5XHxmPRrljD/kUojDavmCR1xn91zll941qNciUHzI+CnNIUDTU3r
         qX66PFU4aDDXSuzFJYng/byzObt/6uB7u9DcvU4PptNoSkWQAexmpeqgEIQ24JZv3iYA
         cI/uWHCWO0gJjcIYfjsfKW6Ta/GqmN8e6uAFcBCFVQDZar3T7u+q4MMe9FhSMIawZyhF
         JCDhsBpzeehh/2vsEP5igKZ7ISdrnGYtsYuQ4KfdAyedpZxKKMmLqwdf2V3W2UZVCEua
         /B4H0wfPvfqNy0Q8R6+xjRxBvkAsiSkcCh1r2nFGwKO0iRXuYzKc0sNQ08A7D0Guoa0O
         cn+w==
X-Gm-Message-State: AOAM5304G/2bamfA+IOzhvW5AKLLrR/dIrCVLhrVqE4Tl/AdH0c8Tx+H
        Mik37cNxbhwQ3w2viuilmQw=
X-Google-Smtp-Source: ABdhPJySMZyPR0WmAzo396GXA1ne0QOjhI4XspnjXyi1wmc3KXUkTAozoNSHDaxp7W8DWK9JSG94Xw==
X-Received: by 2002:a0c:8304:: with SMTP id j4mr9730379qva.18.1613750886944;
        Fri, 19 Feb 2021 08:08:06 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id s126sm6393096qkf.62.2021.02.19.08.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:08:06 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:08:04 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Eric Whitney <enwlinux@gmail.com>,
        lkp@intel.com, kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [ext4:dev 6/8] fs/ext4/extents.c:4456 ext4_alloc_file_blocks()
 error: uninitialized symbol 'ret'.
Message-ID: <20210219160804.GA21133@localhost.localdomain>
References: <20210219082804.GR2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219082804.GR2087@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com>:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> head:   0a76945fd1ba2ab44da7b578b311efdfedf92e6c
> commit: 3258386aba670e3406a499d2d0b7395e14c8d097 [6/8] ext4: reset retry counter when ext4_alloc_file_blocks() makes progress
> config: i386-randconfig-m021-20210215 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/ext4/extents.c:4456 ext4_alloc_file_blocks() error: uninitialized symbol 'ret'.
> 
> Old smatch warnings:
> fs/ext4/extents.c:2396 ext4_rereserve_cluster() warn: should '(1) << sbi->s_cluster_bits' be a 64 bit type?
> include/linux/fs.h:861 i_size_write() warn: statement has no effect 31
> fs/ext4/extents.c:5760 ext4_clu_mapped() warn: should 'lclu << sbi->s_cluster_bits' be a 64 bit type?
> fs/ext4/extents.c:6009 ext4_ext_replay_set_iblocks() warn: should 'numblks << (inode->i_sb->s_blocksize_bits - 9)' be a 64 bit type?
> 
> vim +/ret +4456 fs/ext4/extents.c
> 
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4379  static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4380  				  ext4_lblk_t len, loff_t new_size,
>                                                                                   ^^^^^^^^^^^^^^^
> Can "len" be zero?  If so then we have a problem, if not then this is
> a false positive.


This should be a false positive, but there's no reason not to silence this
warning.  I'll post a v2 correcting the original patch.

Eric


> 
> 77a2e84d51729d Tahsin Erdogan     2017-08-05  4381  				  int flags)
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4382  {
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4383  	struct inode *inode = file_inode(file);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4384  	handle_t *handle;
> 3258386aba670e Eric Whitney       2021-01-13  4385  	int ret, ret2 = 0, ret3 = 0;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4386  	int retries = 0;
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4387  	int depth = 0;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4388  	struct ext4_map_blocks map;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4389  	unsigned int credits;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4390  	loff_t epos;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4391  
> c3fe493ccdb1f4 Fabian Frederick   2016-09-15  4392  	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4393  	map.m_lblk = offset;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4394  	map.m_len = len;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4395  	/*
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4396  	 * Don't normalize the request if it can fit in one extent so
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4397  	 * that it doesn't get unnecessarily split into multiple
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4398  	 * extents.
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4399  	 */
> 556615dcbf38b0 Lukas Czerner      2014-04-20  4400  	if (len <= EXT_UNWRITTEN_MAX_LEN)
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4401  		flags |= EXT4_GET_BLOCKS_NO_NORMALIZE;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4402  
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4403  	/*
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4404  	 * credits to insert 1 extent into extent tree
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4405  	 */
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4406  	credits = ext4_chunk_trans_blocks(inode, len);
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4407  	depth = ext_depth(inode);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4408  
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4409  retry:
> 3258386aba670e Eric Whitney       2021-01-13  4410  	while (len) {
>                                                         ^^^^^^^^^^^^^
> 
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4411  		/*
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4412  		 * Recalculate credits when extent tree depth changes.
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4413  		 */
> 011c88e36c26a0 Dan Carpenter      2016-12-03  4414  		if (depth != ext_depth(inode)) {
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4415  			credits = ext4_chunk_trans_blocks(inode, len);
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4416  			depth = ext_depth(inode);
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4417  		}
> 4134f5c88dcd5b Lukas Czerner      2015-06-15  4418  
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4419  		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4420  					    credits);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4421  		if (IS_ERR(handle)) {
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4422  			ret = PTR_ERR(handle);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4423  			break;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4424  		}
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4425  		ret = ext4_map_blocks(handle, inode, &map, flags);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4426  		if (ret <= 0) {
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4427  			ext4_debug("inode #%lu: block %u: len %u: "
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4428  				   "ext4_ext_map_blocks returned %d",
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4429  				   inode->i_ino, map.m_lblk,
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4430  				   map.m_len, ret);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4431  			ext4_mark_inode_dirty(handle, inode);
> 3258386aba670e Eric Whitney       2021-01-13  4432  			ext4_journal_stop(handle);
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4433  			break;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4434  		}
> 3258386aba670e Eric Whitney       2021-01-13  4435  		/*
> 3258386aba670e Eric Whitney       2021-01-13  4436  		 * allow a full retry cycle for any remaining allocations
> 3258386aba670e Eric Whitney       2021-01-13  4437  		 */
> 3258386aba670e Eric Whitney       2021-01-13  4438  		retries = 0;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4439  		map.m_lblk += ret;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4440  		map.m_len = len = len - ret;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4441  		epos = (loff_t)map.m_lblk << inode->i_blkbits;
> eeca7ea1baa939 Deepa Dinamani     2016-11-14  4442  		inode->i_ctime = current_time(inode);
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4443  		if (new_size) {
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4444  			if (epos > new_size)
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4445  				epos = new_size;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4446  			if (ext4_update_inode_size(inode, epos) & 0x1)
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4447  				inode->i_mtime = inode->i_ctime;
> c174e6d6979a04 Dmitry Monakhov    2014-08-27  4448  		}
> 4209ae12b12265 Harshad Shirwadkar 2020-04-26  4449  		ret2 = ext4_mark_inode_dirty(handle, inode);
> c894aa97577e47 Eryu Guan          2017-12-03  4450  		ext4_update_inode_fsync_trans(handle, inode, 1);
> 4209ae12b12265 Harshad Shirwadkar 2020-04-26  4451  		ret3 = ext4_journal_stop(handle);
> 4209ae12b12265 Harshad Shirwadkar 2020-04-26  4452  		ret2 = ret3 ? ret3 : ret2;
> 4209ae12b12265 Harshad Shirwadkar 2020-04-26  4453  		if (unlikely(ret2))
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4454  			break;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4455  	}
> 3258386aba670e Eric Whitney       2021-01-13 @4456  	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>                                                             ^^^^^^^^^^^^^^
> 
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4457  		goto retry;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4458  
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4459  	return ret > 0 ? ret2 : ret;
> 0e8b6879f3c234 Lukas Czerner      2014-03-18  4460  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


