Return-Path: <linux-ext4+bounces-7473-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69639A9BA0B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC16B935
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA221FF2C;
	Thu, 24 Apr 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmvIYlKs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F781F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530942; cv=none; b=kUdLcaJuY0QqBN/QdnGeWnBXGNTG0SPZ9Z+SWxb0FzLLIRg3n1rIaTQKvl05Wk7JlfvXpz6WJSprzlKiW8KA3U+DoVNov3qy1dBdW+IXrWy0kSorIMe5oUSYzXAetdIt92QXyAgts0Tg6Hbsr+lpu51h3rKuu0AZqHyMh0RCge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530942; c=relaxed/simple;
	bh=zJWCn8dBm22R53cf3QymTm7R9y/cFHogHseBh1pO7AY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUqE76gzXNK92ZVHEUXu3+i+AzZVHAw9w3bMnYeFEv1F1LDfRLJ+dc+uN5vkLV4c7IiyjKOn4Y1xR+nB+7XxQSKlYzjzpiDGKz04mQ8CnEmTDOTotQQc08a44hg57DpLw96UKG1rnYvjn5+DrHL2X54bIosb8ApvVYcEjLx6SzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmvIYlKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB67C4CEE3;
	Thu, 24 Apr 2025 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530941;
	bh=zJWCn8dBm22R53cf3QymTm7R9y/cFHogHseBh1pO7AY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LmvIYlKsMrTbNyWRyeDZPjRUz2ADd1fmqEGmf3O8iTPO5bPLU/EvUo5Ms5JwLM9iR
	 G2Az/cMEl0D2gQzhFKR05+hISYosSphszdtscQeazEzWPeWJZ7eYJGz+zoT/vn/tAD
	 cCHDucdewd3WeQMMGGAFbGB1jQz2S3x4QXzq6CjbmWwce31L7lp8JUk4WJxDup6tQv
	 mEvVXjkGN2Ls1MIbYPWxGsLNHaucNVisAcxmg9vzwjuc4pxZ92BZQ+4RP5DSnFdiyW
	 BsDGqmKETn0QJqU9+jCwSpV4lSoVpx19RlQz1tFXu1kG8rVd8wv9GSihIm6NsV8R0z
	 pu3eMS+LWBZtQ==
Date: Thu, 24 Apr 2025 14:42:20 -0700
Subject: [PATCH 06/16] fuse2fs: add an easy option for emulating kernel access
 behaviors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065033.1160461.1393760776420459221.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

By default, fuse doesn't allow processes with a uid/gid that don't match
those of the server process to access the fuse mount, it doesn't allow
suid files or devices, and it relies on the fuse server to perform
permissions checking.  This is a secure default for very untrusted
filesystems, but it's possible that we might actually want to allow
general access to an ext4 filesystem as part of containerizing the ext4
metadata parsing.  In other words, we want the kernel access control
behavior.

Add an "kernel" mount option that moves most of the access permissions
interpretation back into the kernel, and logs mount/unmount/error
messages to dmesg.  Right now this is mostly useful for fstests, so we
leave it off by default.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.1.in |    9 +++++++++
 misc/fuse2fs.c    |   30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)


diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 1a0c9d54f5893a..517c67ff719911 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -53,6 +53,15 @@ .SS "fuse2fs options:"
 .TP
 \fB-o\fR fuse2fs_debug
 enable fuse2fs debugging
+.TP
+.BR -o kernel
+Behave more like the kernel ext4 driver in the following ways:
+Allows processes owned by other users to access the filesystem.
+Uses the kernel's permissions checking logic instead of fuse2fs's.
+Enables setuid and device files.
+Note that these options can still be overridden (e.g.
+.I nosuid
+) later.
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f499231dd04c94..d56d51207d1f25 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -52,6 +52,7 @@
 #endif
 
 #include "../version.h"
+#include "uuid/uuid.h"
 
 #ifdef ENABLE_NLS
 #include <libintl.h>
@@ -156,6 +157,7 @@ struct fuse2fs {
 	int fakeroot;
 	int alloc_all_blocks;
 	int norecovery;
+	int kernel;
 	unsigned long offset;
 	unsigned int next_generation;
 };
@@ -556,6 +558,13 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (err)
 			translate_error(fs, 0, err);
 	}
+
+	if (ff->kernel) {
+		char uuid[UUID_STR_SIZE];
+
+		uuid_unparse(fs->super->s_uuid, uuid);
+		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
+	}
 }
 
 static void *op_init(struct fuse_conn_info *conn
@@ -589,6 +598,13 @@ static void *op_init(struct fuse_conn_info *conn
 	}
 	if (ff->debug)
 		cfg->debug = 1;
+
+	if (ff->kernel) {
+		char uuid[UUID_STR_SIZE];
+
+		uuid_unparse(fs->super->s_uuid, uuid);
+		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
+	}
 	return ff;
 }
 
@@ -3506,6 +3522,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("no_default_opts",	no_default_opts,	1),
 	FUSE2FS_OPT("norecovery",	norecovery,		1),
 	FUSE2FS_OPT("offset=%lu",	offset,			0),
+	FUSE2FS_OPT("kernel",		kernel,			1),
 
 	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
@@ -3551,6 +3568,8 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o offset=<bytes>      similar to mount -o offset=<bytes>, mount the partition starting at <bytes>\n"
 	"    -o norecovery          don't replay the journal\n"
 	"    -o fuse2fs_debug       enable fuse2fs debugging\n"
+	"    -o kernel              run this as if it were the kernel, which sets:\n"
+	"                           allow_others,default_permissions,suid,dev\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -3636,6 +3655,13 @@ int main(int argc, char *argv[])
 		}
 		stderr = fp;
 		stdout = fp;
+	} else if (fctx.kernel) {
+		/* in kernel mode, try to log errors to the kernel log */
+		FILE *fp = fopen("/dev/ttyprintk", "a");
+		if (fp) {
+			stderr = fp;
+			stdout = fp;
+		}
 	}
 
 	/* Will we allow users to allocate every last block? */
@@ -3762,6 +3788,10 @@ int main(int argc, char *argv[])
 #endif
 	}
 
+	if (fctx.kernel)
+		fuse_opt_insert_arg(&args, 1,
+ "-oallow_other,default_permissions,suid,dev");
+
 	if (fctx.debug) {
 		int	i;
 


