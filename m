Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E560DEC2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJZKS6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiJZKS4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 06:18:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E579DDA5
        for <linux-ext4@vger.kernel.org>; Wed, 26 Oct 2022 03:18:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F09021FF0;
        Wed, 26 Oct 2022 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666779534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAvOcYJU2msOBRHkSh0/+0oDaMvRVY8cSG8HTw+CrWY=;
        b=eMdZXaEZ3phILvlTK4oNa4N49tLMVJPQMVtH+pQE8iwId+EUU2F4pEkNQ1837/PP0s4Zcz
        icARi0n5szrmO1Je0musCYggXmhv9cpid45rkN+YHtAveDF/3jXXwjzvhy6oBFlk/4kMKH
        eXDn3JrB2RR6GtDCIlw9MJSC4E37ztw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666779534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAvOcYJU2msOBRHkSh0/+0oDaMvRVY8cSG8HTw+CrWY=;
        b=BDglwtd5H8NAXqbpcp/PJZCrie7v6PnKglUZk/Y4b63e3eWpfqhaivywzZPYLrPTdJGj8a
        /X5/sD729E+YZMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9181313A77;
        Wed, 26 Oct 2022 10:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ljl7I44JWWOUewAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 26 Oct 2022 10:18:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25EBCA06F9; Wed, 26 Oct 2022 12:18:54 +0200 (CEST)
Date:   Wed, 26 Oct 2022 12:18:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221026101854.k6qgunxexhxthw64@quack3>
References: <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="byvqmrlegsigjfki"
Content-Disposition: inline
In-Reply-To: <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--byvqmrlegsigjfki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> Hello Honza,
> 
> > Yeah, I was pondering about this for some time but still I have no clue who
> > could be holding the buffer lock (which blocks the task holding the
> > transaction open) or how this could related to the commit you have
> > identified. I have two things to try:
> > 
> > 1) Can you please check whether the deadlock reproduces also with 6.0
> > kernel? The thing is that xattr handling code in ext4 has there some
> > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > entries from cache on freeing") in particular.
> 
> This would be complex; we currently do not integrate 6.0 with Flatcar and
> would need to spend quite some effort ingesting it first (mostly, make sure
> the new kernel does not break something unrelated). Flatcar is an
> image-based distro, so kernel updates imply full distro updates.

OK, understood.

> > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > please reproduce the failure with it and post the output of "echo w
> > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> 
> This would be more straightforward - I can reach out to one of our users
> suffering from the issue; they can reliably reproduce it and don't shy away
> from patching their kernel. Where can I find the patch?

Ha, my bad. I forgot to attach it. Here it is.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--byvqmrlegsigjfki
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Debug-buffer_head-lock.patch"

From feaf5e5ca0b22da6a285dc97eb756e0190fa7411 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 24 Oct 2022 12:02:59 +0200
Subject: [PATCH] Debug buffer_head lock

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 13 ++++++++++++-
 include/linux/buffer_head.h | 17 +++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f6d283579491..4514a810f072 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -66,7 +66,18 @@ EXPORT_SYMBOL(touch_buffer);
 
 void __lock_buffer(struct buffer_head *bh)
 {
-	wait_on_bit_lock_io(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE);
+	int loops = 0;
+
+	for (;;) {
+		wait_on_bit_timeout(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE, HZ);
+		if (trylock_buffer(bh))
+			return;
+		loops++;
+		if (WARN_ON(!(loops & 31))) {
+			printk("Waiting for buffer %llu state %lx page flags %lx for %d loops.\n", (unsigned long long)bh->b_blocknr, bh->b_state, bh->b_page->flags, loops);
+			printk("Owner: pid %u file %s:%d\n", bh->lock_pid, bh->lock_file, bh->lock_line);
+		}
+	}
 }
 EXPORT_SYMBOL(__lock_buffer);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 25b4263d66d7..67259a959bac 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -76,6 +76,9 @@ struct buffer_head {
 	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
 					 * serialise IO completion of other
 					 * buffers in the page */
+	char *lock_file;
+	unsigned int lock_line;
+	unsigned int lock_pid;
 };
 
 /*
@@ -395,12 +398,14 @@ static inline int trylock_buffer(struct buffer_head *bh)
 	return likely(!test_and_set_bit_lock(BH_Lock, &bh->b_state));
 }
 
-static inline void lock_buffer(struct buffer_head *bh)
-{
-	might_sleep();
-	if (!trylock_buffer(bh))
-		__lock_buffer(bh);
-}
+#define lock_buffer(bh) do {		\
+	might_sleep();			\
+	if (!trylock_buffer(bh))	\
+		__lock_buffer(bh);	\
+	(bh)->lock_line = __LINE__;	\
+	(bh)->lock_file = __FILE__;	\
+	(bh)->lock_pid = current->pid;	\
+} while (0)
 
 static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 						   sector_t block,
-- 
2.35.3


--byvqmrlegsigjfki--
