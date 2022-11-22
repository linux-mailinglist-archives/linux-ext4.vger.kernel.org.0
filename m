Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB7633BED
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Nov 2022 12:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiKVL5T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Nov 2022 06:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKVL5S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Nov 2022 06:57:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D6252BF
        for <linux-ext4@vger.kernel.org>; Tue, 22 Nov 2022 03:57:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7BA11F895;
        Tue, 22 Nov 2022 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669118235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/dng8lkIOg2faeoiWNDy4THx3GcF8vZLPRk/zBusf+4=;
        b=OJicdSbbWcmOYwcZGkh6xPgwJ8IrHa8oXYCYPiRLmB1yThfMTtkgnw9Vu5/1GjBGnP4Luc
        bOiKMzP7pqX/1FCo64/j4NaSooPWttg/BTNQvML6SHKNEaxtQ38Qjhp6Q5ylaS1sufQvfW
        ngWQQyA4iCWn1dzSjmNJKyqlPbTGs0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669118235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/dng8lkIOg2faeoiWNDy4THx3GcF8vZLPRk/zBusf+4=;
        b=0kS9kOi2r6qGLOrsIRpJNFOo2CLIzvjiyEYAAapf3WKzr1CUOBOhocnE/TohJVvWSBWFBB
        0AcrFXYqzXWuh/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C404C13AA1;
        Tue, 22 Nov 2022 11:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4QjBLxu5fGMWFgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Nov 2022 11:57:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C379A070E; Tue, 22 Nov 2022 12:57:15 +0100 (CET)
Date:   Tue, 22 Nov 2022 12:57:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221122115715.kxqhsk2xs4nrofyb@quack3>
References: <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
 <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111155238.GA32201@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221121133559.srie6oy47udavj52@quack3>
 <20221121150018.tq63ot6qja3mfhpw@quack3>
 <20221121181558.GA9006@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121181558.GA9006@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-11-22 10:15:58, Jeremi Piotrowski wrote:
