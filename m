Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163C93F7E3D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhHYWMh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:12:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60668 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhHYWMe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:12:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8CE520144;
        Wed, 25 Aug 2021 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629929507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvYghihEE4j4aw3qCc09/UW5l2xkoOD7NgJcPbqJYQ0=;
        b=ee5ICvakN4ceAfYLTnVNtFAE0L4cgkxkrvybs8fP1G9PXOw+1leEl35BzeJcwuMB3xj826
        D41GJqEk70z2mfOafuW1b9nwozIinmNGROsFw9mBxo01092HUyacnPv7NMmL+M+V0f3ygk
        uv3mtVpB/ObA1fiCCYDRrLMIEejYd14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629929507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvYghihEE4j4aw3qCc09/UW5l2xkoOD7NgJcPbqJYQ0=;
        b=UTeX9yHtOBnddjVuA+LOkzDTZRRMaaQIMeCO0ygi/Fde2X6iyxEALknaQz2YvsZYJmPFOX
        zV23HrPuUXk+yzAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AA7B1A3B83;
        Wed, 25 Aug 2021 22:11:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EFB141F2BA7; Thu, 26 Aug 2021 00:11:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] dumpe2fs, debugfs, e2image: Add support for orphan file
Date:   Thu, 26 Aug 2021 00:11:34 +0200
Message-Id: <20210825221143.30705-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825220922.4157-1-jack@suse.cz>
References: <20210825220922.4157-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; h=from:subject; bh=RrAYYWZha3l1VxARMPZi1bsDHF9+/kurshkmWEiqFY8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhJsAWrCgo6SPcuq/3aTUw09LZOeFxd7rdMopZNYoJ G80xsnyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSbAFgAKCRCcnaoHP2RA2YxYB/ 9eyV1g5urveEATnRTNVSW3fvtPdWPYpziM5qLOFNhAdeRBzcTIKFPjSJPZFIsNYFhqDXL/e0DmkduN QH+qTJAEXieyaSYqP5REmcomQKA1GssC5BK3vM/tXrVr0eB8JNYx+xZcYP+jo9x/U5Y0TURU2bKkaB B54ynGN3raS6hOWWHocwIjC8JIRsJ8qAJm8hW+/acj2oO935Le9H8rMfw0vObpahO0wARswrv/o4wG I+TbVl1wPYvGrvj0VB5CjFmAdNjKEh4HiafR3bbLyqe287jZWmqVdf3lee9k9HXbU5orzxncZSpXdB GuwmS+Om+LPhfEWq4LPIzBibpm55Ee
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
index 0053b51563bd..2c1f3db33714 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -1370,7 +1370,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
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

