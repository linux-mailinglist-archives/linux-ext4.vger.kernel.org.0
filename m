Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A034B629
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhC0Kcr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhC0Kcq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:32:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10BC0613B2;
        Sat, 27 Mar 2021 03:32:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i19so6033482qtv.7;
        Sat, 27 Mar 2021 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vfeX0nQR+Sy1hp+kWBQYT0oWd50oPW/sWKexnSkktI=;
        b=BmhuCbqnuTX+FKdOu5E8pqR7kYrQ16WEhjT/FDx9Gy0VMc0tBYzRCCXqRcnxWSnCI4
         JJyutxdhni0plsfc9nCfHOjrdEurSYysFOY66hryUywcj7cnTah06iTeM13uALX4PUf2
         nOFhscRB1zdoBZ+4E9XWgFylW9HIK5CoFL6ncnJ7R2ua1Am2+0QXbiLAxEdHuYczm+tT
         tq2EgbiMhoWqY7EQmZfj6mcrqZwo81q3CwIBWog557iUZs18BPA8jD8JJSBp4hTMgGZ/
         MAZJKGHfQVtT7a+RKhSLuunjSWSN7g1Xv3xw9Grxf1tMRAzfay4be5CJowxvV61gIaTm
         3toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vfeX0nQR+Sy1hp+kWBQYT0oWd50oPW/sWKexnSkktI=;
        b=ZWSwTmzrFrxR8+t6rESj2V7PlR2S15hLLPQlyOlGF7cDOw30RjjtHIpqS8pQnCsJsM
         88RBonrHXtf96sGkDm6MtBSvxhkQDzDLxnm600TYHdhDKp+Xnnp8NJJ3Zj3bm9e7R7Vv
         e5jy07ClqlDUEdX4e2mkHUGl0TDJj3qxTrZSEbjNkI7qzb8jtkRX+UyTUCy/3dMpsbTX
         q0fhwz4smzHR8TPw+dptnjSzV8wh2GVVB3Q9YfHvOV0Q6jQoZVV0QtdaPKS0hge3n5eG
         o4ybjxq57Csnj80WCc0UXfeM5hY/f1f3jYvSd3M7H0lhFr6Sln9Rj8ObmVLZaqeJD713
         Kwag==
X-Gm-Message-State: AOAM532tveTkZw/y2zZfDZkITL4VlDprgbGr70Pvh2TQRtbGmcPp12ss
        nV6eC9QAIl6Oxr3+W5HIQmQ=
X-Google-Smtp-Source: ABdhPJzmxXXmp1ahvLsTvEw7tSKaezOHwgFojydNSzbr9DywIWOd8dI/lcbVMtf48F3hKPUmyzv1AA==
X-Received: by 2002:aed:2983:: with SMTP id o3mr15419043qtd.149.1616841165646;
        Sat, 27 Mar 2021 03:32:45 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:32:45 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] EXT4: migrate.c: Fixed few typos
Date:   Sat, 27 Mar 2021 16:00:05 +0530
Message-Id: <1b98b82909dd0f835ffc397206a1ab534fed0afd.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/convinience/convenience/
s/accumalate/accumulate/ .....two differnt places.

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

