Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1580334B635
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhC0KdI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhC0KdH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:33:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A0C0613B1;
        Sat, 27 Mar 2021 03:33:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g20so7881673qkk.1;
        Sat, 27 Mar 2021 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3xJvgZB5dKnG6DpFNul5HX6+8zGHiQ2OFnxMsWdXbc=;
        b=mPNm4B0scQULyL9Yrkf5fXtqiCc2pc/s6iUlR0rA+KIDtp9hYBeCVcHjGWezqoBZM+
         JeF/6gBsm3F8z7+5vIKk1drLMZ0GiK0wnhRv8L+5mA61Q1osZ2EH8/Yob2WB5Sn5/2Oe
         f9nAYnMfWKvBFTSSb7NT2/Frg6aXXDAO5LwMTm2QGqSasKVTnYicBTgljb4noHkL4fA5
         Os0LD/5DtfdUrUSmhskWSLUGD2D42nO+WFrIWEK8x/h4oH66QAUw2SIyGKD/bQSbuTCx
         uSy6rNrGmtiLMAyNtDjJyNprOunrePwSs8W0uqmHD7cvNLkAZLBSgY7MLjhWg7yL0JDs
         L7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3xJvgZB5dKnG6DpFNul5HX6+8zGHiQ2OFnxMsWdXbc=;
        b=TEiWYaLifarQedayIv/0NMzhpxIbGygopV3upoM6fzyztHXjnTHdTCNfES5O66lZ+G
         eolLujJw6qOMcXzhWwgWq3eua9ZTmXFtuiy+sWZGGIdDsa7MC5STguowivUUMi/c+CZQ
         kK3iKX6sQ/UkMw6DMv/Sosuuo6OAnvsbhTqjZ/cbKhI5o8kHfvyakhffSr1ZJAhMgWqR
         0uvYl2yS0yAnSTcaQ+Gr+D+OFFPkyqrb5Nv0s71bW8UQSWWE0XGv6wKcKBJRjHqgtazM
         KEi23furo0tbOHv03g6iDJg9z/TuYoqRuqk62e1QzmSBVp0dTUV6oCiuunAbrxqQJWsh
         t5Ng==
X-Gm-Message-State: AOAM531lTsWLk/56RR9RvGhTrUbZUgOeDdZarC+einMCJEHNI+j+rrYC
        LEcKjcxHUtq7eCRCEvjaYMw=
X-Google-Smtp-Source: ABdhPJyWkR9nxfoGs4r5iuJWOYst4Z9xaoksHedIfHZq5KVCuO4Eai0ZdklWPLLW9zDkkE5phs/ZKg==
X-Received: by 2002:a05:620a:e1a:: with SMTP id y26mr16995172qkm.280.1616841186413;
        Sat, 27 Mar 2021 03:33:06 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:33:05 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] EXT4: xattr.c: Mundane typo fix
Date:   Sat, 27 Mar 2021 16:00:10 +0530
Message-Id: <ebaa6e8b9d610f0c0dc16e62289850ef432165ce.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/futher/further/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6c1018223c54..10ba4b24a0aa 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1617,7 +1617,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		 * If storing the value in an external inode is an option,
 		 * reserve space for xattr entries/names in the external
 		 * attribute block so that a long value does not occupy the
-		 * whole space and prevent futher entries being added.
+		 * whole space and prevent further entries being added.
 		 */
 		if (ext4_has_feature_ea_inode(inode->i_sb) &&
 		    new_size && is_block &&
--
2.26.2

