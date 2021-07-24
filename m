Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2F3D4611
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhGXHCb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhGXHC3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5223AC061757;
        Sat, 24 Jul 2021 00:43:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m1so5453431pjv.2;
        Sat, 24 Jul 2021 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p4qbVHg1IF59H0YMV4jccads7zcNK8YJJGH4Vp8FcEE=;
        b=OJ5avNAbk2XFqgPswCPvf1OgYMMzXqRfe11KQJpYYvCcAK3bCE/gXxoEk6GiGXwnQ2
         zzK8SfYba2XbepRMcb4SjyTjdH0sacsNaufhAfyCm+/mmbEU3vO+lWFOPbDfnN6jZGbk
         InGcsOa52ipwFFNZ5C9CJ84CIMm7SWNJkRs8TEBzi3cq51YQ+hG+6mDKwT9HYbIosrkK
         53ZWcosohVGr9Aa863KYekATNJ/qZMMvwd9FvHl5tGO0qizlmVJicoZqYSW4sYoNhkUm
         50gmUEvJIJVwi4irosZnPjcNg7Ym45XZa/D+ZbKEdEonKH9aWdmmiGRVJk3OZSUz4whL
         ZJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p4qbVHg1IF59H0YMV4jccads7zcNK8YJJGH4Vp8FcEE=;
        b=MvnGy2VHzpvafuzvgEnoqcKa7qnB6HocV4ircCVdIKuIBjRGocmdqaZA6pEW2x51GF
         8Q2bPkXegcR6FX9wUjLnETgRMJFAwfn1P3CQxrb+MmEh53birBC0X8qZVUR1Hx8o3lhY
         81zT1fftK86QHRNuooHFPRAlWAe0RgdORtgZSKNuzCKx8T1Is+Gud42GCLKxEbMfQNUz
         ij9eWjAts067FVhklNQnmx/fFU7EMR9d+mwE/9UW/DNs4euxzs2QjVkh4YqMLCjwIQv6
         y7a6nv7dpDLek+qgPpfbjdnmHDKFi8HI2f1rtekQVrDksVde6AyMmfoEIpl2bAOwq+EL
         xnAg==
X-Gm-Message-State: AOAM533NGcqm/Jmi+UTfdSYVJQ7HHnRX6YsIma95dL64/Ri7ho/wqMYh
        ufghR9yPGE8cQ1eqBakHTKS4RCMj8iQZkQ==
X-Google-Smtp-Source: ABdhPJz/LvCUx61dx9xaFRuZJKNwyxabus8sGlby9mIDF+UrPonpIeocc8sS7Fp22leCiA3eanqPkw==
X-Received: by 2002:a62:5b46:0:b029:38a:ce83:85c9 with SMTP id p67-20020a625b460000b029038ace8385c9mr835268pfb.11.1627112580872;
        Sat, 24 Jul 2021 00:43:00 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:43:00 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 3/5] ext4: remove the repeated comment of ext4_trim_all_free
Date:   Sat, 24 Jul 2021 15:41:22 +0800
Message-Id: <20210724074124.25731-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210724074124.25731-1-jianchao.wan9@gmail.com>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e3844152a643..34be2f07449d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6274,15 +6274,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
  * @max:		last group block to examine
  * @minblocks:		minimum extent block count
  *
- * ext4_trim_all_free walks through group's buddy bitmap searching for free
- * extents. When the free block is found, ext4_trim_extent is called to TRIM
- * the extent.
- *
- *
  * ext4_trim_all_free walks through group's block bitmap searching for free
  * extents. When the free extent is found, mark it as used in group buddy
  * bitmap. Then issue a TRIM command on this extent and free the extent in
- * the group buddy bitmap. This is done until whole group is scanned.
+ * the group buddy bitmap.
  */
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
-- 
2.17.1

