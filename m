Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFA676944
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAUUgo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUgm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8729142
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E13B80862
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65963C4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333398;
        bh=EQHzEyg22Gzigjwzdy0o6sn2XHp/O9QfU3MfLeTNFFo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qM+qDqyqo8KmF+CBMm9hznOW4N7MOxBVr5noMBwNX0bgEI14unmx2wgKGagRxQ1RX
         PT0LQ4Od6C4kOVqU5ALTqvoo75TozxvOz8sqWUCJvbUrznqfZHBk3kZ00IN5DA801S
         s4w1XTu0WEt2M4ixqcBcK3aYr+RFjBWEEJFuGZliVes6gvZ2kXQE8bXEOfsJwJQ/R3
         saTgF6o9ITd+s+EAQTRyIYWM0F5Vmrbc7BMcdjLYwNOgBJZwPTPM+yTMQO17wRF9H+
         FTz/8kNm42jK9VexMLvY6GkpGkkO/8YMmoWD52Ve9pn9hADP+PbCjO/tAZExg65/y5
         uZSsetWs/wA6A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 01/38] configure.ac: only use Windows I/O manager on native Windows
Date:   Sat, 21 Jan 2023 12:31:53 -0800
Message-Id: <20230121203230.27624-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Cygwin and MSYS2 are UNIX-compatible platforms on top of Windows, so
they should use the UNIX I/O manager, not the Windows I/O manager.

(Note that "cygwin" was misspelled as "cigwin", so the code did not have
the intended effect anyway.)

Fixes: d1d44c146a5e ("ext2fs: compile the io implementation according to os")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 78f71fd8e..5f440f1fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1826,7 +1826,7 @@ dnl Adjust the compiled files if we are on windows vs everywhere else
 dnl
 OS_IO_FILE=""
 [case "$host_os" in
-  cigwin*|mingw*|msys*)
+  mingw*)
     OS_IO_FILE=windows_io
   ;;
   *)
-- 
2.39.0

