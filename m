Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457C6129311
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 09:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLWIV1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 03:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLWIVX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:23 -0500
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA2221655;
        Mon, 23 Dec 2019 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577089282;
        bh=laLFbvSbXpbF9WgM9j13HCr9h+SIjAYDeRNGL5MqgaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSO+2pEjr0yzOhOz2hqtI2DxrOJbTrdaWohi9EZsJwcYozzf1zh7CuKnqUC0dcDvF
         HJziWW+1iXRCkzGuK9B0NCUlfaKZ4rcaxTpLmDO9qbHgaT1oLCCwmZVTepfIDhsw8L
         FHrasevXuoqUceNIuq9hmYigC93mMKsCMpNIVQYc=
From:   Andy Lutomirski <luto@kernel.org>
To:     Ted Ts'o <tytso@mit.edu>
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
        Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 7/8] random: Delete code to pull data into pools
Date:   Mon, 23 Dec 2019 00:20:50 -0800
Message-Id: <4a05fe0c7a5c831389ef4aea51d24528ac8682c7.1577088521.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no pool that pulls, so it was just dead code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b4f834893d9d..920bf771e3e1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -528,10 +528,8 @@ struct entropy_store {
 	const struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
-	struct entropy_store *pull;
 
 	/* read-write data: */
-	unsigned long last_pulled;
 	spinlock_t lock;
 	unsigned short add_ptr;
 	unsigned short input_rotate;
@@ -1347,41 +1345,6 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  *
  *********************************************************************/
 
-/*
- * This utility inline function is responsible for transferring entropy
- * from the primary pool to the secondary extraction pool. We make
- * sure we pull enough for a 'catastrophic reseed'.
- */
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
-static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	if (!r->pull ||
-	    r->entropy_count >= (nbytes << (ENTROPY_SHIFT + 3)) ||
-	    r->entropy_count > r->poolinfo->poolfracbits)
-		return;
-
-	_xfer_secondary_pool(r, nbytes);
-}
-
-static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
-{
-	__u32	tmp[OUTPUT_POOL_WORDS];
-
-	int bytes = nbytes;
-
-	/* pull at least as much as a wakeup */
-	bytes = max_t(int, bytes, random_read_wakeup_bits / 8);
-	/* but never more than the buffer size */
-	bytes = min_t(int, bytes, sizeof(tmp));
-
-	trace_xfer_secondary_pool(r->name, bytes * 8, nbytes * 8,
-				  ENTROPY_BITS(r), ENTROPY_BITS(r->pull));
-	bytes = extract_entropy(r->pull, tmp, bytes,
-				random_read_wakeup_bits / 8, 0);
-	mix_pool_bytes(r, tmp, bytes);
-	credit_entropy_bits(r, bytes*8);
-}
-
 /*
  * This function decides how many bytes to actually take from the
  * given pool, and also debits the entropy count accordingly.
@@ -1545,7 +1508,6 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 			spin_unlock_irqrestore(&r->lock, flags);
 			trace_extract_entropy(r->name, EXTRACT_SIZE,
 					      ENTROPY_BITS(r), _RET_IP_);
-			xfer_secondary_pool(r, EXTRACT_SIZE);
 			extract_buf(r, tmp);
 			spin_lock_irqsave(&r->lock, flags);
 			memcpy(r->last_data, tmp, EXTRACT_SIZE);
@@ -1554,7 +1516,6 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 	}
 
 	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
-	xfer_secondary_pool(r, nbytes);
 	nbytes = account(r, nbytes, min, reserved);
 
 	return _extract_entropy(r, buf, nbytes, fips_enabled);
@@ -1825,7 +1786,6 @@ static void __init init_std_data(struct entropy_store *r)
 	ktime_t now = ktime_get_real();
 	unsigned long rv;
 
-	r->last_pulled = jiffies;
 	mix_pool_bytes(r, &now, sizeof(now));
 	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
 		if (!arch_get_random_seed_long(&rv) &&
-- 
2.23.0

