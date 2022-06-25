Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69955A856
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jun 2022 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiFYIxl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jun 2022 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiFYIxj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jun 2022 04:53:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131C20BE2;
        Sat, 25 Jun 2022 01:53:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s185so4520375pgs.3;
        Sat, 25 Jun 2022 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+S5lWO2xuJbiADTUfpb0PUnWieA1/9PRWqfftZkSMo=;
        b=V7z9tGzpmQDCfMQQ1+DAv4aguCUqpmPR8n70GXzD3BK6Zi93YRMUGiQdIZ2FWawJOJ
         SHNEb7rl6JdzeRn0jc1f9/YHKY99/T4mlp7ltI+x/IwDVjcS55tRp4kLhHOrujcwll+9
         hcA//G7pS6IpdnvMaJZsPKzZ+887u1hqqPClnL+/JABbB5zxec9w11iD49lESBTXqfpF
         c06CvAT83mxe1HbUOrlX4VLhzMOdPapqqqQ0eWohW0dI0ql4k1ZrGrM7o5BViPYXFEt7
         nDzhUz9ltseqSVHNZx2qD1VGA4OYkbsYlWVaU66hBUX8yaP8zs/8AF7SQzddKPjRpzrl
         50CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+S5lWO2xuJbiADTUfpb0PUnWieA1/9PRWqfftZkSMo=;
        b=ZO7kRg94sHPS1G8HBXJcc2yeQ6hqU/sb94psK0be8AOC4MLLbKDq0Tq4NbChhMn//1
         47qJmnVXGhSOBikXcL8kLihw7FldImW6hwouw0GjcDILF7r27dsUM4qBjcCXT/89GQjt
         NH9zwY+MMOU83Z+WLHaEScYyv3X1X25ZgC1Jo1Fa4eBB/eIufKVcxFymdKqwjOVgKxaE
         bxrq0/j2oJo8C9KJixHSbLv5Buc5+VJ9S9y/OKnM6uS5e4ULtB+RrocVGhs4TtN1vo52
         HuvR57umcOfr8zuasphjfauh6N8iNVVLC9j33JP60QjapxLCAIiQ8kQeOBT+4fF3MGCh
         bVng==
X-Gm-Message-State: AJIora96So6sXpek+uYOTR1ChSOmDmNjlLolmgVMNjiOMTZIZrXX5JvY
        0S7MIAv7ymjdKf2KuQSsBSg=
X-Google-Smtp-Source: AGRyM1t1lwMkjOCzpoGpWnIS4SnmCuGXlb9JhgYh1otYQACi75Vn/itXEt5boeMGQIFz2V0kWE2j2w==
X-Received: by 2002:a63:1209:0:b0:3fc:e453:5424 with SMTP id h9-20020a631209000000b003fce4535424mr2869043pgl.131.1656147218192;
        Sat, 25 Jun 2022 01:53:38 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id l10-20020a17090a660a00b001ec7c8919f0sm5234656pjj.23.2022.06.25.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:53:37 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH] ext4/056: add a check to make sure ext4 uuid ioctls get/set during fsstress.
Date:   Sat, 25 Jun 2022 01:53:21 -0700
Message-Id: <20220625085321.109451-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
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

Adds a utility to get/set uuid through ext4 ioctl. Executes the ioctls while
running fsstress. These ioctls are used by tune2fs to safely change the uuid
without racing other filesystem modifications.

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---
 src/Makefile       |   4 +-
 src/global.h       |   2 +
 src/uuid_ioctl.c   | 106 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056     |  59 +++++++++++++++++++++++++
 tests/ext4/056.out |   1 +
 5 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 src/uuid_ioctl.c
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

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
diff --git a/src/global.h b/src/global.h
index b4407099..747d95f8 100644
--- a/src/global.h
+++ b/src/global.h
@@ -184,4 +184,6 @@ roundup_64(unsigned long long x, unsigned int y)
 	return rounddown_64(x + y - 1, y);
 }
 
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+
 #endif /* GLOBAL_H */
