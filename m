Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F213EACB6
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhHLVmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 17:42:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45978 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbhHLVmO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 17:42:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 869DF1F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 20/21] samples: Add fs error monitoring example
Date:   Thu, 12 Aug 2021 17:40:09 -0400
Message-Id: <20210812214010.3197279-21-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
errors.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v4:
  - Protect file_handle defines with ifdef guards

Changes since v1:
  - minor fixes
---
 samples/Kconfig               |   9 +++
 samples/Makefile              |   1 +
 samples/fanotify/Makefile     |   5 ++
 samples/fanotify/fs-monitor.c | 138 ++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b0503ef058d3..88353b8eac0b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY
+	help
+	  When enabled, this builds an example code that uses the
+	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
+	  errors.
+	  See also Documentation/admin-guide/filesystem-monitoring.rst.
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index 087e0988ccc5..931a81847c48 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
+obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
new file mode 100644
index 000000000000..e20db1bdde3b
--- /dev/null
+++ b/samples/fanotify/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+userprogs-always-y += fs-monitor
+
+userccflags += -I usr/include -Wall
+
diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
new file mode 100644
index 000000000000..e115053382be
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021, Collabora Ltd.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <err.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/fanotify.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#define FAN_EVENT_INFO_TYPE_ERROR	4
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif
+
+#ifndef FILEID_INO32_GEN
+#define FILEID_INO32_GEN	1
+#endif
+
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
+static void print_fh(struct file_handle *fh)
+{
+	int i;
+	uint32_t *h = (uint32_t *) fh->f_handle;
+
+	printf("\tfh: ");
+	for (i = 0; i < fh->handle_bytes; i++)
+		printf("%hhx", fh->f_handle[i]);
+	printf("\n");
+
+	printf("\tdecoded fh: ");
+	if (fh->handle_type == FILEID_INO32_GEN)
+		printf("inode=%u gen=%u\n", h[0], h[1]);
+	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
+		printf("Type %d (Superblock error)\n", fh->handle_type);
+	else
+		printf("Type %d (Unknown)\n", fh->handle_type);
+
+}
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *metadata;
+	struct fanotify_event_info_error *error;
+	struct fanotify_event_info_fid *fid;
+	char *next;
+
+	for (metadata = (struct fanotify_event_metadata *) buffer;
+	     FAN_EVENT_OK(metadata, len);
+	     metadata = FAN_EVENT_NEXT(metadata, len)) {
+		next = (char *)metadata + metadata->event_len;
+		if (metadata->mask != FAN_FS_ERROR) {
+			printf("unexpected FAN MARK: %llx\n", metadata->mask);
+			goto next_event;
+		} else if (metadata->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			goto next_event;
+		}
+
+		printf("FAN_FS_ERROR found len=%d\n", metadata->event_len);
+
+		error = (struct fanotify_event_info_error *) (metadata+1);
+		if (error->hdr.info_type != FAN_EVENT_INFO_TYPE_ERROR) {
+			printf("unknown record: %d (Expecting TYPE_ERROR)\n",
+			       error->hdr.info_type);
+			goto next_event;
+		}
+
+		printf("\tGeneric Error Record: len=%d\n", error->hdr.len);
+		printf("\terror: %d\n", error->error);
+		printf("\terror_count: %d\n", error->error_count);
+
+		fid = (struct fanotify_event_info_fid *) (error + 1);
+		if ((char *) fid >= next) {
+			printf("Event doesn't have FID\n");
+			goto next_event;
+		}
+		printf("FID record found\n");
+
+		if (fid->hdr.info_type != FAN_EVENT_INFO_TYPE_FID) {
+			printf("unknown record: %d (Expecting TYPE_FID)\n",
+			       fid->hdr.info_type);
+			goto next_event;
+		}
+		printf("\tfsid: %x%x\n", fid->fsid.val[0], fid->fsid.val[1]);
+		print_fh((struct file_handle *) &fid->handle);
+
+next_event:
+		printf("---\n\n");
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+
+	char buffer[BUFSIZ];
+
+	if (argc < 2) {
+		printf("Missing path argument\n");
+		return 1;
+	}
+
+	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
+	if (fd < 0)
+		errx(1, "fanotify_init");
+
+	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
+			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
+		errx(1, "fanotify_mark");
+	}
+
+	while (1) {
+		int n = read(fd, buffer, BUFSIZ);
+
+		if (n < 0)
+			errx(1, "read");
+
+		handle_notifications(buffer, n);
+	}
+
+	return 0;
+}
-- 
2.32.0

