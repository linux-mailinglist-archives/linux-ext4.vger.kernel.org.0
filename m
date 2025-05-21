Return-Path: <linux-ext4+bounces-8085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91BABFFA6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3667A6AAF
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971823958D;
	Wed, 21 May 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqmgLnhr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7092B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866989; cv=none; b=MTvsQIRJRs6Z1RKrAOC2u8hJW11HZ9/19AjYRIyIqsyIjeorGb1ud80Jn3pFOWreqdxLAqHPLgos94KMVyu1pguHXq+z68cQbkmi0wb6nNvizhJaSoirVBKb8yXTdDTf41MQanQb4MStLrNQ6Z3cSWqF+/6AEAaCJPhCod/qQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866989; c=relaxed/simple;
	bh=EawKB3HY+ODyrK44H/M6GdSIlK5TXAWaCAHt7ZiwUwk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv+wfkkbFh3m3k55HqjQ4ODBlFDDhH+/sQutL+kivhCbpoLdm6iVxzamvf32CFNQNxHjbfKzUyTqCrNY4SJgGTLE2H6E2S4uxBlQy08d+NVwlROMZAsdMeR1GEnHF/SI6JC68ikoLZFQkDM3flibWFM20GABh5wDTNzNb7IXNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqmgLnhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFBEC4CEE4;
	Wed, 21 May 2025 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866989;
	bh=EawKB3HY+ODyrK44H/M6GdSIlK5TXAWaCAHt7ZiwUwk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dqmgLnhrarn82kWJP2+PlbPelHGaQxrd/Y0hJFV8slH3Y+tOqtjwRSEZ9ptdoSsy4
	 zn5kz4kLT5Rz4axLcG31+fc0vHZEREuT8+O5xW/dVm7D1YakzF9UBf/IWLgJGsrnJ/
	 yMg6rOlTLzG1uLb7Y3URrtISx1D18Njn7IGjXiSZCQxwOBvhlc99mePJuMev95d6cd
	 aZykf7hgHk7XQphsgHLrJVOQh3TsiS0imnglKsAvcpCOf2p/Rk6ZcFzo655eMPmjou
	 x0J6s00pcPW8GiG1gtjGcP760LlYpIffKYbVjav7ni+SJHjjSBmz249R3V3k3nV2Eg
	 EdqeQhIwyQjTw==
Date: Wed, 21 May 2025 15:36:28 -0700
Subject: [PATCH 06/29] fuse2fs: support XATTR_CREATE/REPLACE in setxattr
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174786677657.1383760.12232239908991346763.stgit@frogsfrogsfrogs>
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

Fix the setxattr implementation to support the create and replace flags
instead of performing an upsert regardless of inputs.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 40bb223d50c4fe..33f72cf08f7b3a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2507,7 +2507,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 
 static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		       const char *key, const char *value,
-		       size_t len, int flags EXT2FS_ATTR((unused)))
+		       size_t len, int flags)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
@@ -2517,6 +2517,9 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	errcode_t err;
 	int ret = 0;
 
+	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
+		return -EOPNOTSUPP;
+
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
@@ -2551,6 +2554,31 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		goto out2;
 	}
 
+	if (flags & (XATTR_CREATE | XATTR_REPLACE)) {
+		void *buf;
+		size_t buflen;
+
+		err = ext2fs_xattr_get(h, key, &buf, &buflen);
+		switch (err) {
+		case EXT2_ET_EA_KEY_NOT_FOUND:
+			if (flags & XATTR_REPLACE) {
+				ret = -ENODATA;
+				goto out2;
+			}
+			break;
+		case 0:
+			ext2fs_free_mem(&buf);
+			if (flags & XATTR_CREATE) {
+				ret = -EEXIST;
+				goto out2;
+			}
+			break;
+		default:
+			ret = translate_error(fs, ino, err);
+			goto out2;
+		}
+	}
+
 	err = ext2fs_xattr_set(h, key, value, len);
 	if (err) {
 		ret = translate_error(fs, ino, err);


