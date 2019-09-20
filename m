Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A4B92F2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392042AbfITOgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 10:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392458AbfITOgg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 10:36:36 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E418218AE;
        Fri, 20 Sep 2019 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990195;
        bh=Xa5lUKuEKR/Mj/s8RMBKL11PjH1zbgHgXvtpnqsOn+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auASqbp4NCulMrJTRWJf4LXFic5L3p2Gu4oJq2LL2f3fV73TmO42qvMn2dWsLhK9F
         MjiEpJRwZt6kibtZIcQ4MDifqQP0W8evATN3Gv3RtlyE1yqvijE+wVc6bAkmYkbejj
         Gkn0WW+2L5mgdqW2IWy87j1sHFInWcULd3gzy8AQ=
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
Subject: [PATCH v2 4/7] random: Make /dev/random be almost like /dev/urandom
Date:   Fri, 20 Sep 2019 07:36:26 -0700
Message-Id: <b3108e0defc82daee3f14a0c794464b6e74c5e71.1568990048.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568990048.git.luto@kernel.org>
References: <cover.1568990048.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch changes the read semantics of /dev/random to be the same
as /dev/urandom except that reads will block until the CRNG is
ready.

None of the cleanups that this enables have been done yet.  As a
result, this gives a warning about an unused function.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 55 +++++++++++--------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1ad2c7eaf675..29a158d9353c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -354,7 +354,6 @@
 #define INPUT_POOL_WORDS	(1 << (INPUT_POOL_SHIFT-5))
 #define OUTPUT_POOL_SHIFT	10
 #define OUTPUT_POOL_WORDS	(1 << (OUTPUT_POOL_SHIFT-5))
-#define SEC_XFER_SIZE		512
 #define EXTRACT_SIZE		10
 
 
@@ -803,7 +802,6 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		if (entropy_bits >= random_read_wakeup_bits &&
 		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
-			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
 		/* If the input pool is getting full, and the blocking
 		 * pool has room, send some entropy to the blocking
@@ -1031,6 +1029,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
+		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("random: crng init done\n");
 		if (unseeded_warning.missed) {
 			pr_notice("random: %d get_random_xx warning(s) missed "
@@ -1921,43 +1920,6 @@ void rand_initialize_disk(struct gendisk *disk)
 }
 #endif
 
-static ssize_t
-_random_read(int nonblock, char __user *buf, size_t nbytes)
-{
-	ssize_t n;
-
-	if (nbytes == 0)
-		return 0;
-
-	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
-	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
-		if (n < 0)
-			return n;
-		trace_random_read(n*8, (nbytes-n)*8,
-				  ENTROPY_BITS(&blocking_pool),
-				  ENTROPY_BITS(&input_pool));
-		if (n > 0)
-			return n;
-
-		/* Pool is (near) empty.  Maybe wait and retry. */
-		if (nonblock)
-			return -EAGAIN;
-
-		wait_event_interruptible(random_read_wait,
-		    blocking_pool.initialized &&
-		    (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits));
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
-}
-
-static ssize_t
-random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
-{
-	return _random_read(file->f_flags & O_NONBLOCK, buf, nbytes);
-}
-
 static ssize_t
 urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
@@ -1981,15 +1943,26 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return ret;
 }
 
+static ssize_t
+random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+{
+	int ret;
+
+	ret = wait_for_random_bytes();
+	if (ret != 0)
+		return ret;
+	return urandom_read(file, buf, nbytes, ppos);
+}
+
 static __poll_t
 random_poll(struct file *file, poll_table * wait)
 {
 	__poll_t mask;
 
-	poll_wait(file, &random_read_wait, wait);
+	poll_wait(file, &crng_init_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
+	if (crng_ready())
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-- 
2.21.0

