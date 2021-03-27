Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAF34B631
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhC0KdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhC0Kc6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:32:58 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56897C0613B1;
        Sat, 27 Mar 2021 03:32:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y5so7847920qkl.9;
        Sat, 27 Mar 2021 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Haw1k5WQyfzJbLvONx7FVMMpnitJmr7FZIE1DGVa1k=;
        b=tVpMa+HOcinKMQT43YZzRqamsseVsUVV40Ed0+Xk3l/4S2JdPm42I8doOSpEg7h/u9
         N9JBbSGBP0WCO5Z6bOACaVsDlnnyz4um2rJoxnyz6oquJfLJKEt+81jBqWhqFcmxPe5G
         FGbFw94iuTnXmuE3e6L3wM2ZaVT9b+mxenqaFsWsZS6yc+7Al5AAGsamFvh5UpJ/W1kc
         COXcK0l0i+to4qN4K/JFs9OBlWdYBcsfajCnI9L1mfg4t+LrOlxoLjvu5We1ZgKdvoEc
         No6ZcfhOVxuyKTyR3GcbccF9Emm3Kns5IhH3vxIdBtcQqn8VeVwdk4CBjxMRz58YiQlT
         FlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Haw1k5WQyfzJbLvONx7FVMMpnitJmr7FZIE1DGVa1k=;
        b=BgZIAjXvKocGp+SjVQcLfKDEKuBXR7aWQS4V9QENZgrYaXvIdBSBjNgt7N265znmgZ
         2p5jrZfiD7QnqlF1xhuXS1+mnrg4Xf4JkmNsn8KFkwSNU08zoqa8eZsCPshxzSacdryI
         umVqdIYz8oCy8uABvsOThsQWK9g7EtCrZyrln9uHctQ4/3gs7q6JArQyRiUdXvxMKkPm
         l+nxki0JBhbqbh512dKioop8UbsjpPrcke6NcH2gSUPZb+Zr2o/xCVkmT0O7ZC+0t54k
         nq6IcESt0/laTqWcqZaO5iDrtn2yeLmSkmCwiFsbvcLHK0+yDJBECUeqiLEe7+kuZoj9
         zZXQ==
X-Gm-Message-State: AOAM532JTJrUrnEf3RkZ65k8Z05KrLQJrBTZvOBf4bGDPC+78VFL2O+O
        Y/JB4Zeiij9rGl41tCfA0wo=
X-Google-Smtp-Source: ABdhPJwH5jdY0oYG7O05oIwVewsCa92dqm6tFwUN+pFI8bbsllSkbTebnUKyOxIwkYXNhkVNbUOqjw==
X-Received: by 2002:a37:946:: with SMTP id 67mr16167677qkj.194.1616841177670;
        Sat, 27 Mar 2021 03:32:57 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:32:57 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Fix a typo
Date:   Sat, 27 Mar 2021 16:00:08 +0530
Message-Id: <55b24d59c574741b30a931836498d7c1bddddf6c.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/cooresponds/corresponds/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..470d310b9b77 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3824,7 +3824,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
  * starting from file offset 'from'.  The range to be zero'd must
  * be contained with in one block.  If the specified range exceeds
  * the end of the block it will be shortened to end of the block
- * that cooresponds to 'from'
+ * that corresponds to 'from'
  */
 static int ext4_block_zero_page_range(handle_t *handle,
 		struct address_space *mapping, loff_t from, loff_t length)
--
2.26.2

