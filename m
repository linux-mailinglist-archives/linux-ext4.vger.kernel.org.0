Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814E6432AFB
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 02:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJSAG4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Oct 2021 20:06:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSAGz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Oct 2021 20:06:55 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 657B11F4321E;
        Tue, 19 Oct 2021 01:04:42 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 31/32] samples: Add fs error monitoring example
Date:   Mon, 18 Oct 2021 21:00:14 -0300
Message-Id: <20211019000015.1666608-32-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
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
 samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
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
index 000000000000..a0e44cd31e6f
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,142 @@
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
+#define FAN_EVENT_INFO_TYPE_ERROR	5
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
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buffer;
+	struct fanotify_event_info_header *info;
+	struct fanotify_event_info_error *err;
+	struct fanotify_event_info_fid *fid;
+	int off;
+
+	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
+
+		if (event->mask != FAN_FS_ERROR) {
+			printf("unexpected FAN MARK: %llx\n", event->mask);
+			goto next_event;
+		}
+
+		if (event->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			goto next_event;
+		}
+
+		printf("FAN_FS_ERROR (len=%d)\n", event->event_len);
+
+		for (off = sizeof(*event) ; off < event->event_len;
+		     off += info->len) {
+			info = (struct fanotify_event_info_header *)
+				((char *) event + off);
+
+			switch (info->info_type) {
+			case FAN_EVENT_INFO_TYPE_ERROR:
+				err = (struct fanotify_event_info_error *) info;
+
+				printf("\tGeneric Error Record: len=%d\n",
+				       err->hdr.len);
+				printf("\terror: %d\n", err->error);
+				printf("\terror_count: %d\n", err->error_count);
+				break;
+
+			case FAN_EVENT_INFO_TYPE_FID:
+				fid = (struct fanotify_event_info_fid *) info;
+
+				printf("\tfsid: %x%x\n",
+				       fid->fsid.val[0], fid->fsid.val[1]);
+				print_fh((struct file_handle *) &fid->handle);
+				break;
+
+			default:
+				printf("\tUnknown info type=%d len=%d:\n",
+				       info->info_type, info->len);
+			}
+		}
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
2.33.0

