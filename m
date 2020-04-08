Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC84B1A1EF3
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgDHKpx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:53 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32929 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id cp9so2069778pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zXhq3xOXGn+EHl8xMpXGWkGwAKQtIqVmt83aW0MwwE=;
        b=fnBPfdqCFIlLdPj7iN+KpT8sxEK8G5ge2uUnTVNGYOQgBWZALrCRe1hc42Evw15BkM
         ludoYA5G0oIWP5GbbVFDouYnJP/rdxclAemaZwLzaLCeqowsf0UHBjUoj/zEGKa1X0BO
         cRJvvKyoRu+n/nZCeZOaV1Gha6uSDSUozPlOojnexd5IJ9lXX2iCcjSTk3pXqyDdfgqe
         4JzyEp9V5hwn7v2d9N6wOpAGJRv4WYAAW5AhbRg/K+flMThwFrFEVxLQ0Ms2Mc8ii03Z
         8pGoqU/mjWsximj5ZAXy1rRLA9UuxuCOVjhQoj/H3CRWkwJi0iP0fry8y9A31qZhah5w
         cGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zXhq3xOXGn+EHl8xMpXGWkGwAKQtIqVmt83aW0MwwE=;
        b=POKmfM6KqdqTc0M0IXipoYVJtXmy9SzowI+ecc9CsWGMUeRLDKGJ/kE8xUg6g5/36k
         gxLJI2TihGFwn0YmJqysnfdvvYoRouMp+VTAhYXhWKN0dcMLbHMNAadIKpGs7eX1fOxH
         MlODNjn/D5LRT8k2Ag/pIRVQNs99HbSWISL9O/UYzMPYqfma277WQoDN9CqhCeUh2Gel
         sh6FJ1seWt4VhYsb6YIRL/PlYGlcofkr3J+80kgCeam6f+JigKrU044cTU8rLyiyisQ8
         FJJ3j20alTDTqTDsKs/6gujWvyisp9C4h2KkzoLdUMufMW+h7bVKGVBXByAMEb0ITwdP
         L8+A==
X-Gm-Message-State: AGi0PuYhzETpnLcWo/KrFRbcizNfrcd3wwM+RspIgXEREEidStbElMNM
        195CIe0iRIHm3ysnnnIQA5AFNAM3pV8=
X-Google-Smtp-Source: APiQypLX6ffl6rcAGswYR8SrG+6KDMUpxGHPS3m21lWm2KFC8rDgQNVztKw+6JmydjGu+MUA7HDkYQ==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr6599429ple.109.1586342752127;
        Wed, 08 Apr 2020 03:45:52 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:51 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 09/46] e2fsck: copy badblocks when copying fs
Date:   Wed,  8 Apr 2020 19:44:37 +0900
Message-Id: <1586342714-12536-10-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch copies badblocks when the copying fs.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 55 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f3337bde..de56562c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2163,10 +2163,23 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		src->dblist = NULL;
 	}
 
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (retval)
+			goto out_dblist;
+
+		ext2fs_badblocks_list_free(src->badblocks);
+		src->badblocks = NULL;
+	}
 	return 0;
+
+out_dblist:
+	ext2fs_free_dblist(dest->dblist);
+	dest->dblist = NULL;
+	return retval;
 }
 
-static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
 	errcode_t	retval = 0;
 
@@ -2178,6 +2191,32 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
 	PASS1_COPY_FS_BITMAP(dest, src, block_map);
 
+	if (src->dblist) {
+		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
+		if (retval)
+			return retval;
+		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+		dest->dblist->fs = dest;
+	}
+
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (retval)
+			goto out_dblist;
+	}
+	return 0;
+out_dblist:
+	ext2fs_free_dblist(dest->dblist);
+	dest->dblist = NULL;
+	return retval;
+}
+
+static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+{
+	errcode_t	retval;
+
+	retval = _e2fsck_pass1_merge_fs(dest, src);
+
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
@@ -2185,16 +2224,16 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	}
 	dest->icache = NULL;
 
-	if (dest->dblist) {
-		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
-		if (retval == 0) {
-			/* The ext2fs_copy_dblist() uses the src->fs as the fs */
-			dest->dblist->fs = dest;
-		}
-
+	if (src->dblist) {
 		ext2fs_free_dblist(src->dblist);
 		src->dblist = NULL;
 	}
+
+	if (src->badblocks) {
+		ext2fs_badblocks_list_free(src->badblocks);
+		src->badblocks = NULL;
+	}
+
 	return retval;
 }
 
-- 
2.25.2

