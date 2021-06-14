Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C793A7152
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhFNVag (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 17:30:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhFNVag (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Jun 2021 17:30:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2E8A21976;
        Mon, 14 Jun 2021 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623706111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yPDTs8si2zBRBtH4NG+TBMCnu8ZHdeJcL1egyvuT8bw=;
        b=WK9D1NLkIstUlwcE9V1tTG2cQ49MFlvCcNB8tpgg5QEXIVd+LT/Pmt2oZrkkEQE2sVyM33
        eY+xNR8iGnxhFWb9qPQFj5Li2f560MOWKvse5P993kKUfsApInFjzdY9TTVVkqYNksHOiE
        V5sz7gvGfRgJGEKxQzA8EnlUcdXH568=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623706111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yPDTs8si2zBRBtH4NG+TBMCnu8ZHdeJcL1egyvuT8bw=;
        b=L0ApJGZtxlKthKahNoPaZ32fjfQH+IBNJDA3kYef1TrLypxuuPyWWPGCdPSKszbDJ7E96z
        nOBU0SQn6D+h8aBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B7E55A3B9C;
        Mon, 14 Jun 2021 21:28:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DAB31F2C5F; Mon, 14 Jun 2021 23:28:31 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] tune2fs: Update overhead when toggling journal feature
Date:   Mon, 14 Jun 2021 23:28:30 +0200
Message-Id: <20210614212830.20207-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When adding or removing journal from a filesystem, we also need to add /
remove journal blocks from overhead stored in the superblock.  Otherwise
total number of blocks in the filesystem as reported by statfs(2) need
not match reality and could lead to odd results like negative number of
used blocks reported by df(1).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/tune2fs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 4d4cf5a13384..2f6858abda32 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -396,6 +396,8 @@ static errcode_t remove_journal_inode(ext2_filsys fs)
 				_("while clearing journal inode"));
 			return retval;
 		}
+		fs->super->s_overhead_clusters -=
+			EXT2FS_NUM_B2C(fs, EXT2_I_SIZE(&inode) / fs->blocksize);
 		memset(&inode, 0, sizeof(inode));
 		ext2fs_mark_bb_dirty(fs);
 		fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
@@ -1663,8 +1665,12 @@ static int add_journal(ext2_filsys fs)
 			com_err(program_name, retval, "%s",
 				_("\n\twhile trying to create journal file"));
 			return retval;
-		} else
-			fputs(_("done\n"), stdout);
+		}
+		fs->super->s_overhead_clusters += EXT2FS_NUM_B2C(fs,
+			jparams.num_journal_blocks + jparams.num_fc_blocks);
+		ext2fs_mark_super_dirty(fs);
+		fputs(_("done\n"), stdout);
+
 		/*
 		 * If the filesystem wasn't mounted, we need to force
 		 * the block group descriptors out.
-- 
2.26.2

