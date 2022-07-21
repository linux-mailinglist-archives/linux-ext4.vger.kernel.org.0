Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255657D705
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGUWjh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGUWjg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 18:39:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C24260A;
        Thu, 21 Jul 2022 15:39:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g17so3135100plh.2;
        Thu, 21 Jul 2022 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Saler0oAQJPYX4zddU+TlRCbYNU6Rzovx951DlE1T9M=;
        b=PcO3pB3WC0Xr+rAa05QKxhuHMHYl8xOqcxFW1gZ3B5tYbI0Qv9DXS79axdFcDsUH5s
         5cPN+BhlGoD/M7Hs/sVsbApnkU4Wj5jQbwmmXh0i9kpwSMnvMPW45KV1JG48c54gxsOl
         0JENeS6nlelxXHjReh17kppOGHl4Fep0NTLfMWQFsiZNklDZ05Avhy+5lJ8BtHtbN0TS
         Q6KWGvTIwRFflcaLTthgBMhHfGI4/ZBMNL7DUesaP7MM7i9WR9iEaJ6oumLDz6+KkaI/
         j+qZk3kzgtDPg76n5hYVB6IwACSD0SZTfncbOXuhDW0EvEJgtgakvQBw1Vsh5RYeQKcT
         7vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Saler0oAQJPYX4zddU+TlRCbYNU6Rzovx951DlE1T9M=;
        b=SRKcSNaZIgjLkdyCf6pigcWn5F/rkVrpHvAmAJ6DW03PbxhnncrLT24xSDMdijCuIP
         x15ITYEq2DxO4wcUuUw4KLiEgRskAFvh+Ka68d94Z4V/NP6TCT0WdhKOpuj3OzLbuHqv
         UzjdsMo/xOUJMhnW1ulAjy0Z4UTDA3Rb2Lc9TBXUf4LIDn8LtygD9EHZ3bBC2c4F7dEE
         V6B42vYMGCbdPkEl7tP2bp1fQ/nxuJVej0lOUH35mzU6Ga+UTvAdyq1BMwnnfmFK60eR
         0YStil6mEn61iv5h0Aaa7QpIk3Rh1H3VozKMXrt31k4bLk1ZgAyh688dXsAnaBoC6vqv
         Wm8A==
X-Gm-Message-State: AJIora/2Uh4dCk4+kgjGYd9QLM+8MuUN372hUPsV+R25K6tvJIZgqsGE
        G3IChAVTDp9Cfb0viGB/Wl0=
X-Google-Smtp-Source: AGRyM1ska6+maRabzkyRJTmdR3JhiFALpVT4acl8Ruremk4htvXF1mtt58N3dgZ2v+Ksk2QJIAnOMg==
X-Received: by 2002:a17:902:b093:b0:16b:f20f:ee1c with SMTP id p19-20020a170902b09300b0016bf20fee1cmr475410plr.37.1658443175198;
        Thu, 21 Jul 2022 15:39:35 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id r22-20020a170902be1600b0016c408ce56fsm2157487pls.301.2022.07.21.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:39:34 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6] ext4/057: add test for ext4 uuid get/set ioctls during fsstress.
Date:   Thu, 21 Jul 2022 15:39:30 -0700
Message-Id: <20220721223930.436993-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
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

Adds a utility to get/set uuid through ext4 ioctl. Executes the ioctls
while running fsstress. These ioctls are used by tune2fs to safely change
the uuid without racing other filesystem modifications.

Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Changes in v6:

Based on latest "for-upstream" branch.

Removed fsstress_pid from wait command.

Test renamed from ext4/056 to ext4/057.

Added Reviewed-by from Zorro Lang.

 .gitignore         |   1 +
 src/Makefile       |   5 ++-
 src/uuid_ioctl.c   | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057     |  64 +++++++++++++++++++++++++++
 tests/ext4/057.out |   2 +
 5 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 src/uuid_ioctl.c
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/.gitignore b/.gitignore
index 88c79412..c1d75b01 100644
--- a/.gitignore
+++ b/.gitignore
@@ -172,6 +172,7 @@ tags
 /src/unwritten_sync
 /src/uring_read_fault
 /src/usemem
+/src/uuid_ioctl
 /src/writemod
 /src/writev_on_pagefault
 /src/xfsctl
diff --git a/src/Makefile b/src/Makefile
index 7eeb08ef..665edcf9 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,14 +31,15 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe
+	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
+	uuid_ioctl
 
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
diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..4006a07c
--- /dev/null
+++ b/tests/ext4/057
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
+        wait > /dev/null 2>&1
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
diff --git a/tests/ext4/057.out b/tests/ext4/057.out
new file mode 100644
index 00000000..185023c7
--- /dev/null
+++ b/tests/ext4/057.out
@@ -0,0 +1,2 @@
+QA output created by 057
+Silence is golden
-- 
2.37.1.359.gd136c6c3e2-goog

