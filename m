Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD713B4BB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 22:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANVua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 16:50:30 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:53926 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANVua (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 16:50:30 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id rTx4iCDaPnCigrTx6izHgi; Tue, 14 Jan 2020 14:42:20 -0700
X-Authority-Analysis: v=2.3 cv=cZisUULM c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=jybF8eiXJzyVKjy0I1oA:9
 a=xhbuIwKagRPct3yY:21 a=uM958QwxTQGTq7Qu:21 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 2/2] mmp: abstract out repeated 'sizeof(buf), buf' usage
Date:   Tue, 14 Jan 2020 14:42:18 -0700
Message-Id: <1579038138-49231-2-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1579038138-49231-1-git-send-email-adilger@dilger.ca>
References: <20191231220724.GA118765@mit.edu>
 <1579038138-49231-1-git-send-email-adilger@dilger.ca>
X-CMAE-Envelope: MS4wfJlQUXiD3KTIhK3nC4oZr+aCktlJH8lC2Tg+C+pc+WqAhge1/X/UXXRELwnc0Ps5iQqAcfppj6S8143CInQeitJb7YsFqUbec7DCZa60UODfaSfUI3tZ
 rx8tuyHbv6EcrToExELQm9OLAvx3ZeG+NfmykXQcngZchFjvbnisOFBtiBueZ/RFYrxc+/4+hVJss4D5Qo3ASU83lSTXHWrEbYM4TMPPNVTULpSptAFNU71y
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The printf("%.*s") format requires both the buffer size and buffer
pointer to be specified for each use.  Since this is repeatedly given
as "(int)sizeof(buf), (char *)buf" for mmp_nodename and mmp_bdevname
fields, with typecasts to avoid compiler warnings.

Add a helper macro EXT2_LEN_STR() to avoid repeated boilerplate code.

This can also be used for other superblock buffer fields that may not
have NUL-terminated strings (e.g. s_volume_name, s_last_mounted,
s_{first,last}_error_func, s_mount_opts) to simplify code and avoid
the need for temporary buffers for NUL-termination.

Annotate the superblock string fields that may not be NUL-terminated.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/debugfs.c       |  4 ++--
 e2fsck/unix.c           | 17 ++++++++---------
 e2fsck/util.c           |  6 ++----
 lib/blkid/probe.c       |  2 +-
 lib/e2p/ls.c            | 39 +++++++++++++++++----------------------
 lib/ext2fs/ext2_fs.h    | 11 ++++++-----
 lib/support/plausible.c | 12 ++++--------
 misc/dumpe2fs.c         | 10 ++++------
 misc/e2label.c          |  2 +-
 misc/findsuper.c        |  5 +++--
 misc/mke2fs.c           |  6 ++----
 misc/tune2fs.c          |  3 +--
 misc/util.c             |  6 ++----
 13 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 7cfc269..9e22c68 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -2447,9 +2447,9 @@ void do_dump_mmp(int argc EXT2FS_ATTR((unused)), char *argv[],
 	fprintf(stdout, "sequence: %08x\n", mmp_s->mmp_seq);
 	fprintf(stdout, "time: %lld -- %s", mmp_s->mmp_time, ctime(&t));
 	fprintf(stdout, "node_name: %.*s\n",
-		(int)sizeof(mmp_s->mmp_nodename), (char *)mmp_s->mmp_nodename);
+		EXT2_LEN_STR(mmp_s->mmp_nodename));
 	fprintf(stdout, "device_name: %.*s\n",
-		(int)sizeof(mmp_s->mmp_bdevname), (char *)mmp_s->mmp_bdevname);
+		EXT2_LEN_STR(mmp_s->mmp_bdevname));
 	fprintf(stdout, "magic: 0x%x\n", mmp_s->mmp_magic);
 	fprintf(stdout, "checksum: 0x%08x\n", mmp_s->mmp_checksum);
 }
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index b3ef0f2..b144c38 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1697,11 +1697,10 @@ failure:
 	 * Set the device name, which is used whenever we print error
 	 * or informational messages to the user.
 	 */
