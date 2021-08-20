Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1133F2BBD
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhHTMJk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbhHTMJf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 08:09:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDEC061756;
        Fri, 20 Aug 2021 05:08:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q11so13949607wrr.9;
        Fri, 20 Aug 2021 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xX8QN7d/XFWwmEHcKdCeyQmpM6FgPCJTtiiYzun1nck=;
        b=kH4HIamt7oILiZuSApPBXZnoQFLtCuckve57zFz8cX9t/D0ZtrdMIBwOUUKRu8xDcu
         njkuMtV4HDsQddnx0Md0jZFue2C4wRZc28Nn6lREOdQvA9NGrae7T1R0Vp4rNKVhdink
         n+YiHQKhsE9YtliitiNoIxoNAeTOEcpqkWhHHfgm+zOul4yKn64rIpqDmHk3ugQvYx5I
         9P0B1jJPnO48StytsxkNkuzAblt0NlXGxCp7FBMCBD+1e8s1Ju5e/V0v5o0zps693vRZ
         ZLQT9kuu3qDnoxH3DCdmeD7QVsrql/+pqdnss3D3JbtTPjtkomC91S3sNX9yEbnGjoBB
         mU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xX8QN7d/XFWwmEHcKdCeyQmpM6FgPCJTtiiYzun1nck=;
        b=mO2PdedQffEt+ZRz7CJ0evn2j9eyuPXljwjpSLmqeHxfXTjU56hW1U7XncIbux7UDq
         iL2XR2D+bECjX+Aopnksjbn2xHjxNOAW+ZOsjRghFR1ZMzwuG8jG6G5GHP+t0w/G1X9F
         W9kGOVPXRl5I70H5w+Zpjp5YgvHm8uqlX/GZvmpdRQalPrnv1pw/BE+lLy6JCidnlTZx
         Cf9FAWjtYGHYi0cHjO6Bahxd+/uzSp9hAGchJkt/Cu7S9qwecJ1EyGAN453SmSRRdI6H
         s4lkyC89K8ri0YO/S5Gs+V8oaVbP6LhzyW9HvHa0oJhcRghKwD8DTChBF2OI/6ea6nRN
         sWgQ==
X-Gm-Message-State: AOAM531bjjV21+nKRMXQWXooX2OA/czz54bik/dpj+zVTradFOWfgI3Y
        PSJdZcuv0ZDPP7nzHLEKEEc=
X-Google-Smtp-Source: ABdhPJz15XRXK+GbAJ5vixyecTYGr4CF9zYwwiwYVn4Z+PLL4hgegHZg4GyJe3sRZKAsk76v0pQZJg==
X-Received: by 2002:adf:ed50:: with SMTP id u16mr9801083wro.174.1629461334826;
        Fri, 20 Aug 2021 05:08:54 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id u5sm5683785wrr.94.2021.08.20.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 05:08:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ext4: scope ret locally in ext4_try_to_trim_range()
Date:   Fri, 20 Aug 2021 14:08:53 +0200
Message-Id: <20210820120853.23134-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As commit 6920b3913235 ("ext4: add new helper interface
ext4_try_to_trim_range()") moves some code into the separate function
ext4_try_to_trim_range(), the use of the variable ret within that
function is more limited and can be adjusted as well.

Scope the use of the variable ret locally and drop dead assignments.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/ext4/mballoc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e89db3396203..f4c0a37431cd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6301,7 +6301,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
-	int ret = 0;
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
@@ -6316,10 +6315,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b);
 			if (ret && ret != -EOPNOTSUPP)
 				break;
-			ret = 0;
 			count += next - start;
 		}
 		free_count += next - start;
-- 
2.26.2

