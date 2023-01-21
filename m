Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DE676962
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAUUhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80B29400
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8873D60B6F
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D36C433A1;
        Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333405;
        bh=SBCJzKRGKr2mo1lvVTXZL+ohtZ1777FKKIEY4Px0uhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHs72LE4o1ibFawv7A/FhoCcxlwJ1R3iEZTIsZZdjVUX/ZTTFjIq6W3xNHyqiqmp0
         n8WkiOtqi+pNVNpGI20MhmwFIQmTv8g6nvf4K6yM6HUnUZl+wAnFZ0pCCzsHGqAaVq
         SwLwmWEBS4gGQPEg5c5ynmrMpDw/5+9R9qoT4emukMHfjthqw0SBxOXH/r5kmq6ec2
         tOAqpUlQflwkcgqJyoat3iim5Tgy4uuEnTtYNc7LQnL9iJiJmxWLOt8atGpymiQ+o/
         VITT1Ztj0uhpoeKWGojEO8gRiRO3XWorx+H9ruQ73+df1ccOhUXNFUKgglY2M1BDlC
         1ER8YhRRDI8OA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Jeremy Bongio <bongiojp@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 34/38] misc/tune2fs: fix setting fsuuid::fsu_len
Date:   Sat, 21 Jan 2023 12:32:26 -0800
Message-Id: <20230121203230.27624-35-ebiggers@kernel.org>
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

Minus does not mean equals.

Besides fixing an obvious bug, this avoids the following compiler
warning with clang -Wall:

tune2fs.c:3625:20: warning: expression result unused [-Wunused-value]
                        fsuuid->fsu_len - UUID_SIZE;
                        ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~

Fixes: a83e199da0ca ("tune2fs: Add support for get/set UUID ioctls.")
Reviewed-by: Jeremy Bongio <bongiojp@gmail.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e53..7937b8b56 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3622,7 +3622,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		ret = -1;
 #ifdef __linux__
 		if (fsuuid) {
-			fsuuid->fsu_len - UUID_SIZE;
+			fsuuid->fsu_len = UUID_SIZE;
 			fsuuid->fsu_flags = 0;
 			memcpy(&fsuuid->fsu_uuid, new_uuid, UUID_SIZE);
 			ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);
-- 
2.39.0

