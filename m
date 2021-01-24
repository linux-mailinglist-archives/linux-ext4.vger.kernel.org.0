Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E665301F95
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Jan 2021 00:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbhAXX2k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Jan 2021 18:28:40 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:37531 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbhAXX2i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Jan 2021 18:28:38 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2021 18:28:38 EST
Received: from webber.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id 3og3lmqA2eHr93og4l0BQq; Sun, 24 Jan 2021 16:20:17 -0700
X-Authority-Analysis: v=2.4 cv=Yq/K+6UX c=1 sm=1 tr=0 ts=600e00b1
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=csaP3fDte-NEDMLNYVAA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] misc: fix minor llvm warnings
Date:   Sun, 24 Jan 2021 16:20:06 -0700
Message-Id: <20210124232006.13832-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFtWGG5vDX8EkW67wKNCRfEKycqjWcd5eRz1T1fIvTeLRlPPTNERwyqlTuDXcUB3LWn6Z54jXf4xIRKXZfKWAMMmM5Z8COd2FcqjQWFxz2KNxsvgRlC6
 044nRHzg5BZYg0euXhNRwqovhVIBahrnTTEOoyqR0stl/nutSKTCUEWwYpFQosBVtl9nd3u0tFU+j3Fy9hh9B5CWztW5XKCL41+a3UqePd9+7BzY2koSrcaK
 pXtyECGvd4U37SKbXez5SA==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix a couple minor type mismatch warnings.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/logdump.c | 2 +-
 lib/ext2fs/link.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index a94043f3..354bc969 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -536,7 +536,7 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 				(struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
 			ex = (struct ext3_extent *)add_range->fc_ex;
 			fprintf(out_file,
-				"tag %s, inode %d, lblk %lu, pblk %llu, len %lu\n",
+				"tag %s, inode %d, lblk %u, pblk %llu, len %lu\n",
 				tag2str(tl->fc_tag),
 				le32_to_cpu(add_range->fc_ino),
 				le32_to_cpu(ex->ee_block),
diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
index 469eea8c..4160ac65 100644
--- a/lib/ext2fs/link.c
+++ b/lib/ext2fs/link.c
@@ -381,7 +381,7 @@ static errcode_t dx_split_leaf(ext2_filsys fs, ext2_ino_t dir,
 	struct ext2_dir_entry *de;
 	void *buf2;
 	errcode_t retval = 0;
-	int rec_len;
+	unsigned int rec_len;
 	int offset, move_size;
 	int i, count = 0;
 	struct dx_hash_map *map;
-- 
2.25.1

