Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71900B92EE
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392457AbfITOgf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 10:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392399AbfITOge (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 10:36:34 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E9E21882;
        Fri, 20 Sep 2019 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990194;
        bh=mXSu3yZoOBiiXKChRyUnZ8uuktrSKvYCEZu71UFxXJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQtJVKJIF5krjrRZo2IniY0+jhafN9a+/m1u8fbUsegHo1w1xKOJONvPoHO04eKGr
         y89lVmlP2zsgu9qjDxUCYy76TtL0DR57ZMar5+4ey/nWS99yS2CQs7Cw7eQEVk9vee
         zL4Vtrlk4V8xgE8YfwOKBvqtbp7yVn8a2oKG7zKo=
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
Subject: [PATCH v2 2/7] random: Add GRND_INSECURE to return best-effort non-cryptographic bytes
Date:   Fri, 20 Sep 2019 07:36:24 -0700
Message-Id: <f38025d4ade72489cbf0faa887f8d850cad3846b.1568990048.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568990048.git.luto@kernel.org>
References: <cover.1568990048.git.luto@kernel.org>
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
index d152612e08fc..acabb870f222 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2122,7 +2122,14 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
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
@@ -2131,7 +2138,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
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
2.21.0

