Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA55C67695D
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjAUUhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADC42916E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C88FB807E4
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252ADC433A0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333402;
        bh=kKpY6N1wjkPqyVf8e/HsPEpKOt8PNFJDIyv9bhAd80w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i0LG2n5m0wq9iDttGSX96j5HWfoiUpGAj2KE0FfI+q+MrEOwHkqERPCqCA3HGlYQw
         KwQzf92tdO8+dt7xnG2+8TnoE+XeOOimktxqDgwwEMgdPa2gyJa9Hf4TWgwTKeqUpd
         H4umUyH6gmp5ohTKX6j5kw4Ow5aQ6B1JUyX1b8KROFFH/4eZrwEHBjrECutMzx1OIA
         Kgesr9TnVfpTHX24HhLXj8wLDB2wRDO0xJVq3kWZZBRfnnBUIojI/0WPq+5Zsf83Gf
         fIJci506dqInUOlamVkrVtsAt0ClD3uFaYlw2jPK+eLJE1idDwVVN2wZJrBPAdHodV
         5pwzlJCAmN9BQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 19/38] lib/ext2fs: fix two compiler warnings in windows_io.c
Date:   Sat, 21 Jan 2023 12:32:11 -0800
Message-Id: <20230121203230.27624-20-ebiggers@kernel.org>
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

init_private_data() triggers a -Wstringop-truncation warning, due to a
real bug.  Fix it.

windows_open() has a -Wunused-variable warning because some
macOS-specific code was copied there for no reason.  Remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/windows_io.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/lib/ext2fs/windows_io.c b/lib/ext2fs/windows_io.c
index 68b5571bb..83aea68b6 100644
--- a/lib/ext2fs/windows_io.c
+++ b/lib/ext2fs/windows_io.c
@@ -499,9 +499,6 @@ static errcode_t windows_open_channel(struct windows_private_data *data,
 #if defined(O_DIRECT)
 	if (flags & IO_FLAG_DIRECT_IO)
 		io->align = ext2fs_get_dio_alignment(data->dev);
-#elif defined(F_NOCACHE)
-	if (flags & IO_FLAG_DIRECT_IO)
-		io->align = 4096;
 #endif
 
 	/*
@@ -609,7 +606,7 @@ static struct windows_private_data *init_private_data(const char *name, int flag
 		return NULL;
 
 	memset(data, 0, sizeof(struct windows_private_data));
-	strncpy(data->name, name, sizeof(data->name));
+	strncpy(data->name, name, sizeof(data->name) - 1);
 	data->magic = EXT2_ET_MAGIC_WINDOWS_IO_CHANNEL;
 	data->io_stats.num_fields = 2;
 	data->flags = flags;
@@ -620,7 +617,6 @@ static struct windows_private_data *init_private_data(const char *name, int flag
 
 static errcode_t windows_open(const char *name, int flags, io_channel *channel)
 {
-	int fd = -1;
 	int open_flags;
 	struct windows_private_data *data;
 
@@ -644,12 +640,6 @@ static errcode_t windows_open(const char *name, int flags, io_channel *channel)
 		return EXT2_ET_BAD_DEVICE_NAME;
 	}
 
-#if defined(F_NOCACHE) && !defined(IO_DIRECT)
-	if (flags & IO_FLAG_DIRECT_IO) {
-		if (fcntl(fd, F_NOCACHE, 1) < 0)
-			return errno;
-	}
-#endif
 	return windows_open_channel(data, flags, channel, windows_io_manager);
 }
 
-- 
2.39.0

