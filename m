Return-Path: <linux-ext4+bounces-7476-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD2A9BA0E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8019A10AB
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8821E087;
	Thu, 24 Apr 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIsXLX+X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B99198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530988; cv=none; b=Ekh//hdtYm46Cr41PmARYfj/mRNhfopWSXGXDX0fzjp/7kZ2bi+0w7jJWT4PBm6VXrB6VWIJs/haZvYmlVUW9Z37jV7EseZcQ212hGzu4SoRNfqFZ1tWn+iK4UflEi6JlFr7UBT3cS5pC0hWSpRQuLLZoFIbSoNafcx+pBdwzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530988; c=relaxed/simple;
	bh=yYFuAfYsVL3y5Fan6j006h23grJ71vIIkI7i5BU+aFc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz01KkPJ7PkDqrTmVl0Oe7jUvXb9nHdDLHat+xrMeM7dXSAqWGt464t0DHS6WwFYKDFggOMUg/TT67Jhx69rGjIDGVlXRNJOIZx33QV3n1z7Z/U/s7KsG8PHx30KTF36i48Tfo5o+U46uCHxrK8YB0HpsOK0VAKy0IEq7dpxxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIsXLX+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B48CC4CEE3;
	Thu, 24 Apr 2025 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530988;
	bh=yYFuAfYsVL3y5Fan6j006h23grJ71vIIkI7i5BU+aFc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sIsXLX+XjMV8ml2iQ8vQeF2B8hsioYc0X6248saMFsmxPNSXJqagGrCqdQgAznFs8
	 icRGTKfE6CNDCNSdo3lgOswYYeKVLybKRm4lGIjomGq8SB/4WQjwypUZAHyhej5cle
	 r6sOpv3gXpsaBNRODHQgBRBHHcQPXvrj0DU9oWR8pxXQZ1tm/H/1aoMqaLp6e6OA2v
	 FHcsvVcbz/Y/MudLGDnTEjRX97Tfx2mc5rfhJYMbG8C9UUx4r06UBsATPBb8N00PVf
	 uoX0Xd1nCll5WZ9KT/GGOE5ngHY78Fev6/+ZrnzmNushuewypI88pTYET6uRl7DlAO
	 Hp/sc7ttws7NQ==
Date: Thu, 24 Apr 2025 14:43:07 -0700
Subject: [PATCH 09/16] fuse2fs: add supportable mount options from the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065087.1160461.16716917319493753291.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add all the kernel mount options that we can actually support.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9cf8c59b8b88ee..9e416e8af77e1b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3548,15 +3548,18 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("rw",		ro,			0),
 	FUSE2FS_OPT("errors=panic",	panic_on_error,		1),
 	FUSE2FS_OPT("minixdf",		minixdf,		1),
+	FUSE2FS_OPT("bsddf",		minixdf,		0),
 	FUSE2FS_OPT("fakeroot",		fakeroot,		1),
 	FUSE2FS_OPT("fuse2fs_debug",	debug,			1),
 	FUSE2FS_OPT("no_default_opts",	no_default_opts,	1),
 	FUSE2FS_OPT("norecovery",	norecovery,		1),
+	FUSE2FS_OPT("noload",		norecovery,		1),
 	FUSE2FS_OPT("offset=%lu",	offset,			0),
 	FUSE2FS_OPT("kernel",		kernel,			1),
 
 	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
+	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),


