Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51738676948
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAUUgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjAUUgn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528829147
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1ED260B72
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F82CC433A8
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333400;
        bh=U7wI4qHzRE7/py31orTHfxUE3tXqYIJBmnHYRx8/5Ac=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jJ7MmG54Gh4jMe3/+sOba4oPma8Y3PlfXtkIIpi50jgXko230QTGP5NXMmFHyWnkL
         BV/DYbFxRGH46Oo7WGctwKH8QwFsP5511vYGL9Q4x+I/oqWlgsrtB/LRYXhBRm1cnt
         pvHBwmJ9dWWi897+4Ad5vCOrbdukWCicJaM6mkCsIJJ4z15/kgbGlYcJ+5dVSTSJj5
         uZGMiSLDnKd5D5TUAGUV96vrf8OM1gqQiy/d91Zc3+bQYJ4mv1vykR1MtOpqkisp7Q
         cvjaBs6dNs25oJ4vMZRa/aKk3nV6dYxrKZNCy2E4CLk9A9WhP5JgPZ6TD4noGR5SMe
         wkQuoSSXuUgmw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 10/38] lib/blkid: suppress -Wunused-result warning in blkid_flush_cache()
Date:   Sat, 21 Jan 2023 12:32:02 -0800
Message-Id: <20230121203230.27624-11-ebiggers@kernel.org>
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

When _FORTIFY_SOURCE is defined, glibc annotates link() with the
warn_unused_result function attribute.  With gcc, that makes
'(void) link()' cause a -Wunused-result warning, despite the explicit
cast to void.  That's annoying, since the use case in lib/blkid/save.c
is legitimate (opportunistic backup).  So let's suppress this warning.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/blkid/save.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/blkid/save.c b/lib/blkid/save.c
index 036f07a4a..6f4499cfd 100644
--- a/lib/blkid/save.c
+++ b/lib/blkid/save.c
@@ -154,7 +154,15 @@ int blkid_flush_cache(blkid_cache cache)
 			if (backup) {
 				sprintf(backup, "%s.old", filename);
 				unlink(backup);
+#if defined(__GNUC__) && __GNUC__ >= 5
+/* explicit (void) cast is not enough with glibc and _FORTIFY_SOURCE */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+#endif
 				(void) link(filename, backup);
+#if defined(__GNUC__) && __GNUC__ >= 5
+#pragma GCC diagnostic pop
+#endif
 				free(backup);
 			}
 			if (rename(opened, filename) < 0)
-- 
2.39.0

