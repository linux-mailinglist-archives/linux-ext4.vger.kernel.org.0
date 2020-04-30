Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D538F1C0551
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgD3Sxp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sxp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Apr 2020 14:53:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCBC035494
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so5930321qts.9
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eor7mAlAIoNUaULZeHdV3ZV59VkPBmqmTLyrGd7P8mk=;
        b=HYkJxRrJLzBxyv9jwgRkbW5Unb6ZY3QkMpSnTXOR35g7PXdZ7bQgbEFOFoaYcs/hyD
         BzcTsBYrmdoLcF4NH7bDJ1Jc/cJ3DoXhuj1acHo2ZEDPPLaac8OzFKdDQz58sJbL2yEg
         vSJ5oiO0M3sApe6sue0I4SJz6FF42ZXBquJMIZevJRTr+P/GrZbjKAjq3G26uA/2oxIu
         9ZtBU8rdkVANh4iBShDWmogAOV7zq5G0tW1cU/kOWsm9sgdYRdlsYzvljOcOYxJWTm8e
         3bf73rKcET8m8Llb+11VmOeKOEDmLlUi15wmVp+CgT6zra/6urnAvBt3fv1ois7FZTIx
         nKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eor7mAlAIoNUaULZeHdV3ZV59VkPBmqmTLyrGd7P8mk=;
        b=uAKBTUeA8kqOnnW2OOM3G7T35vCQChX3Yy0r3zcewp5nbgfKaw9OZyn5WpFlzY/Hsn
         7FdbgQr3DhQyW+5rkpe74hfxAUUxsNT3w3tlQpXOwdYsmqSyCfGUJxEztI4UAsdWUt5P
         xgIFVg20jmSApMpiJt+eR4K43RhceLrH69nQmNzdu+az07YwylpvqJCq5SuATe+IZhxa
         ial7p9SD3ajoEluAYx3EREx7erZKhjmaa7MkPTPs3G07gFWBwCIxXdRnhtWe/64+cGYc
         TcCJr19C4yvv4Z7A0aFmRL5EENl/uhB+vxuTI6YeXADQCRHrLiYmmoGJYTWwdjgUh1Sg
         raAg==
X-Gm-Message-State: AGi0PuY5CX/18YxhRfmb661ONsie9noNz5sAC4vh04EpmSzj5KLFtpQD
        i2jrKwH8yHWjHsVoEqfHgUZALpjW
X-Google-Smtp-Source: APiQypINq5aOHc4Mm9DxPjx21HOnNKGdJcpedYqUBkQWGKa/iW/Mu4S2FALgBJv++L61GEyuOArRVA==
X-Received: by 2002:ac8:4b45:: with SMTP id e5mr5347069qts.86.1588272824593;
        Thu, 30 Apr 2020 11:53:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u5sm695815qkm.116.2020.04.30.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:53:44 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 3/4] ext4: clean up GET_BLOCKS_PRE_IO error handling
Date:   Thu, 30 Apr 2020 14:53:19 -0400
Message-Id: <20200430185320.23001-4-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430185320.23001-1-enwlinux@gmail.com>
References: <20200430185320.23001-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the call to ext4_split_convert_extents() fails in the
EXT4_GET_BLOCKS_PRE_IO case within ext4_ext_handle_unwritten_extents(),
error out through the exit point at function end rather than jumping
through an intermediate point.  Fix the error handling in the event
ext4_split_convert_extents() returns 0, which it shouldn't do when
splitting an existing extent.  The current code returns the passed in
value of allocated (which is likely non-zero) while failing to set
m_flags, m_pblk, and m_len.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 74aad2d77130..fc99f6c357cd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3815,12 +3815,25 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
 						    allocated, newblock);
 
-	/* get_block() before submit the IO, split the extent */
+	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
 		ret = ext4_split_convert_extents(handle, inode, map, ppath,
 					 flags | EXT4_GET_BLOCKS_CONVERT);
-		if (ret <= 0)
-			goto out;
+		if (ret < 0) {
+			err = ret;
+			goto out2;
+		}
+		/*
+		 * shouldn't get a 0 return when splitting an extent unless
+		 * m_len is 0 (bug) or extent has been corrupted
+		 */
+		if (unlikely(ret == 0)) {
+			EXT4_ERROR_INODE(inode,
+					 "unexpected ret == 0, m_len = %u",
+					 map->m_len);
+			err = -EFSCORRUPTED;
+			goto out2;
+		}
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 		goto out;
 	}
@@ -3860,12 +3873,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	ret = ext4_ext_convert_to_initialized(handle, inode, map, ppath, flags);
 	if (ret >= 0)
 		ext4_update_inode_fsync_trans(handle, inode, 1);
-out:
+
 	if (ret <= 0) {
 		err = ret;
 		goto out2;
-	} else
-		allocated = ret;
+	}
+out:
+	allocated = ret;
 	map->m_flags |= EXT4_MAP_NEW;
 map_out:
 	map->m_flags |= EXT4_MAP_MAPPED;
-- 
2.20.1

