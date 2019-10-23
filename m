Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500E3E1BC9
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405591AbfJWNJk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 09:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405577AbfJWNJi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 09:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C858B183;
        Wed, 23 Oct 2019 13:09:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03FDD1E4A89; Wed, 23 Oct 2019 15:09:35 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:09:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 16/22] jbd2: Account descriptor blocks into
 t_outstanding_credits
Message-ID: <20191023130934.GA31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-16-jack@suse.cz>
 <20191021210420.GA24015@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021210420.GA24015@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 17:04:20, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:06:02AM +0200, Jan Kara wrote:
> > Currently, journal descriptor blocks were not accounted in
> > transaction->t_outstanding_credits and we were just leaving some slack
> > space in the journal for them (in jbd2_log_space_left() and
> > jbd2_space_needed()). This is making proper accounting (and reservation
> > we want to add) of descriptor blocks difficult so switch to accounting
> > descriptor blocks in transaction->t_outstanding_credits and just reserve
> > the same amount of credits in t_outstanding credits for journal
> > descriptor blocks when creating transaction.
> 
> This changes the meaning of t_oustanding credits; in particular the
> documentation of t_outstanding_credits in include/linux/jbd2.h is no
> longer correct, as it currently defines it has containing:
> 
>      Number of buffers reserved for use by all handles in this transaction
>      handle but not yet modified. [none]

Right, I can improve the description to better match the new meaning.

> Previously, t_outstanding_credits would go to zero once all of the
> handles attached to the transaction were closed.  Now, it is
> initialized to j_max_transaction_buffers >> 32, and once all of the
> handles are closed t_outstanding_credits will go back to that value.
> It then gets decremented as we write each jbd descriptor block
> (whether it is for a revoke block or a data block) during the commit
> and we throw a warning if we ever write more than j_max_transaction_buffers >> 32
> descriptor blocks.
> 
> Is that a fair summary of what happens after this commit?

Yes, that's correct.

> The thing is, I don't see how this helps the rest of the patch series;
> we account for space needed for the revoke blocks in later patches,
> but I don't see that adjusting t_outstanding credits.  We reserve
> extra space for the revoke blocks, and we then account for that space,
> but the fact that we have accounted for all of the extra descriptor
> blocks in t_outstanding_credits doesn't seem to be changed.  As a
> result, we appear to be double-counting the space needed for the
> revoke descriptor blocks.  Which is fine; I don't mind the accounting
> being a bit more conservative, but I find myself being a bit puzzled
> about why this change is necessary or adds value.

As you properly mentioned above the new meaning of t_outstanding_credits
is meant to be "the amount of space reserved for the transaction in the
journal". This is including all the descriptor blocks the transaction may
need. And it seemed easier to me to change t_outstanding_credits to this
new meaning because later the amount of space reserved for descriptor
blocks stops being constant so we would have to change several places to
use "t_outstanding_credits + t_descritor_credits" instead which gets
especially tricky in cases where we manipulate t_outstanding_credits
atomically (start_this_handle(), add_transaction_credits() in particular).

WRT double-accounting of credits reserved for descriptor blocks: Yes,
revoke descriptor blocks get accounted separately later in the series and
my plan was to shrink the estimate in jbd2_descriptor_blocks_per_trans() at
the end of the series to match the fact that now we need to account only
for commit block and other control blocks which are much more limited.
Which I forgot about in the end. So I will add a patch to do that now.
Thanks for the review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
