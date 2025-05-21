Return-Path: <linux-ext4+bounces-8100-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBAFABFFC9
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094561BC0874
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E3239E9C;
	Wed, 21 May 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z22dULuS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7C239E85
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867225; cv=none; b=gcj77Ovql2MYkDXBl3FyU09WXWt3+GtkU2PfOl0f53HunZiyI9kKL6UyN0UHK8EtKJLzUmFqQEG2nRccZ/DzWXmv73z7TLfTokdZUEliLUBXvbwuXeHvXRL+83iDS7KQFsVWZXPh1K9bC9WrpjHcFAdAZT5pP5jOJlkXIKVqrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867225; c=relaxed/simple;
	bh=vGBAA3/n77rjKrxgonpDyR42yQ//j+YoP4BHK8Fm7DQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3jGCHtJ1SwIZSyDUxaDN5o6wQt6IeefsKDDXzh0XwQp6+TrNNqHdQEqIuzANZGeYcakvU6SJyCNhX8uMmORrcNj1OfKrmsoWjXQf6D1vShOodPIV3asnaLitBTLYAOFHlcpJZV8N3ee/RCU+ivvxDpOFMT4tRfrkiaK693vBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z22dULuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67950C4CEE4;
	Wed, 21 May 2025 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867224;
	bh=vGBAA3/n77rjKrxgonpDyR42yQ//j+YoP4BHK8Fm7DQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z22dULuSslJy/vCbNSp3SM4AFPzu5HG7bMncRtt43ZJiNzLTxmQ0cNtX0HVwIwoP8
	 KuWzcx9UOIuoVtCGSnaaqMUm/iZVm3m383bTJK0hy+B++fMTF4NeXUMAuSsG7RLUc4
	 2C1q8DY+802gbeGpwhYjwx2pRv4HugPm1FcAggGHEZk2YYaK/WiEOyMUDxK/nixlSL
	 B3n7a2zOKwJ9Ob2SnjbE/9b8tU5XtoRAllLCoT3CLcOyrz1uUpe9v2dF+Vo3PJ8GVl
	 Ub0PkV2pIS3k6NnUj0BPsYtaUi3DhmjXkAVaHKXJsSieqnAnVlI30glhk95a4wwF31
	 SVkk4tmF1WcCQ==
Date: Wed, 21 May 2025 15:40:23 -0700
Subject: [PATCH 21/29] fuse2fs: decode fuse_main error codes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677923.1383760.3429767121128890204.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Translate the fuse_main return values into actual mount(8) style error
codes instead of returning 0 all the time, and print something to the
original stderr if something went wrong so that the user will know what
to do next.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 52c24715fbc109..4d4eaedfc33e1f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4072,6 +4072,7 @@ int main(int argc, char *argv[])
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 	struct fuse2fs fctx;
 	errcode_t err;
+	FILE *orig_stderr = stderr;
 	char *logfile;
 	char extra_args[BUFSIZ];
 	int ret = 0;
@@ -4289,11 +4290,43 @@ int main(int argc, char *argv[])
 	}
 
 	pthread_mutex_init(&fctx.bfl, NULL);
-	fuse_main(args.argc, args.argv, &fs_ops, &fctx);
+	ret = fuse_main(args.argc, args.argv, &fs_ops, &fctx);
 	pthread_mutex_destroy(&fctx.bfl);
 
-	ret = 0;
+	switch(ret) {
+	case 0:
+		/* success */
+		ret = 0;
+		break;
+	case 1:
+	case 2:
+		/* invalid option or no mountpoint */
+		ret = 1;
+		break;
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+		/* setup or mounting failed */
+		ret = 32;
+		break;
+	default:
+		/* fuse started up enough to call op_init */
+		ret = 0;
+		break;
+	}
 out:
+	if (ret & 1) {
+		fprintf(orig_stderr, "%s\n",
+ _("Mount failed due to unrecognized options.  Check dmesg(1) for details."));
+		fflush(orig_stderr);
+	}
+	if (ret & 32) {
+		fprintf(orig_stderr, "%s\n",
+ _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
+		fflush(orig_stderr);
+	}
 	if (global_fs) {
 		err = ext2fs_close(global_fs);
 		if (err)


