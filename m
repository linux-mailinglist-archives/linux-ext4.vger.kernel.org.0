Return-Path: <linux-ext4+bounces-11594-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B36C3DA40
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AF8188750A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05330B51B;
	Thu,  6 Nov 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvvPheaq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1F2DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468824; cv=none; b=q9kaI+q3Ksuc+kmBlUWOMgpskX640aZrRRshnPiiuFgVnBR08SHlFMajqW8wkjWhRXnzYnHmW+YhU5UUgWnOp5zeP8G7lMtxu+mbpYqzUTcIX7GC3J1596Ux/SHTk6L5i+eV2CTkPEWG8bEhqFQ8Cz6pZ1Fyh2svBBHZVjf5HpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468824; c=relaxed/simple;
	bh=6K0yvrSh9xqqPt4f1XheSbN0fYAgvDByk1Xfzp9q4wQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv0B8qfxp2PJafpsir5vBj7mTaHQOqpj2yfVsdQd4c/Gfkwir5bj6eyClRRsY7+9LilB08eTdouencwH3efNK9fvUSvGRs10ZkmUWSsd8yd46rgEqx1FRTZfmeu1/WgnOyNLWovG7X4b0zh7cna9C/lpxeTQfX1uPaInqwdo6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvvPheaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E210C4CEF7;
	Thu,  6 Nov 2025 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468824;
	bh=6K0yvrSh9xqqPt4f1XheSbN0fYAgvDByk1Xfzp9q4wQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nvvPheaqAT9EH0okKNdokA5vFB0T/tlgomzNOReBPNkl5jv07pwMlM/2JlPxwWp44
	 TMIUyMb1XkSMtq+lITidKvJ9HbcmZlwhsIr1Qk3xGdqfhUzdC1Q0bCfF+0khQamUi7
	 ovq8VA1Ee3c8D18WejX/59D8VSLWMtsWMI7/f+0K4i/o4o9xNmQBWbGMwh3be5z3pr
	 yVZmeWV8Fy1bBKfDZ7VPRMUYIMseoZeZ+uTNpPkk6yPIRcGeVxWt7Tgykf5tAirI5e
	 QnL7gBVXFgQIfpJC+im9YfZxTuaV8wgutaFHZKL2vZO/U/irlIYs1TNVxUyWTbDR6U
	 J3tFTBinMW1wg==
Date: Thu, 06 Nov 2025 14:40:23 -0800
Subject: [PATCH 1/4] fuse2fs: hook library error message printing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794862.2863722.6964153052378988422.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
References: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hook the com_err library so that error messages coming from libext2fs
such as:
Illegal block number passed to ext2fs_test_block_bitmap #9462 for block bitmap for /dev/sda

are actually printed with the standard "FUSE2FS (sda):" prefix.
Libraries shouldn't be printing that kind of stuff, but it is what it
is, and what it is is against the normal conventions.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d6be5e9968567c..c2896de2316bce 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -201,6 +201,8 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
+const char *err_shortdev;
+
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
 int journal_enable_debug = -1;
 #endif
@@ -5522,6 +5524,18 @@ static void try_adjust_oom_score(struct fuse2fs *ff)
 	fclose(fp);
 }
 
+static void fuse2fs_com_err_proc(const char *whoami, errcode_t code,
+				 const char *fmt, va_list args)
+{
+	fprintf(stderr, "FUSE2FS (%s): ", err_shortdev ? err_shortdev : "?");
+	if (whoami)
+		fprintf(stderr, "%s: ", whoami);
+	fprintf(stderr, "%s ", error_message(code));
+        vfprintf(stderr, fmt, args);
+	fprintf(stderr, "\n");
+	fflush(stderr);
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -5551,6 +5565,10 @@ int main(int argc, char *argv[])
 	else
 		fctx.shortdev = fctx.device;
 
+	/* capture library error messages */
+	err_shortdev = fctx.shortdev;
+	set_com_err_hook(fuse2fs_com_err_proc);
+
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_CTYPE, "");
@@ -5650,6 +5668,8 @@ int main(int argc, char *argv[])
 	}
 	fuse2fs_mmp_destroy(&fctx);
 	fuse2fs_unmount(&fctx);
+	reset_com_err_hook();
+	err_shortdev = NULL;
 	if (fctx.device)
 		free(fctx.device);
 	pthread_mutex_destroy(&fctx.bfl);


