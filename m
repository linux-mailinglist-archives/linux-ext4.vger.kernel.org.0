Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761D632762
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiKUPKF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiKUPJr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 10:09:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52226D299F
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 07:00:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECFA11F8B6;
        Mon, 21 Nov 2022 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669042818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2NRcHs2ncRsZN9m25VxQvWakV7gY8kI00r4Y1adH1Q=;
        b=OPaovobb23hZanqiHTPAKLWkP13VR4Xk/QRQi91E1HH2+VJrfgWaQzNj0wL8GuOPvuPd4G
        3qqpNRZYd5ryP6lGWHkwEeBazq7WaPdZjoEmTLKkaZhNCfksXC1smBBm2NKdrKr9KE5TCc
        iGu2dhGYKV8VX9AuWleBhlN2FiRXL8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669042818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2NRcHs2ncRsZN9m25VxQvWakV7gY8kI00r4Y1adH1Q=;
        b=Bnv1q5onKqMzEbHJ47pb/Nq0KqrjcX1YPN52TwZq1r7rSUV1andcAVjP7JRozKPuT278+h
        6Bon0FlEF3OhV8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C51631376E;
        Mon, 21 Nov 2022 15:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zg0YMIKSe2PCLwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 15:00:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F1AAA070A; Mon, 21 Nov 2022 16:00:18 +0100 (CET)
Date:   Mon, 21 Nov 2022 16:00:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221121150018.tq63ot6qja3mfhpw@quack3>
References: <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
 <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111155238.GA32201@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221121133559.srie6oy47udavj52@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dvcxkjuknopm7mxt"
