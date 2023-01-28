Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6755167FB6F
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 23:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjA1W6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 17:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1W6p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 17:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E722A03
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D1EBB80BFB
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D3CC4339C
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674946721;
        bh=FeajjHnE52Ix7Xgb2KZ7po/g/JisLPCMtZp+5RbWrGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SqxTsfp5mAQUSuozHQSd6M4Bx42SAkprv4t7vFuShPpsQ6qQuhLfkgmo/I71pFJqT
         uKlcz6cYnvJl06lvZs5HhfD6bdF53jCawU8Z9ZzeEm5l/TRxk89y1RGN0xleDdt5LX
         9KJAe7myrEpvR1NSQtObHRML+xwyQFhAt8w+xZ7nCN8ihgEqGhcAdFxrfCE1Y0CAwY
         Sfipmwo6ogGP2wIDNUsSt7rFGYGa3ulFDp0vJ5iXMuG+rihsEm/QtGmuh+yiNvwzMs
         Lv16QLB4ujZEijASkijZT4UZzUpXNu0Wjt7UgP3gQXtLEl7b8DHIjaA2J/RAnsNy+8
         ykvtDBV4Dg8Cw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/4] lib/ext2fs: don't warn about lack of getmntent on Windows
Date:   Sat, 28 Jan 2023 14:46:50 -0800
Message-Id: <20230128224651.59593-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128224651.59593-1-ebiggers@kernel.org>
References: <20230128224651.59593-1-ebiggers@kernel.org>
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

It is expected that Windows doesn't have getmntent(), so don't warn
about it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/Android.bp  | 1 -
 lib/ext2fs/ismounted.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/ext2fs/Android.bp b/lib/ext2fs/Android.bp
index eb4482d79..f5cbeec9f 100644
--- a/lib/ext2fs/Android.bp
+++ b/lib/ext2fs/Android.bp
@@ -121,7 +121,6 @@ cc_library {
             enabled: true,
             include_dirs: ["external/e2fsprogs/include/mingw"],
             cflags: [
-                "-Wno-error=cpp",
                 "-Wno-format",
                 "-Wno-unused-variable",
                 "-Wno-error=typedef-redefinition",
diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index 22bc8352b..a7db1a5c4 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -414,7 +414,7 @@ errcode_t ext2fs_check_mount_point(const char *device, int *mount_flags,
 #ifdef HAVE_GETMNTINFO
 		retval = check_getmntinfo(device, mount_flags, mtpt, mtlen);
 #else
-#ifdef __GNUC__
+#if defined(__GNUC__) && !defined(_WIN32)
  #warning "Can't use getmntent or getmntinfo to check for mounted filesystems!"
 #endif
 		*mount_flags = 0;
-- 
2.39.1

