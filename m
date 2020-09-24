Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3672774B9
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIXPBx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 11:01:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50457 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728139AbgIXPBw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Sep 2020 11:01:52 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08OF0YEO019464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 11:00:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8AF8D42003C; Thu, 24 Sep 2020 11:00:34 -0400 (EDT)
Date:   Thu, 24 Sep 2020 11:00:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 1/2] ext4: Discard preallocations before releasing
 group lock
Message-ID: <20200924150034.GH482521@mit.edu>
References: <20200916113859.1556397-1-yebin10@huawei.com>
 <20200916113859.1556397-2-yebin10@huawei.com>
 <0f17c3a5-2785-939b-47c5-55d39b4bf67b@linux.ibm.com>
 <20200918095653.GF18920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918095653.GF18920@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 11:56:53AM +0200, Jan Kara wrote:
> On Fri 18-09-20 14:37:15, Ritesh Harjani wrote:
> > 
> > 
> > On 9/16/20 5:08 PM, Ye Bin wrote:
> > > From: Jan Kara <jack@suse.cz>
> > > 
> > > ext4_mb_discard_group_preallocations() can be releasing group lock with
> > > preallocations accumulated on its local list. Thus although
> > > discard_pa_seq was incremented and concurrent allocating processes will
> > > be retrying allocations, it can happen that premature ENOSPC error is
> > > returned because blocks used for preallocations are not available for
> > > reuse yet. Make sure we always free locally accumulated preallocations
> > > before releasing group lock.
> > > 
> > > Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ...
> > > +	/* if we still need more blocks and some PAs were used, try again */
> > > +	if (free < needed && busy) {
> > > +		ext4_unlock_group(sb, group);
> > > +		cond_resched();
> > > +		busy = 0;
> > > +		/* Make sure we increment discard_pa_seq again */
> > > +		needed -= free;
> > > +		free = 0;
> > 
> > Oops sorry about getting back to this.
> > But if we are making free 0 here so we may return a wrong free value
> > when we return from this function. We should fix that by also accounting
> > previous freed blocks at the time of final return from this function.
> 
> Ah, good catch! I'll send v2 with this fixed up.

Did you send a v2 of this patch?  I can't find it in my inbox...

Thanks!

					- Ted
