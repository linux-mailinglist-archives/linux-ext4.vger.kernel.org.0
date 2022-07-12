Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA55713D9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGLICM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiGLICJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 04:02:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C09DED4;
        Tue, 12 Jul 2022 01:02:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 73so6867736pgb.10;
        Tue, 12 Jul 2022 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czC6gTsZ0VWb+rxsYJJG1BbtgWHGVYS2sP+uzJx9gcw=;
        b=oftp9zjiXeGkzvkVbs+ztIwKb3iPzt5mIezNNfC1R3hVj9KPmAp/fShqqxJr2W+sUD
         PLtQXMRqiVC5pTx+bV8QHawEQpmIHMJg+jcmAnT8q5y5oYau6/QB7SrPcuu147pYibcM
         cvHaH0ED8BtqG4JyN8DeUBzgOID5TE98Uj4z/qRPPZzMtVXoCkSdTHGtsKwXlRnrR3xw
         jt2VgeZTNlKI4YZXrAI2PzQSjeZOkgqK7py7HZ029ETbK1KDOkyya6S41cw1TiP4oenj
         rbg1w0y47S7NsHdNlmAD3dOHA1uK7Mq5fCdX0u3u5q3Q0gBvbhL0ftVyMOw9AfSwfiAP
         lNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czC6gTsZ0VWb+rxsYJJG1BbtgWHGVYS2sP+uzJx9gcw=;
        b=0WFxBeUd8Ay8Ny1STJA6sK34JdOcITFwVWyYJKkZvvCosxxHH9InBNYjxTGBs7Ah4a
         bfXvHhLtDBpuowk7rE41jcf1QRTcwvBvW358iETwMcdEVQpXDDRCHVAk2W4ZqKL2LFCF
         0u9yv9pTatGl3/4R5g00XfB1Huaktm/bw6E6zCepLoFOPuEuZMlqYVHZZjCRuR2OL8h3
         YpsPedwIv+w8eNjFc0eOWFITWrnS41a2GlluyeQyuFI6Otw2DlGVCyLdyWtxCBmN/bSf
         U4bUVcpp+aoAEAVRa0F+2WCjS2sgP6YTR07kWAGCJ9cReDlXQjmZuBzLeGETeKI5xGZY
         ZrXw==
X-Gm-Message-State: AJIora+lj6oNKLgFV12+igIT+VI1xsjwo/x4y1Nh94AEUDvhEBqmq+nL
        yzXNGsQK6ft3N3YK4XRU+yfmko5LX/PbDZgZ
X-Google-Smtp-Source: AGRyM1vWaFhkgA3X1ekKKpXOranAxmMC/izsr2M9QRDpJUJateUW7ZnO7u/MQ6RyWVpi+tz7L4poRQ==
X-Received: by 2002:a63:8bc8:0:b0:413:9952:6059 with SMTP id j191-20020a638bc8000000b0041399526059mr18885356pge.61.1657612927867;
        Tue, 12 Jul 2022 01:02:07 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id m7-20020a1709026bc700b0016bebb0cb96sm6066036plt.266.2022.07.12.01.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:02:07 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v3] ext4/056: add a check to make sure ext4 uuid ioctls get/set during fsstress.
Date:   Tue, 12 Jul 2022 01:01:53 -0700
Message-Id: <20220712080153.471437-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
while running fsstress. These ioctls are used by tune2fs to safely change
the uuid without racing other filesystem modifications.

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---
 .gitignore         |   1 +
 src/Makefile       |   4 +-
 src/uuid_ioctl.c   | 104 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056     |  61 ++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 5 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 src/uuid_ioctl.c
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

diff --git a/.gitignore b/.gitignore
index ba0c572b..dab24d68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -169,6 +169,7 @@ tags
 /src/unwritten_mmap
 /src/unwritten_sync
 /src/usemem
+/src/uuid_ioctl
 /src/writemod
 /src/writev_on_pagefault
 /src/xfsctl
diff --git a/src/Makefile b/src/Makefile
index 111ce1d9..e33e04de 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,14 +31,14 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation ext4_resize
+	detached_mounts_propagation ext4_resize uuid_ioctl
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py
 
 SUBDIRS = log-writes perf
 
-LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
+LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
 LINUX_TARGETS += loggen
