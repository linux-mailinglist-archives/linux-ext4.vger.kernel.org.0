Return-Path: <linux-ext4+bounces-10071-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A71B587B4
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634AC1B25868
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8722D5925;
	Mon, 15 Sep 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ2vbO1H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7173292B44
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976160; cv=none; b=hj0lZRnVuCA/4p0J+pwmSgn/yk75zeCFRqK8aGVAN7t9LxCGc4tHzbsczd64S7E5ewZH5ljFTjslNPa8us/dauTfMYDOr87mLGuOj74GWNEz8vKKjswp9sH52YITTeXNZ+j3z1sidaMkPxQDUqshWyZX/W8L448cAmqNF08MLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976160; c=relaxed/simple;
	bh=XPPMG5vxMC0iusutEA53qfY/zEynYStWGY0ZjRBFL9w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHALZm76XVsweYUzahYnlwH+xJRF3PMAxfjgiTpdywF2aW6ziWjNGSkuRSEPjf2UTp+607AxezperEjj3OKgujlRmJIoo+b1FIA5SLS5+Jbz6cFRgCAX2bXlLV87sy2ImOjSGknW8RaiDzrPXYEVNUIkoBqL5ekPBgpaJXPJedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ2vbO1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B979C4CEF1;
	Mon, 15 Sep 2025 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976160;
	bh=XPPMG5vxMC0iusutEA53qfY/zEynYStWGY0ZjRBFL9w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JZ2vbO1HcLkkbsFLb3qu4mMBEsGLnq2mb0gBBX+8Fxs6ykG8c0179IIDH0qpiJARw
	 kgS+co3ZQXZYeDtAjA2FYp5Pf1mGPZvpDlvjDMxm/pVKPGGy1RzVkDcKt4sv4CTv/k
	 d0fxZynVkv4Po1xgSv9si+DzFBcHHo4/vb3KFrk0OxwKh1XY7yXGF/kexxFLXaobnk
	 0+u90jxxnapnkVTsPTMkUvjZ8fnmieo9mgkbvDjc3K7mkIWrbqlGISV3VfhvNnQ51K
	 00OXoldOJz+0+rTWAxwxIOAUXKdYAZgD+qWB1q286ykD/OvZjNJnciMrxZyExVo9tL
	 H5CPKdP3OB2xA==
Date: Mon, 15 Sep 2025 15:42:40 -0700
Subject: [PATCH 07/11] fuse2fs: only flush O_SYNC files on close
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570139.246189.6216125042320500531.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't call ext2fs_flush2() from op_release unless the file was opened
with either synchronous write flag.

XXX: Maybe this should be replaced with actual incore state tracking for
inodes?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0e973b53653be0..5409b288a025cf 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2979,11 +2979,15 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
-	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
+
+	if ((fp->flags & O_SYNC) &&
+	    fs_writeable(fs) &&
+	    (fh->open_flags & EXT2_FILE_WRITE)) {
 		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
+
 	fp->fh = 0;
 	pthread_mutex_unlock(&ff->bfl);
 


