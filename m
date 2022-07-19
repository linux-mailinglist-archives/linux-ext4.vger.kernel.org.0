Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2712157AA91
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiGSXo1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiGSXo0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 19:44:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644A4F66E;
        Tue, 19 Jul 2022 16:44:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso461433pjp.2;
        Tue, 19 Jul 2022 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=La4NDlN+zMRQIG1rIzc5cucWV/z4B5Aq504EvoOBXwc=;
        b=SWmsFuG+MngWm0kMxTfARihlDBxCiWevM9Axg/70vuw9X7JngiqarmqRO/1OwZR7TZ
         J18+U5sqdVvcf9QQJZ1MUnKDl8cRaBIRDaKt6Kqo/izLX9XCjiEzxsMi4gSR7gYqXRuE
         v4L+FAOjAZZmkPdE0RK17mKv1VMRJmXXMGK4MTbTqPW+BmPOgCABh4GgRKTFXjLBc441
         Tz4gKjyiPH0Oe0smdJey6pL4del6GWc3CM+UjdKAMmCdb48Rr4soi/+i2uWFLEQRC7kw
         COKaPuo4N0QEhlmCKsCmgAQv6ptClQLg5vxUy6U4xdn6F5oxhfhPGYOH/5mJF5q7wZl0
         BpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=La4NDlN+zMRQIG1rIzc5cucWV/z4B5Aq504EvoOBXwc=;
        b=HUmMDE4nTV1GDyKLvde2P0bBcRpcb57E/AyixNiu+I5T4TRghiHzIEhHCie+F3Y+Tq
         BDRXRdn2/Ze3gSgzYtj5a6sg7qAozRaY95hzHZ1PXJV0IlBXgSSfutK7U0jLWmxQus2l
         Mz9jgF9HqVmVEfIMepq6TnKQL/mlxZYHkvMjj9F1b+yqOQk54tCq6TmzSC81vhS9cyLn
         aH9aAlPWXW001SvWT2a5VmpB0Qfm/AtQSre/BOuGFLar658UyQhifqgpxLFoWQ6BERjE
         uuAWewMizxojJdW7K46M1V5rW6vgeO9bGvcYPCUlBhwmex32vMR9ke+HsT/fhae6xNIS
         W0wA==
X-Gm-Message-State: AJIora+a+bXP7+3/BFNlFn3ZEzqlYS0G2Umspnl+VKLjeZe4eRnlye6K
        +GJV+5vtDRccZtxOQQPLpxkrkq51WpoqoA==
X-Google-Smtp-Source: AGRyM1tvx2OD7bSUx2MHAbKsnhbjMM9jgp84aI2Jl8LfaUMBXPqJsSY8i6wK4N88luRAg9cjMC6VXg==
X-Received: by 2002:a17:902:f70d:b0:16c:50a2:78d1 with SMTP id h13-20020a170902f70d00b0016c50a278d1mr35138157plo.34.1658274264519;
        Tue, 19 Jul 2022 16:44:24 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:c88e:7520:969d:1265])
        by smtp.googlemail.com with ESMTPSA id u14-20020a170903124e00b0016bee3caabesm12249020plh.270.2022.07.19.16.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:44:23 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls get/set during fsstress.
Date:   Tue, 19 Jul 2022 16:44:13 -0700
Message-Id: <20220719234413.235499-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
while running fsstress. These ioctls are used by tune2fs to safely change
the uuid without racing other filesystem modifications.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---

Added reviewed-by tag.

Added wait after killing fsstress pids.

Removed _scratch_mount output redirection.

 .gitignore         |   1 +
 src/Makefile       |   4 +-
 src/uuid_ioctl.c   | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056     |  64 +++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 5 files changed, 174 insertions(+), 2 deletions(-)
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
index 00000000..89a9b5d8
--- /dev/null
+++ b/src/uuid_ioctl.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Google, Inc. All Rights Reserved.
+ *
+ * Test program which uses the raw ext4 set_fsuuid ioctl directly.
+ * SYNOPSIS:
+ *   $0 COMMAND MOUNT_POINT [UUID]
+ *
+ * COMMAND must be either "get" or "set".
+ * The UUID must be a 16 octet sequence represented as 32 hexadecimal digits in
+ * canonical textual representation, e.g. output from `uuidgen`.
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
+	__u32   fsu_len;
+	__u32   fsu_flags;
+	__u8    fsu_uuid[];
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
+	fsuuid->fsu_len = sizeof(uuid_t);
+	fsuuid->fsu_flags = 0;
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
+		memcpy(&uuid, fsuuid->fsu_uuid, sizeof(uuid));
+		uuid_unparse(uuid, uuid_str);
+		printf("%s\n", uuid_str);
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
+		memcpy(&fsuuid->fsu_uuid, uuid, sizeof(uuid));
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
index 00000000..376f2972
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Google, Inc. All Rights Reserved.
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
+        cd /
+        rm -r -f $tmp.*
+        kill -9 $fsstress_pid 2>/dev/null;
+        wait $fsstress_pid > /dev/null 2>&1
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
+_scratch_mount
+
+# Begin fsstress while modifying UUID
+fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
+$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
+fsstress_pid=$!
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
2.37.0.170.g444d1eabd0-goog

