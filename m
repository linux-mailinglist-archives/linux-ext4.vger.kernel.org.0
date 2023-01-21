Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26767694F
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAUUg4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407029158
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C41860B7A
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8752C433EF
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333402;
        bh=+mTd8IgdCLykkHo8OjOUrcA2S6yRkqQ7cxfnuRQtaiY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d06zKSJ6QAd/dY1oXLAuH08Yt1/CIp8NbW7Ktwa3bwT/u+d1Y8EDtuzMr0ahV3t+F
         UNbIeXESZPpvart8z1mhkBsMB/biLiP6NKN7vY/FC3SQcFtr2LDsXsiivRmmG0ZKvv
         VmTMbR+FkZcwgtKrhl5RzY2GTxw6BEa5fj5GWXzN/ZEfr7rsU2KAJrCVXNzIvAA96P
         u3MXGgNI1x1dQB9jXXJ7CT/7AMOfUSA/KM93GyuEkDQp6gAxObb4m0lLofCrU5j4+5
         lsylCZfJdzThIHLQYX2NB8tcOZIaHGEJpG6n8mkcoE0511joR/WsBV4I27wNQe6gEZ
         gy9RIFGKhpmQw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 18/38] lib/ext2fs: fix a printf format specifier in file_test()
Date:   Sat, 21 Jan 2023 12:32:10 -0800
Message-Id: <20230121203230.27624-19-ebiggers@kernel.org>
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

size_t should be matched by %zu, not %lu.  This fixes a -Wformat warning
when building for 32-bit x86.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/inline_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/inline_data.c b/lib/ext2fs/inline_data.c
index b62fb6769..bd52e3770 100644
--- a/lib/ext2fs/inline_data.c
+++ b/lib/ext2fs/inline_data.c
@@ -653,7 +653,7 @@ static errcode_t file_test(ext2_filsys fs)
 
 	if (size != BUFF_SIZE) {
 		fprintf(stderr,
-			"tst_inline_data: size %lu != buflen %u\n",
+			"tst_inline_data: size %zu != buflen %u\n",
 			size, BUFF_SIZE);
 		retval = 1;
 		goto err;
-- 
2.39.0

