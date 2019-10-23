Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB60E205E
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404734AbfJWQR0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 12:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404543AbfJWQR0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 12:17:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E14CADF0;
        Wed, 23 Oct 2019 16:17:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DC73B1E4A99; Wed, 23 Oct 2019 18:17:24 +0200 (CEST)
Date:   Wed, 23 Oct 2019 18:17:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 15/22] jbd2: Factor out common parts of stopping and
 restarting a handle
Message-ID: <20191023161724.GE31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-15-jack@suse.cz>
 <20191021174933.GH27850@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021174933.GH27850@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 13:49:33, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:06:01AM +0200, Jan Kara wrote:
> > jbd2__journal_restart() has quite some code that is common with
> > jbd2_journal_stop(). Factor this functionality into stop_this_handle()
> > helper and use it from both functions. Note that this also drops
> > t_handle_lock protection from jbd2__journal_restart() as
> > jbd2_journal_stop() does the same thing without it.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/jbd2/transaction.c | 94 +++++++++++++++++++++++----------------------------
> >  1 file changed, 42 insertions(+), 52 deletions(-)
> > 
> > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > index d648cec3f90f..d4ee02e5161b 100644
> > --- a/fs/jbd2/transaction.c
> > +++ b/fs/jbd2/transaction.c
> > @@ -677,52 +704,30 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
> 
> > -	read_lock(&journal->j_state_lock);
> > -	spin_lock(&transaction->t_handle_lock);
> > -	atomic_sub(handle->h_buffer_credits,
> > -		   &transaction->t_outstanding_credits);
> > -	if (handle->h_rsv_handle) {
> > -		sub_reserved_credits(journal,
> > -				     handle->h_rsv_handle->h_buffer_credits);
> > -	}
> > -	if (atomic_dec_and_test(&transaction->t_updates))
> > -		wake_up(&journal->j_wait_updates);
> > -	tid = transaction->t_tid;
> > -	spin_unlock(&transaction->t_handle_lock);
> > +	jbd_debug(2, "restarting handle %p\n", handle);
> > +	stop_this_handle(handle);
> >  	handle->h_transaction = NULL;
> > -	current->journal_info = NULL;
> >  
> > -	jbd_debug(2, "restarting handle %p\n", handle);
> > +	read_lock(&journal->j_state_lock);
> >  	need_to_start = !tid_geq(journal->j_commit_request, tid);
> >  	read_unlock(&journal->j_state_lock);
> 
> What is j_state_lock protecting at this point?  There's only a 32-bit
> read of j_commit_request at this point.

We could almost drop the lock. To be fully correct, we'd then need to use
READ_ONCE here and WRITE_ONCE in places changing j_commit_request (reasons
are well summarized in recent LWN series on how compiler can screw your
unlocked reads and writes). So probably a fair cleanup but something I've
decided to leave for later.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
