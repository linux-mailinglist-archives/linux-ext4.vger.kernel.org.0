Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45343A66A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhJYWXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhJYWXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 18:23:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D5C061745;
        Mon, 25 Oct 2021 15:20:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so542801pji.5;
        Mon, 25 Oct 2021 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gY/CrtG64wJSVZcLWOWpwa2R2QUK2S+0RFYWuG+wKCg=;
        b=JxfRcOOJUvz9MShRfjx7QNut1TTO5K+WAAp4bSEMJ6T8COF6VlwVe0PC33KxV1V+xj
         QY/HTJIs6xceUgVDsGOIhqdtna0lZpn+vh22OeND20l0ZAUfVFduyYS8OZ6Hdn3U1oQh
         W48S3zBie5el1etzqinYCyCisJ+OAloUABm5vGy6jySIBocYpaxyqVnXq0gwRVL/D15T
         v2H4DeDdnbSd5BLF6pp0L53ebm63zvaJPX+3Yla9BTUtYPgK+3SB9xfqynf2YdLsEI3z
         L8hUqG6fvrhRNWoq5K1PLNJv5P1dAKubAYVAX719F/JKiidSkdMAKeMB1GJe7GLC60b4
         ZG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gY/CrtG64wJSVZcLWOWpwa2R2QUK2S+0RFYWuG+wKCg=;
        b=3iTfEGQ+drZAax7ojkwnOwMqgzu8PDscF/u2pZEJ5Na1ruyfDfpzHWKDhzASBiciKT
         dN0slF5PZ5a1F7ZUyZ/1cNV3fSZcTAEOTPKlddmTEi/b0nDZQ5PXPExRv0ZqWfK8LFNA
         kfeZiIVvOB+vwIQwxsRlZsgPK8LOQnzgR47IogfVDzos0f7kpChJQ+SPwXxPmcZIMtl2
         8qDEZMk1J9u/IyXTPQ+Sop9/xcfDTTxhEO8Sp0pU8Ht18RTdiySKran1JZ22LR3e5scH
         LlIgKlIQIILJpsGwHZEBzMnEldrrqF1iRl5rp2cRsCOKhMm0y9zRrjVSflFRrvp4u45J
         UxgQ==
X-Gm-Message-State: AOAM533rHli/s50OseGXopm42bYYlImwWjo1ZFRmV40IgBTOR/f7XAGP
        d93GTxTxnIjfCl9OR5Fc2VE=
X-Google-Smtp-Source: ABdhPJw1M+GSNXjH3WTbbujpz1f0+KQg7PDYTju1ODa6ZJ+SOgud71PYDVpiJXuy6a6LbJDeHwImcg==
X-Received: by 2002:a17:90b:3148:: with SMTP id ip8mr23586012pjb.62.1635200449724;
        Mon, 25 Oct 2021 15:20:49 -0700 (PDT)
Received: from localhost.localdomain ([171.224.177.148])
        by smtp.gmail.com with ESMTPSA id v19sm17500636pfu.179.2021.10.25.15.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:20:49 -0700 (PDT)
From:   Nghia Le <nghialm78@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Nghia Le <nghialm78@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: remove useless resetting io_end_size in mpage_process_page()
Date:   Tue, 26 Oct 2021 05:18:03 +0700
Message-Id: <20211025221803.3326-1-nghialm78@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The command "make clang-analyzer" detects dead stores in
mpage_process_page() function.

Do not reset io_end_size to 0 in the current paths, as the function
exits on those paths without further using io_end_size.

Signed-off-by: Nghia Le <nghialm78@gmail.com>
---
 fs/ext4/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305167d5..03efed2ed1ea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2260,7 +2260,6 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 			mpd->map.m_len = 0;
 			mpd->map.m_flags = 0;
 			io_end_vec->size += io_end_size;
-			io_end_size = 0;
 
 			err = mpage_process_page_bufs(mpd, head, bh, lblk);
 			if (err > 0)
@@ -2285,7 +2284,6 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 	} while (lblk++, (bh = bh->b_this_page) != head);
 
 	io_end_vec->size += io_end_size;
-	io_end_size = 0;
 	*map_bh = false;
 out:
 	*m_lblk = lblk;
-- 
2.25.1

