Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FA6245C5
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKJP1M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKJP0l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 10:26:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A63C6FF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 07:26:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29BAE1F9A8;
        Thu, 10 Nov 2022 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668093999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPJOoWaO0n/foHTlhils+lb+/QQupsaHoQpi8lxc858=;
        b=tG30dOHzEhPPkMOksYc+eCCW6nVW9UtJq1PeLcC5i9YHrJCmoElKijMuIOueSr5ueqeGbP
        kgF60behMYxOMNZnyfiAH9H0T1O0z4uuowvL54NlIV1Y40CptXjuEQmT2QZmf6Ve+A07Kt
        CbXUso4WB7bKypjJtjgdWx2QeHk3MNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668093999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPJOoWaO0n/foHTlhils+lb+/QQupsaHoQpi8lxc858=;
        b=jnN+NuPswoyYar7QAhpI2yigJdx2Thf+XoNyxxwdywsC3FaLQ3r7rwWbNyfiZTueY1qxfw
        4JhamSMZQDReCcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 076A713B58;
        Thu, 10 Nov 2022 15:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qcjFAS8YbWOZRgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Nov 2022 15:26:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 71529A0704; Thu, 10 Nov 2022 16:26:37 +0100 (CET)
Date:   Thu, 10 Nov 2022 16:26:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221110152637.g64p4hycnd7bfnnr@quack3>
References: <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lfspazkb772shitl"
Content-Disposition: inline
In-Reply-To: <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--lfspazkb772shitl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 10-11-22 04:57:58, Jeremi Piotrowski wrote:
> On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> > On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > > Hello Honza,
> > > 
> > > > Yeah, I was pondering about this for some time but still I have no clue who
> > > > could be holding the buffer lock (which blocks the task holding the
> > > > transaction open) or how this could related to the commit you have
> > > > identified. I have two things to try:
> > > > 
> > > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > > kernel? The thing is that xattr handling code in ext4 has there some
> > > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > > entries from cache on freeing") in particular.
> > > 
> > > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > > would need to spend quite some effort ingesting it first (mostly, make sure
> > > the new kernel does not break something unrelated). Flatcar is an
> > > image-based distro, so kernel updates imply full distro updates.
> > 
> > OK, understood.
> > 
> > > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > > please reproduce the failure with it and post the output of "echo w
> > > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > > 
> > > This would be more straightforward - I can reach out to one of our users
> > > suffering from the issue; they can reliably reproduce it and don't shy away
> > > from patching their kernel. Where can I find the patch?
> > 
> > Ha, my bad. I forgot to attach it. Here it is.
> > 
> 
> Unfortunately this patch produced no output, but I have been able to repro so I
> understand why: except for the hung tasks, we have 1+ tasks busy-looping through
> the following code in ext4_xattr_block_set():
> 
> inserted:
>         if (!IS_LAST_ENTRY(s->first)) {
>                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
>                                                      &ce);
>                 if (new_bh) {
>                         /* We found an identical block in the cache. */
>                         if (new_bh == bs->bh)
>                                 ea_bdebug(new_bh, "keeping");
>                         else {
>                                 u32 ref;
> 
>                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
> 
>                                 /* The old block is released after updating
>                                    the inode. */
>                                 error = dquot_alloc_block(inode,
>                                                 EXT4_C2B(EXT4_SB(sb), 1));
>                                 if (error)
>                                         goto cleanup;
>                                 BUFFER_TRACE(new_bh, "get_write_access");
>                                 error = ext4_journal_get_write_access(
>                                                 handle, sb, new_bh,
>                                                 EXT4_JTR_NONE);
>                                 if (error)
>                                         goto cleanup_dquot;
>                                 lock_buffer(new_bh);
>                                 /*
>                                  * We have to be careful about races with
>                                  * adding references to xattr block. Once we
>                                  * hold buffer lock xattr block's state is
>                                  * stable so we can check the additional
>                                  * reference fits.
>                                  */
>                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
>                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
>                                         /*
>                                          * Undo everything and check mbcache
>                                          * again.
>                                          */
>                                         unlock_buffer(new_bh);
>                                         dquot_free_block(inode,
>                                                          EXT4_C2B(EXT4_SB(sb),
>                                                                   1));
>                                         brelse(new_bh);
>                                         mb_cache_entry_put(ea_block_cache, ce);
>                                         ce = NULL;
>                                         new_bh = NULL;
>                                         goto inserted;
>                                 }
> 
> The tasks keep taking the 'goto inserted' branch, and never finish. I've been
> able to repro with kernel v6.0.7 as well.

Interesting! That makes is much clearer (and also makes my debug patch
unnecessary). So clearly the e_reusable variable in the mb_cache_entry got
out of sync with the number of references really in the xattr block - in
particular the block likely has h_refcount >= EXT4_XATTR_REFCOUNT_MAX but
e_reusable is set to true. Now I can see how e_reusable can stay at false due
to a race when refcount is actually smaller but I don't see how it could
stay at true when refcount is big enough - that part seems to be locked
properly. If you can reproduce reasonably easily, can you try reproducing
with attached patch? Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--lfspazkb772shitl
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Debug-xattr-refcount.patch"

From eb426ff2e678925781cb6804898a321e7e83b433 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 10 Nov 2022 16:22:06 +0100
Subject: [PATCH] ext4: Debug xattr refcount

---
 fs/ext4/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 36d6ba7190b6..ae7d9743f800 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2026,6 +2026,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				 */
 				ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
 				if (ref > EXT4_XATTR_REFCOUNT_MAX) {
+					printk("ce %p ref %u reusable %d\n", ce, ref, (int)ce->e_reusable);
 					/*
 					 * Undo everything and check mbcache
 					 * again.
-- 
2.35.3


--lfspazkb772shitl--
