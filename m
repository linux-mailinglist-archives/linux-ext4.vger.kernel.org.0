Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14392412D87
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Sep 2021 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhIUDnf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Sep 2021 23:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhIUDne (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Sep 2021 23:43:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0AC061574
        for <linux-ext4@vger.kernel.org>; Mon, 20 Sep 2021 20:42:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j14so5327130plx.4
        for <linux-ext4@vger.kernel.org>; Mon, 20 Sep 2021 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bG78IdeBbZzdefOwwpIeze0rrfGIZQYb/+7B900R2cM=;
        b=TJKCRlA0MDZ6FqncqvFYBFe1N/QZFoTYNBtne5WyJzalBsh8qcPyIFYmtDuXyxtpAC
         8prAiD+MWiEvsp7geFgO96FCoqJhNUU+EfQ5tCRzs3XFYR+u30gZDEkbES8G1TVA6p25
         nhejkQ7TI85PVnLHYbszNuIjrEAmK+KxKIumA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bG78IdeBbZzdefOwwpIeze0rrfGIZQYb/+7B900R2cM=;
        b=I9flJBJioas+Aca8ERW/gV8iJJcUcirtnR5pBk/zEmtF4hJj5zEa6SgT88iLU9XOw2
         G5kwu4PDyrki0W1J6+PaN00bumAzZHqUCS01DFB2EJikg6gUI8kVo0MAP7eEKdHHZaqx
         x9jB2AmehrAk+jgHXS9R8yeCuQIKvyOEHSQAG5+0JYNtHcaof5fkpLhsQPqyZ+799nLb
         caxADVkWDK2ZxaLPsXCt7FYSTKMWxodArD+zsTrEnbXk7Lm7vQY1OdJrPQNN01zr5qEY
         MeRZT72fmmHM8njma9ipivwIDpp8MQ9RQ+wfAac5olOvVsMM5TJ/ULHX4z6CL0YdTMUG
         w0gg==
X-Gm-Message-State: AOAM531r/6e4M9EUbmq/RlVjpXzMfLD8RxSPUKNt6CPpAAttE9Z4P1df
        bJ0uZ+XAdZsGUwGIKB7NbmhEKJ0/0yrZfA==
X-Google-Smtp-Source: ABdhPJwgNSTyux5kdoZs1c0U9tjx75htNyfcLZnfjaRHVVh4YbgStTimlt62odLiPl3er4WA54gcdQ==
X-Received: by 2002:a17:902:a60d:b0:13b:7dad:9a5 with SMTP id u13-20020a170902a60d00b0013b7dad09a5mr25331934plq.41.1632195726395;
        Mon, 20 Sep 2021 20:42:06 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0::a7b9])
        by smtp.gmail.com with ESMTPSA id 9sm792582pjs.14.2021.09.20.20.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:42:06 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     gwendal@chromium.org, tytso@mit.edu,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH] mke2fs: Add extended option for prezeroed storage devices
Date:   Mon, 20 Sep 2021 20:42:03 -0700
Message-Id: <20210921034203.323950-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

This patch adds an extended option "assume_storage_prezeroed" to
mke2fs. When enabled, this option acts as a hint to mke2fs that
the underlying block device was zeroed before mke2fs was called.
This allows mke2fs to optimize out the zeroing of the inode
table and the journal, which speeds up the filesystem creation
time.

Additionally, on thinly provisioned storage devices (like Ceph,
dm-thin), reads on unmapped extents return zero. This property
allows mke2fs (with assume_storage_prezeroed) to avoid
pre-allocating metadata space for inode tables for the entire
filesystem and saves space that would normally be preallocated
for zero inode tables.

Testing on ChromeOS (running linux kernel 4.19) with dm-thin
and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':

- Time taken by mke2fs drops from 1.07s to 0.08s.
- Avoiding zeroing out the inode table and journal reduces the
  initial metadata space allocation from 0.48% to 0.01%.
- Lazy inode table zeroing results in a further 1.45% of logical
  volume space getting allocated for inode tables, even if not file
  data is added to the filesystem. With assume_storage_prezeroed,
  the metadata allocation remains at 0.01%.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 misc/mke2fs.8.in |  6 ++++++
 misc/mke2fs.c    | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index c0b53245..b82f8445 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -364,6 +364,12 @@ This speeds up file system initialization noticeably, but carries some
 small risk if the system crashes before the journal has been overwritten
 entirely one time.  If the option value is omitted, it defaults to 1 to
 enable lazy journal inode zeroing.
+.B assume_storage_prezeroed\fR[\fB= \fI<0 to disable, 1 to enable>\fR]
+If enabled,
+.BR mke2fs
+assumes that the storage device has been prezeroed, skips zeroing the journal
+and inode tables, and annotates the block group flags to signal that the inode
+table has been zeroed.
 .TP
 .B no_copy_xattrs
 Normally
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 04b2fbce..5293d9b0 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -95,6 +95,7 @@ int	journal_size;
 int	journal_flags;
 int	journal_fc_size;
 static int	lazy_itable_init;
+static int	assume_storage_prezeroed;
 static int	packed_meta_blocks;
 int		no_copy_xattrs;
 static char	*bad_blocks_filename = NULL;
@@ -1012,6 +1013,11 @@ static void parse_extended_opts(struct ext2_super_block *param,
 				lazy_itable_init = strtoul(arg, &p, 0);
 			else
 				lazy_itable_init = 1;
+		} else if (!strcmp(token, "assume_storage_prezeroed")) {
+			if (arg)
+				assume_storage_prezeroed = strtoul(arg, &p, 0);
+			else
+				assume_storage_prezeroed = 1;
 		} else if (!strcmp(token, "lazy_journal_init")) {
 			if (arg)
 				journal_flags |= strtoul(arg, &p, 0) ?
@@ -1115,7 +1121,8 @@ static void parse_extended_opts(struct ext2_super_block *param,
 			"\tnodiscard\n"
 			"\tencoding=<encoding>\n"
 			"\tencoding_flags=<flags>\n"
-			"\tquotatype=<quota type(s) to be enabled>\n\n"),
+			"\tquotatype=<quota type(s) to be enabled>\n"
+			"\tassume_storage_prezeroed=<0 to disable, 1 to enable>\n\n"),
 			badopt ? badopt : "");
 		free(buf);
 		exit(1);
@@ -3095,6 +3102,18 @@ int main (int argc, char *argv[])
 		io_channel_set_options(fs->io, opt_string);
 	}
 
+	if (assume_storage_prezeroed) {
+	  if (verbose)
+			printf("%s",
+				       _("Assuming the storage device is prezeroed "
+                         "- skipping inode table and journal wipe\n"));
+
+	  lazy_itable_init = 1;
+	  itable_zeroed = 1;
+	  zero_hugefile = 0;
+	  journal_flags |= EXT2_MKJOURNAL_LAZYINIT;
+	}
+
 	/* Can't undo discard ... */
 	if (!noaction && discard && dev_size && (io_ptr != undo_io_manager)) {
 		retval = mke2fs_discard_device(fs);
-- 
2.31.0

