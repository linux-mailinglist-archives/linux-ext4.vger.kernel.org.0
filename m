Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAEA3C5F8F
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhGLPqS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52508 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhGLPqM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C41952217B;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pb/2tVFedocS+FH0D59jy+87lCOXbgCfd1rnKsgzts=;
        b=TMxqhXyKSPbagfmJgYkUpwptHnPzR/u5PLOT/oUxGZYqf37DOvNv7WhIuxQulf0kh6fWRf
        8noPpFuW9rwAjQ2/8nEcSvDpQIgzfY6z35z+0V5oLNXWIQc7+dcmTaX2CXr/N0JPbvxy7A
        oNcr+EmKPIh5+SLLlsQm0dkeyhHWfZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pb/2tVFedocS+FH0D59jy+87lCOXbgCfd1rnKsgzts=;
        b=gNVkfX6oTpzv6tzseWwco1pVpet3u0fFcz4ZeE2rrg3Zq9JZGEKNlH4GaBxoJ3NQPBYi1q
        zMrPgG9aZ9NJR8CQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B9BF6A3BA9;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A75F61F2CDA; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] dumpe2fs, debugfs, e2image: Add support for orphan file
Date:   Mon, 12 Jul 2021 17:43:15 +0200
Message-Id: <20210712154315.9606-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; h=from:subject; bh=RzuIGldTN8nLq9cBr1Yqtza/iJXdDm2r9DOlDNcAbvw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMSrjQBiO0CpeSH9iy+i5EDrNt3QcmPzdjFpyZ/ OIp1cRGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjEgAKCRCcnaoHP2RA2frgCA C4DtCoJzEIgq5yAq/4DPIvZ5CGBhzaEsy0dPUa5xjSDDTbNBWc/RGQHFMb0kQ4zTW6v62EiqdJLP4s Bs+anlTRc0Awl6k2fX1rzgfcmFstt3UKZ8CuAq/AJFvLK1+H7GB6arNwu16oFQXT3hHI2rgCHDXqcH pOstuMDjZT3lBr+0RG09RqXlo/NQ2vYxeVxvExZE+c/w+U+47cQ8nT/VkRAb2R/XlXEyp/8OQWnLj1 ZwyIeV8hJSuy+XrpF2QZvLoA0QhxJYzu3owIP0bFs4xPGWWkM6sW8tEyOVHAEm97ISPL6WAYucfOpq UhvMfNdocN0JJNumciZQOCklAxh8hx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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

