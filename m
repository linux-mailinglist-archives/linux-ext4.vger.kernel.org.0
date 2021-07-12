Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A073C5F88
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhGLPqM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52444 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhGLPqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9FD822135;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO8dUp84n6yNDrm8gJ+4XYzi8C4FmWVx7RQ+DqaFXY0=;
        b=iuKEd1rihmYwrFObTJSZxkHW2hAQ2XtCnk6vJcQ7UUi7SAJ0AubE7+H4/BX6zFuxxRqib2
        GYdbmAn/h5S0dvaiQjFVZ+b1iaQ8/vVXKIMDOGBGehFCrqxSAkY7gKOfGc/kxDx0A6fNRl
        tw4m6TEfSom7w3JeL9fIhVYSCn5LTMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO8dUp84n6yNDrm8gJ+4XYzi8C4FmWVx7RQ+DqaFXY0=;
        b=P0VxrQlIt9YyoXXb4INbZroV5Oose+4kSN2Du5YhdbQAjMAnMqd6VHcK/Irynl1Aee51l6
        r+uj8awnTkobB6BQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A0E65A3B9A;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9125C1F2CCB; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] e2image: Dump quota files
Date:   Mon, 12 Jul 2021 17:43:09 +0200
Message-Id: <20210712154315.9606-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; h=from:subject; bh=4+N8q8EZ7wZfMadqUfKCLgk5uPC+4jou/8lfjXnWyVI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMNw0gDvVSgB0i331rOTNaXIZy7SU55eYo1jj8k Wn1KFA2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjDQAKCRCcnaoHP2RA2YoIB/ 9HZuFQn4je8bCEnhAh1pULae1OztpfaRe8/pxo/Bfu1zc6MN3G6Qe/86KkxidyXrGPr3jfIkUSJxnD BHfIwhxGLI1co5Wl8s0aXVKtLm5KsxRKm5xg+i42dcwUHARE3/57vG3Hn8OaRaKzY8jFlnS4pLHWwn VI6fkDQcmEL/5wpcOzh9sbyFblWKetBtcMm+GlKeIHlCQ6Vhx/eZM3tzX/Msi3EmjNkavJEHFIKd23 RROez0qW1AdKF8G+JTgT8HLLTycGjypgj58VuUOYT9wV80kAcBPbIvzs4L4dWmFZt3KpUzlvWHDk/L iq8VyC/tVLxNtiTKvcCGXtzNLVhhzb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dump quota files to resulting filesystem image. They are fs metadata.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/e2image.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/misc/e2image.c b/misc/e2image.c
index 90a34bebc36d..ac00827e4628 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -52,6 +52,7 @@ extern int optind;
 
 #include "support/nls-enable.h"
 #include "support/plausible.h"
+#include "support/quotaio.h"
 #include "../version.h"
 
 #define QCOW_OFLAG_COPIED     (1ULL << 63)
@@ -1364,9 +1365,11 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 		pb.ino = ino;
 		pb.is_dir = LINUX_S_ISDIR(inode.i_mode);
 		if (LINUX_S_ISDIR(inode.i_mode) ||
-		    (LINUX_S_ISLNK(inode.i_mode) &&
-		     ext2fs_inode_has_valid_blocks2(fs, &inode)) ||
-		    ino == fs->super->s_journal_inum) {
+		    LINUX_S_ISLNK(inode.i_mode) ||
+		    ino == fs->super->s_journal_inum ||
+		    ino == quota_type2inum(USRQUOTA, fs->super) ||
+		    ino == quota_type2inum(GRPQUOTA, fs->super) ||
+		    ino == quota_type2inum(PRJQUOTA, fs->super)) {
 			retval = ext2fs_block_iterate3(fs, ino,
 					BLOCK_FLAG_READ_ONLY, block_buf,
 					process_dir_block, &pb);
-- 
2.26.2