-	if (ctx->device_name == 0 &&
-	    (sb->s_volume_name[0] != 0)) {
+	if (ctx->device_name == 0 && sb->s_volume_name[0])
 		ctx->device_name = string_copy(ctx, sb->s_volume_name,
 					       sizeof(sb->s_volume_name));
-	}
+
 	if (ctx->device_name == 0)
 		ctx->device_name = string_copy(ctx, ctx->filesystem_name, 0);
 	for (cp = ctx->device_name; *cp; cp++)
@@ -1709,19 +1708,19 @@ failure:
 			*cp = '_';
 
 	if (ctx->problem_logf) {
-		char buf[48];
 
 		fprintf(ctx->problem_logf, "<filesystem dev=\"%s\"",
 			ctx->filesystem_name);
 		if (!uuid_is_null(sb->s_uuid)) {
+			char buf[48];
+
 			uuid_unparse(sb->s_uuid, buf);
 			fprintf(ctx->problem_logf, " uuid=\"%s\"", buf);
 		}
-		if (sb->s_volume_name[0]) {
-			memset(buf, 0, sizeof(buf));
-			strncpy(buf, sb->s_volume_name, sizeof(buf));
-			fprintf(ctx->problem_logf, " label=\"%s\"", buf);
-		}
+		if (sb->s_volume_name[0])
+			fprintf(ctx->problem_logf, " label=\"%.*s\"",
+				EXT2_LEN_STR(sb->s_volume_name));
+
 		fputs("/>\n", ctx->problem_logf);
 	}
 
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 07885ab..314c989 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -778,11 +778,9 @@ void dump_mmp_msg(struct mmp_struct *mmp, const char *fmt, ...)
 		printf("    mmp_update_date: %s", ctime(&t));
 		printf("    mmp_update_time: %lld\n", mmp->mmp_time);
 		printf("    mmp_node_name: %.*s\n",
-		       (int)sizeof(mmp->mmp_nodename),
-		       (char *)mmp->mmp_nodename);
+		       EXT2_LEN_STR(mmp->mmp_nodename));
 		printf("    mmp_device_name: %.*s\n",
-		       (int)sizeof(mmp->mmp_bdevname),
-		       (char *)mmp->mmp_bdevname);
+		       EXT2_LEN_STR(mmp->mmp_bdevname));
 	}
 }
 
diff --git a/lib/blkid/probe.c b/lib/blkid/probe.c
index d720144..f8687cd 100644
--- a/lib/blkid/probe.c
+++ b/lib/blkid/probe.c
@@ -144,7 +144,7 @@ static void get_ext2_info(blkid_dev dev, struct blkid_magic *id,
 		   blkid_le32(es->s_feature_incompat),
 		   blkid_le32(es->s_feature_ro_compat)));
 
-	if (strlen(es->s_volume_name))
+	if (es->s_volume_name[0])
 		label = es->s_volume_name;
 	blkid_set_tag(dev, "LABEL", label, sizeof(es->s_volume_name));
 
diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
index 5a44617..1521099 100644
--- a/lib/e2p/ls.c
+++ b/lib/e2p/ls.c
@@ -224,7 +224,7 @@ static const char *quota_type2prefix(enum quota_type qtype)
 void list_super2(struct ext2_super_block * sb, FILE *f)
 {
 	int inode_blocks_per_group;
-	char buf[80], *str;
+	char *str;
 	time_t	tm;
 	enum quota_type qtype;
 
@@ -232,18 +232,16 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 				    EXT2_INODE_SIZE(sb)) +
 				   EXT2_BLOCK_SIZE(sb) - 1) /
 				  EXT2_BLOCK_SIZE(sb));
