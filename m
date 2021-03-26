Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0634A75D
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Mar 2021 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCZMdu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Mar 2021 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCZMdn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Mar 2021 08:33:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1093EC0613AA;
        Fri, 26 Mar 2021 05:33:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g20so4997778qkk.1;
        Fri, 26 Mar 2021 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1HoQOlFK45LqbwKA8xSwNvct1ROnntMbS0R2nBbCrg=;
        b=r6YNSVFZ+slcBEEFimAknB2fFFEaK2on9WC/6sgUBUYNj5AlB1rPIn6WzKOfN5NWU0
         tMXYI9cx5Qq8iq6atwCVpw1vixIlEVWMpR4385j2O2qtpsNBgaKeKNULQVQIULxeRRaB
         UsG4iKBLn5Ut/dVNeE/0NByToS+QZosFLFE65z8fHjOxdPF64xTjxdj3xHtLTOW3KSBg
         UsVHuwbwiXhFK3l2ax+vXpGc4spbWHy9DxBRB7ZZgHL6ILc8Yy/Y9XJUX6oq4exclIY6
         5MZDh2A/qQTn/JPYUowi+zMNI2m9/+tbkuHkqUB/EmD7CyI/wrFDE2UK3gNpiR11HriT
         gBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1HoQOlFK45LqbwKA8xSwNvct1ROnntMbS0R2nBbCrg=;
        b=eaFZvy1R6EiKfIAQtkHPLCURWDLUXYVbcQxT7Oog7rS+CkJLZOWBu3SMNAfaxNjt51
         zcc80bxyMxa/DsYwKJGLDdFuSVC/zW9D5tAwX1/9JhmLQNpPIcn5ROYUoMDeWjtvfgpC
         FCa3GMsBKZmFvs75SpUE4qZjDl7eH0Bwl2+MhwZb9fiSCVWrvqFN8KmJyA5wZ2JAuIkB
         6UsNvDmjdnpR+Cm7KrJSzsEc3R8HtCKRl89B1wsZI0mVwy0XjYyVkmMGBtdkOHxd5OnQ
         rsZHIkNXMEMGcNotesg9ZY7cX6uZvJFo8OST9qF77TzTvYcf1QoC3rKNA0eXWisFFHOY
         ybmg==
X-Gm-Message-State: AOAM532v1KImjW3EWu1KV3exk+w2keBaMkISIRmg3kIqXyKNtpSDm6C9
        ogb4LKkcXEMFp+YAhUB0KukWO9I9BUnPtK0B
X-Google-Smtp-Source: ABdhPJxbf9sZfuhxrD4KBekAIQNRIUoq80wrpk08MW76UBLX9CBZ8xGKEc3ZPKSoDmtWYfRtSQ+BWw==
X-Received: by 2002:a37:7b41:: with SMTP id w62mr12619818qkc.256.1616762022344;
        Fri, 26 Mar 2021 05:33:42 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id h11sm5543681qtp.24.2021.03.26.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 05:33:41 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ext4/migrate.c: Mundane typo fixes
Date:   Fri, 26 Mar 2021 18:01:29 +0530
Message-Id: <20210326123129.30089-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


s/convinience/convenience/
s/accumalate/accumulate/  .......two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index c5e3fc998211..7e0b4f81c6c0 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -32,7 +32,7 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	newext.ee_block = cpu_to_le32(lb->first_block);
 	newext.ee_len   = cpu_to_le16(lb->last_block - lb->first_block + 1);
 	ext4_ext_store_pblock(&newext, lb->first_pblock);
-	/* Locking only for convinience since we are operating on temp inode */
+	/* Locking only for convenience since we are operating on temp inode */
 	down_write(&EXT4_I(inode)->i_data_sem);
 	path = ext4_find_extent(inode, lb->first_block, NULL, 0);
 	if (IS_ERR(path)) {
@@ -43,8 +43,8 @@ static int finish_range(handle_t *handle, struct inode *inode,

 	/*
 	 * Calculate the credit needed to inserting this extent
-	 * Since we are doing this in loop we may accumalate extra
-	 * credit. But below we try to not accumalate too much
+	 * Since we are doing this in loop we may accumulate extra
+	 * credit. But below we try to not accumulate too much
 	 * of them by restarting the journal.
 	 */
 	needed = ext4_ext_calc_credits_for_single_extent(inode,
--
2.26.2