> On Mon, Nov 21, 2022 at 04:00:18PM +0100, Jan Kara wrote:
> > On Mon 21-11-22 14:35:59, Jan Kara wrote:
> > > On Fri 11-11-22 07:52:38, Jeremi Piotrowski wrote:
> > > > On Fri, Nov 11, 2022 at 07:10:29AM -0800, Jeremi Piotrowski wrote:
> > > > > On Fri, Nov 11, 2022 at 03:24:24PM +0100, Jan Kara wrote:
> > > > > > On Thu 10-11-22 11:27:01, Jeremi Piotrowski wrote:
> > > > > > > On Thu, Nov 10, 2022 at 04:26:37PM +0100, Jan Kara wrote:
> > > > > > > > On Thu 10-11-22 04:57:58, Jeremi Piotrowski wrote:
> > > > > > > > > On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> > > > > > > > > > On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > > > > > > > > > > Hello Honza,
> > > > > > > > > > > 
> > > > > > > > > > > > Yeah, I was pondering about this for some time but still I have no clue who
> > > > > > > > > > > > could be holding the buffer lock (which blocks the task holding the
> > > > > > > > > > > > transaction open) or how this could related to the commit you have
> > > > > > > > > > > > identified. I have two things to try:
> > > > > > > > > > > > 
> > > > > > > > > > > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > > > > > > > > > > kernel? The thing is that xattr handling code in ext4 has there some
> > > > > > > > > > > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > > > > > > > > > > entries from cache on freeing") in particular.
> > > > > > > > > > > 
> > > > > > > > > > > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > > > > > > > > > > would need to spend quite some effort ingesting it first (mostly, make sure
> > > > > > > > > > > the new kernel does not break something unrelated). Flatcar is an
> > > > > > > > > > > image-based distro, so kernel updates imply full distro updates.
> > > > > > > > > > 
> > > > > > > > > > OK, understood.
> > > > > > > > > > 
> > > > > > > > > > > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > > > > > > > > > > please reproduce the failure with it and post the output of "echo w
> > > > > > > > > > > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > > > > > > > > > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > > > > > > > > > > 
> > > > > > > > > > > This would be more straightforward - I can reach out to one of our users
> > > > > > > > > > > suffering from the issue; they can reliably reproduce it and don't shy away
> > > > > > > > > > > from patching their kernel. Where can I find the patch?
> > > > > > > > > > 
> > > > > > > > > > Ha, my bad. I forgot to attach it. Here it is.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Unfortunately this patch produced no output, but I have been able to repro so I
> > > > > > > > > understand why: except for the hung tasks, we have 1+ tasks busy-looping through
> > > > > > > > > the following code in ext4_xattr_block_set():
> > > > > > > > > 
> > > > > > > > > inserted:
> > > > > > > > >         if (!IS_LAST_ENTRY(s->first)) {
> > > > > > > > >                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
> > > > > > > > >                                                      &ce);
> > > > > > > > >                 if (new_bh) {
> > > > > > > > >                         /* We found an identical block in the cache. */
> > > > > > > > >                         if (new_bh == bs->bh)
> > > > > > > > >                                 ea_bdebug(new_bh, "keeping");
> > > > > > > > >                         else {
> > > > > > > > >                                 u32 ref;
> > > > > > > > > 
> > > > > > > > >                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
> > > > > > > > > 
> > > > > > > > >                                 /* The old block is released after updating
> > > > > > > > >                                    the inode. */
> > > > > > > > >                                 error = dquot_alloc_block(inode,
> > > > > > > > >                                                 EXT4_C2B(EXT4_SB(sb), 1));
> > > > > > > > >                                 if (error)
> > > > > > > > >                                         goto cleanup;
> > > > > > > > >                                 BUFFER_TRACE(new_bh, "get_write_access");
> > > > > > > > >                                 error = ext4_journal_get_write_access(
> > > > > > > > >                                                 handle, sb, new_bh,
> > > > > > > > >                                                 EXT4_JTR_NONE);
> > > > > > > > >                                 if (error)
> > > > > > > > >                                         goto cleanup_dquot;
> > > > > > > > >                                 lock_buffer(new_bh);
> > > > > > > > >                                 /*
> > > > > > > > >                                  * We have to be careful about races with
> > > > > > > > >                                  * adding references to xattr block. Once we
> > > > > > > > >                                  * hold buffer lock xattr block's state is
> > > > > > > > >                                  * stable so we can check the additional
> > > > > > > > >                                  * reference fits.
> > > > > > > > >                                  */
> > > > > > > > >                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
> > > > > > > > >                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
> > > > > > > > >                                         /*
> > > > > > > > >                                          * Undo everything and check mbcache
> > > > > > > > >                                          * again.
> > > > > > > > >                                          */
> > > > > > > > >                                         unlock_buffer(new_bh);
> > > > > > > > >                                         dquot_free_block(inode,
> > > > > > > > >                                                          EXT4_C2B(EXT4_SB(sb),
> > > > > > > > >                                                                   1));
> > > > > > > > >                                         brelse(new_bh);
> > > > > > > > >                                         mb_cache_entry_put(ea_block_cache, ce);
> > > > > > > > >                                         ce = NULL;
> > > > > > > > >                                         new_bh = NULL;
> > > > > > > > >                                         goto inserted;
> > > > > > > > >                                 }
> > > > > > > > > 
> > > > > > > > > The tasks keep taking the 'goto inserted' branch, and never finish. I've been
> > > > > > > > > able to repro with kernel v6.0.7 as well.
> > > > > > > > 
> > > > > > > > Interesting! That makes is much clearer (and also makes my debug patch
> > > > > > > > unnecessary). So clearly the e_reusable variable in the mb_cache_entry got
> > > > > > > > out of sync with the number of references really in the xattr block - in
> > > > > > > > particular the block likely has h_refcount >= EXT4_XATTR_REFCOUNT_MAX but
> > > > > > > > e_reusable is set to true. Now I can see how e_reusable can stay at false due
> > > > > > > > to a race when refcount is actually smaller but I don't see how it could
> > > > > > > > stay at true when refcount is big enough - that part seems to be locked
> > > > > > > > properly. If you can reproduce reasonably easily, can you try reproducing
> > > > > > > > with attached patch? Thanks!
> > > > > > > > 
> > > > > > > 
> > > > > > > Sure, with that patch I'm getting the following output, reusable is false on
> > > > > > > most items until we hit something with reusable true and then that loops
> > > > > > > indefinitely:
> > > > > > 
> > > > > > Thanks. So that is what I've suspected. I'm still not 100% clear on how
> > > > > > this inconsistency can happen although I have a suspicion - does attached
> > > > > > patch fix the problem for you?
> > > > > > 
> > > > > > Also is it possible to share the reproducer or it needs some special
> > > > > > infrastructure?
> > > > > > 
> > > > > > 								Honza
> > > > > 
> > > > > I'll test the patch and report back.
> > > > > 
> > > > > Attached you'll find the reproducer, for me it reproduces within a few minutes.
> > > > > It brings up a k8s node and then runs 3 instances of the application which
> > > > > creates a lot of small files in a loop. The OS we run it on has selinux enabled
> > > > > in permissive mode, that might play a role.
> > > > > 
> > > > 
> > > > I can still reproduce it with the patch.
> > > 
> > > Thanks for the answer! So I was trying to make your reproducer work on my
> > > system but it was not so easy on openSUSE ;). Anyway, when working on this
> > > I've realized there may be a simpler way to tickle the bug and indeed, I
> > > can now trigger it with a simple C program. So thanks for your help, I'm
> > > now debugging the issue on my system.
> > 
> > OK, attached patch fixes the deadlock for me. Can you test whether it fixes
> > the problem for you as well? Thanks!
> 
> I'll test the fix tomorrow, but I've noticed it doesn't apply cleanly to
> 5.15.78, which seems to be missing:
> 
> - 5fc4cbd9fde5d4630494fd6ffc884148fb618087 mbcache: Avoid nesting of cache->c_list_lock under bit locks
>   (this one is marked for stable but not in 5.15?)
> - 307af6c879377c1c63e71cbdd978201f9c7ee8df mbcache: automatically delete entries from cache on freeing
>   (this one is not marked for stable)
> 
> So either a special backport is needed or these two would need to be applied as
> well.

Right. The fix is against current mainline kernel. Stable tree backports
are a second step once the fix is confirmed to work :). Let me know in case
you need help with porting to the kernel version you need for testing.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