Content-Disposition: inline
In-Reply-To: <20221121133559.srie6oy47udavj52@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--dvcxkjuknopm7mxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 21-11-22 14:35:59, Jan Kara wrote:
> On Fri 11-11-22 07:52:38, Jeremi Piotrowski wrote:
> > On Fri, Nov 11, 2022 at 07:10:29AM -0800, Jeremi Piotrowski wrote:
> > > On Fri, Nov 11, 2022 at 03:24:24PM +0100, Jan Kara wrote:
> > > > On Thu 10-11-22 11:27:01, Jeremi Piotrowski wrote:
> > > > > On Thu, Nov 10, 2022 at 04:26:37PM +0100, Jan Kara wrote:
> > > > > > On Thu 10-11-22 04:57:58, Jeremi Piotrowski wrote:
> > > > > > > On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> > > > > > > > On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > > > > > > > > Hello Honza,
> > > > > > > > > 
> > > > > > > > > > Yeah, I was pondering about this for some time but still I have no clue who
> > > > > > > > > > could be holding the buffer lock (which blocks the task holding the
> > > > > > > > > > transaction open) or how this could related to the commit you have
> > > > > > > > > > identified. I have two things to try:
> > > > > > > > > > 
> > > > > > > > > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > > > > > > > > kernel? The thing is that xattr handling code in ext4 has there some
> > > > > > > > > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > > > > > > > > entries from cache on freeing") in particular.
> > > > > > > > > 
> > > > > > > > > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > > > > > > > > would need to spend quite some effort ingesting it first (mostly, make sure
> > > > > > > > > the new kernel does not break something unrelated). Flatcar is an
> > > > > > > > > image-based distro, so kernel updates imply full distro updates.
> > > > > > > > 
> > > > > > > > OK, understood.
> > > > > > > > 
> > > > > > > > > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > > > > > > > > please reproduce the failure with it and post the output of "echo w
> > > > > > > > > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > > > > > > > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > > > > > > > > 
> > > > > > > > > This would be more straightforward - I can reach out to one of our users
> > > > > > > > > suffering from the issue; they can reliably reproduce it and don't shy away
> > > > > > > > > from patching their kernel. Where can I find the patch?
> > > > > > > > 
> > > > > > > > Ha, my bad. I forgot to attach it. Here it is.
> > > > > > > > 
> > > > > > > 
> > > > > > > Unfortunately this patch produced no output, but I have been able to repro so I
> > > > > > > understand why: except for the hung tasks, we have 1+ tasks busy-looping through
> > > > > > > the following code in ext4_xattr_block_set():
> > > > > > > 
> > > > > > > inserted:
> > > > > > >         if (!IS_LAST_ENTRY(s->first)) {
> > > > > > >                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
> > > > > > >                                                      &ce);
> > > > > > >                 if (new_bh) {
> > > > > > >                         /* We found an identical block in the cache. */
> > > > > > >                         if (new_bh == bs->bh)
> > > > > > >                                 ea_bdebug(new_bh, "keeping");
> > > > > > >                         else {
> > > > > > >                                 u32 ref;
> > > > > > > 
> > > > > > >                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
> > > > > > > 
> > > > > > >                                 /* The old block is released after updating
> > > > > > >                                    the inode. */
> > > > > > >                                 error = dquot_alloc_block(inode,
> > > > > > >                                                 EXT4_C2B(EXT4_SB(sb), 1));
> > > > > > >                                 if (error)
> > > > > > >                                         goto cleanup;
> > > > > > >                                 BUFFER_TRACE(new_bh, "get_write_access");
> > > > > > >                                 error = ext4_journal_get_write_access(
> > > > > > >                                                 handle, sb, new_bh,
> > > > > > >                                                 EXT4_JTR_NONE);
> > > > > > >                                 if (error)
> > > > > > >                                         goto cleanup_dquot;
> > > > > > >                                 lock_buffer(new_bh);
> > > > > > >                                 /*
> > > > > > >                                  * We have to be careful about races with
> > > > > > >                                  * adding references to xattr block. Once we
> > > > > > >                                  * hold buffer lock xattr block's state is
> > > > > > >                                  * stable so we can check the additional
> > > > > > >                                  * reference fits.
> > > > > > >                                  */
> > > > > > >                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
> > > > > > >                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
> > > > > > >                                         /*
> > > > > > >                                          * Undo everything and check mbcache
> > > > > > >                                          * again.
> > > > > > >                                          */
> > > > > > >                                         unlock_buffer(new_bh);
> > > > > > >                                         dquot_free_block(inode,
> > > > > > >                                                          EXT4_C2B(EXT4_SB(sb),
> > > > > > >                                                                   1));
> > > > > > >                                         brelse(new_bh);
> > > > > > >                                         mb_cache_entry_put(ea_block_cache, ce);
> > > > > > >                                         ce = NULL;
> > > > > > >                                         new_bh = NULL;
> > > > > > >                                         goto inserted;
> > > > > > >                                 }
> > > > > > > 
> > > > > > > The tasks keep taking the 'goto inserted' branch, and never finish. I've been
> > > > > > > able to repro with kernel v6.0.7 as well.
> > > > > > 
> > > > > > Interesting! That makes is much clearer (and also makes my debug patch
> > > > > > unnecessary). So clearly the e_reusable variable in the mb_cache_entry got
> > > > > > out of sync with the number of references really in the xattr block - in
> > > > > > particular the block likely has h_refcount >= EXT4_XATTR_REFCOUNT_MAX but
> > > > > > e_reusable is set to true. Now I can see how e_reusable can stay at false due
> > > > > > to a race when refcount is actually smaller but I don't see how it could
> > > > > > stay at true when refcount is big enough - that part seems to be locked
> > > > > > properly. If you can reproduce reasonably easily, can you try reproducing
> > > > > > with attached patch? Thanks!
> > > > > > 
> > > > > 
> > > > > Sure, with that patch I'm getting the following output, reusable is false on
> > > > > most items until we hit something with reusable true and then that loops
> > > > > indefinitely:
> > > > 
> > > > Thanks. So that is what I've suspected. I'm still not 100% clear on how
> > > > this inconsistency can happen although I have a suspicion - does attached
> > > > patch fix the problem for you?
> > > > 
> > > > Also is it possible to share the reproducer or it needs some special
> > > > infrastructure?
> > > > 
> > > > 								Honza
> > > 
> > > I'll test the patch and report back.
> > > 
> > > Attached you'll find the reproducer, for me it reproduces within a few minutes.
> > > It brings up a k8s node and then runs 3 instances of the application which
> > > creates a lot of small files in a loop. The OS we run it on has selinux enabled
> > > in permissive mode, that might play a role.
> > > 
> > 
> > I can still reproduce it with the patch.
> 
> Thanks for the answer! So I was trying to make your reproducer work on my
> system but it was not so easy on openSUSE ;). Anyway, when working on this
> I've realized there may be a simpler way to tickle the bug and indeed, I
> can now trigger it with a simple C program. So thanks for your help, I'm
> now debugging the issue on my system.

OK, attached patch fixes the deadlock for me. Can you test whether it fixes
the problem for you as well? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--dvcxkjuknopm7mxt
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Fix-deadlock-due-to-mbcache-entry-corruption.patch"

From 513b8ebc1df41937b2d522e21668584d8b5a48a1 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 21 Nov 2022 15:44:10 +0100
Subject: [PATCH] ext4: Fix deadlock due to mbcache entry corruption

