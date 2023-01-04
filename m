Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A8965CF05
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjADJEQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjADJEK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80306370
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DAABB815C3
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201C0C433EF;
        Wed,  4 Jan 2023 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672823046;
        bh=oMufIILpRMVDNGSU9axbqVZYgF+/ryDm3eUQGwt2Pio=;
        h=From:To:Cc:Subject:Date:From;
        b=lv2gk11DuK2UxsjWN0MxIc5RFOb35iI3zE2LAZziWD6cWJcjG2crxFQyylQ2DP0wI
         XyGytwhJcdr+vMQKLMRs6rVEa8rQvVJgMYkrBcLF1YEjatJXZ2TyQtFUoSFZtHf6mG
         /ljMM5hf7G3Ys0kYPtFoVHEpO5Q1HDuVb1U8pKEi79vOnrArmSiu1nR4YtFXObdo4l
         U1fC2I0xOVowrVDODrk6Uix4jLAI51tipkb6mzRAZ7QTipovMgebG7WT/Avs9ybP31
         niDUphox1dwXe2hnUNQj8uvtP7Ya8Wy/VMZZE+lhM3DATvWyz/GNe4vilqqWD3FtAU
         9Eu4/AlzmBQfw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Jeremy Bongio <bongiojp@gmail.com>
Subject: [e2fsprogs PATCH] tune2fs: fix setting fsuuid::fsu_len
Date:   Wed,  4 Jan 2023 01:04:01 -0800
Message-Id: <20230104090401.276188-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
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
Cc: Jeremy Bongio <bongiojp@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e5..7937b8b5 100644
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