-	if (sb->s_volume_name[0]) {
-		memset(buf, 0, sizeof(buf));
-		strncpy(buf, sb->s_volume_name, sizeof(sb->s_volume_name));
-	} else
-		strcpy(buf, "<none>");
-	fprintf(f, "Filesystem volume name:   %s\n", buf);
-	if (sb->s_last_mounted[0]) {
-		memset(buf, 0, sizeof(buf));
-		strncpy(buf, sb->s_last_mounted, sizeof(sb->s_last_mounted));
-	} else
-		strcpy(buf, "<not available>");
-	fprintf(f, "Last mounted on:          %s\n", buf);
+	if (sb->s_volume_name[0])
+		fprintf(f, "Filesystem volume name:   %.*s\n",
+			EXT2_LEN_STR(sb->s_volume_name));
+	else
+		fprintf(f, "Filesystem volume name:   <none>\n");
+	if (sb->s_last_mounted[0])
+		fprintf(f, "Last mounted on:          %.*s\n",
+			EXT2_LEN_STR(sb->s_last_mounted));
+	else
+		fprintf(f, "Last mounted on:          <not available>\n");
 	fprintf(f, "Filesystem UUID:          %s\n", e2p_uuid2str(sb->s_uuid));
 	fprintf(f, "Filesystem magic number:  0x%04X\n", sb->s_magic);
 	fprintf(f, "Filesystem revision #:    %d", sb->s_rev_level);
@@ -259,7 +257,8 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 	print_super_flags(sb, f);
 	print_mntopts(sb, f);
 	if (sb->s_mount_opts[0])
-		fprintf(f, "Mount options:            %s\n", sb->s_mount_opts);
+		fprintf(f, "Mount options:            %.*s\n",
+			EXT2_LEN_STR(sb->s_mount_opts));
 	fprintf(f, "Filesystem state:        ");
 	print_fs_state (f, sb->s_state);
 	fprintf(f, "\n");
