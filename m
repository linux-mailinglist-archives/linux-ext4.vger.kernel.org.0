Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DD3A984B
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFPK7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A87A7219E4;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO8dUp84n6yNDrm8gJ+4XYzi8C4FmWVx7RQ+DqaFXY0=;
        b=ZlLzdityhxvSQbMHzPtv8x+YRFKP6QJwQ5SZiH8KU3ABc0Sdywjs0gInJSUOlfo+J1bl40
        MjrT8DMfcvrH8PKKaOLZMQHlT3VPWwHwunaUeAK+kmVpZtZmCnaC0tBaWFaE6x755AeTSh
        Rib8r8r5oXcsvR0bPMwAzsut0lex5ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO8dUp84n6yNDrm8gJ+4XYzi8C4FmWVx7RQ+DqaFXY0=;
        b=HHe81ALtElFoC4Nwl3DYuZ+zkGhAkK9RN+nJMuHGIMazN22WY9jMsu5zosi7u+tpm/fjL3
        IZ/1M2JbIgHn0LCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8A4D1A3BA9;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62D4D1F2CBB; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] e2image: Dump quota files
Date:   Wed, 16 Jun 2021 12:57:29 +0200
Message-Id: <20210616105735.5424-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
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

