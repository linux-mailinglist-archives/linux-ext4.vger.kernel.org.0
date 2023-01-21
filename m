Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3A676963
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAUUhR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9D829403
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B218760B07
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D5C433EF
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333405;
        bh=BHlFdsm+U4LzKUPj9OwfoZOYeQ7WU/+UY8dOM0bSebE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aZOCkfwBZxehZlEDlb0iP79onRFrHkhJO8rA+SSkNh+8e2UbKGRSg5oiD83Sd/3Zs
         XYDnQBRNBk34f6icbcWNOr9vPD2QGvBWANZqtjILTFPokkE2X9ABZ1al5eGOYp0Xvi
         EajX28hjAqSHPBCBrxmrDJD52aanPO/mEyh+r7iuGIGYTuNUph6qr/yoEsqdNiuDsH
         0HXmywRF04JUzfLMQM4LaKGAvFdAe23+8332s/kvrEs0zHZPd6p3Pp5j1O/gMfLrJR
         5oJyo49sArVBZa8S5Quthosz27TyH2pUMaAjc96Dhr+SjzJAqGQMMO4b5jcECdxgfo
         X5BLtQE/Go0MQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 33/38] misc/mke2fs: fix a -Wunused-variable warning in PRS()
Date:   Sat, 21 Jan 2023 12:32:25 -0800
Message-Id: <20230121203230.27624-34-ebiggers@kernel.org>
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

This showed up when building for Windows.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/mke2fs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 24cc14750..7028d3935 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1598,7 +1598,6 @@ static void PRS(int argc, char *argv[])
 	 * Finally, we complain about fs_blocks_count > 2^32 on a non-64bit fs.
 	 */
 	blk64_t		fs_blocks_count = 0;
-	long		sysval;
 	int		s_opt = -1, r_opt = -1;
 	char		*fs_features = 0;
 	int		fs_features_size = 0;
@@ -1632,9 +1631,12 @@ static void PRS(int argc, char *argv[])
 #define _SC_PAGESIZE _SC_PAGE_SIZE
 #endif
 #ifdef _SC_PAGESIZE
-	sysval = sysconf(_SC_PAGESIZE);
-	if (sysval > 0)
-		sys_page_size = sysval;
+	{
+		long sysval = sysconf(_SC_PAGESIZE);
+
+		if (sysval > 0)
+			sys_page_size = sysval;
+	}
 #endif /* _SC_PAGESIZE */
 #endif /* HAVE_SYSCONF */
 
-- 
2.39.0

