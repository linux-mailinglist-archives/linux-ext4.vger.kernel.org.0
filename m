Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8810C67695B
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjAUUhJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB252916C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B4160B76
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C25DC4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333404;
        bh=IF0tzK9qzRjNcfSVZjyoBUt3GW1r1KZLNwT9shnLSiw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RN0PH/lPg6F1oUwkbqvwSa2X2ZeXvzvTJeWqmKoWTl+iVPDqxCf3xjD2sfzJMBd37
         9TVE4z4BNCFYqRKrPRu6Ekyxi+mL46rr+tsdoFHQxyoJ2dcUseArpzuyQH8i4bURD7
         8Eg5W63g1E6xLzfsZCMlAToSV7ozC989NRPlezL7qLeRnZcdge54Tlt+2OX1aRSAOQ
         Pu/Ku1cMzjqZLy9kJ40tRPfZl6TZJjV9HQQMcccDvs7hLsTaaLXh8vs3RwBDuVc3yP
         hRjZKa4aiJZOfN89czSi/hVEJtEYI05B1sSzswB/gxeszA/X6Jd0U62XiAsPRbd33L
         HwXUtbVQiXUIg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 29/38] misc/e4defrag: fix -Wstringop-truncation warnings
Date:   Sat, 21 Jan 2023 12:32:21 -0800
Message-Id: <20230121203230.27624-30-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix two -Wstringop-truncation warnings in is_ext4() by simplifying how
how mnt_type is handled and by using the correct bound for mnt_fsname.

Fix a -Wstringop-truncation warning in main() by replacing the fragile
pattern 'strncpy(dst, src, strnlen(src, N))', which doesn't
null-terminate the destination string, with a standard string copy.  (It
happened to work anyway because dst happens to be zero-initialized.)

These warnings showed up when building with -Wall with gcc 8 or later.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/e4defrag.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/misc/e4defrag.c b/misc/e4defrag.c
index 9ec265f2e..33bd05d2c 100644
--- a/misc/e4defrag.c
+++ b/misc/e4defrag.c
@@ -258,12 +258,12 @@ static int get_mount_point(const char *devname, char *mount_point,
  *
  * @file:		the file's name.
  */
-static int is_ext4(const char *file, char *devname)
+static int is_ext4(const char *file, char devname[PATH_MAX + 1])
 {
 	int 	maxlen = 0;
 	int	len, ret;
+	int	type_is_ext4 = 0;
 	FILE	*fp = NULL;
-	char	*mnt_type = NULL;
 	/* Refer to /etc/mtab */
 	const char	*mtab = MOUNTED;
 	char	file_path[PATH_MAX + 1];
@@ -307,26 +307,16 @@ static int is_ext4(const char *file, char *devname)
 
 		maxlen = len;
 
-		mnt_type = realloc(mnt_type, strlen(mnt->mnt_type) + 1);
-		if (mnt_type == NULL) {
-			endmntent(fp);
-			return -1;
-		}
-		memset(mnt_type, 0, strlen(mnt->mnt_type) + 1);
-		strncpy(mnt_type, mnt->mnt_type, strlen(mnt->mnt_type));
+		type_is_ext4 = !strcmp(mnt->mnt_type, FS_EXT4);
 		strncpy(lost_found_dir, mnt->mnt_dir, PATH_MAX);
-		strncpy(devname, mnt->mnt_fsname, strlen(mnt->mnt_fsname) + 1);
+		strncpy(devname, mnt->mnt_fsname, PATH_MAX);
 	}
 
 	endmntent(fp);
-	if (mnt_type && strcmp(mnt_type, FS_EXT4) == 0) {
-		FREE(mnt_type);
+	if (type_is_ext4)
 		return 0;
-	} else {
-		FREE(mnt_type);
-		PRINT_ERR_MSG(NGMSG_EXT4);
-		return -1;
-	}
+	PRINT_ERR_MSG(NGMSG_EXT4);
+	return -1;
 }
 
 /*
@@ -1865,11 +1855,9 @@ int main(int argc, char *argv[])
 			/* fall through */
 		case DEVNAME:
 			if (arg_type == DEVNAME) {
-				strncpy(lost_found_dir, dir_name,
-					strnlen(dir_name, PATH_MAX));
+				strcpy(lost_found_dir, dir_name);
 				strncat(lost_found_dir, "/lost+found/",
-					PATH_MAX - strnlen(lost_found_dir,
-							   PATH_MAX));
+					PATH_MAX - strlen(lost_found_dir));
 			}
 
 			nftw64(dir_name, calc_entry_counts, FTW_OPEN_FD, flags);
-- 
2.39.0

