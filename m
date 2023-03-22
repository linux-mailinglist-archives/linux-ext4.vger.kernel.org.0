Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68D6C4107
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 04:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCVDax (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVDaw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 23:30:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4177BDEB
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 20:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4747D61E74
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89899C433D2
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455850;
        bh=Kx94LyeQiRoEMTNKLWu/szK/MzaYm0uwTuF/hkCJbUo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qnL9Aoih+vdqiwfztlgDZXSRTFD8GfBTyyo+mjMbHy2YPoOrJ2v0BI4WRfTTndT85
         UyBtZTi8CKNb1fXzJ0s6hmkmqaxmWa/OMBNloHTF6NXUEpuUJCKLVqkSijtZ5KJVjS
         bqW9H6f+Aj5s0uoRnxyTu9RAjElG5/q5xwBd3UTQwEZK5HAg3jzyLtexQdd3auouTJ
         bE2MhYDpn69Ws/mEvYs6TVHhqJZlN4fCyfqNusUsWPj3VhmOrC5y+0j0OWT9BB/6kL
         DIwPBMkN6C4t9Q6gs5BbjdrLx7tbdm/I37DEUuz8+i7x12h46+Ycjtz5KzP5Tl9q0V
         2fm5+/ztyAGoA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] e2fsck: avoid -Wtautological-constant-out-of-range-compare warnings
Date:   Tue, 21 Mar 2023 20:29:43 -0700
Message-Id: <20230322032945.31779-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322032945.31779-1-ebiggers@kernel.org>
References: <20230322032945.31779-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix two compiler warnings on 32-bit platforms that have mallinfo() but
not mallinfo2().  These showed up when building e2fsprogs for armv7a or
i686 Android using the Android NDK, targeting Android API level 32 or
lower and using the autotools-based build system.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 e2fsck/iscan.c | 3 ++-
 e2fsck/util.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/e2fsck/iscan.c b/e2fsck/iscan.c
index 33c6a4cdc..1253f52ff 100644
--- a/e2fsck/iscan.c
+++ b/e2fsck/iscan.c
@@ -120,7 +120,8 @@ void print_resource_track(const char *desc,
 	} else
 #elif defined HAVE_MALLINFO
 	/* don't use mallinfo() if over 2GB used, since it returns "int" */
-	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
+	if ((unsigned long)((char *)sbrk(0) - (char *)track->brk_start) <
+	    2UL << 30) {
 		struct mallinfo	malloc_info = mallinfo();
 
 		printf("Memory used: %lluk/%lluk (%lluk/%lluk), ",
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 42740d9ef..0fe436031 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -441,7 +441,8 @@ void print_resource_track(e2fsck_t ctx, const char *desc,
 	} else
 #elif defined HAVE_MALLINFO
 	/* don't use mallinfo() if over 2GB used, since it returns "int" */
-	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
+	if ((unsigned long)((char *)sbrk(0) - (char *)track->brk_start) <
+	    2UL << 30) {
 		struct mallinfo	malloc_info = mallinfo();
 
 		log_out(ctx, _("Memory used: %lluk/%lluk (%lluk/%lluk), "),
-- 
2.40.0

