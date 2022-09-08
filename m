Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83195B1B89
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiIHLeC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIHLeA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 07:34:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEF6112E74
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 04:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CBEF33698;
        Thu,  8 Sep 2022 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662636835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzRRWETyANLnGaN0aHv+J+v0L4tAgoQ0eI4SngtQZO0=;
        b=B5SZqq1AJn79zbxxH4GWY829XNBt4cLa/lat2x5H3GFMuF/7EWEDkyf8SYODKmuEJHjk3z
        Rr/gpeLnboHuXxwnNrJI/Obq13dAU5LWXgZZyVjLP6EQdRfVAyTcevEdYgN3rjQOp6GT5W
        Sz2SrY8J0iYn820IjPUjPbqyTNu9p+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662636835;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzRRWETyANLnGaN0aHv+J+v0L4tAgoQ0eI4SngtQZO0=;
        b=whGVnPLep2Z4UJq5cwRftC9j6M+661NRTpBKpYtk/iaf4Ac8Zf2OdPnXo87zBDE4lbyxvY
        BiUsa0LRqXaprvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E95613A6D;
        Thu,  8 Sep 2022 11:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HSNnByPTGWMCBQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 11:33:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9CC37A067E; Thu,  8 Sep 2022 13:33:54 +0200 (CEST)
Date:   Thu, 8 Sep 2022 13:33:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <20220908113354.uikvfzlv7sn4a6iw@quack3>
References: <20220906152920.25584-5-jack@suse.cz>
 <202209071206.u1iHKVzB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209071206.u1iHKVzB-lkp@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-09-22 14:00:17, Dan Carpenter wrote:
> Hi Jan,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/ext4-Fix-performance-regression-with-mballoc/20220907-000945
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e99dcff61e1523ec1c3628b2d564ba15d32eb7
> config: m68k-randconfig-m041-20220906 (https://download.01.org/0day-ci/archive/20220907/202209071206.u1iHKVzB-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/ext4/mballoc.c:945 ext4_mb_choose_next_group_cr1() error: uninitialized symbol 'grp'.
> 
> vim +/grp +945 fs/ext4/mballoc.c
> 
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  909  static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  910  		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  911  {
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  912  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> 31b571b608cf66 Jan Kara           2022-09-06  913  	struct ext4_group_info *grp, *iter;
> 31b571b608cf66 Jan Kara           2022-09-06  914  	int i;
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  915  
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  916  	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  917  		if (sbi->s_mb_stats)
> 196e402adf2e4c Harshad Shirwadkar 2021-04-01  918  			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
> 31b571b608cf66 Jan Kara           2022-09-06  919  	}
> 31b571b608cf66 Jan Kara           2022-09-06  920  
> 31b571b608cf66 Jan Kara           2022-09-06  921  	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
> 31b571b608cf66 Jan Kara           2022-09-06  922  	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> 31b571b608cf66 Jan Kara           2022-09-06  923  		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
> 31b571b608cf66 Jan Kara           2022-09-06  924  			continue;
> 31b571b608cf66 Jan Kara           2022-09-06  925  		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
> 31b571b608cf66 Jan Kara           2022-09-06  926  		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
> 31b571b608cf66 Jan Kara           2022-09-06  927  			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> 31b571b608cf66 Jan Kara           2022-09-06  928  			continue;
> 
> Smatch worries that we can hit these two continues on every iteration.
> Why not just initialize "grp = NULL;" at the start of the function?

Yes, good point. It may even be possible in some rare racy cornercase. I'll
do what you suggest. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
