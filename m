Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1260A533C5A
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiEYMMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243615AbiEYMMi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 08:12:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0732065;
        Wed, 25 May 2022 05:12:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D683C2197D;
        Wed, 25 May 2022 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653480725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9ADgFqAEGWFiaV0FfZvAzF+jTR4txDSI8ABAqVPOrU=;
        b=awLFvIy/3uDe+jRPi3uM6ImNGcgr76dhhnrE5FbEsTNqI1+nB9prPG5CID+74x/itCyjSJ
        a2GNM8kaKtB6kHUqHOenvn20yFWg2r+zaZK8oJdqYP7kjRxS6EZxIIVU37Nzt9AKP+Ke9l
        TTB2CNpvemT9RZDBJoERQvemdsiy/74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653480725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9ADgFqAEGWFiaV0FfZvAzF+jTR4txDSI8ABAqVPOrU=;
        b=K706IInHg4GxeM1vCvXQsH8K459190FtlVuCjS88lPD7RMRcayC1vyXtj3RD1gefDX6lpt
        1tYagrhZl6r3bKAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AEF6C2C141;
        Wed, 25 May 2022 12:12:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56E32A0632; Wed, 25 May 2022 14:12:05 +0200 (CEST)
Date:   Wed, 25 May 2022 14:12:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220525121205.znoxp52yxyhoxjcc@quack3.lan>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
 <20220523210806.yeapg54ctleocwdn@quack3.lan>
 <20220524062655.ddiltnfxxhlelfgb@riteshh-domain>
 <20220524093933.bittzsrrpddttnab@quack3.lan>
 <20220524173135.imboagpi3iqav2cg@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524173135.imboagpi3iqav2cg@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 24-05-22 23:01:35, Ritesh Harjani wrote:
