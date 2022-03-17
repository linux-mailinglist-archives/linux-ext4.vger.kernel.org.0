Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD534DC797
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Mar 2022 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiCQNcE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Mar 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiCQNcE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Mar 2022 09:32:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4081D760F;
        Thu, 17 Mar 2022 06:30:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B3F021108;
        Thu, 17 Mar 2022 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647523846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3ogMsPlSaEsoClzjz9EcODCM0amrFlbTL76cPWoxW8=;
        b=pcN5FVkm/AKs2RCVsJd1K1LIyO98Zu1CQZKhqH98cbpzL2YLTnOnD+gH3hVKHaIrz4sw26
        bWC1YwQxLsd1cZ2xrG1Vz+exYEow2tuOVFtkh1Vaq9nVawfiRxYu2bkomxZJaCBYpn0Yji
        ef2LZAPq+8wQLcOnivK0cjw91AmAFEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647523846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3ogMsPlSaEsoClzjz9EcODCM0amrFlbTL76cPWoxW8=;
        b=R7Yce8VYFFfK3zxHtNRCJ6ZE5j12DJroKiFi1ESH613q6iucIg4vUrVOXZJ0J+X3e59Vm6
        lUYg/cqS4aO1vjDw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B8636A3B81;
        Thu, 17 Mar 2022 13:30:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67E37A0615; Thu, 17 Mar 2022 14:30:45 +0100 (CET)
Date:   Thu, 17 Mar 2022 14:30:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] jbd2: Fix null-ptr-deref when process reserved
 list in jbd2_journal_commit_transaction
Message-ID: <20220317133045.hc6vliufp53idb72@quack3.lan>
References: <20220317012755.2621687-1-yebin10@huawei.com>
 <20220317100012.mw7iuvrehlaj5jve@quack3.lan>
 <62331D5C.2010808@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62331D5C.2010808@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-03-22 19:37:00, yebin wrote:
