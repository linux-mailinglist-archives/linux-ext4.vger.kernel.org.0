Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A428159E7E
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgBLBGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 20:06:15 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:40586 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgBLBGP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 20:06:15 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 20:06:14 EST
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id 1gLtjH9wGnCig1gLujMFIX; Tue, 11 Feb 2020 17:58:06 -0700
X-Authority-Analysis: v=2.3 cv=cZisUULM c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=ySfo2T4IAAAA:8
 a=FaBPmBmokNLrZCp-OeEA:9 a=fa_un-3J20JGBB2Tu-mn:22 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] misc: handle very large files with filefrag
Date:   Tue, 11 Feb 2020 17:58:05 -0700
Message-Id: <1581469085-85472-1-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfEUM4UF2mkEBQAGB/KA45yNwgfR/BCadXlm4xqlIPdIsC7RdjcNjcKZ6DIdeaicQQBcT5f1l4o+DGKWFsm1860q764cba9zFwikIc8ZFmAAhwRkhF77F
 eCDUHGzmv0ZZ9Js/1ppB9Cz11e2IbV4wN/+d70zksz1zf9AYvKfQD3xmU9nI/lzJIyoq2hNQe5xnNAp+Hq35BoroQRtZhdv5YlhtpeGb8WAkVIkE5FzM3LPX
 /aLMGm379LsTGPSyWAsMsK6kL3S/LU2ABxyhsHf54X4=
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Avoid overflowing the column-width calc printing files over 4B blocks.

Document the [KMG] suffixes for the "-b <blocksize>" option.

The blocksize is limited to at most 1GiB blocksize to avoid shifting
all extents down to zero GB in size.  Even the use of 1GB blocksize
is unlikely, but non-ext4 filesystems may use multi-GB extents.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 misc/filefrag.8.in |  4 ++--
 misc/filefrag.c    | 36 ++++++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/misc/filefrag.8.in b/misc/filefrag.8.in
index 5292672..4b89e72 100644
--- a/misc/filefrag.8.in
+++ b/misc/filefrag.8.in
@@ -33,8 +33,8 @@ testing purposes.
 .BI \-b blocksize
 Use
 .I blocksize
-in bytes for output instead of the filesystem blocksize.
-For compatibility with earlier versions of
+in bytes, or with [KMG] suffix, up to 1GB for output instead of the
+filesystem blocksize.  For compatibility with earlier versions of
 .BR filefrag ,
 if
 .I blocksize
diff --git a/misc/filefrag.c b/misc/filefrag.c
index 1eec146..032535f 100644
--- a/misc/filefrag.c
+++ b/misc/filefrag.c
@@ -53,7 +53,7 @@ extern int optind;
 #include <ext2fs/fiemap.h>
 
 int verbose = 0;
-int blocksize;		/* Use specified blocksize (default 1kB) */
+unsigned int blocksize;	/* Use specified blocksize (default 1kB) */
 int sync_file = 0;	/* fsync file before getting the mapping */
 int xattr_map = 0;	/* get xattr mapping */
 int force_bmap;	/* force use of FIBMAP instead of FIEMAP */
@@ -73,7 +73,7 @@ const char *hex_fmt = "%4d: %*llx..%*llx: %*llx..%*llx: %6llx: %s\n";
 #define	EXT4_EXTENTS_FL			0x00080000 /* Inode uses extents */
 #define	EXT3_IOC_GETFLAGS		_IOR('f', 1, long)
 
-static int int_log2(int arg)
+static int ulong_log2(unsigned long arg)
 {
 	int     l = 0;
 
@@ -85,7 +85,7 @@ static int int_log2(int arg)
 	return l;
 }
 
-static int int_log10(unsigned long long arg)
+static int ulong_log10(unsigned long long arg)
 {
 	int     l = 0;
 
@@ -452,17 +452,17 @@ static int frag_report(const char *filename)
 	}
 	last_device = st.st_dev;
 
-	width = int_log10(fsinfo.f_blocks);
+	width = ulong_log10(fsinfo.f_blocks);
 	if (width > physical_width)
 		physical_width = width;
 
 	numblocks = (st.st_size + blksize - 1) / blksize;
 	if (blocksize != 0)
-		blk_shift = int_log2(blocksize);
+		blk_shift = ulong_log2(blocksize);
 	else
-		blk_shift = int_log2(blksize);
+		blk_shift = ulong_log2(blksize);
 
-	width = int_log10(numblocks);
+	width = ulong_log10(numblocks);
 	if (width > logical_width)
 		logical_width = width;
 	if (verbose)
@@ -517,7 +517,7 @@ out_close:
 
 static void usage(const char *progname)
 {
-	fprintf(stderr, "Usage: %s [-b{blocksize}] [-BeksvxX] file ...\n",
+	fprintf(stderr, "Usage: %s [-b{blocksize}[KMG]] [-BeksvxX] file ...\n",
 		progname);
 	exit(1);
 }
@@ -535,7 +535,9 @@ int main(int argc, char**argv)
 		case 'b':
 			if (optarg) {
 				char *end;
-				blocksize = strtoul(optarg, &end, 0);
+				unsigned long val;
+
+				val = strtoul(optarg, &end, 0);
 				if (end) {
 #if __GNUC_PREREQ (7, 0)
 #pragma GCC diagnostic push
@@ -544,15 +546,15 @@ int main(int argc, char**argv)
 					switch (end[0]) {
 					case 'g':
 					case 'G':
-						blocksize *= 1024;
+						val *= 1024;
 						/* fall through */
 					case 'm':
 					case 'M':
-						blocksize *= 1024;
+						val *= 1024;
 						/* fall through */
 					case 'k':
 					case 'K':
-						blocksize *= 1024;
+						val *= 1024;
 						break;
 					default:
 						break;
@@ -561,6 +563,16 @@ int main(int argc, char**argv)
 #pragma GCC diagnostic pop
 #endif
 				}
+				/* Specifying too large a blocksize will just
+				 * shift all extents down to zero length. Even
+				 * 1GB is questionable, but caveat emptor. */
+				if (val > 1024 * 1024 * 1024) {
+					fprintf(stderr,
+						"%s: blocksize %lu over 1GB\n",
+						argv[0], val);
+					usage(argv[0]);
+				}
+				blocksize = val;
 			} else { /* Allow -b without argument for compat. Remove
 				  * this eventually so "-b {blocksize}" works */
 				fprintf(stderr, "%s: -b needs a blocksize "
-- 
1.8.0

