Return-Path: <linux-ext4+bounces-11571-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A0C3D9E3
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296893A759F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848F30DED7;
	Thu,  6 Nov 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGT5fZMB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2353074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468457; cv=none; b=W7SDV7CFJzLLfeRmoVQ7Ti9vLgrX2OSVMHcnUoRdk2O6JiSYcZamNNXNJwLrnGKuQjGTN5RaEOADbhbDqcuGUnQKoYUT0h3uO3dQ3MIvjtpxyVYNwrTezLjEABNGDT+8RtnXqVTquWiUhelfKvUGHXCXEJTwGXQMDqME5HQuNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468457; c=relaxed/simple;
	bh=PI5byXd2mlwOKFZSY8BQN7rPzjD8xvSNsnyf/nHXu9M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKSpVqaWQUS3fbxpjlCZrJcf3YOMTvj5pfzquxC2CuMkOEca2th4u2Ye6ZBXvlv2374z4c70zlZ1/vLJV0gD8GRCKjmhVXcdKGqkcqW/2Xc+xBx3uFWy9UFcsr+SNsUC40rBtYeuz7+CH7WHwBbygx99+WAIPFM2mezyHVrcrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGT5fZMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D3BC4CEFB;
	Thu,  6 Nov 2025 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468456;
	bh=PI5byXd2mlwOKFZSY8BQN7rPzjD8xvSNsnyf/nHXu9M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FGT5fZMBtWw+9ZK8hXVFWrmdEMwsB2JbEtGEv6nXHoUoihhjiDcY4YrIoIbILdYoH
	 QmX68AZBqRTJR6y7xkZdk41IEVSMOkiSutswI5NkAxbeCjaGBWXHjl/jcEwOWQx4UV
	 vJWVt+ExF6YpPd6EXG4j5KuWH888n2EXmDCneqn6OwDC8kggL8Fy8O3tMv1vqHdxX/
	 6IPBfIdBcZhCiyPpd0MCLESpWRZnmChIkJPMS/bnU0JAyNvNpt8iU3IjbspiDghmwg
	 B6mbTfCo1BxTMFl6HgErsDazFoeuLljQBAGQ6g3QptQ7Y0hn5oZdd9yGyoWH8I+ofd
	 CrkOcrf0Up/Eg==
Date: Thu, 06 Nov 2025 14:34:16 -0800
Subject: [PATCH 12/19] fuse2fs: only flush O_SYNC files on close
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793845.2862242.10475710215307901590.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
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
index 0b4f7f10ddc97f..4af22ea9e0d3a3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3059,11 +3059,15 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
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
 


