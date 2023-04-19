Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36B6E7374
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Apr 2023 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjDSGqg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Apr 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjDSGqb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Apr 2023 02:46:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116774EC0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 23:46:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edc63c82d1so1699169e87.0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681886785; x=1684478785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLzM2+BlpNCdmMN6XaJsZFT5iwLTV8yl3YYwzAnzcTg=;
        b=uABhSHxVmrtvg24dScLCKMHy0Au3Gc5n4nSNf40v0MmTTFCBDPc+2FfIPwCoYQCcwZ
         Yss0f5vVUBgwQYLjgMIUrE5/Jy0Zw+r63ZyqzTK6dm0kVhJ3MBCOg+2WpKjN8tbYAS6v
         DKL9Nc40N9yJWy+kTnLhhcuHxjXPpSB9paNZg5fQ2adAQFAJNU6zDf4mGyKqSxV5d9ho
         nbtzeJgGDkil7YDHHWKm1Mwdbz1dImphXvhwbqFNUQq7RmnnZsn5hYf50xl3Ubq3U4Re
         UxqqspWeDN/Fzm5M6iDgDS0QZ8xvgflIwke3qqfDSbRHyu4WAF26cEknj5f3Gc9+4ZWe
         C7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886785; x=1684478785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLzM2+BlpNCdmMN6XaJsZFT5iwLTV8yl3YYwzAnzcTg=;
        b=PpNtM2O9UJsqwp2tdpimjUEgiMFqmYYW3kqnL+utZUaJdYSuCBMedrHS9+thh48Y/0
         W3Xh0Uu+2o8gGQlUI4+XUrXq23uklrfoazH8/kfxA/YTRd4Oy1kwZieZDNUnxLcfFntI
         4pErbqU8Fmn5ZKR+hopVsWODMGVc5CgXKWZ/LrZhYGozpRedYzq9YayYBK8AgNrI8TZS
         NAsyp+0FP2NxQidw7QvPRrAzG3EpNak0ZrI5O74C6fq19vqMbFF1atcOb5L6HvtouX+s
         egwfj4BjXv4Xa8J+D0dJt4CR6yN8Pc1W0lprEZ/tHM/KBpRAqqKHSOxJk46IPmWepGxP
         EpWg==
X-Gm-Message-State: AAQBX9cH5UlZ322koIXx0v7o7xA09TA3U7JrQHMixzi/WqrPJ4sB8wwp
        yaAQSV5MIEB8GKOd5lkK3/4sIg==
X-Google-Smtp-Source: AKy350aGazEo5Msk12xFNlWcFuOmgzrgc4sPBBQX2e74nnBlLH9DkTszWbLxFVKmZThG02rmBG9u4A==
X-Received: by 2002:ac2:5635:0:b0:4eb:3de1:dfc0 with SMTP id b21-20020ac25635000000b004eb3de1dfc0mr3095649lff.69.1681886785350;
        Tue, 18 Apr 2023 23:46:25 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id e24-20020ac25478000000b004edce1d338csm438208lfn.89.2023.04.18.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:46:23 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for stable [4.14, 5.10] 1/3] Revert "ext4: fix use-after-free in ext4_xattr_set_entry"
Date:   Wed, 19 Apr 2023 06:46:08 +0000
Message-ID: <20230419064610.1918038-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419064610.1918038-1-tudor.ambarus@linaro.org>
References: <20230419064610.1918038-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit bb8592efcf8ef2f62947745d3182ea05b5256a15 which is
commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3 upstream.

The order in which patches are queued to stable matters. This patch
has a logical dependency on commit 310c097c2bdbea253d6ee4e064f3e65580ef93ac
upstream, and failing to queue the latter results in a null-ptr-deref
reported at the Link below.

In order to avoid conflicts on stable, revert the commit just so that we
can queue its prerequisite patch first and then queue the same after.

Link: https://syzkaller.appspot.com/bug?extid=d5ebf56f3b1268136afd
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/xattr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f3da1f2d4cb9..948da799abab 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2193,9 +2193,8 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	struct ext4_inode *raw_inode;
 	int error;
 
-	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
+	if (EXT4_I(inode)->i_extra_isize == 0)
 		return 0;
-
 	raw_inode = ext4_raw_inode(&is->iloc);
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
@@ -2223,9 +2222,8 @@ int ext4_xattr_ibody_inline_set(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_search *s = &is->s;
 	int error;
 
-	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
+	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
-
 	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
 	if (error)
 		return error;
-- 
2.40.0.634.g4ca3ef3211-goog

