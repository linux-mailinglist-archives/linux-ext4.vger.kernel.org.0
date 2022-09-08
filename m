Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E885B17EC
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIHJBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIHJBl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:01:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A47FD22C
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE18233E62;
        Thu,  8 Sep 2022 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662627698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhZQ5z9ejj0Z2DOJLU1WXVxG50cvWY2jHB0z+Fj1BK0=;
        b=XMRyhxx27wc9C0XjF/Zo6v13pqnzFwJ3A/hc45aH6npul8/Hk52xCbPOivzQApOqyq1ubv
        C+tsowLuIsO5CIQetxe1ME1Iqg7he6EKxmbYO65TY6v9zuQp2I7I/JUCF+1qvcyD8D3+bL
        QI1mbtgrPiSu1BHdpslWoc3O9knCGQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662627698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhZQ5z9ejj0Z2DOJLU1WXVxG50cvWY2jHB0z+Fj1BK0=;
        b=ls3C7PIx/Cjb5yWtzejp+o/+sUS0QqmxEFuxMBy31btGXBFXwHu/jdvpPADnYF90jGTsTX
        5kUAUr1X4mB1iGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBBBC1322C;
        Thu,  8 Sep 2022 09:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Ha7MXKvGWMsPAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:01:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C39B4A067E; Thu,  8 Sep 2022 11:01:37 +0200 (CEST)
Date:   Thu, 8 Sep 2022 11:01:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <20220908090137.ojysovmucdmlfbti@quack3>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-5-jack@suse.cz>
 <20220907184110.wu2uqs7s3hggdtj2@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907184110.wu2uqs7s3hggdtj2@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-09-22 00:11:10, Ritesh Harjani (IBM) wrote:
> On 22/09/06 05:29PM, Jan Kara wrote:
> > Using rbtree for sorting groups by average fragment size is relatively
> > expensive (needs rbtree update on every block freeing or allocation) and
> > leads to wide spreading of allocations because selection of block group
> > is very sentitive both to changes in free space and amount of blocks
> > allocated. Furthermore selecting group with the best matching average
> > fragment size is not necessary anyway, even more so because the
> > variability of fragment sizes within a group is likely large so average
> > is not telling much. We just need a group with large enough average
> > fragment size so that we have high probability of finding large enough
> > free extent and we don't want average fragment size to be too big so
> > that we are likely to find free extent only somewhat larger than what we
> > need.
> > 
> > So instead of maintaing rbtree of groups sorted by fragment size keep
> > bins (lists) or groups where average fragment size is in the interval
> > [2^i, 2^(i+1)). This structure requires less updates on block allocation
> > / freeing, generally avoids chaotic spreading of allocations into block
> > groups, and still is able to quickly (even faster that the rbtree)
> > provide a block group which is likely to have a suitably sized free
> > space extent.
> 
> This makes sense because we anyways maintain buddy bitmap for MB_NUM_ORDERS
> bitmaps. Hence our data structure to maintain different lists of groups, with 
> their average fragments size can be bounded within MB_NUM_ORDERS lists.
> This also makes it for amortized O(1) search time for finding the right group
> in CR1 search.
> 
> > 
> > This patch reduces number of block groups used when untarring archive
> > with medium sized files (size somewhat above 64k which is default
> > mballoc limit for avoiding locality group preallocation) to about half
> > and thus improves write speeds for eMMC flash significantly.
> > 
> 
> Indeed a nice change. More inline with the how we maintain
> sbi->s_mb_largest_free_orders lists.

I didn't really find more comments than the one below?

> I think as you already noted there are few minor checkpatch errors,
> other than that one small query below.

Yep, some checkpatch errors + procfs file handling bugs + one bad unlock in
an error recovery path. All fixed up locally :)

> > -/*
> > - * Reinsert grpinfo into the avg_fragment_size tree with new average
> > - * fragment size.
> > - */
> > +/* Move group to appropriate avg_fragment_size list */
> >  static void
> >  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
> >  {
> >  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +	int new_order;
> >  
> >  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> >  		return;
> >  
> > -	write_lock(&sbi->s_mb_rb_lock);
> > -	if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
> > -		rb_erase(&grp->bb_avg_fragment_size_rb,
> > -				&sbi->s_mb_avg_fragment_size_root);
> > -		RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
> > -	}
> > +	new_order = mb_avg_fragment_size_order(sb,
> > +					grp->bb_free / grp->bb_fragments);
> 
> Previous rbtree change was always checking for if grp->bb_fragments for 0.
> Can grp->bb_fragments be 0 here?

Since grp->bb_free is greater than zero, there should be at least one
fragment...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
