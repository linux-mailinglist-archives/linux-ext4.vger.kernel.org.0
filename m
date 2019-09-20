Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5241B92F6
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392515AbfITOgi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 10:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392470AbfITOgh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 10:36:37 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAFD21928;
        Fri, 20 Sep 2019 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990196;
        bh=Nm5ZEPhJ5iW6wy1xtViittGqLfT6Ya6S88l/UkOXLuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXna2tpHNuI5NPsWMl5YPngT7mYeEygUp1y16zF8xmgHBnbuUu2BxOmaJpldPnJ+9
         nTZCllUhIsvNp48AAyeoNehVpRvwoOackZUZMpy+aQTxFTq+CraHgMY1wf6VfYmPjl
         c3XijBZzLsvl/pb3dDhn2T0IYPPz/EwJ2BSOkDFA=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 5/7] random: Remove the blocking pool
Date:   Fri, 20 Sep 2019 07:36:27 -0700
Message-Id: <3ce6a6d7532d90300b45ec7d6b966ef9c052897d.1568990048.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568990048.git.luto@kernel.org>
References: <cover.1568990048.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no longer any interface to read data from the blocking
pool, so remove it.

This enables quite a bit of code deletion, much of which will be
done in subsequent patches.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 106 ------------------------------------------
 1 file changed, 106 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 29a158d9353c..4521138231ed 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -470,7 +470,6 @@ static const struct poolinfo {
 /*
  * Static global variables
  */
-static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 static struct fasync_struct *fasync;
 
@@ -530,7 +529,6 @@ struct entropy_store {
 	__u32 *pool;
 	const char *name;
 	struct entropy_store *pull;
-	struct work_struct push_work;
 
 	/* read-write data: */
 	unsigned long last_pulled;
@@ -549,9 +547,7 @@ static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
 				size_t nbytes, int fips);
 
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r);
-static void push_to_pool(struct work_struct *work);
 static __u32 input_pool_data[INPUT_POOL_WORDS] __latent_entropy;
-static __u32 blocking_pool_data[OUTPUT_POOL_WORDS] __latent_entropy;
 
 static struct entropy_store input_pool = {
 	.poolinfo = &poolinfo_table[0],
@@ -560,16 +556,6 @@ static struct entropy_store input_pool = {
 	.pool = input_pool_data
 };
 
-static struct entropy_store blocking_pool = {
-	.poolinfo = &poolinfo_table[1],
-	.name = "blocking",
-	.pull = &input_pool,
-	.lock = __SPIN_LOCK_UNLOCKED(blocking_pool.lock),
-	.pool = blocking_pool_data,
-	.push_work = __WORK_INITIALIZER(blocking_pool.push_work,
-					push_to_pool),
-};
-
 static __u32 const twist_table[8] = {
 	0x00000000, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
 	0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
@@ -765,15 +751,11 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		entropy_count = 0;
 	} else if (entropy_count > pool_size)
 		entropy_count = pool_size;
-	if ((r == &blocking_pool) && !r->initialized &&
-	    (entropy_count >> ENTROPY_SHIFT) > 128)
-		has_initialized = 1;
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
 	if (has_initialized) {
 		r->initialized = 1;
-		wake_up_interruptible(&random_read_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 	}
 
@@ -782,7 +764,6 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 	if (r == &input_pool) {
 		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
-		struct entropy_store *other = &blocking_pool;
 
 		if (crng_init < 2) {
 			if (entropy_bits < 128)
@@ -790,27 +771,6 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 			crng_reseed(&primary_crng, r);
 			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
 		}
-
-		/* initialize the blocking pool if necessary */
-		if (entropy_bits >= random_read_wakeup_bits &&
-		    !other->initialized) {
-			schedule_work(&other->push_work);
-			return;
-		}
-
-		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits &&
-		    wq_has_sleeper(&random_read_wait)) {
-			wake_up_interruptible(&random_read_wait);
-		}
-		/* If the input pool is getting full, and the blocking
-		 * pool has room, send some entropy to the blocking
-		 * pool.
-		 */
-		if (!work_pending(&other->push_work) &&
-		    (ENTROPY_BITS(r) > 6 * r->poolinfo->poolbytes) &&
-		    (ENTROPY_BITS(other) <= 6 * other->poolinfo->poolbytes))
-			schedule_work(&other->push_work);
 	}
 }
 
@@ -1422,22 +1382,6 @@ static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
 	credit_entropy_bits(r, bytes*8);
 }
 
-/*
- * Used as a workqueue function so that when the input pool is getting
- * full, we can "spill over" some entropy to the output pools.  That
- * way the output pools can store some of the excess entropy instead
- * of letting it go to waste.
- */
-static void push_to_pool(struct work_struct *work)
-{
-	struct entropy_store *r = container_of(work, struct entropy_store,
-					      push_work);
-	BUG_ON(!r);
-	_xfer_secondary_pool(r, random_read_wakeup_bits/8);
-	trace_push_to_pool(r->name, r->entropy_count >> ENTROPY_SHIFT,
-			   r->pull->entropy_count >> ENTROPY_SHIFT);
-}
-
 /*
  * This function decides how many bytes to actually take from the
  * given pool, and also debits the entropy count accordingly.
@@ -1616,54 +1560,6 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 	return _extract_entropy(r, buf, nbytes, fips_enabled);
 }
 
-/*
- * This function extracts randomness from the "entropy pool", and
- * returns it in a userspace buffer.
- */
-static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
-				    size_t nbytes)
-{
-	ssize_t ret = 0, i;
-	__u8 tmp[EXTRACT_SIZE];
-	int large_request = (nbytes > 256);
-
-	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	if (!r->initialized && r->pull) {
-		xfer_secondary_pool(r, ENTROPY_BITS(r->pull)/8);
-		if (!r->initialized)
-			return 0;
-	}
-	xfer_secondary_pool(r, nbytes);
-	nbytes = account(r, nbytes, 0, 0);
-
-	while (nbytes) {
-		if (large_request && need_resched()) {
-			if (signal_pending(current)) {
-				if (ret == 0)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
-
-		extract_buf(r, tmp);
-		i = min_t(int, nbytes, EXTRACT_SIZE);
-		if (copy_to_user(buf, tmp, i)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		nbytes -= i;
-		buf += i;
-		ret += i;
-	}
-
-	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
-
-	return ret;
-}
-
 #define warn_unseeded_randomness(previous) \
 	_warn_unseeded_randomness(__func__, (void *) _RET_IP_, (previous))
 
@@ -1893,7 +1789,6 @@ static void __init init_std_data(struct entropy_store *r)
 int __init rand_initialize(void)
 {
 	init_std_data(&input_pool);
-	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
@@ -2053,7 +1948,6 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		input_pool.entropy_count = 0;
-		blocking_pool.entropy_count = 0;
 		return 0;
 	case RNDRESEEDCRNG:
 		if (!capable(CAP_SYS_ADMIN))
-- 
2.21.0

