Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4030713B4BA
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 22:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgANVu2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 16:50:28 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:53922 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgANVu2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 16:50:28 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 16:50:27 EST
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id rTx4iCDaPnCigrTx5izHgX; Tue, 14 Jan 2020 14:42:20 -0700
X-Authority-Analysis: v=2.3 cv=cZisUULM c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=bax6B7nZl5R60_kwWbMA:9
 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 1/2] mmp: don't assume NUL termination for MMP strings
Date:   Tue, 14 Jan 2020 14:42:17 -0700
Message-Id: <1579038138-49231-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <20191231220724.GA118765@mit.edu>
References: <20191231220724.GA118765@mit.edu>
X-CMAE-Envelope: MS4wfJlQUXiD3KTIhK3nC4oZr+aCktlJH8lC2Tg+C+pc+WqAhge1/X/UXXRELwnc0Ps5iQqAcfppj6S8143CInQeitJb7YsFqUbec7DCZa60UODfaSfUI3tZ
 rx8tuyHbv6EcrToExELQm9OLAvx3ZeG+NfmykXQcngZchFjvbnisOFBtiBueZ/RFYrxc+/4+hVJss4D5Qo3ASU83lSTXHWrEbYM4TMPPNVTULpSptAFNU71y
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't assume that mmp_nodename and mmp_bdevname are NUL terminated,
since very long node/device names may completely fill the buffers.

Limit string printing to the maximum buffer size for safety, and
change the field definitions to __u8 to make it more clear that
they are not NUL-terminated strings, as is done with other strings
in the superblock that do not have NUL termination.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/debugfs.c    |  6 ++++--
 e2fsck/util.c        |  8 ++++++--
 lib/ext2fs/ext2_fs.h |  6 +++---
 misc/dumpe2fs.c      | 14 ++++++++++----
 misc/util.c          |  7 +++++--
 tests/filter.sed     |  1 +
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 9b70145..7cfc269 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -2446,8 +2446,10 @@ void do_dump_mmp(int argc EXT2FS_ATTR((unused)), char *argv[],
 	fprintf(stdout, "check_interval: %d\n", mmp_s->mmp_check_interval);
 	fprintf(stdout, "sequence: %08x\n", mmp_s->mmp_seq);
 	fprintf(stdout, "time: %lld -- %s", mmp_s->mmp_time, ctime(&t));
-	fprintf(stdout, "node_name: %s\n", mmp_s->mmp_nodename);
-	fprintf(stdout, "device_name: %s\n", mmp_s->mmp_bdevname);
+	fprintf(stdout, "node_name: %.*s\n",
+		(int)sizeof(mmp_s->mmp_nodename), (char *)mmp_s->mmp_nodename);
+	fprintf(stdout, "device_name: %.*s\n",
+		(int)sizeof(mmp_s->mmp_bdevname), (char *)mmp_s->mmp_bdevname);
 	fprintf(stdout, "magic: 0x%x\n", mmp_s->mmp_magic);
 	fprintf(stdout, "checksum: 0x%08x\n", mmp_s->mmp_checksum);
 }
diff --git a/e2fsck/util.c b/e2fsck/util.c
index db6a1cc..07885ab 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -777,8 +777,12 @@ void dump_mmp_msg(struct mmp_struct *mmp, const char *fmt, ...)
 		printf("    mmp_sequence: %08x\n", mmp->mmp_seq);
 		printf("    mmp_update_date: %s", ctime(&t));
 		printf("    mmp_update_time: %lld\n", mmp->mmp_time);
