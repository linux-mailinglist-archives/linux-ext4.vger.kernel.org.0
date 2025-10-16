Return-Path: <linux-ext4+bounces-10894-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88468BE44EC
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0C93A251F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F034BA21;
	Thu, 16 Oct 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADkFwJaI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EF1607AC
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629219; cv=none; b=XnNItrDaP1Af/nL83+jGUgzAmvH701K1kuKBfoXnnsVduPDmCKgiyjcm0XCB83MmkvVmYa389fx0rlYExmGtp46kW46Fy3Iix0M5UPqUqEUVXzl3/NE201paZo2Siscjg7wGLZvdqo7UxoLrAMHzo+jgYC/aXzqdLB7cI3MWx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629219; c=relaxed/simple;
	bh=r+YysSLmhZgbQU1W61N7rL0NvHp5qXjJGT+qPwNJ2pE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCwlwQlzA068pc3MbrphrMtf2e8HLAqrRm7wBDg8K+XbQJrKf87+B8tgEIySTcNOhcWJEioYfAynyxOnLyYDM4i82Nbt0tQH7Cj0KTgG5Pwjz1ZCme0itRA68xDygt+7dQWfRRK7tvOw8+BcvmOr3tQoXvqVsRC0QJG5fvmRJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADkFwJaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089E3C4CEF1;
	Thu, 16 Oct 2025 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629219;
	bh=r+YysSLmhZgbQU1W61N7rL0NvHp5qXjJGT+qPwNJ2pE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ADkFwJaI1B4TaYc1ML4E/2FgMfjjiGmHsmopj+OzzzDf256hEd9azgseRp9jjI8Yu
	 kAbkrQCc5pIHen6ETS5nNQR+En3YeqHHI4Qem/+Z07IlTG88x0FRG0JZtxDav3tWPM
	 U+BmMQuB37eJ41kj2dKcf+q4O+fy3BTPHFWn0txA3ZYbFbbHsWwuwKskz2K/niS5JQ
	 ZT5nKdT1C40mMSfC4bAG+veFug+GlEr+rmwJ7t6swW3k2UqueNxF5QJjFLkE8fqBkE
	 djiri48gUgt9AjZ5zfiiUpzwjJ5tV3tRIIWbPQrNgsKx/ZgSQ2RWeazIikff8wh4O6
	 Jd8QgXNaqM2Pg==
Date: Thu, 16 Oct 2025 08:40:18 -0700
Subject: [PATCH 02/16] libext2fs: use F_GETFL, not F_GETFD, in unixfd_open
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915501.3343688.14285477097185830572.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

F_GETFD is the fcntl command that returns FD_* flags, but the callsite
wants to look at the O_* flags.  F_GETFL is the fcntl command that
returns the O_* flags, so change the subcommand to be correct.

Cc: <linux-ext4@vger.kernel.org> # v1.43.2
Fixes: 4ccf9e4fe165cf ("libext2fs: add unixfd_io_manager")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index cb408f51779aa7..adbdd5f6603d74 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1086,7 +1086,7 @@ static errcode_t unixfd_open(const char *str_fd, int flags,
 
 	fd = atoi(str_fd);
 #if defined(HAVE_FCNTL)
-	fd_flags = fcntl(fd, F_GETFD);
+	fd_flags = fcntl(fd, F_GETFL);
 	if (fd_flags == -1)
 		return EBADF;
 