> 
> 
> On 2022/3/17 18:00, Jan Kara wrote:
> > On Thu 17-03-22 09:27:55, Ye Bin wrote:
> > > we got issue as follows:
> > > [   72.796117] EXT4-fs error (device sda): ext4_journal_check_start:83: comm fallocate: Detected aborted journal
> > > [   72.826847] EXT4-fs (sda): Remounting filesystem read-only
> > > fallocate: fallocate failed: Read-only file system
> > > [   74.791830] jbd2_journal_commit_transaction: jh=0xffff9cfefe725d90 bh=0x0000000000000000 end delay
> > > [   74.793597] ------------[ cut here ]------------
> > > [   74.794203] kernel BUG at fs/jbd2/transaction.c:2063!
> > > [   74.794886] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > [   74.795533] CPU: 4 PID: 2260 Comm: jbd2/sda-8 Not tainted 5.17.0-rc8-next-20220315-dirty #150
> > > [   74.798327] RIP: 0010:__jbd2_journal_unfile_buffer+0x3e/0x60
> > > [   74.801971] RSP: 0018:ffffa828c24a3cb8 EFLAGS: 00010202
> > > [   74.802694] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > [   74.803601] RDX: 0000000000000001 RSI: ffff9cfefe725d90 RDI: ffff9cfefe725d90
> > > [   74.804554] RBP: ffff9cfefe725d90 R08: 0000000000000000 R09: ffffa828c24a3b20
> > > [   74.805471] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9cfefe725d90
> > > [   74.806385] R13: ffff9cfefe725d98 R14: 0000000000000000 R15: ffff9cfe833a4d00
> > > [   74.807301] FS:  0000000000000000(0000) GS:ffff9d01afb00000(0000) knlGS:0000000000000000
> > > [   74.808338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   74.809084] CR2: 00007f2b81bf4000 CR3: 0000000100056000 CR4: 00000000000006e0
> > > [   74.810047] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [   74.810981] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [   74.811897] Call Trace:
> > > [   74.812241]  <TASK>
> > > [   74.812566]  __jbd2_journal_refile_buffer+0x12f/0x180
> > > [   74.813246]  jbd2_journal_refile_buffer+0x4c/0xa0
> > > [   74.813869]  jbd2_journal_commit_transaction.cold+0xa1/0x148
> > > [   74.817550]  kjournald2+0xf8/0x3e0
> > > [   74.819056]  kthread+0x153/0x1c0
> > > [   74.819963]  ret_from_fork+0x22/0x30
> > > 
> > > Above issue may happen as follows:
> > >          write                   truncate                   kjournald2
> > > generic_perform_write
> > >   ext4_write_begin
> > >    ext4_walk_page_buffers
> > >     do_journal_get_write_access ->add BJ_Reserved list
> > >   ext4_journalled_write_end
> > >    ext4_walk_page_buffers
> > >     write_end_fn
> > >      ext4_handle_dirty_metadata
> > >                  ***************JBD2 ABORT**************
> > >       jbd2_journal_dirty_metadata
> > >   -> return -EROFS, jh in reserved_list
> > >                                                     jbd2_journal_commit_transaction
> > >                                                      while (commit_transaction->t_reserved_list)
> > >                                                        jh = commit_transaction->t_reserved_list;
> > >                          truncate_pagecache_range
> > >                           do_invalidatepage
> > > 			  ext4_journalled_invalidatepage
> > > 			   jbd2_journal_invalidatepage
> > > 			    journal_unmap_buffer
> > > 			     __dispose_buffer
> > > 			      __jbd2_journal_unfile_buffer
> > > 			       jbd2_journal_put_journal_head ->put last ref_count
> > > 			        __journal_remove_journal_head
> > > 				 bh->b_private = NULL;
> > > 				 jh->b_bh = NULL;
> > > 				                      jbd2_journal_refile_buffer(journal, jh);
> > > 							bh = jh2bh(jh);
> > > 							->bh is NULL, later will trigger null-ptr-deref
> > > 				 journal_free_journal_head(jh);
> > > 
> > > As after 96f1e0974575 commit, handle reserved list will not hold "journal->j_state_lock"
> > > when kjournald2 commit transaction. So journal_unmap_buffer maybe free
> > > journal_head when handle reserved list. And lead to null-ptr-deref or some
> > > strange errors.
> > > As reserved list almost time is empty. Use "journal->j_state_lock" to protect
> > > handle reserved list can simply solve above issue.
> > > 
> > > Fixes: 96f1e0974575("jbd2: avoid long hold times of j_state_lock while committing a transaction")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Good spotting! Thanks for the analysis and the patch!
> > 
> > > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > > index 5b9408e3b370..2b737b928d26 100644
> > > --- a/fs/jbd2/commit.c
> > > +++ b/fs/jbd2/commit.c
> > > @@ -488,7 +488,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> > >   	jbd2_journal_wait_updates(journal);
> > >   	commit_transaction->t_state = T_SWITCH;
> > > -	write_unlock(&journal->j_state_lock);
> > >   	J_ASSERT (atomic_read(&commit_transaction->t_outstanding_credits) <=
> > >   			journal->j_max_transaction_buffers);
> > > @@ -527,6 +526,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> > >   		jbd2_journal_refile_buffer(journal, jh);
> > >   	}
> > > +	write_unlock(&journal->j_state_lock);
> > >   	/*
> > >   	 * Now try to drop any written-back buffers from the journal's
> > >   	 * checkpoint lists.  We do this *before* commit because it potentially
> > Honestly, using j_state_lock seems like unnecessarily big hammer for this.
> > I'd rather use journal->j_list_lock for this which is much more natural for
> > list processing. And we grab it anyway from jbd2_journal_refile_buffer() so
> > it is not like there will be any additional overhead anyway.
> > 
> > 								Honza
> If use journal->j_list_lock for reserved list, we must change order of
> jh->b_state_lock and
> journal->j_list_lock.
> <../cgi-bin/global.cgi?pattern=j_list_lock&type=symbol>
> I have another idea as follows. Do you think it is feasible?

Oh right, I forgot the lock ordering is not very convenient for these two
locks. Ok, then I probably prefer your original solution to the one below.
But please add a comment like:

We use journal->j_state_lock here to serialize processing of
t_reserved_list with eviction of buffers from journal_unmap_buffer().

Thanks!

								Honza


> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 73ed02f061e1..00c51a92a5cc 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2282,6 +2282,7 @@ static int journal_unmap_buffer(journal_t *journal,
> struct buffer_head *bh,
>         if (!jh)
>                 goto zap_buffer_unlocked;
> 
> +repeat:
>         /* OK, we have data buffer in journaled mode */
>         write_lock(&journal->j_state_lock);
>         spin_lock(&jh->b_state_lock);
> @@ -2357,6 +2358,11 @@ static int journal_unmap_buffer(journal_t *journal,
> struct buffer_head *bh,
>                                 goto zap_buffer;
>                         }
>                 }
> +       } else if (transaction->t_state == T_SWITCH) {
> +               spin_unlock(&journal->j_list_lock);
> +               spin_unlock(&jh->b_state_lock);
> +               wait_transaction_switching(journal);
> +               goto repeat;
>         } else if (transaction == journal->j_committing_transaction) {
>                 JBUFFER_TRACE(jh, "on committing transaction");
>                 /*
> --
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
