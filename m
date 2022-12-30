Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E035659776
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiL3K77 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 05:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3K77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 05:59:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DC1A390
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 02:59:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ge16so18272139pjb.5
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxndJAPqkkg+7Ix0bR4//3QWQHh62xysWAMqysIRogg=;
        b=r4S60t+e7LHJD84L4tGRkRjswj8B2srCvk7wIaOyMdPLpuAdJNk8govJKTrz9UGKWY
         6KrXE+RfpY0E6kdX3zBmuzZ5azWaJgfoPXkJKWigg4TFrHazZY3XhpcpOWQYnZI+LV0a
         YQ8OvN1X8JqLkpQe91eTg+5oppyBOZC9FAj8/py/ZIhF1hlqun4ml3iAXZxH3XbY8Db2
         7QKJjfXwYujAw9z6rq7fkPIkIvj2jnaXcs6o9B8nefySlMDw+8CdmX16/cIdQ4tNgIul
         0vyfbrd8dqA/JlOP+Jla3JjoKvIbOzaCsChJHAvz/WE3fW/EsMnhx2eyOh+B84Xx6XeH
         34bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxndJAPqkkg+7Ix0bR4//3QWQHh62xysWAMqysIRogg=;
        b=WtVwQRLg4NPUw/bWxS+vlEb5dU/qfxQP4PKp88K4OOL21nz9DcoANCtqzv5Lb/mBaL
         8UT6Px4Sv9MNwfCahRigEWiSxwSi80opLrYIzakmrEJ51OwWtoalegi9E+zIJD0Zmeex
         /p7ZT/WMCeBFvAD7QiSQ72OQMReJlIKDAs6P/V2AfD7p4s0M7aqs36jj/Qk9MbtoDlcd
         85lrKoy2fn6nWukQm/q+YQIAX1PnoUVnjJBPC78S+vtDFt2ndsszO3Dquoa1hA6ukeDR
         lhJottkVLjtK/ja7hVpjZOtdhXCHDhVTZ0Tc8DlZKhtG8envVhEFBuvp1JRulACHKuDH
         Ug4A==
X-Gm-Message-State: AFqh2koBPUoyuhLHUj9b2NEUsSPT4vobjKfTMCym6WVOybE7w/y00JtC
        shpMQeaZe3jNQuTJWJIrXpZxFA==
X-Google-Smtp-Source: AMrXdXtbsjbDOe4a+dSKeMV3//SGrYFNIXwKXcSRIhyUZDUFh/NuC4tBsnNsoI7Vyrjx33cp0GCkfg==
X-Received: by 2002:a17:902:cec2:b0:185:441e:6ef3 with SMTP id d2-20020a170902cec200b00185441e6ef3mr54743349plg.61.1672397997228;
        Fri, 30 Dec 2022 02:59:57 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b00186a437f4d7sm14662525plh.147.2022.12.30.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 02:59:56 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH 1/2] ext4: optimize ea_inode block expansion
Date:   Fri, 30 Dec 2022 19:00:15 +0800
Message-Id: <20221230110016.476621-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
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

