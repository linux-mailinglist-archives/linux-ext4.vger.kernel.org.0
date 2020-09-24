Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF12774F6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgIXPMl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 11:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgIXPMk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 11:12:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3282FACE3;
        Thu, 24 Sep 2020 15:12:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F03391E12DD; Thu, 24 Sep 2020 17:12:38 +0200 (CEST)
Date:   Thu, 24 Sep 2020 17:12:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 1/2] ext4: Discard preallocations before releasing
 group lock
Message-ID: <20200924151238.GA3960@quack2.suse.cz>
References: <20200916113859.1556397-1-yebin10@huawei.com>
 <20200916113859.1556397-2-yebin10@huawei.com>
 <0f17c3a5-2785-939b-47c5-55d39b4bf67b@linux.ibm.com>
 <20200918095653.GF18920@quack2.suse.cz>
 <20200924150034.GH482521@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924150034.GH482521@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-09-20 11:00:34, Theodore Y. Ts'o wrote:
> On Fri, Sep 18, 2020 at 11:56:53AM +0200, Jan Kara wrote:
> > On Fri 18-09-20 14:37:15, Ritesh Harjani wrote:
> > > 
> > > 
> > > On 9/16/20 5:08 PM, Ye Bin wrote:
> > > > From: Jan Kara <jack@suse.cz>
> > > > 
> > > > ext4_mb_discard_group_preallocations() can be releasing group lock with
> > > > preallocations accumulated on its local list. Thus although
> > > > discard_pa_seq was incremented and concurrent allocating processes will
> > > > be retrying allocations, it can happen that premature ENOSPC error is
> > > > returned because blocks used for preallocations are not available for
> > > > reuse yet. Make sure we always free locally accumulated preallocations
> > > > before releasing group lock.
> > > > 
> > > > Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ...
> > > > +	/* if we still need more blocks and some PAs were used, try again */
> > > > +	if (free < needed && busy) {
> > > > +		ext4_unlock_group(sb, group);
> > > > +		cond_resched();
> > > > +		busy = 0;
> > > > +		/* Make sure we increment discard_pa_seq again */
> > > > +		needed -= free;
> > > > +		free = 0;
> > > 
> > > Oops sorry about getting back to this.
> > > But if we are making free 0 here so we may return a wrong free value
> > > when we return from this function. We should fix that by also accounting
> > > previous freed blocks at the time of final return from this function.
> > 
> > Ah, good catch! I'll send v2 with this fixed up.
> 
> Did you send a v2 of this patch?  I can't find it in my inbox...

Yeah, somehow I forgot to send it. I've sent it now:

https://lore.kernel.org/linux-ext4/20200924150959.4335-1-jack@suse.cz

Note that Ye Bin's patch will need trivial context fixup after applying
this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