-		printf("    mmp_node_name: %s\n", mmp->mmp_nodename);
-		printf("    mmp_device_name: %s\n", mmp->mmp_bdevname);
+		printf("    mmp_node_name: %.*s\n",
+		       (int)sizeof(mmp->mmp_nodename),
+		       (char *)mmp->mmp_nodename);
+		printf("    mmp_device_name: %.*s\n",
+		       (int)sizeof(mmp->mmp_bdevname),
+		       (char *)mmp->mmp_bdevname);
 	}
 }
 
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 3165b38..79816b6 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -1098,9 +1098,9 @@ struct ext2_dir_entry_tail {
 struct mmp_struct {
 	__u32	mmp_magic;		/* Magic number for MMP */
 	__u32	mmp_seq;		/* Sequence no. updated periodically */
-	__u64	mmp_time;		/* Time last updated */
-	char	mmp_nodename[64];	/* Node which last updated MMP block */
-	char	mmp_bdevname[32];	/* Bdev which last updated MMP block */
+	__u64	mmp_time;		/* Time last updated (seconds) */
+	__u8	mmp_nodename[64];	/* Node updating MMP block, no NUL? */
+	__u8	mmp_bdevname[32];	/* Bdev updating MMP block, no NUL? */
 	__u16	mmp_check_interval;	/* Changed mmp_check_interval */
 	__u16	mmp_pad1;
 	__u32	mmp_pad2[226];
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 9a6f586..a6053d2 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -439,8 +439,12 @@ static int check_mmp(ext2_filsys fs)
 				time_t mmp_time = mmp->mmp_time;
 
 				fprintf(stderr,
-					"%s: MMP last updated by '%s' on %s",
-					program_name, mmp->mmp_nodename,
+					"%s: MMP update by '%.*s%.*s' at %s",
+					program_name,
+					(int)sizeof(mmp->mmp_nodename),
+					(char *)mmp->mmp_nodename,
+					(int)sizeof(mmp->mmp_bdevname),
+					(char *)mmp->mmp_bdevname,
 					ctime(&mmp_time));
 			}
 			retval = 1;
@@ -489,8 +493,10 @@ static void print_mmp_block(ext2_filsys fs)
 	printf("    mmp_sequence: %#08x\n", mmp->mmp_seq);
 	printf("    mmp_update_date: %s", ctime(&mmp_time));
 	printf("    mmp_update_time: %lld\n", mmp->mmp_time);
-	printf("    mmp_node_name: %s\n", mmp->mmp_nodename);
-	printf("    mmp_device_name: %s\n", mmp->mmp_bdevname);
+	printf("    mmp_node_name: %.*s\n",
+	       (int)sizeof(mmp->mmp_nodename), (char *)mmp->mmp_nodename);
+	printf("    mmp_device_name: %.*s\n",
+	       (int)sizeof(mmp->mmp_bdevname), (char *)mmp->mmp_bdevname);
 }
 
 static void parse_extended_opts(const char *opts, blk64_t *superblock,
diff --git a/misc/util.c b/misc/util.c
index 7799158..6239b36 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -288,7 +288,10 @@ void dump_mmp_msg(struct mmp_struct *mmp, const char *msg)
 	if (mmp) {
 		time_t t = mmp->mmp_time;
 
-		printf("MMP error info: last update: %s node: %s device: %s\n",
-		       ctime(&t), mmp->mmp_nodename, mmp->mmp_bdevname);
+		printf("MMP error info: node: %.*s, device: %.*s, updated: %s",
+		       (int)sizeof(mmp->mmp_nodename),
+		       (char *)mmp->mmp_nodename,
+		       (int)sizeof(mmp->mmp_bdevname),
+		       (char *)mmp->mmp_bdevname, ctime(&t));
 	}
 }
diff --git a/tests/filter.sed b/tests/filter.sed
index f37986c..796186e 100644
--- a/tests/filter.sed
+++ b/tests/filter.sed
@@ -37,3 +37,4 @@ s/mmp_node_name: .*/mmp_node_name: test_node/
 s/mmp_update_date: .*/mmp_update_date: test date/
 s/mmp_update_time: .*/mmp_update_time: test_time/
 s/MMP last updated by '.*' on .*/MMP last updated by 'test_node' on test date/
+s/MMP update by '.*' at .*/MMP last updated by 'test_node' on test date/
-- 
1.8.0

