Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A33A984F
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFPK7z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE53C1FD7C;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pb/2tVFedocS+FH0D59jy+87lCOXbgCfd1rnKsgzts=;
        b=uokbQCqwa15nH9LModYQAayd8LaVk2t+EMH+ETog+L09iZMmJOsLMkhPsblK/lrlhwE898
        hlPvUdE9j9orNwcOtxJhGw1P9086xhfG/SBK/DpaK+kgvUlOwqihElZC/eN8WOYiYC5EDA
        fv4zskYrmyLcMcfOPvv6uJ8mg4pPjaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pb/2tVFedocS+FH0D59jy+87lCOXbgCfd1rnKsgzts=;
        b=zoHg8ux+0y4/l//CIsAu3+TueG6NkCLFBDz/P3ZAXD3LdI/+pyA5sI1BDpG5XHnjcpvAbs
        C9edMBxEUH68AFBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B8E40A3BAC;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79D751F2CC2; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] dumpe2fs, debugfs, e2image: Add support for orphan file
Date:   Wed, 16 Jun 2021 12:57:35 +0200
Message-Id: <20210616105735.5424-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Print inode number of orphan file in outputs, dump e2image file to
filesystem image.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 debugfs/set_fields.c | 1 +
 lib/e2p/ls.c         | 3 +++
 misc/e2image.c       | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/debugfs/set_fields.c b/debugfs/set_fields.c
index b00157940774..f916deab8cea 100644
--- a/debugfs/set_fields.c
+++ b/debugfs/set_fields.c
@@ -183,6 +183,7 @@ static struct field_set_info super_fields[] = {
 	{ "lpf_ino", &set_sb.s_lpf_ino, NULL, 4, parse_uint },
 	{ "checksum_seed", &set_sb.s_checksum_seed, NULL, 4, parse_uint },
 	{ "encoding", &set_sb.s_encoding, NULL, 2, parse_encoding },
+	{ "orphan_file_inum", &set_sb.s_orphan_file_inum, NULL, 4, parse_uint },
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
index 176bee0fd19f..1762bc44cac4 100644
--- a/lib/e2p/ls.c
+++ b/lib/e2p/ls.c
@@ -482,6 +482,9 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 	if (ext2fs_has_feature_casefold(sb))
 		fprintf(f, "Character encoding:       %s\n",
 			e2p_encoding2str(sb->s_encoding));
+	if (ext2fs_has_feature_orphan_file(sb))
+		fprintf(f, "Orphan file inode:        %u\n",
+			sb->s_orphan_file_inum);
 }
 
 void list_super (struct ext2_super_block * s)
diff --git a/misc/e2image.c b/misc/e2image.c
index ac00827e4628..a9c64506d7cc 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -1369,7 +1369,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 		    ino == fs->super->s_journal_inum ||
 		    ino == quota_type2inum(USRQUOTA, fs->super) ||
 		    ino == quota_type2inum(GRPQUOTA, fs->super) ||
-		    ino == quota_type2inum(PRJQUOTA, fs->super)) {
+		    ino == quota_type2inum(PRJQUOTA, fs->super) ||
+		    ino == fs->super->s_orphan_file_inum) {
 			retval = ext2fs_block_iterate3(fs, ino,
 					BLOCK_FLAG_READ_ONLY, block_buf,
 					process_dir_block, &pb);
-- 
2.26.2

