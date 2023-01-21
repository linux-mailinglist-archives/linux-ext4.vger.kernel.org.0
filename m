Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D916676961
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUUhP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A9329176
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43AA60B92
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE9C433EF
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333404;
        bh=VEkoFq9DgQ/t9PgvjnI05sXJeWdbDnvI1z7dx9j6ORI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QKTyeFqKJTgVz/2ybdDJkBkseGND2s+vADrnwlaxeOWHgPD9nSHGVJO8xCllOakid
         YhIiPDI2wi5RMCI5N7tC9tfXiLHoj4Io34/bjy+1dxGHWhBxyTPVGFaUl/H0N7SwDi
         KLjWD5begeqGBXpWj4AqBsgrU0+vd87JPiGHb/LpNNhbasTWT2fTVWHHzEB21ifqP2
         yErNCS8ZltB/OnPZk0fY8Y92q5Kp/cF0P6PpG7nUI8uXq4uY7UIh8qKpXSGytaaU58
         nSYP5Ce9QpkkV9MQAnY4Cm1Kp1ph1PM9FVnJddp3FJy1XcWdKHCe8SL2vvM+BzBMNQ
         B5J+is2gez01g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 30/38] misc/fuse2fs: avoid error-prone strncpy() pattern
Date:   Sat, 21 Jan 2023 12:32:22 -0800
Message-Id: <20230121203230.27624-31-ebiggers@kernel.org>
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

'strncpy(dst, src, strlen(src))' is usually wrong, as it doesn't copy
the null terminator.  For this reason, it causes a -Wstringop-truncation
warning with gcc 8 and later.

The code happens to be correct anyway, since the destination buffer is
zero-initialized.  But to avoid relying on this, let's just copy the
terminating null.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/fuse2fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c59572129..6d4bcf4fd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2508,9 +2508,10 @@ static int copy_names(char *name, char *value EXT2FS_ATTR((unused)),
 		      size_t value_len EXT2FS_ATTR((unused)), void *data)
 {
 	char **b = data;
+	size_t name_len = strlen(name);
 
-	strncpy(*b, name, strlen(name));
-	*b = *b + strlen(name) + 1;
+	memcpy(*b, name, name_len + 1);
+	*b = *b + name_len + 1;
 
 	return 0;
 }
-- 
2.39.0

