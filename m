Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E841926A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Sep 2021 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhI0Kpn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Sep 2021 06:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhI0Kpn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Sep 2021 06:45:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5CBC061575
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 03:44:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g2so11346189pfc.6
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZ3MDzrW2f3mMQC47L1Sr+6RlesnLaSjD9S2sXFnpYg=;
        b=ZxuxBjRLqBL7FomnBl6k0fk+qDw6AxJhU9x3im4l2oBBo7ODo808Pd96gej6qR4RFo
         CGs1pqSFq94rfLLZwaliSGmYFJbIi0LgWS/hD6zBGXChMujsRNYaMdB+LKx7gbRk6t7m
         02Pt4eaj70yKLJEXiti5WvPHuG+A2t5xA25dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZ3MDzrW2f3mMQC47L1Sr+6RlesnLaSjD9S2sXFnpYg=;
        b=dXSsvQzBYZvIPbpUDJ/xbenMHMyTvD4VAbUeLq9s+7wIQEu49nc30RqKfrFOT9xkv9
         iqDbeyYJlJc/00XcdX8hSPDvSma+tuqg8mFV1Rm+KZ071Xs4gkc871eU4VnhyOA8YELk
         koZtl400r/EC45vtliMx6bTjjGPahQkr1HEDMZSXHtgIWFx8HqS0egsnQh7+gW14WquR
         CaFKOt1hO++pLwt72S0CIsroruIukKqGDXQQN+43g655VSgZSqaLxtnSeiKGGIc9AOIP
         Vs0aP7PuElgV7frxvuusfVXuUVzWvPRrMZGqz1j2QApW24E27o2Q3Q7ICuyl44Y8sJ+u
         l4Sg==
X-Gm-Message-State: AOAM531Sr04tI82yU04U5h2xrxwr0O7FevIA/Yk+dyxbZW/W0LXQ2pst
        yvdEji1EHOeQ7Lleb/OdQsAJHlk/BRsHGA==
X-Google-Smtp-Source: ABdhPJxiSkaIIlP/UC+bSPCYYCJgt5tanAKn9ORkz7N3c2a8VD4POTHHk8snyovh9XeQaUvbNid/gA==
X-Received: by 2002:a62:19d4:0:b0:43d:1bb7:13ae with SMTP id 203-20020a6219d4000000b0043d1bb713aemr22728242pfz.63.1632739444722;
        Mon, 27 Sep 2021 03:44:04 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0::a7b9])
        by smtp.gmail.com with ESMTPSA id mv6sm15468952pjb.16.2021.09.27.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:44:04 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, gwendal@chromium.org, tytso@mit.edu,
        okiselev@amazon.com
Subject: [PATCH v2] mke2fs: Add extended option for prezeroed storage devices
Date:   Mon, 27 Sep 2021 03:39:10 -0700
Message-Id: <20210927103910.341417-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
References: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds an extended option "assume_storage_prezeroed" to
mke2fs. When enabled, this option acts as a hint to mke2fs that
the underlying block device was zeroed before mke2fs was called.
This allows mke2fs to optimize out the zeroing of the inode
table and the journal, which speeds up the filesystem creation
time.

Additionally, on thinly provisioned storage devices (like Ceph,
dm-thin, newly created sparse loopback files), reads on unmapped extents
return zero. This property allows mke2fs (with assume_storage_prezeroed)
to avoid pre-allocating metadata space for inode tables for the entire
filesystem and saves space that would normally be preallocated
for zero inode tables.

Tests
-----
1) Running 'mke2fs -t ext4' on 10G sparse files on an ext4
filesystem drops the time taken by mke2fs from 0.09s to 0.04s
and reduces the initial metadata space allocation (stat on
sparse file) from 139736 blocks (545M) to 8672 blocks (34M).

2) On ChromeOS (running linux kernel 4.19) with dm-thin
and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':

- Time taken by mke2fs drops from 1.07s to 0.08s.
- Avoiding zeroing out the inode table and journal reduces the
  initial metadata space allocation from 0.48% to 0.01%.
- Lazy inode table zeroing results in a further 1.45% of logical
  volume space getting allocated for inode tables, even if no file
  data is added to the filesystem. With assume_storage_prezeroed,
  the metadata allocation remains at 0.01%.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
--
Changes in v2: Added regression test, fixed indentation.
---
 misc/mke2fs.8.in                        |  7 ++++++
 misc/mke2fs.c                           | 21 ++++++++++++++++-
 tests/m_assume_storage_prezeroed/expect |  2 ++
 tests/m_assume_storage_prezeroed/script | 31 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tests/m_assume_storage_prezeroed/expect
 create mode 100644 tests/m_assume_storage_prezeroed/script

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index c0b53245..5c6ea5ec 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -365,6 +365,13 @@ small risk if the system crashes before the journal has been overwritten
 entirely one time.  If the option value is omitted, it defaults to 1 to
 enable lazy journal inode zeroing.
 .TP
+.B assume_storage_prezeroed\fR[\fB= \fI<0 to disable, 1 to enable>\fR]
+If enabled,
+.BR mke2fs
+assumes that the storage device has been prezeroed, skips zeroing the journal
+and inode tables, and annotates the block group flags to signal that the inode
+table has been zeroed.
+.TP
 .B no_copy_xattrs
 Normally
 .B mke2fs
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 04b2fbce..24c69966 100644
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
+		if (verbose)
+			printf("%s",
+			       _("Assuming the storage device is prezeroed "
+			       "- skipping inode table and journal wipe\n"));
+
+		lazy_itable_init = 1;
+		itable_zeroed = 1;
+		zero_hugefile = 0;
+		journal_flags |= EXT2_MKJOURNAL_LAZYINIT;
+	}
+
 	/* Can't undo discard ... */
 	if (!noaction && discard && dev_size && (io_ptr != undo_io_manager)) {
 		retval = mke2fs_discard_device(fs);
diff --git a/tests/m_assume_storage_prezeroed/expect b/tests/m_assume_storage_prezeroed/expect
new file mode 100644
index 00000000..2ca3784a
--- /dev/null
+++ b/tests/m_assume_storage_prezeroed/expect
@@ -0,0 +1,2 @@
+2384
+336
diff --git a/tests/m_assume_storage_prezeroed/script b/tests/m_assume_storage_prezeroed/script
new file mode 100644
index 00000000..0745fb28
--- /dev/null
+++ b/tests/m_assume_storage_prezeroed/script
@@ -0,0 +1,31 @@
+test_description="test prezeroed storage metadata allocation"
+FILE_SIZE=16M
+
+LOG=$test_name.log
+OUT=$test_name.out
+EXP=$test_dir/expect
+
+dd if=/dev/zero of=$TMPFILE.1 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
+dd if=/dev/zero of=$TMPFILE.2 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
+
+$MKE2FS -o Linux -t ext4 -O has_journal $TMPFILE.1 >> $LOG 2>&1
+stat -c "%b" $TMPFILE.1 > $OUT
+
+$MKE2FS -o Linux -t ext4 -O has_journal -E assume_storage_prezeroed=1 $TMPFILE.2 >> $LOG 2>&1
+stat -c "%b" $TMPFILE.2 >> $OUT
+
+rm -f $TMPFILE.1 $TMPFILE.2
+
+cmp -s $OUT $EXP
+status=$?
+
+if [ "$status" = 0 ] ; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "$test_name: $test_description: failed"
+	cat $LOG > $test_name.failed
+	diff $EXP $OUT >> $test_name.failed
+fi
+
+unset LOG OUT EXP FILE_SIZE
\ No newline at end of file
-- 
2.31.0

