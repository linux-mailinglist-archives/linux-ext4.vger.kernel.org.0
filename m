Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289D616330C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRU1F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 15:27:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32961 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgBRU1F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 15:27:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so15554479qto.0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iIHuBqZwK3fiW11YSsih5DOtNTFmGf8UzQ6/tQQ3BF4=;
        b=JLxUIvhDdjyknyaR0m3/WhGQ76QL6yMguI6FKrGZA02djyhdNZ5t8BTjHjCf2B4egd
         cWja/7CCWc5UPfW3AN3cXLEfhxpmwtb+IGkgoyuxWxQL9nqUosr+D7lfK7ceHVcqTHco
         2YPZtfeyniAkKEE3cZIlaGaF77lRzYXlRsGei5iTzBkn5KaIfKXVXXM6mxeKwVMlxxzr
         teqhlLeiYtPofxqWaf/U208y0pfKUbE414FDkyT9GusVXI+m5EC+ytT6MTc7bmnXPst/
         zgrOS7HU8Ccub1cI5Td/CE/MMUOgJkRuaOWZU0c25uK8TCMSo+JDuq3lSc4tn2fV9enU
         sDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iIHuBqZwK3fiW11YSsih5DOtNTFmGf8UzQ6/tQQ3BF4=;
        b=DgJzF90iEDyq7gd4/dieU1c/0Zpgved28bw0Tvfvwf7TFDTLQMfE1T9xcS/im4AuRC
         ylQVaaP72oFBqGIxmNTPUhIh4NeX82Ht3RPwLRpA9vKkIhmb+otQfep4THpLIGDrB7ff
         LZAqsz0UmwtCfqd4vt719IqcXeIpcOZLCGgzM8w4l3A7/VG6KAnoFlS5QpRa+ugL9kJ9
         A0GYed5Jp5tc82YB4FzYIWZpAD9xWgMGe7EErLLjNAN/LgrnOd/KNLQYiyJrTyLzVJFV
         SCnH7rX5wJZTpmNETbpls60WBGMU/JxwgiQw/k6Js9+T/Z09Zetb6gk8wzMCFtsVuqKo
         ZPxg==
X-Gm-Message-State: APjAAAUQ7mYN0ul4U74Z2b5563WPLiJCEPPkZcWe0G/VZPwjgQTS3GLg
        s/a/l2mlmUSV4n1CHdlL+v5Tb1tE
X-Google-Smtp-Source: APXvYqyD83Fb/MNbeB4LCy2kc843uABVoyhKotO+oLNe6yxIFUGp+b7q+RUFjhgsG1uaKHn036t5ug==
X-Received: by 2002:ac8:538e:: with SMTP id x14mr19116313qtp.301.1582057623910;
        Tue, 18 Feb 2020 12:27:03 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id k11sm2380743qti.68.2020.02.18.12.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:27:03 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: clean up error return for convert_initialized_extent()
Date:   Tue, 18 Feb 2020 15:26:56 -0500
Message-Id: <20200218202656.21561-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Although convert_initialized_extent() can potentially return an error
code with a negative value, its returned value is assigned to an
unsigned variable containing a block count in ext4_ext_map_blocks() and
then returned to that function's caller. The code currently works,
though the way this happens is obscure.  The code would be more
readable if it followed the error handling convention used elsewhere
in ext4_ext_map_blocks().

This patch does not address any known test failure or bug report - it's
simply a cleanup.  It also addresses a nearby coding standard issue.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d6076b..71820d879a80 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3931,7 +3931,7 @@ static int
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path **ppath,
-			   unsigned int allocated)
+			   unsigned int *allocated)
 {
 	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent *ex;
@@ -3995,10 +3995,10 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	if (err)
 		return err;
 	map->m_flags |= EXT4_MAP_UNWRITTEN;
-	if (allocated > map->m_len)
-		allocated = map->m_len;
-	map->m_len = allocated;
-	return allocated;
+	if (*allocated > map->m_len)
+		*allocated = map->m_len;
+	map->m_len = *allocated;
+	return 0;
 }
 
 static int
@@ -4308,12 +4308,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
-				allocated = convert_initialized_extent(
-						handle, inode, map, &path,
-						allocated);
+				err = convert_initialized_extent(handle,
+					inode, map, &path, &allocated);
 				goto out2;
-			} else if (!ext4_ext_is_unwritten(ex))
+			} else if (!ext4_ext_is_unwritten(ex)) {
 				goto out;
+			}
 
 			ret = ext4_ext_handle_unwritten_extents(
 				handle, inode, map, &path, flags,
-- 
2.11.0