@@ -419,10 +418,8 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 	if (sb->s_first_error_time) {
 		tm = sb->s_first_error_time;
 		fprintf(f, "First error time:         %s", ctime(&tm));
-		memset(buf, 0, sizeof(buf));
-		strncpy(buf, (char *)sb->s_first_error_func,
-			sizeof(sb->s_first_error_func));
-		fprintf(f, "First error function:     %s\n", buf);
+		fprintf(f, "First error function:     %.*s\n",
+			EXT2_LEN_STR(sb->s_first_error_func));
 		fprintf(f, "First error line #:       %u\n",
 			sb->s_first_error_line);
 		fprintf(f, "First error inode #:      %u\n",
@@ -433,10 +430,8 @@ void list_super2(struct ext2_super_block * sb, FILE *f)
 	if (sb->s_last_error_time) {
 		tm = sb->s_last_error_time;
 		fprintf(f, "Last error time:          %s", ctime(&tm));
-		memset(buf, 0, sizeof(buf));
-		strncpy(buf, (char *)sb->s_last_error_func,
-			sizeof(sb->s_last_error_func));
-		fprintf(f, "Last error function:      %s\n", buf);
+		fprintf(f, "Last error function:      %.*s\n",
+			EXT2_LEN_STR(sb->s_last_error_func));
 		fprintf(f, "Last error line #:        %u\n",
 			sb->s_last_error_line);
 		fprintf(f, "Last error inode #:       %u\n",
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 79816b6..6fe5cab 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -682,8 +682,8 @@ struct ext2_super_block {
 /*060*/	__u32	s_feature_incompat;	/* incompatible feature set */
 	__u32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /*068*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*078*/	char	s_volume_name[EXT2_LABEL_LEN];	/* volume name */
-/*088*/	char	s_last_mounted[64];	/* directory where last mounted */
+/*078*/	__u8	s_volume_name[EXT2_LABEL_LEN];	/* volume name, no NUL? */
+/*088*/	__u8	s_last_mounted[64];	/* directory last mounted on, no NUL? */
 /*0c8*/	__u32	s_algorithm_usage_bitmap; /* For compression */
 	/*
 	 * Performance hints.  Directory preallocation should only
@@ -731,15 +731,15 @@ struct ext2_super_block {
 	__u32	s_first_error_time;	/* first time an error happened */
 	__u32	s_first_error_ino;	/* inode involved in first error */
 /*1a0*/	__u64	s_first_error_block;	/* block involved in first error */
-	__u8	s_first_error_func[32];	/* function where the error happened */
+	__u8	s_first_error_func[32];	/* function where error hit, no NUL? */
 /*1c8*/	__u32	s_first_error_line;	/* line number where error happened */
 	__u32	s_last_error_time;	/* most recent time of an error */
 /*1d0*/	__u32	s_last_error_ino;	/* inode involved in last error */
 	__u32	s_last_error_line;	/* line number where error happened */
 	__u64	s_last_error_block;	/* block involved of last error */
-/*1e0*/	__u8	s_last_error_func[32];	/* function where the error happened */
+/*1e0*/	__u8	s_last_error_func[32];	/* function where error hit, no NUL? */
 #define EXT4_S_ERR_END ext4_offsetof(struct ext2_super_block, s_mount_opts)
-/*200*/	__u8	s_mount_opts[64];
+/*200*/	__u8	s_mount_opts[64];	/* default mount options, no NUL? */
 /*240*/	__u32	s_usr_quota_inum;	/* inode number of user quota file */
 	__u32	s_grp_quota_inum;	/* inode number of group quota file */
 	__u32	s_overhead_blocks;	/* overhead blocks/clusters in fs */
@@ -763,6 +763,7 @@ struct ext2_super_block {
 };
 
 #define EXT4_S_ERR_LEN (EXT4_S_ERR_END - EXT4_S_ERR_START)
+#define EXT2_LEN_STR(buf) (int)sizeof(buf), (char *)buf
 
 /*
  * Codes for operating systems
diff --git a/lib/support/plausible.c b/lib/support/plausible.c
index a726898..024f205 100644
--- a/lib/support/plausible.c
+++ b/lib/support/plausible.c
@@ -101,7 +101,6 @@ static void print_ext2_info(const char *device)
 	ext2_filsys		fs;
 	errcode_t		retval;
 	time_t			tm;
-	char			buf[80];
 
 	retval = ext2fs_open2(device, 0, EXT2_FLAG_64BITS, 0, 0,
 			      unix_io_manager, &fs);
@@ -111,13 +110,10 @@ static void print_ext2_info(const char *device)
 
 	if (sb->s_mtime) {
 		tm = sb->s_mtime;
-		if (sb->s_last_mounted[0]) {
-			memset(buf, 0, sizeof(buf));
-			strncpy(buf, sb->s_last_mounted,
-				sizeof(sb->s_last_mounted));
-			printf(_("\tlast mounted on %s on %s"), buf,
-			       ctime(&tm));
-		} else
+		if (sb->s_last_mounted[0])
+			printf(_("\tlast mounted on %.*s on %s"),
+			       EXT2_LEN_STR(sb->s_last_mounted), ctime(&tm));
+		else
 			printf(_("\tlast mounted on %s"), ctime(&tm));
 	} else if (sb->s_mkfs_time) {
 		tm = sb->s_mkfs_time;
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index a6053d2..5c955a9 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -441,10 +441,8 @@ static int check_mmp(ext2_filsys fs)
 				fprintf(stderr,
 					"%s: MMP update by '%.*s%.*s' at %s",
 					program_name,
-					(int)sizeof(mmp->mmp_nodename),
-					(char *)mmp->mmp_nodename,
-					(int)sizeof(mmp->mmp_bdevname),
-					(char *)mmp->mmp_bdevname,
+					EXT2_LEN_STR(mmp->mmp_nodename),
+					EXT2_LEN_STR(mmp->mmp_bdevname),
 					ctime(&mmp_time));
 			}
 			retval = 1;
@@ -494,9 +492,9 @@ static void print_mmp_block(ext2_filsys fs)
 	printf("    mmp_update_date: %s", ctime(&mmp_time));
 	printf("    mmp_update_time: %lld\n", mmp->mmp_time);
 	printf("    mmp_node_name: %.*s\n",
-	       (int)sizeof(mmp->mmp_nodename), (char *)mmp->mmp_nodename);
+	       EXT2_LEN_STR(mmp->mmp_nodename));
 	printf("    mmp_device_name: %.*s\n",
-	       (int)sizeof(mmp->mmp_bdevname), (char *)mmp->mmp_bdevname);
+	       EXT2_LEN_STR(mmp->mmp_bdevname));
 }
 
 static void parse_extended_opts(const char *opts, blk64_t *superblock,
diff --git a/misc/e2label.c b/misc/e2label.c
index 526a62c..910ccc7 100644
--- a/misc/e2label.c
+++ b/misc/e2label.c
@@ -81,7 +81,7 @@ static void print_label (char *dev)
 	char label[VOLNAMSZ+1];
 
 	open_e2fs (dev, O_RDONLY);
-	strncpy(label, sb.s_volume_name, VOLNAMSZ);
+	snprintf(label, sizeof(label), "%.*s", EXT2_LEN_STR(sb.s_volume_name));
 	label[VOLNAMSZ] = 0;
 	printf("%s\n", label);
 }
diff --git a/misc/findsuper.c b/misc/findsuper.c
index ff20b98..765295c 100644
--- a/misc/findsuper.c
+++ b/misc/findsuper.c
@@ -251,7 +251,7 @@ int main(int argc, char *argv[])
 			sb_offset = 0;
 		if (jnl_copy && !print_jnl_copies)
 			continue;
-		printf("\r%11Lu %11Lu%s %11Lu%s %9u %5Lu %4u%s %s %02x%02x%02x%02x %s\n",
+		printf("\r%11Lu %11Lu%s %11Lu%s %9u %5Lu %4u%s %s %02x%02x%02x%02x %.*s\n",
 		       sk, sk - ext2.s_block_group_nr * grpsize - sb_offset,
 		       jnl_copy ? "*":" ",
 		       sk + ext2fs_blocks_count(&ext2) * bsize -
@@ -259,7 +259,8 @@ int main(int argc, char *argv[])
 		       jnl_copy ? "*" : " ", ext2fs_blocks_count(&ext2), bsize,
 		       ext2.s_block_group_nr, jnl_copy ? "*" : " ", s,
 		       ext2.s_uuid[0], ext2.s_uuid[1],
-		       ext2.s_uuid[2], ext2.s_uuid[3], ext2.s_volume_name);
+		       ext2.s_uuid[2], ext2.s_uuid[3],
+		       EXT2_LEN_STR(ext2.s_volume_name));
 	}
 	printf(_("\n%11Lu: finished with errno %d\n"), sk, errno);
 	close(fd);
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index ffea823..bbae131 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -655,7 +655,6 @@ write_superblock:
 static void show_stats(ext2_filsys fs)
 {
 	struct ext2_super_block *s = fs->super;
-	char 			buf[80];
         char                    *os;
 	blk64_t			group_block;
 	dgrp_t			i;
@@ -673,9 +672,8 @@ static void show_stats(ext2_filsys fs)
 		fprintf(stderr, _("warning: %llu blocks unused.\n\n"),
 		       ext2fs_blocks_count(&fs_param) - ext2fs_blocks_count(s));
 
-	memset(buf, 0, sizeof(buf));
-	strncpy(buf, s->s_volume_name, sizeof(s->s_volume_name));
-	printf(_("Filesystem label=%s\n"), buf);
+	printf(_("Filesystem label=%.*s\n"), EXT2_LEN_STR(s->s_volume_name));
+
 	os = e2p_os2string(fs->super->s_creator_os);
 	if (os)
 		printf(_("OS type: %s\n"), os);
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index a0448f6..dd5d40a 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2990,8 +2990,7 @@ retry_open:
 
 	if (print_label) {
 		/* For e2label emulation */
-		printf("%.*s\n", (int) sizeof(sb->s_volume_name),
-		       sb->s_volume_name);
+		printf("%.*s\n", EXT2_LEN_STR(sb->s_volume_name));
 		remove_error_table(&et_ext2_error_table);
 		goto closefs;
 	}
diff --git a/misc/util.c b/misc/util.c
index 6239b36..dcd2f0a 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -289,9 +289,7 @@ void dump_mmp_msg(struct mmp_struct *mmp, const char *msg)
 		time_t t = mmp->mmp_time;
 
 		printf("MMP error info: node: %.*s, device: %.*s, updated: %s",
-		       (int)sizeof(mmp->mmp_nodename),
-		       (char *)mmp->mmp_nodename,
-		       (int)sizeof(mmp->mmp_bdevname),
-		       (char *)mmp->mmp_bdevname, ctime(&t));
+		       EXT2_LEN_STR(mmp->mmp_nodename),
+		       EXT2_LEN_STR(mmp->mmp_bdevname), ctime(&t));
 	}
 }
-- 
1.8.0

