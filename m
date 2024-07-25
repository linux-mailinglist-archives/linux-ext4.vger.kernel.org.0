Return-Path: <linux-ext4+bounces-3465-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0B93C677
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2A1F22AE5
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC819D8B1;
	Thu, 25 Jul 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGvwnsKz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E119D89E;
	Thu, 25 Jul 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921566; cv=none; b=LaNk2pQLZ1cvHLITSTrVKUUxxop5l8dF1uIJteuMaTBtOeWobmvii/21hbaTIGaxeVxe15dAoT2z1hA76DYJaGn+hrG+rFGO4Yg0cEXTABr4L0PB0+RCaImAzHBEL9+6yloHF33hYSmcei620woH/g0YoSdAdaMzG5v1Alp/98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921566; c=relaxed/simple;
	bh=IAGr9NYUDyHtFfmyrAQwOZnwCCTqbixvZ3E6iLbMYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwESSrJ+yPEJXq/Yfhuv339vfcPxEfajgphU0srMbjoUfVIE5vnRbwMD4fP1tES0fs94wlkV27Utlof8xA/mw/A38YwBT60usnpGVedU3ZNlZemxG14YZVG4QmwVIi5NzC40knQEcWoElXBFV6E8Vo5HDhrYBfnDU0Ws1hI+ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGvwnsKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5C8C4AF07;
	Thu, 25 Jul 2024 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921566;
	bh=IAGr9NYUDyHtFfmyrAQwOZnwCCTqbixvZ3E6iLbMYTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGvwnsKzPD+OO4eXKRENgWBvlIdPP0eatRSqpt1FnlbrREWvnnQHwVtC+39xfoxjU
	 5seld4tcm6WkYF+P94hmsCDsSnysmkigZL2+DckHhzdROpEBaufP0KyxVz6OcslCNT
	 c8LQ0vSfEO1C/HZtHWgZuXCqCy9U4Bl80uA93T0UngKcNRKP4aLyqcFmVfFj1vqez/
	 E7Uq3k7WrWcJd/nF6BfPYCVG16dtq2Kf+fXR/5YUwiUCSAxfE0xeC00Li7+UZgLDIQ
	 GFsTA8vGjQeZgloYAK6nY1MXTQ0B5IKjiiOZSh2dbC/Ek+owzI1f/pIvtAOeAt6hQw
	 ARd4LoUJjpzTA==
From: cel@kernel.org
To: amir73il@gmail.com,
	krisman@collabora.com
Cc: gregkh@linuxfoundation.org,
	jack@suse.cz,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH v5.10.y 1/3] samples: Add fs error monitoring example
Date: Thu, 25 Jul 2024 11:32:27 -0400
Message-ID: <20240725153229.13407-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153229.13407-1-cel@kernel.org>
References: <20240725153229.13407-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 5451093081db6ca1a708d149e11cfd219800bc4c ]

Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
errors.

Link: https://lore.kernel.org/r/20211025192746.66445-31-krisman@collabora.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[ cel: adjusted to squelch a missing file warning on v5.10.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 samples/Kconfig               |   8 ++
 samples/Makefile              |   1 +
 samples/fanotify/Makefile     |   5 ++
 samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

diff --git a/samples/Kconfig b/samples/Kconfig
index e76cdfc50e25..cecd311ff321 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,14 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY
+	help
+	  When enabled, this builds an example code that uses the
+	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
+	  errors.
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index c3392a595e4b..93e2d64bc9a7 100644
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
2.45.2