When manipulating xattr blocks, we can deadlock infinitely looping
inside ext4_xattr_block_set() where we constantly keep finding xattr
block for reuse in mbcache but we are unable to reuse it because its
reference count is too big. This happens because cache entry for the
xattr block is marked as reusable (e_reusable set) although its
reference count is too big. When this inconsistency happens, this
inconsistent state is kept indefinitely and so ext4_xattr_block_set()
keeps retrying indefinitely.

The inconsistent state is caused by non-atomic update of e_reusable bit.
e_reusable is part of a bitfield and e_reusable update can race with
update of e_referenced bit in the same bitfield resulting in loss of one
of the updates. Fix the problem by using atomic bitops instead.

CC: stable@vger.kernel.org
Fixes: 6048c64b2609 ("mbcache: add reusable flag to cache entries")
Reported-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Reported-by: Thilo Fromm <t-lo@linux.microsoft.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c         |  4 ++--
 fs/mbcache.c            | 14 ++++++++------
 include/linux/mbcache.h |  9 +++++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 800ce5cdb9d2..08043aa72cf1 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1281,7 +1281,7 @@ ext4_xattr_release_block(handle_t *handle, struct inode *inode,
 				ce = mb_cache_entry_get(ea_block_cache, hash,
 							bh->b_blocknr);
 				if (ce) {
-					ce->e_reusable = 1;
+					set_bit(MBE_REUSABLE_B, &ce->e_flags);
 					mb_cache_entry_put(ea_block_cache, ce);
 				}
 			}
@@ -2042,7 +2042,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				}
 				BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
 				if (ref == EXT4_XATTR_REFCOUNT_MAX)
-					ce->e_reusable = 0;
+					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
 				ea_bdebug(new_bh, "reusing; refcount now=%d",
 					  ref);
 				ext4_xattr_block_csum_set(inode, new_bh);
diff --git a/fs/mbcache.c b/fs/mbcache.c
index e272ad738faf..2a4b8b549e93 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -100,8 +100,9 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	atomic_set(&entry->e_refcnt, 2);
 	entry->e_key = key;
 	entry->e_value = value;
-	entry->e_reusable = reusable;
-	entry->e_referenced = 0;
+	entry->e_flags = 0;
+	if (reusable)
+		set_bit(MBE_REUSABLE_B, &entry->e_flags);
 	head = mb_cache_entry_head(cache, key);
 	hlist_bl_lock(head);
 	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
@@ -165,7 +166,8 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	while (node) {
 		entry = hlist_bl_entry(node, struct mb_cache_entry,
 				       e_hash_list);
-		if (entry->e_key == key && entry->e_reusable &&
+		if (entry->e_key == key &&
+		    test_bit(MBE_REUSABLE_B, &entry->e_flags) &&
 		    atomic_inc_not_zero(&entry->e_refcnt))
 			goto out;
 		node = node->next;
@@ -284,7 +286,7 @@ EXPORT_SYMBOL(mb_cache_entry_delete_or_get);
 void mb_cache_entry_touch(struct mb_cache *cache,
 			  struct mb_cache_entry *entry)
 {
-	entry->e_referenced = 1;
+	set_bit(MBE_REFERENCED_B, &entry->e_flags);
 }
 EXPORT_SYMBOL(mb_cache_entry_touch);
 
@@ -309,9 +311,9 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 		entry = list_first_entry(&cache->c_list,
 					 struct mb_cache_entry, e_list);
 		/* Drop initial hash reference if there is no user */
-		if (entry->e_referenced ||
+		if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
 		    atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
-			entry->e_referenced = 0;
+			clear_bit(MBE_REFERENCED_B, &entry->e_flags);
 			list_move_tail(&entry->e_list, &cache->c_list);
 			continue;
 		}
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 2da63fd7b98f..97e64184767d 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -10,6 +10,12 @@
 
 struct mb_cache;
 
+/* Cache entry flags */
+enum {
+	MBE_REFERENCED_B = 0,
+	MBE_REUSABLE_B
+};
+
 struct mb_cache_entry {
 	/* List of entries in cache - protected by cache->c_list_lock */
 	struct list_head	e_list;
@@ -26,8 +32,7 @@ struct mb_cache_entry {
 	atomic_t		e_refcnt;
 	/* Key in hash - stable during lifetime of the entry */
 	u32			e_key;
-	u32			e_referenced:1;
-	u32			e_reusable:1;
+	unsigned long		e_flags;
 	/* User provided value - stable during lifetime of the entry */
 	u64			e_value;
 };
-- 
2.35.3


--dvcxkjuknopm7mxt--
