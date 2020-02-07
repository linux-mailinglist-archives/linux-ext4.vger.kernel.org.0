Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9368F154FFA
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGBR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:59 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:60370 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgBGBR6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:58 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9ViUgmY; Thu, 06 Feb 2020 18:09:50 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ySfo2T4IAAAA:8 a=eHDQnFYlT9L0-YAYYPsA:9
 a=8ty6zNTV4aV-TJ-z:21 a=QgK72iNzw4mAnYXO:21 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH 6/9] debugfs: print inode numbers as unsigned
Date:   Thu,  6 Feb 2020 18:09:43 -0700
Message-Id: <1581037786-62789-6-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfCHFKYyVwTbMSdzILXV/ZzhITSbAJ1orY4M4amqh9Q6vQun2CxmuFZyZXL97gNl2y2ZZiJKkbNJ0ZfSuXxHFdVuxkHQCHGLfB86PTPP1JDBUexb7fH6+
 /OdoHj9ml1MEWa/aRhwYtJkkHTUOGqg1f2HD8sUN3BEXBqDauIpCNqN8dLNAioBp01URn+9SyMlgtp7lAhBQ7bhuX5jxt7w3S3brQovrKaDqV2Riw3YWMwta
 cXPILDXEqGXBAodnSeiHVw==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Print inode numbers as unsigned values, to avoid printing negative
numbers for inodes above 2B.

Flags should be printed as hex instead of signed decimal values.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 debugfs/debugfs.c      | 18 +++++++++---------
 debugfs/do_journal.c   |  4 ++--
 debugfs/extent_inode.c |  4 ++--
 debugfs/htree.c        |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 60931a9..08fb9a3 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -467,7 +467,7 @@ void do_show_super_stats(int argc, char *argv[],
 	}
 	for (i=0; i < current_fs->group_desc_count; i++)
 		numdirs += ext2fs_bg_used_dirs_count(current_fs, i);