> On 22/05/24 11:39AM, Jan Kara wrote:
> > On Tue 24-05-22 11:56:55, Ritesh Harjani wrote:
> > > On 22/05/23 11:08PM, Jan Kara wrote:
> > > > On Tue 24-05-22 01:38:44, Ritesh Harjani wrote:
> > > > > On 22/05/21 09:42PM, Baokun Li wrote:
> > > > > > When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> > > > > > "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> > > > > > that the fe_logical is not in the allocated range.
> > > > >
> > > > > Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
> > > > > We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
> > > > > within the preallocated range. So if our start or start + size doesn't include
> > > > > fe_logical then it is a bug in the ext4_mb_normalize_request() logic.
> > > >
> > > > I agree ac->ac_o_ex.fe_logical is a goal block. But AFAIK it never was a
> > > > hard guarantee that we would allocate extent that includes that block. It
> > >
> > > Agree that the guarantee is not about the extent which finally gets allocated.
> > > It is only within ext4_mb_normalize_request() that the "start" and "size"
> > > variable calculations is done in such a way that the ac->ac_o_ex.fe_logical
> > > block will always fall within the "start" & "end" boundaries after
> > > normalization.
> > >
> > > That is how it also updates the goal block at the end too. ac->ac_g_ex.
> > >
> > > > was always treated as a hint only. In particular if you look at the logic
> > > > in ext4_mb_normalize_request() it does shift the start of the allocation to
> > > > avoid preallocated ranges etc.
> > >
> > > Yes, I checked the logic of ext4_mb_normalize_request() again.
> > > As I see it (I can be wrong, so please correct me), there is always an attempt
> > > to make "start" & "start + size" such that it covers ac->ac_o_ex.fe_logical
> > > except just one change where we are trimming the size of the request to only
> > > EXT4_BLOCKS_PER_GROUP.
> > >
> > > For e.g. when it compares against preallocated ranges. It has a BUG() which
> > > checks if the ac->ac_o_ex.fe_logical already lies in the preallocated range.
> > > Because then we should never have come here to do allocation of a new block.
> > >
> > > 4143                 /* PA must not overlap original request */
> > > 4144                 BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
> > > 4145                         ac->ac_o_ex.fe_logical < pa->pa_lstart));
> > > <...>
> > > 4152                 BUG_ON(pa->pa_lstart <= start && pa_end >= end);
> > >
> > > Then after skipping the preallocated regions which doesn't fall in between
> > > "start" and "end"...
> > >
> > > 4147                 /* skip PAs this normalized request doesn't overlap with */
> > > 4148                 if (pa->pa_lstart >= end || pa_end <= start) {
> > > 4149                         spin_unlock(&pa->pa_lock);
> > > 4150                         continue;
> > > 4151                 }
> > >
> > > ...it adjusts "start" and "end" boundary according to allocated PAs boundaries
> > > such that fe_logical is always in between "start" and "end".
> > >
> > > 4154                 /* adjust start or end to be adjacent to this pa */
> > > 4155                 if (pa_end <= ac->ac_o_ex.fe_logical) {
> > > 4156                         BUG_ON(pa_end < start);
> > > 4157                         start = pa_end;
> > > 4158                 } else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
> > > 4159                         BUG_ON(pa->pa_lstart > end);
> > > 4160                         end = pa->pa_lstart;
> > > 4161                 }
> > >
> > >
> > >
> > > > so I don't see how we are guaranteed that
> > > > ext4_mb_normalize_request() will result in an allocation request that
> > > > includes ac->ac_o_ex.fe_logical.
> > >
> > > It could be I am wrong, but looks like ext4_mb_normalize_request() keeps
> > > ac->ac_o_ex.fe_logical within "start" and "end" of allocation request.
> > > And then updates the goal block.
> > >
> > > 4196         ac->ac_g_ex.fe_logical = start;
> > > 4197         ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
> > >
> > > Thoughts?
> >
> > Right, after some more inspection the only thing I'm concerned about is:
> >
> >         /* don't cover already allocated blocks in selected range */
> >         if (ar->pleft && start <= ar->lleft) {
> >                 size -= ar->lleft + 1 - start;
> >                 start = ar->lleft + 1;
> >         }
> >
> > which can shift start beyond ac->ac_o_ex.fe_logical if the block would be
> > already allocated. But I guess in that case we should not be calling
> > ext4_mb_normalize_request()? ... some more code digging .. Yes, that is
> > guaranteed in how lleft is initialized in ext4_ext_map_blocks().
> 
> Yes.
> 
> > So OK, I withdraw my objection to the stronger check but the changelog really needs
> 
> Thanks Jan for confirming it.
> 
> 
> > to do a better job to explain why the stronger condition should be true.
> 
> Agreed.
> 
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 252c168454c7..9e7c145e9aa2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4179,7 +4179,22 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>         }
>         rcu_read_unlock();
> 
> -       if (start + size <= ac->ac_o_ex.fe_logical &&
> +       /*
> +        * In this function "start" and "size" are normalized for better
> +        * alignment and length such that we could preallocate more blocks.
> +        * This normalization is done such that original request of
> +        * ac->ac_o_ex.fe_logical & fe_len should always lie within "start" and
> +        * "size" boundaries.
> 
> Does above comment look good to you?

Yes, thanks!

> +        * (Note fe_len can be relaxed since FS block allocation API does not
> +        * provide gurantee on number of contiguous blocks allocation since that
> +        * depends upon free space left, etc).
> +        * In case of inode pa, later we use the allocated blocks
> +        * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
> +        * range of goal/best blocks [start, size] to put it at the
> +        * ac_o_ex.fe_logical extent of this inode.
> +        * (See ext4_mb_use_inode_pa() for more details)
> +        */
> 
> ^^^ We can even put more info if needed (maybe in commit message?)

I'd just put into commit message a note like: ext4_mb_normalize_request()
can move logical start of allocated blocks to reduce fragmentation and
better utilize preallocation. However logical block requested as a start of
allocation (ac->ac_o_ex.fe_logical) should always be covered by allocated
blocks so we add assertion to check that.

> 
> +       if (start + size <= ac->ac_o_ex.fe_logical ||
>                         start > ac->ac_o_ex.fe_logical) {
>                 ext4_msg(ac->ac_sb, KERN_ERR,
>                          "start %lu, size %lu, fe_logical %lu",
> 
> FYI - I ran the fsstress test (with -g 256) shared by Baokun with only above
> change (&& -> ||) and not the original fix. And I see that we can hit this
> mentioned BUG() now.

Cool.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
