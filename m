Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2219129301
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfLWIVC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 03:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfLWIVC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:02 -0500
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11FE320709;
        Mon, 23 Dec 2019 08:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577089261;
        bh=j9mpvD2vwVqJgqgRO1huDRjRF97+pmAiqRJqpb4yQWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgMk4fE0EfdHV0JXNpb2TasyUXF7PfAmCOc7uF/6HodTzMkS1oOJjyz//vZONpMPF
         CTxunEVo9DvwQ02weloIIbupCnBwGA2dP8GRrF3HJoITmTCK1dM8t6X+jj+e5Wq0Vp
         roYfVLl0NQiC3iKV9M78+5ehKLdjrHlMmLrzYxno=
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
Subject: [PATCH v3 1/8] random: Don't wake crng_init_wait when crng_init == 1
Date:   Mon, 23 Dec 2019 00:20:44 -0800
Message-Id: <6fbc0bfcbfc1fa2c76fd574f5b6f552b11be7fde.1577088521.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

crng_init_wait is only used to wayt for crng_init to be set to 2, so
there's no point to waking it when crng_init is set to 1.  Remove the
unnecessary wake_up_interruptible() call.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cda12933a17d..c6252a3a4aec 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -946,7 +946,6 @@ static int crng_fast_load(const char *cp, size_t len)
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: fast init done\n");
 	}
 	return 1;
-- 
2.23.0

