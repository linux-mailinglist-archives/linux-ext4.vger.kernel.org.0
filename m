Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B509F3FB220
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhH3HzK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhH3HzI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206AC061575;
        Mon, 30 Aug 2021 00:54:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d5so3103371pjx.2;
        Mon, 30 Aug 2021 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QHAzSdptgC6qne6WaVUeNLk/QMe5aEBSnsP4kC/AGoQ=;
        b=mQKCuzLYZc3gHhi+qoWZk5E360ByqCWaXwy+lfnBodQxHWvVVjPt9L0mTpZwnjVDFj
         KPP0v8LZP2Xb/a9zY7rsnbXvIQJGu5n69eYJoxe9R0/DLZIcaRC66XR38LoEGV3JsUse
         pxhBlCyW5CUsxhzixKKOVFf/RXNjqiRFgiXH/OoRqwpzfSPALuBHmE2xyCj6hJflKUXl
         btSoAHcGIl9JzszrneD/rvfgZDKX0rDyGO4UfpmJstmPfB74DByW6oacdmZUR99tkKkr
         X7kp/5HYNxjZriIQwZQMU0dVPsiPjuKdWyNmIGIEFcWqMFl/UWlO9OzEv5IffEp7iqmh
         oJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QHAzSdptgC6qne6WaVUeNLk/QMe5aEBSnsP4kC/AGoQ=;
        b=ea64ob3YJSwr/0MvhIo9uJ/n0xVzFebpxeZ33OGUJ+0i3p5nUmWz0Ry1V6+C6/YkuA
         znGd7hwccANOsBvRpfh0rbFMaVfxF6iEWjK4tWjEJBfplu62grglDomDTb37Zv0YPjOf
         VOB+k+F+373ocNdCrq6W5/9WXTFpIDwz6wjTk3qom0xbhmjU3wIUa0vHYuz+WmgEsbuR
         QfI5pgchafb04udIKR5AEWlQygI+EvqL2BGio053DH1NcW+pelCT6yjQ9xztcMgBpJ0f
         FEyR3FEBqK2KsEtpDA2VM6hUKwn5v477d940i48LcVHZksFergkJ2ctwUHUhKH8WVFi+
         Sv3g==
X-Gm-Message-State: AOAM531xx0gXDjNc6+qS6MruU8IInmlc4pTUvMEC5qlnCnjk9g/Td+5G
        I3G6Qke16EbsaYBPk1HyDsk=
X-Google-Smtp-Source: ABdhPJy6RSQQ9busYgiN3UErJlDEqtf8ItxvNiwt4oLZerHCjN19TqONnLMckfnxzApy4EPO17P6Gw==
X-Received: by 2002:a17:90b:30c1:: with SMTP id hi1mr24970319pjb.187.1630310055164;
        Mon, 30 Aug 2021 00:54:15 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:14 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 3/5] ext4: remove the repeated comment of ext4_trim_all_free
Date:   Mon, 30 Aug 2021 15:52:44 +0800
Message-Id: <20210830075246.12516-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830075246.12516-1-jianchao.wan9@gmail.com>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e47089cc6c07..ef2aa2b1a939 100644
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

