Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688A91C0550
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgD3Sxo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sxn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Apr 2020 14:53:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7624C035494
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so5977635qtt.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zc5WLDaH0/OFz+swOtTEawhwZRfkWkP/YVekfgyaU4=;
        b=qmUx+N5KMxuGyyTm6c0m+gmAl/UeE7qimx7L8N0SCxIrHXEvOSx2iZ4Wge6Fzzansg
         I8VlxnyZeoPmsI7maRVlgA+rUfhQSh1gLM3yNZk8bnhGnH2f0lWsybPvXOa4hrVDI1Gm
         0eh52IqPsN6ShoSP5MJ9Uy4O4v0wiR/x+f27b+zLapu8FmzmNpqM2RlnKbqP1AkxIDUU
         r4d+hIuue0GBYyIguVVR26hQGgJo7jmO9z4tswI2y+dG2OZOA/fSDB4gwN1jo6CkFgdZ
         Kg0nNiUF0qVqbQz/nm5eMLD8qInopZjxygg4lzUVAmKg5L03+ygAWqYgSv0lAETXcfIL
         qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zc5WLDaH0/OFz+swOtTEawhwZRfkWkP/YVekfgyaU4=;
        b=uBHnolGyb5sULENs14qW/AMmfcXAoOZu1GcsRq8UEZdQQ8VglJzp5NTsKckZynVyyO
         EJhPwMcBeIihhwInpEVJ0RpH3i1QV/V+mV0SAyFLBoVlD/QAIex0hBFWY7OMHilUObvb
         ckl2rrpudhop5BLsPrGBrHiNcRVBjJHipxqkrz4NNjJQU/2vtMqYRuE+c7gZp25OlJIS
         ZNPACS/YvCLjYZpZy4k0T5aCn+WQGGwPwIfSZOv9nREd5KpD1+1HwHVVp6wPiGkBMlKg
         jH4YcUu2XRlAzPo7/r4FhWCPxfetqcYDZC03H1cwMzsNQH0+VCW80rMV7wO6KWswy/iP
         sMdQ==
X-Gm-Message-State: AGi0PuYTjJs9kZTJk0GuWFAJqMahfkC6XwDevNJglRrevDN9l/HDL3oO
        qPSqZ6tZptU4RRmIBL7UDKCIPY3S
X-Google-Smtp-Source: APiQypKwWXx8wiIB0hMGosFWvOHn7BSMVd7C3jERtq52yUMG+bSkql32gVaHhzSsiB17I7Ba3xWArQ==
X-Received: by 2002:ac8:7204:: with SMTP id a4mr5257346qtp.324.1588272822873;
        Thu, 30 Apr 2020 11:53:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u5sm695815qkm.116.2020.04.30.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:53:42 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 2/4] ext4: remove redundant GET_BLOCKS_CONVERT code
Date:   Thu, 30 Apr 2020 14:53:18 -0400
Message-Id: <20200430185320.23001-3-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430185320.23001-1-enwlinux@gmail.com>
References: <20200430185320.23001-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove the redundant code assigning values to ext4_map_blocks components
in ext4_ext_handle_unwritten_extents() for the EXT4_GET_BLOCKS_CONVERT
case, using the code at the function exit instead.  Clean up and reorder
that code to eliminate more redundancy and improve readability.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 59a90492b9dd..74aad2d77130 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3826,20 +3826,14 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
-		ret = ext4_convert_unwritten_extents_endio(handle, inode, map,
+		err = ext4_convert_unwritten_extents_endio(handle, inode, map,
 							   ppath);
-		if (ret >= 0)
-			ext4_update_inode_fsync_trans(handle, inode, 1);
-		else
-			err = ret;
-		map->m_flags |= EXT4_MAP_MAPPED;
-		map->m_pblk = newblock;
-		if (allocated > map->m_len)
-			allocated = map->m_len;
-		map->m_len = allocated;
-		goto out2;
+		if (err < 0)
+			goto out2;
+		ext4_update_inode_fsync_trans(handle, inode, 1);
+		goto map_out;
 	}
-	/* buffered IO case */
+	/* buffered IO cases */
 	/*
 	 * repeat fallocate creation request
 	 * we already have an unwritten extent
@@ -3873,18 +3867,14 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	} else
 		allocated = ret;
 	map->m_flags |= EXT4_MAP_NEW;
-	if (allocated > map->m_len)
-		allocated = map->m_len;
-	map->m_len = allocated;
-
 map_out:
 	map->m_flags |= EXT4_MAP_MAPPED;
 out1:
+	map->m_pblk = newblock;
 	if (allocated > map->m_len)
 		allocated = map->m_len;
-	ext4_ext_show_leaf(inode, path);
-	map->m_pblk = newblock;
 	map->m_len = allocated;
+	ext4_ext_show_leaf(inode, path);
 out2:
 	return err ? err : allocated;
 }
-- 
2.20.1

