Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F133E268715
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgINIUM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 04:20:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgINIUL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Sep 2020 04:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 315F3AC46;
        Mon, 14 Sep 2020 08:20:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B152F1E12ED; Mon, 14 Sep 2020 10:20:11 +0200 (CEST)
Date:   Mon, 14 Sep 2020 10:20:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ye Bin <yebin10@huawei.com>, Jan Kara <jack@suse.cz>,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Fix dead loop in ext4_mb_new_blocks
Message-ID: <20200914082011.GA4863@quack2.suse.cz>
References: <20200910091252.525346-1-yebin10@huawei.com>
 <20200910161753.GB17362@quack2.suse.cz>
 <0e48b9bb-f839-4b3b-dbce-45755618df97@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e48b9bb-f839-4b3b-dbce-45755618df97@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello Ritesh,

On Fri 11-09-20 18:50:22, Ritesh Harjani wrote:
> On 9/10/20 9:47 PM, Jan Kara wrote:
> > > ---
> > >   fs/ext4/mballoc.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index f386fe62727d..fd55264dc3fe 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -4191,7 +4191,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> > >   	INIT_LIST_HEAD(&list);
> > >   repeat:
> > >   	ext4_lock_group(sb, group);
> > > -	this_cpu_inc(discard_pa_seq);
> > >   	list_for_each_entry_safe(pa, tmp,
> > >   				&grp->bb_prealloc_list, pa_group_list) {
> > >   		spin_lock(&pa->pa_lock);
> > > @@ -4233,6 +4232,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> > >   		goto out;
> > >   	}
> > > +	/* only increase when find reallocation to discard */
> > > +	this_cpu_inc(discard_pa_seq);
> > > +
> > 
> > This is a good place to increment the counter but I think you also need to
> > handle the case:
> > 
> >          if (free < needed && busy) {
> >                  busy = 0;
> >                  ext4_unlock_group(sb, group);
> >                  cond_resched();
> >                  goto repeat;
> >          }
> > 
> > We can unlock the group here after removing some preallocations and thus
> > other processes checking discard_pa_seq could miss we did this. In fact I
> > think the code is somewhat buggy here and we should also discard extents
> > accumulated on "list" so far before unlocking the group. Ritesh?
> > 
> 
> mmm, so even though this code is not discarding those buffers b4
> unlocking, but it has still removed those from the grp->bb_prealloc_list
> and added it to the local list. And since it will at some point get
> scheduled and start operating from repeat: label so functionally wise
> this should be ok. Am I missing anything?

Yes, this function itself will be working correctly. But if we unlock the
group before discarding preallocations we have in our local list the
following can happen:

TASK0					TASK1
					ext4_mb_new_blocks()
					  - no free block found
					  ext4_mb_discard_preallocations_should_retry()
					    ext4_mb_discard_preallocations()
ext4_mb_discard_group_preallocations()
  ext4_lock_group(sb, group);
  this_cpu_inc(discard_pa_seq);
  scans group, moves some preallocations to local list
  if (free < needed && busy) {
    ext4_unlock_group(sb, group);
					      - finds no pa to discard
					    seq_retry = ext4_get_discard_pa_seq_sum()
					      - ok seq_retry != seq -> retry
					  - new search still didn't return
					    anything because preallocations
					    are sitting in TASK0 local list
					    and are not freed yet

> Although I agree, that if we remove at least the current pa's before
> unlocking the group may be a good idea, but we should also check
> why was this done like this at the first place.

If we don't care about somewhat premature ENOSPC error, then not discarding
preallocations before unlocking the group is not a problem. That's why
previously it was done like this I believe.
 
> I agree with Jan, that we should increment discard_pa_seq once we
> actually have something to discard. I should have written a comment here
> to explain why we did this here.  But I think commit msg should have all
> the history (since I have a habit of writing long commit msgs ;)
> 
> But IIRC, it was done since in case if there is a parallel thread which
> is discarding all the preallocations so the current thread may return 0
> since it checks the list_empty(&grp->bb_prealloc_list) check in
> ext4_mb_discard_group_preallocations() and returns 0 directly.

Ah, OK. I forgot about the unlocked check for empty bb_prealloc_list.

> And why the discard_pa_seq counter at other places may not help since we
> remove the pa nodes from grp->bb_prealloc_list into a local list and then
> start operating on that. So meanwhile some thread may comes and just
> checks that the list is empty and return 0 while some other thread may
> start discarding from it's local list.  So I guess the main problem was
> that in the current code we remove the pa from grp->bb_prealloc_list and
> add it to local list. So if someone else comes and checks that
> grp->bb_prealloc_list is empty then it will directly return 0.
> 
> So, maybe we could do something like this then?
> 
> repeat:
> 	ext4_lock_group(sb, group);
> -	this_cpu_inc(discard_pa_seq);
> list_for_each_entry_safe(pa, tmp,
> 				&grp->bb_prealloc_list, pa_group_list) {<...>
> 
> +		if (!free)
> +			this_cpu_inc(discard_pa_seq);   // we should do this here before calling
> list_del(&pa->pa_group_list);

Yup, that looks good.

> 		/* we can trust pa_free ... */
> 		free += pa->pa_free;
> 		spin_unlock(&pa->pa_lock);
> 
> 		list_del(&pa->pa_group_list);
> 		list_add(&pa->u.pa_tmp_list, &list);
> 	}
> 
> I have some test cases around this to test for cases which were
> failing. Since in world of parallelism you can't be 100% certain of some
> corner case (like this one you just reported).
> But, I don't have my other box rite now where I kept all of those -
> due to some technical issues. I think I should be able to get those by
> next week, if not, I anyways will setup my current machine for testing
> this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
