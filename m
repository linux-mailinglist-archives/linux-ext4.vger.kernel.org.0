Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0A6342FF
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Nov 2022 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKVRxI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Nov 2022 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiKVRw2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Nov 2022 12:52:28 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94A15B961A
        for <linux-ext4@vger.kernel.org>; Tue, 22 Nov 2022 09:48:40 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id BA03320B717A; Tue, 22 Nov 2022 09:48:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA03320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669139287;
        bh=MdGAdeNQYdvRiHl1oLCKAcHKDmeK9AlUZj2XSrndgQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruCLKfD0l5XLSlKrECT+P4aImxvBPduuhiX6rroyCELMOlIQTJY0wtmV+0GbnJR4k
         M60VveKMyvc27SP34Vq5YpvDUYgkwaQGsg/2ImnIUwQV1APKVZZrSOOxboMRhAWDJ1
         npGAvBZ0BbXF9SA/X4HLvWfPLdoz963a38N1VDTc=
Date:   Tue, 22 Nov 2022 09:48:07 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221122174807.GA9658@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
 <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111155238.GA32201@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221121133559.srie6oy47udavj52@quack3>
 <20221121150018.tq63ot6qja3mfhpw@quack3>
 <20221121181558.GA9006@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221122115715.kxqhsk2xs4nrofyb@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20221122115715.kxqhsk2xs4nrofyb@quack3>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2022 at 12:57:15PM +0100, Jan Kara wrote:
> On Mon 21-11-22 10:15:58, Jeremi Piotrowski wrote:
> > On Mon, Nov 21, 2022 at 04:00:18PM +0100, Jan Kara wrote:
> > > 
> > > OK, attached patch fixes the deadlock for me. Can you test whether it fixes
> > > the problem for you as well? Thanks!
> > 
> > I'll test the fix tomorrow, but I've noticed it doesn't apply cleanly to
> > 5.15.78, which seems to be missing:
> > 
> > - 5fc4cbd9fde5d4630494fd6ffc884148fb618087 mbcache: Avoid nesting of cache->c_list_lock under bit locks
> >   (this one is marked for stable but not in 5.15?)
> > - 307af6c879377c1c63e71cbdd978201f9c7ee8df mbcache: automatically delete entries from cache on freeing
> >   (this one is not marked for stable)
> > 
> > So either a special backport is needed or these two would need to be applied as
> > well.
> 
> Right. The fix is against current mainline kernel. Stable tree backports
> are a second step once the fix is confirmed to work :). Let me know in case
> you need help with porting to the kernel version you need for testing.
> 

I confirm that this patch fixes things with the more complicated reproducer :)
Attached is my tweaked version of the patch that applies against 5.15.

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0001-ext4-Fix-deadlock-due-to-mbcache-en.patch"

From e7ec42e181c6213d1fd71b946196f05af601ba5c Mon Sep 17 00:00:00 2001
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
index 533216e80fa2..22700812a4d3 100644
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
index 2010bc80a3f2..ac07b50ea3df 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -94,8 +94,9 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	atomic_set(&entry->e_refcnt, 1);
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
@@ -155,7 +156,8 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	while (node) {
 		entry = hlist_bl_entry(node, struct mb_cache_entry,
 				       e_hash_list);
-		if (entry->e_key == key && entry->e_reusable) {
+		if (entry->e_key == key &&
+		    test_bit(MBE_REUSABLE_B, &entry->e_flags)) {
 			atomic_inc(&entry->e_refcnt);
 			goto out;
 		}
@@ -325,7 +327,7 @@ EXPORT_SYMBOL(mb_cache_entry_delete_or_get);
 void mb_cache_entry_touch(struct mb_cache *cache,
 			  struct mb_cache_entry *entry)
 {
-	entry->e_referenced = 1;
+	set_bit(MBE_REFERENCED_B, &entry->e_flags);
 }
 EXPORT_SYMBOL(mb_cache_entry_touch);
 
@@ -350,8 +352,8 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 	while (nr_to_scan-- && !list_empty(&cache->c_list)) {
 		entry = list_first_entry(&cache->c_list,
 					 struct mb_cache_entry, e_list);
-		if (entry->e_referenced || atomic_read(&entry->e_refcnt) > 2) {
-			entry->e_referenced = 0;
+		if (test_bit(MBE_REFERENCED_B, &entry->e_flags) || atomic_read(&entry->e_refcnt) > 2) {
+			clear_bit(MBE_REFERENCED_B, &entry->e_flags);
 			list_move_tail(&entry->e_list, &cache->c_list);
 			continue;
 		}
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 8eca7f25c432..62927f7e2588 100644
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
@@ -18,8 +24,7 @@ struct mb_cache_entry {
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
2.25.1


--X1bOJ3K7DJ5YkBrT--