diff --git a/src/uuid_ioctl.c b/src/uuid_ioctl.c
new file mode 100644
index 00000000..51480689
--- /dev/null
+++ b/src/uuid_ioctl.c
@@ -0,0 +1,106 @@
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
+#include "global.h"
+
+struct fsuuid {
+        size_t len;
+        __u8 *b;
+};
+
+#ifndef EXT4_IOC_GETFSUUID
+#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
+#endif
+
+#ifndef EXT4_IOC_SETFSUUID
+#define EXT4_IOC_SETFSUUID      _IOW('f', 45, struct fsuuid)
+#endif
+
+int main(int argc, char **argv)
+{
+	int	error, fd;
+        struct fsuuid fsuuid;
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
+	BUILD_BUG_ON(sizeof(uuid_t) % 16);
+	fsuuid.len = 16;
+	fsuuid.b = calloc(fsuuid.len, sizeof(__u8));
+
+	if (strcmp(argv[1], "get") == 0) {
+		uuid_t uuid;
+		char uuid_str[37];
+
+		if (ioctl(fd, EXT4_IOC_GETFSUUID, &fsuuid)) {
+			close(fd);
+			fprintf(stderr, "%s while trying to get fs uuid\n",
+				strerror(errno));
+			return 1;
+		}
+
+		memcpy(&uuid, fsuuid.b, sizeof(uuid));
+		uuid_unparse(uuid, uuid_str);
+		printf("%s", uuid_str);
+	} else if (strcmp(argv[1], "set") == 0) {
+		if (argc != 4) {
+			fprintf(stderr, "UUID argument missing.\n");
+			return 1;
+		}
+
+		if (strlen(argv[3]) != 36) {
+			fprintf(stderr, "Invalid UUID. The UUID should be in "
+				"canonical format. Example: "
+				"8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
+			return 1;
+		}
+
+		uuid_t uuid;
+		error = uuid_parse(argv[3], uuid);
+		if (error < 0) {
+			fprintf(stderr, "%s: invalid UUID.\n", argv[0]);
+			return 1;
+		}
+
+		memcpy(fsuuid.b, uuid, sizeof(uuid));
+		if(ioctl(fd, EXT4_IOC_SETFSUUID, &fsuuid)) {
+			close(fd);
+			fprintf(stderr, "%s while trying to set fs uuid\n",
+				strerror(errno));
+			return 1;
+		}
+	} else {
+		fprintf(stderr, "Invalid command\n");
+	}
+
+	close(fd);
+	return 0;
+}
diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..46631d46
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+# Test the set/get UUID ioctl.
+#
+
+. ./common/preamble
+_begin_fstest auto ioctl resize
+
+tmpfile="/tmp/$$."
+trap "rm -f $tmpfile; exit" 0 1 2 3 15
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_require_scratch
+_require_test_program uuid_ioctl
+
+UUID_IOCTL=$here/src/uuid_ioctl
+
+# if the ioctl is not supported by the kernel, then skip test.
+current_uid=$($UUID_IOCTL get $SCRATCH_MNT)
+if [[ "$current_uid" = "Inappropriate ioctl for device while trying to set fs uuid" ]]; then
+  _notrun "UUID ioctls are not supported by kernel."
+fi
+
+# Create filesystem and mount
+_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full
+
+# Begin fsstress while modifying UUID
+fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
+"$FSSTRESS_PROG" $fsstress_args > /dev/null &
+
+test_uuid_ioctl()
+{
+  for n in $(seq 1 20); do
+    new_uuid=$(uuidgen)
+
+    echo "Setting UUID to ${new_uuid}" >> $seqres.full 2>&1
+    $UUID_IOCTL set $SCRATCH_MNT $new_uuid >> $seqres.full 2>&1
+
+    current_uuid=$($UUID_IOCTL get $SCRATCH_MNT)
+    echo "$UUID_IOCTL get $SCARTCH_MNT: $current_uuid" >> $seqres.full 2>&1
+    if [[ "$current_uuid" != "$new_uuid" ]]; then
+      echo "UUID does not equal what was sent with the ioctl"
+      exit
+    fi
+  done
+}
+
+test_uuid_ioctl
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/056.out b/tests/ext4/056.out
new file mode 100644
index 00000000..06f52bb4
--- /dev/null
+++ b/tests/ext4/056.out
@@ -0,0 +1 @@
+QA output created by 056
-- 
2.37.0.rc0.161.g10f37bed90-goog