diff --git a/src/uuid_ioctl.c b/src/uuid_ioctl.c
new file mode 100644
index 00000000..367e5ed5
--- /dev/null
+++ b/src/uuid_ioctl.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test program which uses the raw ext4 set_fsuuid ioctl directly.
+ * SYNOPSIS:
+ *   $0 COMMAND MOUNT_POINT [UUID]
+ *
+ * COMMAND must be either "get" or "set".
+ * The UUID must be a 16 octet represented as 32 hexadecimal digits in canonical
+ * textual representation, e.g. output from `uuidgen`.
+ *
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <uuid/uuid.h>
+#include <linux/fs.h>
+
+struct fsuuid {
+	__u32   fu_len;
+	__u32   fu_flags;
+	__u8    fu_uuid[];
+};
+
+#ifndef EXT4_IOC_GETFSUUID
+#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
+#endif
+
+#ifndef EXT4_IOC_SETFSUUID
+#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)
+#endif
+
+int main(int argc, char **argv)
+{
+	int error, fd;
+	struct fsuuid *fsuuid = NULL;
+
+	if (argc < 3) {
+		fprintf(stderr, "Invalid arguments\n");
+		return 1;
+	}
+
+	fd = open(argv[2], O_RDONLY);
+	if (!fd) {
+		perror(argv[2]);
+		return 1;
+	}
+
+	fsuuid = malloc(sizeof(*fsuuid) + sizeof(uuid_t));
+	if (!fsuuid) {
+		perror("malloc");
+		return 1;
+	}
+	fsuuid->fu_len = sizeof(uuid_t);
+	fsuuid->fu_flags = 0;
+
+	if (strcmp(argv[1], "get") == 0) {
+		uuid_t uuid;
+		char uuid_str[37];
+
+		if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid)) {
+			fprintf(stderr, "%s while trying to get fs uuid\n",
+				strerror(errno));
+			return 1;
+		}
+
+		memcpy(&uuid, fsuuid->fu_uuid, sizeof(uuid));
+		uuid_unparse(uuid, uuid_str);
+		printf("%s", uuid_str);
+	} else if (strcmp(argv[1], "set") == 0) {
+		uuid_t uuid;
+
+		if (argc != 4) {
+			fprintf(stderr, "UUID argument missing.\n");
+			return 1;
+		}
+
+		error = uuid_parse(argv[3], uuid);
+		if (error < 0) {
+			fprintf(stderr, "Invalid UUID. The UUID should be in "
+				"canonical format. Example: "
+				"8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
+			return 1;
+		}
+
+		memcpy(&fsuuid->fu_uuid, uuid, sizeof(uuid));
+		if (ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid)) {
+			fprintf(stderr, "%s while trying to set fs uuid\n",
+				strerror(errno));
+			return 1;
+		}
+	} else {
+		fprintf(stderr, "Invalid command\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..4a011fa3
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the set/get UUID ioctl.
+#
+
+. ./common/preamble
+_begin_fstest auto ioctl
+
+# Override the default cleanup function.
+_cleanup()
+{
+  cd /
+  rm -r -f $tmp.*
+  $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_require_scratch
+_require_test_program uuid_ioctl
+_require_command $UUIDGEN_PROG uuidgen
+
+UUID_IOCTL=$here/src/uuid_ioctl
+
+# If the ioctl is not supported by the kernel, then skip test.
+current_uuid=$($UUID_IOCTL get $SCRATCH_MNT 2>&1)
+if [[ "$current_uuid" =~ ^Inappropriate[[:space:]]ioctl ]]; then
+        _notrun "UUID ioctls are not supported by kernel."
+fi
+
+# metadata_csum_seed must be set to decouple checksums from the uuid.
+# Otherwise, checksums need to be recomputed when the uuid changes, which
+# is not supported by the ioctl.
+_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full
+
+# Begin fsstress while modifying UUID
+fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
+$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
+
+for n in $(seq 1 20); do
+        new_uuid=$($UUIDGEN_PROG)
+
+        echo "Setting UUID to ${new_uuid}" >> $seqres.full 2>&1
+        $UUID_IOCTL set $SCRATCH_MNT $new_uuid
+
+        current_uuid=$($UUID_IOCTL get $SCRATCH_MNT)
+        echo "$UUID_IOCTL get $SCARTCH_MNT: $current_uuid" >> $seqres.full 2>&1
+        if [[ "$current_uuid" != "$new_uuid" ]]; then
+                echo "Current UUID ($current_uuid) does not equal what was sent with the ioctl ($new_uuid)"
+        fi
+done
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/056.out b/tests/ext4/056.out
new file mode 100644
index 00000000..6142fcd2
--- /dev/null
+++ b/tests/ext4/056.out
@@ -0,0 +1,2 @@
+QA output created by 056
+Silence is golden
-- 
2.37.0.144.g8ac04bfd2-goog

