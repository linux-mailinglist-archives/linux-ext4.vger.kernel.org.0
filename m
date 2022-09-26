Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C71F5EA8CB
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiIZOn6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiIZOnf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 10:43:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A309785AB
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 06:06:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5E961F385;
        Mon, 26 Sep 2022 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664197574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sDa980gmFs/Sf8xH4iBz70exbRowIvlH5is0xLFORak=;
        b=LpFuVsVv9Nyt2KjpfZAbO8Id7+QbXREq1m4izwENQxRh204byEKFYm4JOXcV17GA3ln7ZX
        pk/jICh9bVB2qYwKQ3QiNT040V6CG1PLQJ1/Ye8AgDDJI/4YAN/uGVinGlCSwnrOIRKjAR
        GEnSqBqa0orH98PBnIxS/ULlvRewNCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664197574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sDa980gmFs/Sf8xH4iBz70exbRowIvlH5is0xLFORak=;
        b=zn3EcrSjlzTpvMVlKJT1OWi5OwDck58bBanH7INHwG1w4Pwhng7IoKxtpLizKdbqQm9KgR
        MUeIHc9A36T/5OBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F9C413486;
        Mon, 26 Sep 2022 13:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SprzI8ajMWN/YgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 26 Sep 2022 13:06:14 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 17a5b84e;
        Mon, 26 Sep 2022 13:07:09 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH] debugfs: add commands to dump and change extent header fields
Date:   Mon, 26 Sep 2022 14:07:08 +0100
Message-Id: <20220926130708.15476-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This commit adds two new commands to debugfs:

* dump_extent_header - dump an extent header
* set_extent_header_field - modifying an extent header field

These commands take a block number as an argument, and will take the extent
header from the beginning of this block.  Basic validation of the header
data is done, but it is possible to override this validation when modifying
the header.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 debugfs/debug_cmds.ct |  6 +++
 debugfs/debugfs.8.in  | 24 +++++++++++
 debugfs/debugfs.c     | 50 +++++++++++++++++++++++
 debugfs/debugfs.h     |  2 +
 debugfs/set_fields.c  | 94 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+)

diff --git a/debugfs/debug_cmds.ct b/debugfs/debug_cmds.ct
index 1ff6c9dcd6b5..4ed613627258 100644
--- a/debugfs/debug_cmds.ct
+++ b/debugfs/debug_cmds.ct
@@ -49,6 +49,12 @@ request do_stat, "Show inode information ",
 request do_dump_extents, "Dump extents information ",
 	dump_extents, extents, ex;
 
+request do_dump_extent_header, "Dump extent header information",
+	dump_extent_header, deh;
+
+request do_set_extent_header_field, "Sets an extent header field",
+	set_extent_header_field, seh;
+
 request do_blocks, "Dump blocks used by an inode ",
 	blocks;
 
diff --git a/debugfs/debugfs.8.in b/debugfs/debugfs.8.in
index a3227a80ab24..f50fd6d9e987 100644
--- a/debugfs/debugfs.8.in
+++ b/debugfs/debugfs.8.in
@@ -298,6 +298,13 @@ not stored in file system data structures.   Hence, the values displayed
 may not necessarily by accurate and does not indicate a problem or
 corruption in the file system.)
 .TP
+.BI dump_extent_header " block"
+Dump the contents of the extent header at the beginning of block
+.IR block .
+A warning will be emitted if the block doesn't start with a valid extent
+header (for example, if the extent header doesn't start with the '0xf30a'
+magic value).
+.TP
 .B dump_unused
 Dump unused blocks which contain non-null bytes.
 .TP
@@ -739,6 +746,23 @@ can be displayed by using the command:
 Also available as
 .BR ssv .
 .TP
