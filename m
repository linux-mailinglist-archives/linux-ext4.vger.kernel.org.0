Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56907676943
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjAUUgn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAUUgm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB829143
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81AD60B6C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70472C4339B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333400;
        bh=6vaEcMU11C00JgLvJinTeK77gDvStZvOlqFTbREyXSM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JCzwUxp8O1RrY0XzQ5C/7gJrIHHCf8jyBgR90U1nLLGr8upbLKds6GGt7zg+Slrsc
         WlOdC6xvOOw4QnSMb3Wrjb30k/6SvPRJ3N2wMpmolR2sihQ31MVwqjSpUYvQQ63cX1
         0be6GKhf3pKlZpTmT2azYEP0ZDp7YRLZRJYovJook9uQo1M15AqeOquBxcos85oJ8i
         RACvb+k4fmD2IE/so4YHFLtfMUKVzWQit/NuwI/lJyG7RZN4elkpbqNSHx+P6RIUgH
         INHixUNzYuDdGAC9CK8n1w3rHyGqHXqvaFY/+wP9snUceth1PtgaIsJFnbivv41RG5
         UcB4sxFbD51Hw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 11/38] lib/blkid: suppress -Wstringop-truncation warning in blkid_strndup()
Date:   Sat, 21 Jan 2023 12:32:03 -0800
Message-Id: <20230121203230.27624-12-ebiggers@kernel.org>
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

Unfortunately, gcc gets confused by blkid_strndup() and incorrectly
thinks the destination string is not being null-terminated.  This is
part of -Wstringop-truncation, enabled automatically by -Wall in gcc 8
and later.  Let's just suppress this warning here.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/blkid/devno.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/blkid/devno.c b/lib/blkid/devno.c
index 34ceb3c48..b1cadc9df 100644
--- a/lib/blkid/devno.c
+++ b/lib/blkid/devno.c
@@ -37,6 +37,12 @@
 
 #include "blkidP.h"
 
+#if defined(__GNUC__) && __GNUC__ >= 8
+/* gcc incorrectly thinks the destination string is not being null-terminated */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wstringop-truncation"
+#endif
+
 char *blkid_strndup(const char *s, int length)
 {
 	char *ret;
@@ -55,6 +61,10 @@ char *blkid_strndup(const char *s, int length)
 	return ret;
 }
 
+#if defined(__GNUC__) && __GNUC__ >= 8
+#pragma GCC diagnostic pop
+#endif
+
 char *blkid_strdup(const char *s)
 {
 	return blkid_strndup(s, 0);
-- 
2.39.0

