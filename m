Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8936481C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Apr 2021 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhDSQVi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Apr 2021 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhDSQVf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Apr 2021 12:21:35 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EECC06174A
        for <linux-ext4@vger.kernel.org>; Mon, 19 Apr 2021 09:21:03 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k19so4804608vsg.0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Apr 2021 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJMUPOEhiWAIZhOq5DVec1lFleZqhDWGuiQc3/a5csA=;
        b=M6pBbMltJlvRnopGnc952guSk9FkEhIzT/yQDw7ZrOMWxb6vkSIVai/76c2bjV0WBY
         ZX8tVFZgVGonwlxGXvseIY2VfdVfZjhA7IRyPXV5gOpA0xaq5S7vXhZCbp7oc6PNOV/i
         WtG4wAtD7p/hswPBKi+K1L4vs79fOSvTs7k/HC64hndrw7XEVB1031wuAk1UupZx7y+g
         2ZTTN4NSUybwk++rsHVtiOfHMSmKfZDbJrShSypviKkgV74WY4zihpp1Vq1W5Ej7YoCJ
         PXWCqDl8rlCmqQ89tRn9O59ZAQlEJ1FPJwR8VfGNd+Ai1q2exNsuqD71z9bX3dfgdwEc
         75Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJMUPOEhiWAIZhOq5DVec1lFleZqhDWGuiQc3/a5csA=;
        b=L/8CA5A3F3/XPbaOqXbeeUnEGVd3tCQSZytiH4Y/UotZiErqoSNKyfy8yd7c2TnGDP
         47lP9Ya7c8c05AzOKN4Wol373DDMakGBOFQvqo6fRQ0Vi6dMXmEQwJPKgpjCF7LMw0Tn
         k5NHwIo0qefioo8jsLXGMjayUsK4i8glKIbeNblaiG10/qqqQwYLqV5qnQVTy8p4lG+u
         aCBINmk3knEG7xSV59ezAQ4y/U5ZE11JD/mbQDEuTGbFoaiy6PZO6vdWTbX+MD4ujGBt
         HyQ6Ap4F39TjTI/h8MpyHXhRDQT1n/HfBotbx2ofwbmWu6CcZ19HC0KLsURUC1P+0F7i
         hjUA==
X-Gm-Message-State: AOAM530HKZXpX5S6ItCqEuzbZT+iPgTIw0EIYdC22nRRUag27uM2RD5S
        YEK8ImDlghkNTx8o+wZjyqAHgzQ5nepPWg==
X-Google-Smtp-Source: ABdhPJwBquX/NRlf9oi0cpaDHFdyk9kW+HXSSawUVeuLXsVkmgDco4kHL3M9/bXEU3pskWNxQAzVpg==
X-Received: by 2002:a67:e00b:: with SMTP id c11mr10262613vsl.33.1618849262538;
        Mon, 19 Apr 2021 09:21:02 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (127.10.73.34.bc.googleusercontent.com. [34.73.10.127])
        by smtp.googlemail.com with ESMTPSA id z22sm2983365uav.5.2021.04.19.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:21:02 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3] ext4: wipe filename upon file deletion
Date:   Mon, 19 Apr 2021 16:21:00 +0000
Message-Id: <20210419162100.1284475-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Upon file deletion, zero out all fields in ext4_dir_entry2 besides inode
and rec_len. In case sensitive data is stored in filenames, this ensures
no potentially sensitive data is left in the directory entry upon deletion.
Also, wipe these fields upon moving a directory entry during the conversion
to an htree and when splitting htree nodes.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/namei.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..df7809a4821f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1778,6 +1778,11 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
 		de->inode = 0;
+
+		/* wipe name_len through and name field */
+		memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
+						blocksize) - 6);
+
 		map++;
 		to += rec_len;
 	}
@@ -2102,6 +2107,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	data2 = bh2->b_data;
 
 	memcpy(data2, de, len);
+	memset(de, 0, len); /* wipe old data */
 	de = (struct ext4_dir_entry_2 *) data2;
 	top = data2 + len;
 	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top)
@@ -2492,6 +2498,11 @@ int ext4_generic_delete_entry(struct inode *dir,
 			else
 				de->inode = 0;
 			inode_inc_iversion(dir);
+
+			/* wipe name_len through name field */
+			memset(&de->name_len, 0,
+				ext4_rec_len_from_disk(de->rec_len, blocksize) - 6);
+
 			return 0;
 		}
 		i += ext4_rec_len_from_disk(de->rec_len, blocksize);
-- 
2.31.1.368.gbe11c130af-goog