+.BI set_extent_header_field " -l | block field value"
+Change the value of
+.IR field
+to
+.IR value
+in the extent header at the beginning of
+.IR block.
+If
+.IR block
+doesn't start with a valid extent header, a warning will be emitted and field
+isn't changed.  To force the change, the
+.IR -f
+flag can be used.
+The fields that may be changed with this command can be listed by using the
+.IR -l
+flag.
+.TP
 .B show_debugfs_params
 Display
 .B debugfs
diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 78b93eda7b61..f9fb0dc9b347 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -1079,6 +1079,56 @@ void do_dump_extents(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 	return;
 }
 
+void do_dump_extent_header(int argc, char **argv,
+			   int sci_idx EXT2FS_ATTR((unused)),
+			   void *infop EXT2FS_ATTR((unused)))
+{
+	struct ext3_extent_header *eh;
+	errcode_t	errcode;
+	blk64_t		block;
+	unsigned char	*buf;
+	int		err;
+
+	if (check_fs_open(argv[0]))
+		return;
+
+	if (common_args_process(argc, argv, 2, 2, argv[0], "<block>",
+				CHECK_FS_BITMAPS)) {
+		return;
+	}
+	err = strtoblk(argv[0], argv[1], "physical block", &block);
+	if (err)
+		return;
+
+	buf = malloc(current_fs->blocksize);
+	if (!buf) {
+		com_err(argv[0], 0, "Couldn't allocate block buffer");
+		return;
+	}
+
+	errcode = io_channel_read_blk64(current_fs->io, block, 1, buf);
+	if (errcode) {
+		com_err(argv[0], errcode, "while reading block %llu\n",
+			(unsigned long long) block);
+		goto errout;
+	}
+
+	eh = (struct ext3_extent_header *)buf;
+	if (ext2fs_extent_header_verify(eh, current_fs->blocksize))
+		fprintf(stdout, "Warning: block %llu doesn't seem to contain a "
+			"valid extent header\n", block);
+	fprintf(stdout,
+		"header: magic=%x entries=%u max=%u depth=%u generation=%u\n",
+		ext2fs_le16_to_cpu(eh->eh_magic),
+		ext2fs_le16_to_cpu(eh->eh_entries),
+		ext2fs_le16_to_cpu(eh->eh_max),
+		ext2fs_le16_to_cpu(eh->eh_depth),
+		ext2fs_le32_to_cpu(eh->eh_generation));
+
+errout:
+	free(buf);
+}
+
 static int print_blocks_proc(ext2_filsys fs EXT2FS_ATTR((unused)),
 			     blk64_t *blocknr,
 			     e2_blkcnt_t blockcnt EXT2FS_ATTR((unused)),
diff --git a/debugfs/debugfs.h b/debugfs/debugfs.h
index 39bc0247f527..f1797c660f55 100644
--- a/debugfs/debugfs.h
+++ b/debugfs/debugfs.h
@@ -144,6 +144,8 @@ extern void do_find_free_block(int argc, char **argv, int sci_idx, void *infop);
 extern void do_find_free_inode(int argc, char **argv, int sci_idx, void *infop);
 extern void do_stat(int argc, char **argv, int sci_idx, void *infop);
 extern void do_dump_extents(int argc, char **argv, int sci_idx, void *infop);
+extern void do_dump_extent_header(int argc, char **argv, int sci_idx, void *infop);
+extern void do_set_extent_header_field(int argc, char **argv, int sci_idx, void *infop);
 extern void do_blocks(int argc, char *argv[], int sci_idx, void *infop);
 
 extern void do_chroot(int argc, char **argv, int sci_idx, void *infop);
diff --git a/debugfs/set_fields.c b/debugfs/set_fields.c
index f916deab8cea..3f74331ae85c 100644
--- a/debugfs/set_fields.c
+++ b/debugfs/set_fields.c
@@ -47,6 +47,7 @@ static struct ext2_inode_large set_inode;
 static struct ext2_group_desc set_gd;
 static struct ext4_group_desc set_gd4;
 static struct mmp_struct set_mmp;
+static struct ext3_extent_header set_eh;
 static dgrp_t set_bg;
 static ext2_ino_t set_ino;
 static int array_idx;
@@ -297,6 +298,16 @@ static struct field_set_info mmp_fields[] = {
 	{ "checksum", &set_mmp.mmp_checksum, NULL, 4, parse_uint },
 	{ 0, 0, 0, 0 }
 };
+
+static struct field_set_info extent_header_fields[] = {
+	{"magic", &set_eh.eh_magic, NULL, 2, parse_uint },
+	{"entries", &set_eh.eh_entries, NULL, 2, parse_uint },
+	{"max", &set_eh.eh_max, NULL, 2, parse_uint },
+	{"depth", &set_eh.eh_depth, NULL, 2, parse_uint },
+	{"generation", &set_eh.eh_generation, NULL, 4, parse_uint },
+	{0, 0, 0, 0 }
+};
+
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic pop
 #endif
@@ -1022,3 +1033,86 @@ void do_set_mmp_value(int argc EXT2FS_ATTR((unused)),
 }
 #endif
 
+void do_set_extent_header_field(int argc, char **argv,
+				int sci_idx EXT2FS_ATTR((unused)),
+				void *infop EXT2FS_ATTR((unused)))
+{
+	struct ext3_extent_header *eh;
+	struct field_set_info	*ss;
+	const char		*usage = "-l | <block> <field> <value>";
+	errcode_t		errcode;
+	blk64_t			block;
+	unsigned char		*buf;
+	int			c, err, force = 0;
+
+	if (check_fs_open(argv[0]) || check_fs_read_write(argv[0]) ||
+	    check_fs_bitmaps(argv[0]))
+		return;
+
+	reset_getopt();
+	while ((c = getopt(argc, argv, "lf")) != EOF) {
+		switch (c) {
+		case 'l':
+			print_possible_fields(extent_header_fields);
+			return;
+			break;
+		case 'f':
+			force = 1;
+			break;
+		default:
+			com_err(argv[0], 0, usage);
+			return;
+		}
+	}
+	if (argc != optind + 3) {
+		com_err(argv[0], 0, usage);
+		return;
+	}
+
+	err = strtoblk(argv[0], argv[optind++], "physical block", &block);
+	if (err)
+		return;
+
+	ss = find_field(extent_header_fields, argv[optind]);
+	if (ss == 0) {
+		com_err(argv[0], 0, "invalid field specifier: %s",
+			argv[optind]);
+		return;
+	}
+
+	buf = malloc(current_fs->blocksize);
+	if (!buf) {
+		com_err(argv[0], 0, "Couldn't allocate block buffer");
+		return;
+	}
+
+	errcode = io_channel_read_blk64(current_fs->io, block, 1, buf);
+	if (errcode) {
+		com_err(argv[0], errcode, "while reading block %llu\n",
+			(unsigned long long) block);
+		goto errout;
+	}
+
+	eh = (struct ext3_extent_header *)buf;
+	if (ext2fs_extent_header_verify(eh, current_fs->blocksize)) {
+		fprintf(stdout, "Warning: block %llu doesn't seem to contain a "
+			"valid extent header.  ", block);
+		if (!force) {
+			fprintf(stdout, "Use '-f' to force\n");
+			goto errout;
+		} else
+			fprintf(stdout, "Forcing write.\n");
+	}
+	memcpy(&set_eh, eh, sizeof(set_eh));
+	if (ss->func(ss, argv[optind], argv[optind + 1]) == 0) {
+		memcpy(eh, &set_eh, sizeof(set_eh));
+		errcode = io_channel_write_blk(current_fs->io, block, 1, buf);
+		if (errcode) {
+			com_err(argv[0], errcode, "while writing block %llu\n",
+				(unsigned long long) block);
+		}
+	}
+
+errout:
+	free(buf);
+}
