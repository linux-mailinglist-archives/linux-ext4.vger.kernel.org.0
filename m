Return-Path: <linux-ext4+bounces-8838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39731AFA735
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E185176F52
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4E846F;
	Sun,  6 Jul 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56YkwY8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A01891AB
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826771; cv=none; b=UawraFbIxUVu21IG9taPvV2Nvy6XPDdjcNifQ6jTFPnRQ0qZHPWTnyrVzowHLBsWUbAjHvYYBIIrTjGma5Ppocs8/YqQgRxepc07XRThAyHxEF/uzBO3hiyOQeavhw1dlhz/0pC6m1hogO6YttSP4TXlkArLtrlF/VMzqwbZ0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826771; c=relaxed/simple;
	bh=HH2ZeYlKf6adbD/AupzIOMlW4no7DXzsAvNAHm7Wr94=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEyN53zaVaDWTPZXYblfwCJ6JzFU0zMzdl0yspkv/9NCxf1ot8KRXzrKfKPOVrTul0ampYAP8ZjB61eSSy/dx2klPsd2QdSRnO0bnnXfDPdoQsJEwdebmsomWCfICoEXqvkNmD594eo9u2UKPzL5TpRoZ0I/vpqvoIZpBBQJ//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56YkwY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C357EC4CEED;
	Sun,  6 Jul 2025 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826770;
	bh=HH2ZeYlKf6adbD/AupzIOMlW4no7DXzsAvNAHm7Wr94=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c56YkwY8xBc/yOR15bSGkG0LVBpWJISHseDtay7CU2AgNbCX4hwZYPfIfFBAtaS33
	 Y8BydfYFrYaS+GAwJjiG/Pz7RcvlabInA9rKVVzq8tBKij+Uk1eyaX3xxPvVeSAKT9
	 JfieDb52hXr9gsc6+2iIhXHKtvmNdreBORTKYt8YsRkiCpm7IC1ZOwjC64DBejhUyS
	 5Xj3raKbPB1Mgw+2NMdpJ/iG9MKLEuC9m/L/YF4yAznzWVqx5Q9aXjyYfIkc8TFHQN
	 LZxyPqPTb6XmIPVRX467lwfm2dcVk2NCUIAWzktFcp8PugAdjsGk66K6Mngqaiknm7
	 trpHNo6yiLFJQ==
Date: Sun, 06 Jul 2025 11:32:50 -0700
Subject: [PATCH 8/8] fuse2fs: don't try to mount after option parsing errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175182663113.1984706.10460295274868313866.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Actually check the outcome of parsing CLI options before trying to
mount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ff8aa023d1c555..ab3efea66d3def 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4407,14 +4407,16 @@ int main(int argc, char *argv[])
 	FILE *orig_stderr = stderr;
 	char *logfile;
 	char extra_args[BUFSIZ];
-	int ret = 0;
+	int ret;
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
 		    EXT2_FLAG_RW;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
 
-	fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
+	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
+	if (ret)
+		exit(1);
 	if (fctx.device == NULL) {
 		fprintf(stderr, "Missing ext4 device/image\n");
 		fprintf(stderr, "See '%s -h' for usage\n", argv[0]);


