Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF336865E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Apr 2021 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhDVSJR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Apr 2021 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVSJQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Apr 2021 14:09:16 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98CC06174A
        for <linux-ext4@vger.kernel.org>; Thu, 22 Apr 2021 11:08:39 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k124so23398092vsk.3
        for <linux-ext4@vger.kernel.org>; Thu, 22 Apr 2021 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1dnTt32LdMxrAXY5qsRnDa0nCUc8bFswe4RDGxsswg=;
        b=rc8pZJtzphs8JSeeKUNPN7qiz9dK4Uz+4xaGPQPCzbLY//TQnuOq9jxPiD3YhoI0YE
         zWJcE0df8uuMMlPeK7ZwDF+hfHFCTDz2nks+DgQjjnIHOQ3rnNMdGHLtJvBsR8V8++Co
         pzP6c6xLVIEWlPTwpK7wuYQwe86X4306ZyZ6aSiLkDbaBWPZ0xxipMEKENJJ6mfl3Ghi
         ZBciU1fdsXRUH8U6Y0085SVa690zD5u8SPxVXskcq4RxTKewahCrH86F6Jy5RbskCySV
         q7Ym817Y1JO11sBrVsfg72kHSbIIS4ZWbDuRAIwy6aOATosSdJiSR9zE1d65bXZk5J2P
         AeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1dnTt32LdMxrAXY5qsRnDa0nCUc8bFswe4RDGxsswg=;
        b=kLV3VQslMXbD4gle51KPgEhJxNkos6XMwtOnbHqtEwAAGectbfFX1TTLAjP1n2tX8A
         jdHpEPLgzQ1tiVhzYoPG93DeCxs1bz76rWhIaf8tkng7v75qdo0teIq8WN/6FJuzV+ff
         pRGkdJKurfh89qR0qEAnjInyVBvZ53LBjm/YXsfceiHWyXKo506N+1VNu9oHx5AYZ/jH
         97mO5oYPEK2CIm5H/+WhDSvMOgDfCLaQSZhQcv/oeXfpVHU3rlhcsAE8Qsv0yi77D9Qg
         lFzxqaEN4zXp0a/ah7F+71nfGm78msRE19kCPg0Jh3jM3FLgP0PZQEXkOG2FWxfoxsqh
         tJMg==
X-Gm-Message-State: AOAM532orIAZmKMtoqL6bNZK5p/F4ETAcWO9VVK+1AaJddXKmymArnx3
        zbDGVLdYOXMSqLwkrr6g+pRvF5yW1aA=
X-Google-Smtp-Source: ABdhPJxM3LzqPTPCtGu4dFVSJuLOf5Oh9w0GgFlOUnRLH5B4Mej3oOmL34FviQhgku2lNq0L8zYYtQ==
X-Received: by 2002:a67:8752:: with SMTP id j79mr18417vsd.36.1619114918238;
        Thu, 22 Apr 2021 11:08:38 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (127.10.73.34.bc.googleusercontent.com. [34.73.10.127])
        by smtp.googlemail.com with ESMTPSA id m89sm411737uam.12.2021.04.22.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:08:37 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v4] ext4: wipe ext4_dir_entry2 upon file deletion
Date:   Thu, 22 Apr 2021 18:08:34 +0000
Message-Id: <20210422180834.2242353-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Upon file deletion, zero out all fields in ext4_dir_entry2 besides rec_len.
In case sensitive data is stored in filenames, this ensures no potentially
sensitive data is left in the directory entry upon deletion. Also, wipe
these fields upon moving a directory entry during the conversion to an
htree and when splitting htree nodes.

The data wiped may still exist in the journal, but there are future
commits planned to address this.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/namei.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..0cfb1278ce1b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1777,7 +1777,14 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
 		memcpy (to, de, rec_len);
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
+
+		/* wipe dir_entry excluding the rec_len field */
 		de->inode = 0;
+		memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
+								blocksize) -
+					 offsetof(struct ext4_dir_entry_2,
+								name_len));
+
 		map++;
 		to += rec_len;
 	}
@@ -2102,6 +2109,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	data2 = bh2->b_data;
 
 	memcpy(data2, de, len);
+	memset(de, 0, len); /* wipe old data */
 	de = (struct ext4_dir_entry_2 *) data2;
 	top = data2 + len;
 	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top)
@@ -2482,15 +2490,27 @@ int ext4_generic_delete_entry(struct inode *dir,
 					 entry_buf, buf_size, i))
 			return -EFSCORRUPTED;
 		if (de == de_del)  {
-			if (pde)
+			if (pde) {
 				pde->rec_len = ext4_rec_len_to_disk(
 					ext4_rec_len_from_disk(pde->rec_len,
 							       blocksize) +
 					ext4_rec_len_from_disk(de->rec_len,
 							       blocksize),
 					blocksize);
-			else
+
+				/* wipe entire dir_entry */
+				memset(de, 0, ext4_rec_len_from_disk(de->rec_len,
+								blocksize));
+			} else {
+				/* wipe dir_entry excluding the rec_len field */
 				de->inode = 0;
+				memset(&de->name_len, 0,
+					ext4_rec_len_from_disk(de->rec_len,
+								blocksize) -
+					offsetof(struct ext4_dir_entry_2,
+								name_len));
+			}
+
 			inode_inc_iversion(dir);
 			return 0;
 		}
-- 
2.31.1.498.g6c1eba8ee3d-goog

