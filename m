Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316CC129306
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 09:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWIVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 03:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfLWIVJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:09 -0500
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A862073A;
        Mon, 23 Dec 2019 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577089268;
        bh=yhFKFV2M8IVRdKt/jk/YAVP+IDJiL/eZhJKGWL/fJmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LP5/95pzggJ/fF7QjTRyw5EkeWW7uhGq0dh2s7OfKwpm/EeAeFyGB5OMU7pV6R38Y
         2gt10UaeFCR7EMKrE8YVRQD3hAH+1sJPwDUtyaj0AXM88mEs2+2Pe9uYh3mqSmn0pZ
         5XAchGRv2tYQa+cSRdo/+ChDo9tzZkDGgAWbca0A=
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
Subject: [PATCH v3 3/8] random: Add GRND_INSECURE to return best-effort non-cryptographic bytes
Date:   Mon, 23 Dec 2019 00:20:46 -0800
Message-Id: <d5473b56cf1fa900ca4bd2b3fc1e5b8874399919.1577088521.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c       | 11 +++++++++--
 include/uapi/linux/random.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7b46751772e5..675b8a48e18a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2193,7 +2193,14 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 {
 	int ret;
 
-	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
+	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE))
+		return -EINVAL;
+
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags & (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|GRND_RANDOM))
 		return -EINVAL;
 
 	if (count > INT_MAX)
@@ -2202,7 +2209,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (flags & GRND_RANDOM)
 		return _random_read(flags & GRND_NONBLOCK, buf, count);
 
-	if (!crng_ready()) {
+	if (!(flags & GRND_INSECURE) && !crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_for_random_bytes();
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 26ee91300e3e..c092d20088d3 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -49,8 +49,10 @@ struct rand_pool_info {
  *
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
  * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ * GRND_INSECURE	Return non-cryptographic random bytes
  */
 #define GRND_NONBLOCK	0x0001
 #define GRND_RANDOM	0x0002
+#define GRND_INSECURE	0x0004
 
 #endif /* _UAPI_LINUX_RANDOM_H */
-- 
2.23.0

