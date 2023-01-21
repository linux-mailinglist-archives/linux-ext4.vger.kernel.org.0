Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4A676952
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUUg7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB429152
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB0EACE0923
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC4C4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333400;
        bh=YZ2pKcUw+HsnTmBeblDkOs6JI46xxZANugYMD/K+Xx8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VSW/sBKWD/bDQogPkisFfT1wugXETv4b0mRPPP9wfivhvFAMM1LFUwufl4xodTFOr
         MllNP/WdaCEMYHgndUk9BaQMupSZzTxwCJ0iz3K2kE8NBYaE8rQv/O4d0tSRB8qah7
         c2nIvKLz2h65bcBcB5M02gnm0daZsog7/Ow1CIeYhxbBy0CMCvi4qI4gzagXmsTN3S
         i1QPpBuCvk++vZePQJH3jdQejYrCIASOL39WuCJh4nAWdM8FWUXAgg3T2DXGj84qQC
         xhML605IPjZCQqpnixsFhrYKlSNTBHVkjfSHQom/mNzV1X5F00i/jw9hhoqfPQTs2K
         N8+5sN3t5UyJw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 09/38] lib/blkid: fix -Wunused-variable warning in blkid_get_dev_size()
Date:   Sat, 21 Jan 2023 12:32:01 -0800
Message-Id: <20230121203230.27624-10-ebiggers@kernel.org>
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

This showed up when building for Windows.  It's hard to conditionally
define this variable, so use the 'unused' attribute.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/blkid/Android.bp | 1 -
 lib/blkid/getsize.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/blkid/Android.bp b/lib/blkid/Android.bp
index a40113193..f5d25da4f 100644
--- a/lib/blkid/Android.bp
+++ b/lib/blkid/Android.bp
@@ -42,7 +42,6 @@ cc_library {
             include_dirs: ["external/e2fsprogs/include/mingw"],
             cflags: [
                 "-Wno-pointer-to-int-cast",
-                "-Wno-unused-variable",
                 "-Wno-error=typedef-redefinition",
             ],
 
diff --git a/lib/blkid/getsize.c b/lib/blkid/getsize.c
index 75f21d5c1..7a6e6fd86 100644
--- a/lib/blkid/getsize.c
+++ b/lib/blkid/getsize.c
@@ -75,7 +75,7 @@ static int valid_offset(int fd, blkid_loff_t offset)
  */
 blkid_loff_t blkid_get_dev_size(int fd)
 {
-	unsigned long long size64;
+	unsigned long long size64 __BLKID_ATTR((unused));
 	blkid_loff_t high, low;
 
 #if defined DKIOCGETBLOCKCOUNT && defined DKIOCGETBLOCKSIZE	/* For Apple Darwin */
-- 
2.39.0

