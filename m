Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07322676955
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAUUhB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0D2915F
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0BD060B72
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F83C433A1
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333403;
        bh=kti/DpdHfEfhMTbcC9Le45ZXZpgKFpFCpFhO0AZSpFA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P34F22tT9UjTGKAW/2Wd7b4EtRI/q4FG55U0pPnOv/L0Soe4P+3zz0gnxJDP0sN1Q
         7qiVnAc268Fa0XSdVzL8opY4/RM0Q0O4st9+UThnCTLyvFbw7/zW0TcZD0Rbwc1C6q
         /8Gn877NsRHZTepoa826DpJreFOOKrpdl3R4VIFp4c/NZEmYlsjKyt3Dfqhdxm7mBI
         ktXa+1AgJf73inqmf2/p0HzX8KWBegWDUhEQn2l+n+Y9ZZ/QarRRUSeoOy9SJwnLx2
         UDmPO7Cxfjf/4ugUPkHU3Tzff+QjLugMm/8qAIQC9oF6AVoofBdGPG8rjiEuCogsU/
         gqrwg6VVYV1/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 25/38] lib/uuid: remove conflicting Windows implementation of gettimeofday()
Date:   Sat, 21 Jan 2023 12:32:17 -0800
Message-Id: <20230121203230.27624-26-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When building libuuid for Windows with MinGW with the default settings,
there is a build error in lib/uuid/gen_uuid.c because the explicit
definition of gettimeofday() conflicts with MinGW's declaration of
gettimeofday().  gen_uuid.c apparently expects USE_MINGW to be defined
to avoid that, but the build system doesn't actually do that.

Since native Windows builds of e2fsprogs are currently only supported
via MinGW anyway (in particular, Visual Studio is not supported), let's
fix this by just removing our own definition of gettimeofday().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/uuid/gen_uuid.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/lib/uuid/gen_uuid.c b/lib/uuid/gen_uuid.c
index 14c98eb4a..a2225ccee 100644
--- a/lib/uuid/gen_uuid.c
+++ b/lib/uuid/gen_uuid.c
@@ -117,27 +117,6 @@
 THREAD_LOCAL unsigned short jrand_seed[3];
 #endif
 
-#ifdef _WIN32
-#ifndef USE_MINGW
-static void gettimeofday (struct timeval *tv, void *dummy)
-{
-	FILETIME	ftime;
-	uint64_t	n;
-
-	GetSystemTimeAsFileTime (&ftime);
-	n = (((uint64_t) ftime.dwHighDateTime << 32)
-	     + (uint64_t) ftime.dwLowDateTime);
-	if (n) {
-		n /= 10;
-		n -= ((369 * 365 + 89) * (uint64_t) 86400) * 1000000;
-	}
-
-	tv->tv_sec = n / 1000000;
-	tv->tv_usec = n % 1000000;
-}
-#endif
-#endif
-
 static int get_random_fd(void)
 {
 	struct timeval	tv;
-- 
2.39.0

