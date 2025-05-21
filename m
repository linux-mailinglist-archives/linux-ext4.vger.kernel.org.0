Return-Path: <linux-ext4+bounces-8094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2261ABFFB5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147B83B3B0D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A523958D;
	Wed, 21 May 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIbxa7kJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663201754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867130; cv=none; b=ea74F6mpceJlCqO9qqLRjes3uBpK9yXoZAi4DzXINv4mfN79R+78OMqVfYSF64ijrOyCuGoCSEnpJlBJqRtGMdmg3aSohFVETs49wZZyUduBf4hNfKvza99el4AdYRxjIsNi7DBRAwumZ0XLKjZyZujr5MEp3u9ERzeYZQePbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867130; c=relaxed/simple;
	bh=511LU/JWnIQ7P3jVmTjyshZ5RjWmqRQHQD8/629ixfY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxxwQpQoO2AjvjmwGMoCnc28MTyf5sovMpTO+cbQHYmsjgRon8SLt7vX4rWm3cUg6N2jY3x0gieRpT97Gq0cld2wriqsW0hXBJgVypYmPXdMapXD2TAEIIKezzorLjKFdDOVH36l2ZgDwTXvYtXXamu0IbLmS6XOmF33U3nU4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIbxa7kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A491C4CEE4;
	Wed, 21 May 2025 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867130;
	bh=511LU/JWnIQ7P3jVmTjyshZ5RjWmqRQHQD8/629ixfY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jIbxa7kJfn/N4ByU1ACU+1Yi+uYpaTHcx8RmPnd7/PwYerUdWDo/urSLanNmY9yJS
	 9jn1fQCvAjWo0isoKJvImG8t4z50zDr3N6sxdMApFDBvPeBQQgE3lkNA7lF/jxiozr
	 YRUZGqGDtAowsVd/gXElkQveewBnAQsuK7EKNm+MIHzaBJR+qTjjOUQtjTlHRCSql2
	 fQCJtlTGmqc7Vdez709xKI/NjFWK+VF0mZIjkdEo1ukBzhAo2jn0UVT+FSqPCk6fBt
	 rFKZwrfNKT5GBq09uuZ02xOpWGqNDdcujjzgmUhpWiQ3XSQ+gAOUrkTnfTB6ywAuiT
	 DAlXDOrY6XCsg==
Date: Wed, 21 May 2025 15:38:49 -0700
Subject: [PATCH 15/29] fuse2fs: make filesystem corruption a hard error
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677819.1383760.15120011207188940205.stgit@frogsfrogsfrogs>
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

Change __translate_error so that all the EXT2_*_CORRUPTED codes generate
a hard error returning EUCLEAN which is the same errno that the kernel
uses.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index eb1ac818359c19..f0ac89db4f6c37 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4275,6 +4275,19 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
+	case EXT2_ET_DIR_CORRUPTED:
+	case EXT2_ET_CORRUPT_SUPERBLOCK:
+	case EXT2_ET_RESIZE_INODE_CORRUPT:
+	case EXT2_ET_TDB_ERR_CORRUPT:
+	case EXT2_ET_UNDO_FILE_CORRUPT:
+	case EXT2_ET_FILESYSTEM_CORRUPTED:
+	case EXT2_ET_CORRUPT_JOURNAL_SB:
+	case EXT2_ET_INODE_CORRUPTED:
+	case EXT2_ET_EA_INODE_CORRUPTED:
+		/* same errno that linux uses */
+		is_err = 1;
+		ret = -EUCLEAN;
+		break;
 	default:
 		is_err = 1;
 		ret = -EIO;


