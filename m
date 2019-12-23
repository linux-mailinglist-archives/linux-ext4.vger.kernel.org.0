Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6569F129305
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLWIVH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 03:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfLWIVF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:05 -0500
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E3520715;
        Mon, 23 Dec 2019 08:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577089265;
        bh=XeFchNmcZbVFLTtXDEHSwMt1Lj3xsRNy7aafhPPE0z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkiXLYCKS8ogBXsb7jvhMKmp3BCxIBxS0e3TpXACkT7lZonNTgQUgMuaO9OXvrzF7
         j8oGlGiWxKUQtKZfzv2qOTqOrfa/K31DVSDq11rL6kaHaBWfxECCMTeT9y3UtITqvf
         ByBhlDIIFoFBCZgcwQlq18VV+2Z8NYJwCd1ObSfc=
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
Subject: [PATCH v3 2/8] random: Add a urandom_read_nowait() for random APIs that don't warn
Date:   Mon, 23 Dec 2019 00:20:45 -0800
Message-Id: <c87ab200588de746431d9f916501ef11e5242b13.1577088521.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

/dev/random and getrandom() never warn.  Split the meat of
urandom_read() into urandom_read_nowarn() and leave the warning code
in urandom_read().

This has no effect on kernel behavior, but it makes subsequent
patches more straightforward.  It also makes the fact that
getrandom() never warns more obvious.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c6252a3a4aec..7b46751772e5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2018,12 +2018,23 @@ random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return _random_read(file->f_flags & O_NONBLOCK, buf, nbytes);
 }
 
+static ssize_t
+urandom_read_nowarn(struct file *file, char __user *buf, size_t nbytes,
+		    loff_t *ppos)
+{
+	int ret;
+
+	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));
+	ret = extract_crng_user(buf, nbytes);
+	trace_urandom_read(8 * nbytes, 0, ENTROPY_BITS(&input_pool));
+	return ret;
+}
+
 static ssize_t
 urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	unsigned long flags;
 	static int maxwarn = 10;
-	int ret;
 
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
@@ -2035,10 +2046,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 		crng_init_cnt = 0;
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 	}
-	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));
-	ret = extract_crng_user(buf, nbytes);
-	trace_urandom_read(8 * nbytes, 0, ENTROPY_BITS(&input_pool));
-	return ret;
+
+	return urandom_read_nowarn(file, buf, nbytes, ppos);
 }
 
 static __poll_t
@@ -2200,7 +2209,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 		if (unlikely(ret))
 			return ret;
 	}
-	return urandom_read(NULL, buf, count, NULL);
+	return urandom_read_nowarn(NULL, buf, count, NULL);
 }
 
 /********************************************************************
-- 
2.23.0

