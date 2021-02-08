Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD77C313827
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Feb 2021 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhBHPhR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Feb 2021 10:37:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:59738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhBHPfA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Feb 2021 10:35:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8755CB122;
        Mon,  8 Feb 2021 15:34:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 14DAE1E14C4; Mon,  8 Feb 2021 16:27:50 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:27:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     tytso@mit.edu, Jan Kara <jack@suse.com>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-ext4@vger.kernel.org
Subject: Re: [RFC] Fine-grained locking documentation for jbd2 data structures
Message-ID: <20210208152750.GD30081@quack2.suse.cz>
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
 <14dbc946-b0c5-4165-3e6a-3cbe3c6a74b4@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dbc946-b0c5-4165-3e6a-3cbe3c6a74b4@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Alexander!

On Fri 05-02-21 16:31:54, Alexander Lochmann wrote:
> have you had the chance to review our results?

It fell through the cracks I guess. Thanks for pinging. Let me have a look.

> On 15.10.20 15:56, Alexander Lochmann wrote:
> > Hi folks,
> > 
> > when comparing our generated locking documentation with the current
> > documentation
> > located in include/linux/jbd2.h, I found some inconsistencies. (Our
> > approach: https://dl.acm.org/doi/10.1145/3302424.3303948)
> > According to the official documentation, the following members should be
> > read using a lock:
> > journal_t
> > - j_flags: j_state_lock
> > - j_barrier_count: j_state_lock
> > - j_running_transaction: j_state_lock
> > - j_commit_sequence: j_state_lock
> > - j_commit_request: j_state_lock
> > transactiont_t
> > - t_nr_buffers: j_list_lock
> > - t_buffers: j_list_lock
> > - t_reserved_list: j_list_lock
> > - t_shadow_list: j_list_lock
> > jbd2_inode
> > - i_transaction: j_list_lock
> > - i_next_transaction: j_list_lock
> > - i_flags: j_list_lock
> > - i_dirty_start: j_list_lock
> > - i_dirty_start: j_list_lock
> > 
> > However, our results say that no locks are needed at all for *reading*
> > those members.
> > From what I know, it is common wisdom that word-sized data types can be
> > read without any lock in the Linux kernel.

Yes, although in last year, people try to convert these unlocked reads to
READ_ONCE() or similar as otherwise the compiler is apparently allowed to
generate code which is not safe. But that's a different story. Also note
that although reading that particular word may be safe without any other
locks, the lock still may be needed to safely interpret the value in the
context of other fetched values (e.g., due to consistency among multiple
structure members). So sometimes requiring the lock is just the least
problematic solution - there's always the tradeoff between the speed and
simplicity.

> > All of the above members have word size, i.e., int, long, or ptr.
> > Is it therefore safe to split the locking documentation as follows?
> > @j_flags: General journaling state flags [r:nolocks, w:j_state_lock]

I've checked the code and we usually use unlocked reads for quick, possibly
racy checks and if they indicate we may need to do something then take the
lock and do a reliable check. This is quite common pattern, not sure how to
best document this. Maybe like [j_state_lock, no lock for quick racy checks]?

> > The following members are not word-sizes. Our results also suggest that
> > no locks are needed.
> > Can the proposed change be applied to them as well?
> > transaction_t
> > - t_chp_stats: j_checkpoint_sem

Where do we read t_chp_stats outside of a lock? j_list_lock seems to be
used pretty consistently there. Except perhaps
__jbd2_journal_remove_checkpoint() but there we know we are already the
only ones touching the transaction and thus its statistics.

> > jbd2_inode:
> > - i_list: j_list_lock

And here as well. I would not complicate the locking description unless we
really have places that access these fields without locks...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
