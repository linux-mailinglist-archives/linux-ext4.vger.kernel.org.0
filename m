Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2765B8FD
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 02:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjACBpI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 20:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjACBpC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 20:45:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4DA45D
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 17:45:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o2so25940790pjh.4
        for <linux-ext4@vger.kernel.org>; Mon, 02 Jan 2023 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxndJAPqkkg+7Ix0bR4//3QWQHh62xysWAMqysIRogg=;
        b=OA9Ef4d7WAhxk3cq8MrSUCkpcHlzZH+HT+d01d/QTtdnSonZ77AoCruMSuanMHugrn
         jl58RqjaIt0JWQTOB4sKnOn7DJLfWU5rPX6UHsz63hrE5SseDFK+oNb0mR/v4kgVVYTM
         quJA+9nHYuVz4qNR7p5zQl3wENJWYe+mgyoZsbJP9YQ1SXQ+JaUd7UpmQExG4o7bsiCg
         +F5vpkzxahtdpc5rPPMiWriCxPqfQ4T9cRQ47j9WNlGnjk+dxn5+BH8ug6db8DsGbW3H
         nHPKCqO5VkHLEKkFgxlzjL8DT8CqyQvgCvdQ/EtJEEa1kO+nh591uZ7L7CnhA1XQW84s
         I+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxndJAPqkkg+7Ix0bR4//3QWQHh62xysWAMqysIRogg=;
        b=UyDfXy54MABbx01lMXaeNsIomv1PH9OsoasJG9hCbyz0j79NvI9uyP+XW1/9Z24OSw
         HVziwDUT/wuRFP1ji6ZiH4BjeWhk7oCOcv9bio4j4T2bVoKF6NWU6X4baBf/8H6effmY
         9llDmBIEzRS/sbUPJol8zEzFEC13Ldw9dA4wIVW1oy/EFKyMEhUlKCncsgCbVwV7hd4B
         0obFhsvlwGjHQUO0touHpwzoNYds3JzoMTrvUzvSDwaRIOloHpegAsG/zsxToWsDwN8w
         rKBava3xjx8qCIYhdknuXxeHtqWOwd9pRU6/VQCNWAtLmzEzOWXaRxt05lU3bwq3o8ts
         hzcA==
X-Gm-Message-State: AFqh2ko1YPEsBwLR05rUQ2naMXavjKrjpM5FNINcaBgCGeZVVD8+dPZJ
        Dm4vFahkMj1tDHud0h4ZOsrTpkv/pRCLSjHz
X-Google-Smtp-Source: AMrXdXu6ms8jwa7l3akSlsQVzB56U6hlL47LPcdCgIQm0acDZRRCDScYKInsFoEtDPDalygWO6EJ2A==
X-Received: by 2002:a17:902:c948:b0:188:a6ea:279f with SMTP id i8-20020a170902c94800b00188a6ea279fmr60269041pla.12.1672710301260;
        Mon, 02 Jan 2023 17:45:01 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b001769206a766sm20588895plr.307.2023.01.02.17.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:45:00 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH v2 1/2] ext4: optimize ea_inode block expansion
Date:   Tue,  3 Jan 2023 09:45:16 +0800
Message-Id: <20230103014517.495275-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103014517.495275-1-jun.nie@linaro.org>
References: <20230103014517.495275-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Copy ea data from inode entry when expanding ea block if possible.
Then remove the ea entry if expansion success. Thus memcpy to a
temporary buffer may be avoided.

If the expansion fails, we do not need to recovery the removed ea
entry neither in this way.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 fs/ext4/xattr.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7decaaf27e82..235a517d9c17 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2551,9 +2551,8 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
 	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
-	buffer = kvmalloc(value_size, GFP_NOFS);
 	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
-	if (!is || !bs || !buffer || !b_entry_name) {
+	if (!is || !bs || !b_entry_name) {
 		error = -ENOMEM;
 		goto out;
 	}
@@ -2565,12 +2564,18 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 	/* Save the entry name and the entry value */
 	if (entry->e_value_inum) {
+		buffer = kvmalloc(value_size, GFP_NOFS);
+		if (!buffer) {
+			error = -ENOMEM;
+			goto out;
+		}
+
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
 	} else {
 		size_t value_offs = le16_to_cpu(entry->e_value_offs);
-		memcpy(buffer, (void *)IFIRST(header) + value_offs, value_size);
+		buffer = (void *)IFIRST(header) + value_offs;
 	}
 
 	memcpy(b_entry_name, entry->e_name, entry->e_name_len);
@@ -2585,25 +2590,26 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	/* Remove the chosen entry from the inode */
-	error = ext4_xattr_ibody_set(handle, inode, &i, is);
-	if (error)
-		goto out;
-
 	i.value = buffer;
 	i.value_len = value_size;
 	error = ext4_xattr_block_find(inode, &i, bs);
 	if (error)
 		goto out;
 
-	/* Add entry which was removed from the inode into the block */
+	/* Move ea entry from the inode into the block */
 	error = ext4_xattr_block_set(handle, inode, &i, bs);
 	if (error)
 		goto out;
-	error = 0;
+
+	/* Remove the chosen entry from the inode */
+	i.value = NULL;
+	i.value_len = 0;
+	error = ext4_xattr_ibody_set(handle, inode, &i, is);
+
 out:
 	kfree(b_entry_name);
-	kvfree(buffer);
+	if (entry->e_value_inum && buffer)
+		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
 	if (bs)
-- 
2.34.1