-	fprintf(out, "Directories:              %d\n", numdirs);
+	fprintf(out, "Directories:              %u\n", numdirs);
 
 	if (header_only) {
 		close_pager(out);
@@ -718,7 +718,7 @@ static void dump_extents(FILE *f, const char *prefix, ext2_ino_t ino,
 				continue;
 			}
 
-			fprintf(f, "%s(ETB%d):%lld",
+			fprintf(f, "%s(ETB%d):%llu",
 				printed ? ", " : "", info.curr_level,
 				extent.e_pblk);
 			printed = 1;
@@ -851,10 +851,10 @@ void internal_dump_inode(FILE *out, const char *prefix,
 	if (LINUX_S_ISREG(inode->i_mode) || LINUX_S_ISDIR(inode->i_mode))
 		fprintf(out, "%llu\n", EXT2_I_SIZE(inode));
 	else
-		fprintf(out, "%d\n", inode->i_size);
+		fprintf(out, "%u\n", inode->i_size);
 	if (os == EXT2_OS_HURD)
 		fprintf(out,
-			"%sFile ACL: %d Translator: %d\n",
+			"%sFile ACL: %u Translator: %u\n",
 			prefix,
 			inode->i_file_acl,
 			inode->osd1.hurd1.h_i_translator);
@@ -864,13 +864,13 @@ void internal_dump_inode(FILE *out, const char *prefix,
 			inode->i_file_acl | ((long long)
 				(inode->osd2.linux2.l_i_file_acl_high) << 32));
 	if (os != EXT2_OS_HURD)
-		fprintf(out, "%sLinks: %d   Blockcount: %llu\n",
+		fprintf(out, "%sLinks: %u   Blockcount: %llu\n",
 			prefix, inode->i_links_count,
 			(((unsigned long long)
 			  inode->osd2.linux2.l_i_blocks_hi << 32)) +
 			inode->i_blocks);
 	else
-		fprintf(out, "%sLinks: %d   Blockcount: %u\n",
+		fprintf(out, "%sLinks: %u   Blockcount: %u\n",
 			prefix, inode->i_links_count, inode->i_blocks);
 	switch (os) {
 	    case EXT2_OS_HURD:
@@ -880,7 +880,7 @@ void internal_dump_inode(FILE *out, const char *prefix,
 	    default:
 		frag = fsize = 0;
 	}
-	fprintf(out, "%sFragment:  Address: %d    Number: %d    Size: %d\n",
+	fprintf(out, "%sFragment:  Address: %u    Number: %u    Size: %u\n",
 		prefix, inode->i_faddr, frag, fsize);
 	if (is_large_inode && large_inode->i_extra_isize >= 24) {
 		fprintf(out, "%s ctime: 0x%08x:%08x -- %s", prefix,
@@ -1397,7 +1397,7 @@ void do_modify_inode(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 		modify_u8(argv[0], "Fragment size", decimal_format, fsize);
 
 	for (i=0;  i < EXT2_NDIR_BLOCKS; i++) {
-		sprintf(buf, "Direct Block #%d", i);
+		sprintf(buf, "Direct Block #%u", i);
 		modify_u32(argv[0], buf, decimal_format, &inode.i_block[i]);
 	}
 	modify_u32(argv[0], "Indirect Block", decimal_format,
@@ -2133,7 +2133,7 @@ void do_imap(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 		block;
 	offset &= (EXT2_BLOCK_SIZE(current_fs->super) - 1);
 
-	printf("Inode %d is part of block group %lu\n"
+	printf("Inode %u is part of block group %lu\n"
 	       "\tlocated at block %lu, offset 0x%04lx\n", ino, group,
 	       block_nr, offset);
 
diff --git a/debugfs/do_journal.c b/debugfs/do_journal.c
index eeb363e..15ef682 100644
--- a/debugfs/do_journal.c
+++ b/debugfs/do_journal.c
@@ -59,7 +59,7 @@ static journal_t *current_journal = NULL;
 static void journal_dump_trans(journal_transaction_t *trans EXT2FS_ATTR((unused)),
 			       const char *tag EXT2FS_ATTR((unused)))
 {
-	dbg_printf("TRANS %p(%s): tid=%d start=%llu block=%llu end=%llu "
+	dbg_printf("TRANS %p(%s): tid=%u start=%llu block=%llu end=%llu "
 		   "flags=0x%x\n", trans, tag, trans->tid, trans->start,
 		   trans->block, trans->end, trans->flags);
 }
@@ -912,7 +912,7 @@ void do_journal_open(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	}
 	journal = current_journal;
 
-	dbg_printf("JOURNAL: seq=%d tailseq=%d start=%lu first=%lu "
+	dbg_printf("JOURNAL: seq=%u tailseq=%u start=%lu first=%lu "
 		   "maxlen=%lu\n", journal->j_tail_sequence,
 		   journal->j_transaction_sequence, journal->j_tail,
 		   journal->j_first, journal->j_last);
diff --git a/debugfs/extent_inode.c b/debugfs/extent_inode.c
index ada1308..6706629 100644
--- a/debugfs/extent_inode.c
+++ b/debugfs/extent_inode.c
@@ -77,7 +77,7 @@ void do_extent_open(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 
 	if (argc == 1) {
 		if (current_ino)
-			printf("Current inode is %d\n", current_ino);
+			printf("Current inode is %u\n", current_ino);
 		else
 			printf("No current inode\n");
 		return;
@@ -107,7 +107,7 @@ void do_extent_open(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	cp = strchr(extent_prompt, ':');
 	if (cp)
 		*cp = 0;
-	sprintf(extent_prompt + strlen(extent_prompt), " (extent ino %d): ",
+	sprintf(extent_prompt + strlen(extent_prompt), " (extent ino %u): ",
 		current_ino);
 	ss_add_request_table(sci_idx, &extent_cmds, 1, &ret);
 	ss_set_prompt(sci_idx, extent_prompt);
diff --git a/debugfs/htree.c b/debugfs/htree.c
index 3aae3c2..7fae7f1 100644
--- a/debugfs/htree.c
+++ b/debugfs/htree.c
@@ -288,7 +288,7 @@ void do_htree_dump(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	fprintf(pager, "\t Hash Version: %d\n", rootnode->hash_version);
 	fprintf(pager, "\t Info length: %d\n", rootnode->info_length);
 	fprintf(pager, "\t Indirect levels: %d\n", rootnode->indirect_levels);
-	fprintf(pager, "\t Flags: %d\n", rootnode->unused_flags);
+	fprintf(pager, "\t Flags: %#x\n", rootnode->unused_flags);
 
 	ent = (struct ext2_dx_entry *)
 		((char *)rootnode + rootnode->info_length);
-- 
1.8.0

