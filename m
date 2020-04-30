Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBE1C0552
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 20:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD3Sxr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sxr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Apr 2020 14:53:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C4C035494
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so6884665qkg.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vVddqGsOmdchap23aulHNUzb9x3m+wzZQjd8/DLcK0=;
        b=TuaDdIv/dauINwTxVv4h7aGFKCCPm+iVC0wRrsK5w4yzXdcGvKal8DnYhlDZs8pz9/
         Eo/H8IfXzPLsus1wF2p5Eu/9FtESkVRAbx1RM4OJ5ewuNEj0CCY9DAi0Cy29ppH4wPIY
         7pr4YMvZ7rQjv8wAGfA3GTy/5jrYbOVpXSZcPXuWgYJXholcBQ4HJ/dVaEVrtce5V1y0
         xYCvHiui9GmyXU3IOjjdfkqta2erIrGZgs9+rSn01gDTSE44qamrNoLodo6cd/hBBEPB
         U+uFQFkdGEi3MPF2ulGV63tfvRoEBx+9QgcgLXLcgNwkyofCJw80/D4Myr7e80/77JrL
         LBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vVddqGsOmdchap23aulHNUzb9x3m+wzZQjd8/DLcK0=;
        b=jBM80AfEoTotzgqVwqopoX+40qjDLvLgFPKOoSklMxl+JQ+G4MZu0ltqfYHVBp4i/Q
         eazo5lD6cRW7f9z29fWX00JYYK9zw2Mrz+5WPWBzfMq9O3nXjShd+V12/hFdSgxVxx7H
         b3Yh+VMiKfa2Skhjk0GF4lBABVG0UFzaphUXKlse1EK6yTzjfvlZYhIFhrG69EkcahUm
         zqQuIvuJTnMT3Qp1S6bif47a39QZaXcEMtMg2Y7K4DO3c103/UTWL5mn8RPHvjvYErHv
         IF5HKTIQup5FVjXs/SLhLQKRUu8BkrMv7xAArHv93nklrNEKlX+m+tWetgVtn5Dzh+/v
         fMeQ==
X-Gm-Message-State: AGi0PuY/XGuHL2uDz5c5r4HwH1fwRKzCSe0coX6OFv2Qg31jEPZcEzSy
        uTgrI3JmV8IqEF2dboJ1NeK1Xzhk
X-Google-Smtp-Source: APiQypJy6wN9aVc1l/m74Alxw++4ZMB3byOdZEAe7PMjn4ykCRUR1+Bc7uCSI49pHTsHmQa1ThkfXg==
X-Received: by 2002:a05:620a:758:: with SMTP id i24mr4978480qki.46.1588272826495;
        Thu, 30 Apr 2020 11:53:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u5sm695815qkm.116.2020.04.30.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:53:46 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 4/4] ext4: clean up ext4_ext_convert_to_initialized() error handling
Date:   Thu, 30 Apr 2020 14:53:20 -0400
Message-Id: <20200430185320.23001-5-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430185320.23001-1-enwlinux@gmail.com>
References: <20200430185320.23001-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4_ext_convert_to_initialized() fails when called within
ext4_ext_handle_unwritten_extents(), immediately error out through the
exit point at function end.  Fix the error handling in the event
ext4_ext_convert_to_initialized() returns 0, which it shouldn't do when
converting an existing extent.  The current code returns the passed in
value of allocated (which is likely non-zero) while failing to set
m_flags, m_pblk, and m_len.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fc99f6c357cd..202787977e3d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3869,15 +3869,28 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 		goto out1;
 	}
 
-	/* buffered write, writepage time, convert*/
+	/*
+	 * Default case when (flags & EXT4_GET_BLOCKS_CREATE) == 1.
+	 * For buffered writes, at writepage time, etc.  Convert a
+	 * discovered unwritten extent to written.
+	 */
 	ret = ext4_ext_convert_to_initialized(handle, inode, map, ppath, flags);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
-
-	if (ret <= 0) {
+	if (ret < 0) {
 		err = ret;
 		goto out2;
 	}
+	ext4_update_inode_fsync_trans(handle, inode, 1);
+	/*
+	 * shouldn't get a 0 return when converting an unwritten extent
+	 * unless m_len is 0 (bug) or extent has been corrupted
+	 */
+	if (unlikely(ret == 0)) {
+		EXT4_ERROR_INODE(inode, "unexpected ret == 0, m_len = %u",
+				 map->m_len);
+		err = -EFSCORRUPTED;
+		goto out2;
+	}
+
 out:
 	allocated = ret;
 	map->m_flags |= EXT4_MAP_NEW;
-- 
2.20.1

