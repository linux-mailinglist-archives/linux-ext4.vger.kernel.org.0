Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CEE444EF6
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 07:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDGjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKDGjV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 02:39:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B4C061714;
        Wed,  3 Nov 2021 23:36:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p8so3266206pgh.11;
        Wed, 03 Nov 2021 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qa38Hr8PpqNlm41iUNRxZ1ZclCNiQPBWGYmHAX7AEA=;
        b=gkjhlXzqcwDzSQ/RubPfs21QF072fAo1yzVASBcyOIl29IGux7V9TPCY3Mm7JRgdlx
         jScgBqDZyekGnLm9v8L1urjQ3stpzxzGlGir1IpkYrvmPaHPG/3zF7VpEMmJYsy9cwPs
         GnSEaHwnC0vKNe0MwD2ulrCDwJ9EQju6QEm0/5DxF/Bqkl/JuQBV44yPzPpdTg6562YP
         qoROYDEJhsdpw8p3QJ44bHZM38dzkFExse9rWoz6vf9SxsTrUl07gSc0gf8F+y13O3dK
         Xauks6KGhsCksK1MOL57CfrmZVeDIZCvZzyMWKjq+41DryS7FUQMx0yuWj/DQ6uBkjq5
         vhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qa38Hr8PpqNlm41iUNRxZ1ZclCNiQPBWGYmHAX7AEA=;
        b=f5VDceD7AXRttBRbjZCdz6tUZ73EB09hrhZrz7rm6BgiGZE6SYWD3+irPo2Ef6uThA
         J2Ftr4nJzyUUV0a/XLJGhnxoFpWUe+FEt2vTWyDdlevR/iK9c0S4viOyVJty2DRw5eyL
         ZuCn0TnSeKDWrenaHsFX+y2LIeSpEOSXXf6VXfuAZb5Dopj0h9V7y3gcL9nVdjQ6Y5oQ
         5aIPvCBpmk5BwYJ6zbxuNbb8oXlsxFIbBtuPCCiCw3r6Eq+gOsqJa0bEi72qOwln4gxY
         BSnTM8LQPy7WsctKTPxx07G8m+fxpl8A1Qf4yEVKxnVcE8TmsrCE1gM636a89Z6clQLv
         bx6w==
X-Gm-Message-State: AOAM5300gSsUb2lRtwdTdC6Ky8sTFw/GaCHuizWXSjtZgCY5qrq5pAAc
        CjDoexrKX8TOu0nzpecC5hhs4S8R5o8=
X-Google-Smtp-Source: ABdhPJzFY2or2j+EMWpzPgsR5TUIpvbjTSWZNGiNxhx1vz7l+Kf8B9qPLGB8FTqpYVINdc/iK3OpJg==
X-Received: by 2002:a63:b54b:: with SMTP id u11mr36845790pgo.163.1636007803874;
        Wed, 03 Nov 2021 23:36:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j5sm3339575pjs.2.2021.11.03.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:36:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] ext4: Remove unnecessary assignments
Date:   Thu,  4 Nov 2021 06:36:37 +0000
Message-Id: <20211104063637.2842-1-luo.penghao@zte.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignment at the end of the function is not necessary

The clang_analyzer complains as follows:

fs/ext4/mballoc.c:3889:3 warning:

Value stored to 'err' is never read

change in v2:

Repair the sending email box

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 089c958..f1258a7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3886,7 +3886,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	if (err)
 		goto out_err;
 	sync_dirty_buffer(bitmap_bh);
-	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
 	sync_dirty_buffer(gdp_bh);
 
 out_err:
-- 
2.15.2


