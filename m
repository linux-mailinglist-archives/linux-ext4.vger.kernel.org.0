Return-Path: <linux-ext4+bounces-7466-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E50A9BA04
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F050D16C14A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBC21E087;
	Thu, 24 Apr 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD2kMOmK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B2199949
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530832; cv=none; b=ZneZeDdWzOhI33SpBD9b99VjwY4oIZ1YzzyDFkmyEp0133zfkahWxzBp/Bgo69WAa4sHdTIpgxhdinXBJTAFRNe5tP28OnA2ANYH2A5RI8iEuBMyYZihsVDfbXA2EIamnuFfWvW80qGbvXP1wQlNbbo2KJpHCKJr4mZDxc8ac3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530832; c=relaxed/simple;
	bh=VY5JCV+v9v/DNY1ROSVygzh43bHsJfV5rpSbOUuxrHs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omzXpCmZMphjsgcl/T5KwXkbncR4k7mxCVzhueFyUKp5qylSuAdamxOUzQ2vk27FUjdPSQHmwHsbCViTtj79FCnbItOC4+5QgPArpYSt7mLSuECwfafNYvoWo+1rFjgCgJriE8gk+p2wcueSsEJMYz+KLWMZesDIPxy9TmO7m08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD2kMOmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C682C4CEE3;
	Thu, 24 Apr 2025 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530832;
	bh=VY5JCV+v9v/DNY1ROSVygzh43bHsJfV5rpSbOUuxrHs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aD2kMOmKMD52ep0J2fCDt6Buh3CXhHdTjz9sfqwaHOMfuwjdhyaD1hqpW2Fr1uOym
	 j/MzuqExyc2hwxN5yd73a0NrGQUq6f3ajvMrcLleKe1kk2w4Yy8+F6n2nUWJbzyiM/
	 GevwSYsddBM2Zg20l+LuJV88OWlM9c9cJG0vLFXeJKvf/1S8bGrujIkP6YTmxhcSqN
	 SSZcdimjdquTjtnBN9FdE5r9Nko3vp7O4iNhZWtkXWu3h8Sp07BsCwa21sb4Xz9y37
	 DuTAmD+4IDrkF1vZ56a1FuuLjeQWfP9QZ3ROoTPoz9G5fi0k0GKMF9WpCT+ELAMChM
	 VOjvLTEbz5/Hw==
Date: Thu, 24 Apr 2025 14:40:31 -0700
Subject: [PATCH 2/3] fuse2fs: set fuse subtype via argv[0] if possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064709.1160289.11028230202411857669.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
References: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If argv[0] ends in "ext[0-9]", set the fuse subtype string to this
value.  This enables us to place fuse2fs at some place in the filesystem
like /sbin/mount.ext2 and have /proc/mounts report the filesystem type
as "fuse.ext2".  This is fairly boring, but it'll make it easier to test
things in fstests.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 245d2b3b916686..991a9f6733148d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -26,6 +26,7 @@
 #endif
 #include <sys/ioctl.h>
 #include <unistd.h>
+#include <ctype.h>
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
 #endif
@@ -3812,6 +3813,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	return 1;
 }
 
+static const char *get_subtype(const char *argv0)
+{
+	size_t argvlen = strlen(argv0);
+
+	if (argvlen < 4)
+		goto out_default;
+
+	if (argv0[argvlen - 4] == 'e' &&
+	    argv0[argvlen - 3] == 'x' &&
+	    argv0[argvlen - 2] == 't' &&
+	    isdigit(argv0[argvlen - 1]))
+		return &argv0[argvlen - 4];
+
+out_default:
+	return "ext4";
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -3954,8 +3972,9 @@ int main(int argc, char *argv[])
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
 	/* Set up default fuse parameters */
-	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=ext4,"
+	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
 		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
+		 get_subtype(argv[0]),
 		 fctx.device);
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);


