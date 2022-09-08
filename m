Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474E25B1895
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIHJYw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiIHJYa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:24:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA8D0751
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:23:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1762206pjh.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=612B2TCXLYXXLA360jKXEOpf8t1ama4xjgLXroauTDo=;
        b=ItV413tQ4aHcZl0J2OhgAsBBC42mibLMm7m5GrH1h/MSJua6LN84db6tLxrBL60NVz
         vCNTVeMEREG8DbQtT+Tmze6WTEOUn/4hvMSNC9eSTttAHDtQvI48FeeLMeucoMTxXBq/
         PglF477y0odOAPyGtVXNELme4SFyf7cRxQ10GtHpcTXjvR567NByuQF3iAmtPDTSVBgF
         xYtXBO1fsBwDpBM18Roi8vVIiUNUO9EPOy8XTVxWrN9uX4iFpXnZGXPIemeTqdVc+cay
         e03ndY8DPw9g6BGsE+IHDQUutEqD54qSnjj2imD5I8S+uMwPEHBK8jvinP6HSOphbOYp
         wLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=612B2TCXLYXXLA360jKXEOpf8t1ama4xjgLXroauTDo=;
        b=xxFLX2R/syiYEbluVVzG6WCUPuROBz2Sr0PFpOFrsJqbdk2a6K9gDxDJ4qAg4zjPSW
         32SkSNntENm8c0nlJ7qPz6fA5cSegSxGMTjVJr/ODw42M/Jkp0GDq/Xyq9weJq1fB70t
         hc95NVTkT7JNnirMK6DnV2g17nxEsxR851M+lvlNuFgm2MxVXwTbMMWGDOua46ZBk2Rh
         9z++rS8U+aETSS0IPsBm/kCW7wEt7yYMOcp96R5L3gSRDLN3Vy7s4AReNNXVlbaXX1uE
         e6QBCH0mNP0LRKzvMMheMSYayr1cwuloO6f7aEdLb/wNK3p6CMBYRSNckCu/L8PW4Yg3
         g3Ow==
X-Gm-Message-State: ACgBeo3pPozzDlnFLipxJM/Jl/JM8WWKrc0eB6CiuYGCx4zxhPHZme+w
        YrGli1tAQDfO2upmH1OO6QY=
X-Google-Smtp-Source: AA6agR5gPGw2FYNhod24kiK2iDB5EGEOtvqE2S9+kYY5fSvIre1+RME5xuXpb7On3Z7sey7Sf0rlUw==
X-Received: by 2002:a17:902:cec7:b0:172:b20d:e666 with SMTP id d7-20020a170902cec700b00172b20de666mr8096087plg.154.1662628999194;
        Thu, 08 Sep 2022 02:23:19 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm1261898pjo.47.2022.09.08.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:23:18 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:53:14 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <20220908092314.j6o2szika2r6agal@riteshh-domain>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-5-jack@suse.cz>
 <20220907184110.wu2uqs7s3hggdtj2@riteshh-domain>
 <20220908090137.ojysovmucdmlfbti@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908090137.ojysovmucdmlfbti@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/08 11:01AM, Jan Kara wrote:
> On Thu 08-09-22 00:11:10, Ritesh Harjani (IBM) wrote:
> > On 22/09/06 05:29PM, Jan Kara wrote:
> > > Using rbtree for sorting groups by average fragment size is relatively
> > > expensive (needs rbtree update on every block freeing or allocation) and
> > > leads to wide spreading of allocations because selection of block group
> > > is very sentitive both to changes in free space and amount of blocks
> > > allocated. Furthermore selecting group with the best matching average
> > > fragment size is not necessary anyway, even more so because the
> > > variability of fragment sizes within a group is likely large so average
> > > is not telling much. We just need a group with large enough average
> > > fragment size so that we have high probability of finding large enough
> > > free extent and we don't want average fragment size to be too big so
> > > that we are likely to find free extent only somewhat larger than what we
> > > need.
> > > 
> > > So instead of maintaing rbtree of groups sorted by fragment size keep
> > > bins (lists) or groups where average fragment size is in the interval
> > > [2^i, 2^(i+1)). This structure requires less updates on block allocation
> > > / freeing, generally avoids chaotic spreading of allocations into block
> > > groups, and still is able to quickly (even faster that the rbtree)
> > > provide a block group which is likely to have a suitably sized free
> > > space extent.
> > 
> > This makes sense because we anyways maintain buddy bitmap for MB_NUM_ORDERS
> > bitmaps. Hence our data structure to maintain different lists of groups, with 
> > their average fragments size can be bounded within MB_NUM_ORDERS lists.
> > This also makes it for amortized O(1) search time for finding the right group
> > in CR1 search.
> > 
> > > 
> > > This patch reduces number of block groups used when untarring archive
> > > with medium sized files (size somewhat above 64k which is default
> > > mballoc limit for avoiding locality group preallocation) to about half
> > > and thus improves write speeds for eMMC flash significantly.
> > > 
> > 
> > Indeed a nice change. More inline with the how we maintain
> > sbi->s_mb_largest_free_orders lists.
> 
> I didn't really find more comments than the one below?

No I meant. The data structure is more inline with sbi->s_mb_largest_free_orders
lists :) Had no other comments. 

> 
> > I think as you already noted there are few minor checkpatch errors,
> > other than that one small query below.
> 
> Yep, some checkpatch errors + procfs file handling bugs + one bad unlock in
> an error recovery path. All fixed up locally :)

Sure.

> 
> > > -/*
> > > - * Reinsert grpinfo into the avg_fragment_size tree with new average
> > > - * fragment size.
> > > - */
> > > +/* Move group to appropriate avg_fragment_size list */
> > >  static void
> > >  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
> > >  {
> > >  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> > > +	int new_order;
> > >  
> > >  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> > >  		return;
> > >  
> > > -	write_lock(&sbi->s_mb_rb_lock);
> > > -	if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
> > > -		rb_erase(&grp->bb_avg_fragment_size_rb,
> > > -				&sbi->s_mb_avg_fragment_size_root);
> > > -		RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
> > > -	}
> > > +	new_order = mb_avg_fragment_size_order(sb,
> > > +					grp->bb_free / grp->bb_fragments);
> > 
> > Previous rbtree change was always checking for if grp->bb_fragments for 0.
> > Can grp->bb_fragments be 0 here?
> 
> Since grp->bb_free is greater than zero, there should be at least one
> fragment...

aah yes, right.

-ritesh
