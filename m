Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44055320017
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 22:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBSVEb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 16:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSVE2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 16:04:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FAC061786
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so4025222plg.13
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJWZzEzNS5vVfW1OyrxYVwHMUBJWStcPfWCrCP2j/8o=;
        b=FVdIy63KW/nFgp5W5PBcy0IA3kiq8f63H77OnccQrNlT4obd9IRy5w8ESUbhp5TbJi
         GB7vGl3sxSGd+SGVDX+mk3FQlURT3Ep1CB1wK4/87Jc11CkfO/f5RNTWvbBXXZV3Pw4i
         QKULP/AwzgZciCtaKH8h5G7pwNr/FZ4LEVz3xTvOTOQcqTq/e2ECU1vCU7DL5WwA7rjY
         ZXBMwVyl5gD/uFX/xkiNw6PYFvTl1iXMpb/2u8HcUtd412viXliUhdEyYAInn0Xw+g5N
         tW17JMW8ExPiw9O0Mw+yDkKBJwVdOJ0yFeFXDbG8B6BJ4VVr8ko8MOqCnhsOnqD88y/v
         NeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJWZzEzNS5vVfW1OyrxYVwHMUBJWStcPfWCrCP2j/8o=;
        b=uM3wTNg1tcuD5sWsftKt1s05EBrpsNrYaNN7/g+C6bpYTTv9gdUzuCTgZgf8tZRkKg
         wT1jqyZOCZurYTEM737I2i/15F8dK+x94JlIvrmqTz1TMExvtjeZQv9VZuz4vxYguL4S
         QnXdc19cubHjBCRE184bAuELp5ehttER/vUBVx6nUx7iAyU+w8HyW8jAvr835F71lvg7
         1v+7x42PxTtcmNNnfJtycW6lHZUd/4CAbK71Th36mUUBfO6fw27NKoqUckbOByaMxITP
         D0oX2Xg+9iNozNtpqcHrh5BUafYfEyiwt5F29hpp80Q/mrYtvunn16yRT9q61RwZ/T5s
         r1aw==
X-Gm-Message-State: AOAM533qSj3s/8n9jyFl5Dqw6v1MbsaekQoaO936CgMSjIh4oXICO9zS
        sq6gL9rToRo1aQ5iMy4aSQtyTsaslLA=
X-Google-Smtp-Source: ABdhPJxw6pJuhYf9SAHtpH3B5FTRhnVxBVT3nYnSVLEGWpcaT+mU0P3tCQA3uv3OpxI/BN3xFTOWmw==
X-Received: by 2002:a17:90a:588c:: with SMTP id j12mr10791964pji.93.1613768627167;
        Fri, 19 Feb 2021 13:03:47 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:48e6:60ce:73b8:bccd])
        by smtp.googlemail.com with ESMTPSA id 30sm10318756pgl.77.2021.02.19.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:03:46 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/4] ext2fs: don't ignore return value in ext2fs_count_blocks
Date:   Fri, 19 Feb 2021 13:03:31 -0800
Message-Id: <20210219210333.1439525-2-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210219210333.1439525-1-harshads@google.com>
References: <20210219210333.1439525-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Don't ignore return value of ext2fs_get_array() in
ext2fs_count_blocks().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/extent.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index 1a87e68b..9e611038 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1824,8 +1824,11 @@ errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
 	if (errcode)
 		goto out;
 
-	ext2fs_get_array(handle->max_depth, sizeof(blk64_t),
-				&intermediate_nodes);
+	errcode = ext2fs_get_array(handle->max_depth, sizeof(blk64_t),
+				   &intermediate_nodes);
+	if (errcode)
+		goto out;
+
 	blkcount = handle->level;
 	while (!errcode) {
 		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF) {
-- 
2.30.0.617.g56c4b15f3c-goog

