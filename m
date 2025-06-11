Return-Path: <linux-ext4+bounces-8366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D3AD5C8B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 18:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631CE3A829B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116361A9B32;
	Wed, 11 Jun 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtPKAK90"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FC1F91C8
	for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660257; cv=none; b=aK9V+YeZkTHQ/+IES74FZ2H/NJE0GSQTB8+D7AtPyFARyHq6aIIFpOKqh/JEMlVEr6VnkBs+2o+L7lzeaWqS0g+cZNRwzME+F0/hboH7pjAp87kf0Ol4h1aFk7dinl7KXFXCNfXkcGIYwx/TXx4cKFkgoEBbDK/ymqr799VcUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660257; c=relaxed/simple;
	bh=SbfOxPk+Af1rze7qx7haIef9DB33wxyIrVwK++evUUo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hELfl5hG/VDkxaWRBYUynaqSGqRUrZoNPUr8//qAVqUIxQn6P59c8QAbIRQMuRFfkQWAH21HO+R4aM0A9uc2RlINEQM7Q0kNnlB3zJH/v87EJp0O5GsN3nyp3DybRlJDzStVVMhRk+qR3isajCAx9t0Nq3Z9rRHbCQi+AGTq+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtPKAK90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E776C4CEEA;
	Wed, 11 Jun 2025 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660257;
	bh=SbfOxPk+Af1rze7qx7haIef9DB33wxyIrVwK++evUUo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZtPKAK90U/vXO8opiDrXOu8h2iSBgswdk05wbFMLJwWdJKYID1qildWsTZDsHB59s
	 iP9X3ASptUbmODf8PRfZBkk0L33AwtqHfqs8gR1TbD9Y8bW/pjHG4eP2N7U3ISXMcP
	 7sPG1yeBZjjxWIAL8KxBql0jhHA/t0YMnrSIIPG8uwV9y8+XKg95C+9qREtNV4kIth
	 Xj5sNI49EVKbw8U/Be3SOqoK9Alo4KHBkJE5ACDa7zEgzjCrgCH3q9uC7jWnWw3cw4
	 EkdfVKP7F/lOLXscRa3lLwY5SzPwFqv2JNiXmRjuXdII6JNMOTWW1My2RFUR5+cpjJ
	 vm7vnQlGjY5sQ==
Date: Wed, 11 Jun 2025 09:44:17 -0700
Subject: [PATCH 3/3] fuse2fs: catch positive errnos coming from libext2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174966018106.3972888.12154557537002504919.stgit@frogsfrogsfrogs>
In-Reply-To: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Something in libext2fs is returning EOVERFLOW (positive) to us.  We need
to pass negative errnos back to the fuse driver, so perform this
translation.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cc023065727fd5..2bf7413bebb70c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4633,8 +4633,18 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	int is_err = 0;
 
 	/* Translate ext2 error to unix error code */
-	if (err < EXT2_ET_BASE)
+	if (err < EXT2_ET_BASE) {
+		if (err > 0) {
+			/*
+			 * Apparently libext2fs can throw positive errno
+			 * numbers at us.  We need to return negative errnos
+			 * to the fuse driver.
+			 */
+			is_err = 1;
+			ret = -err;
+		}
 		goto no_translation;
+	}
 	switch (err) {
 	case EXT2_ET_NO_MEMORY:
 	case EXT2_ET_TDB_ERR_OOM:


