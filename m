Return-Path: <linux-ext4+bounces-8087-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD68ABFFA9
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ADE8C7FE7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A323958D;
	Wed, 21 May 2025 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UujM3Ku0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0981754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867021; cv=none; b=alV6d5477aLCOv/fknxG2pIYvCNVATdkhEU8tSPieK9zbizjMzL3NMX8gB/FiJ2J4Hesca0EbihExGZKSX+LeCi6ngz8TMTAXc8cW7nGldUH8lY0P7TaQCzbZPph9reGnxODfGdpMCKQYWIr/b8v6h8aJ4A6Od1W/M8hvuN3uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867021; c=relaxed/simple;
	bh=KtrMHmhvN4xbjnCzz8O/Nof1SVudiyJjNyQ/F1K3kJY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ4goYFszs+M28DWAstFEHGslNPni4awbLMGjSuM5zgw4BReE/Y7WBmhw8wKWG2biF37OkO6zL5guD3k0d61FAZp3M5CSvGdXdDdLnY4Fx2vUqa1JxLMs7xbDWSdm8NaPbvTDUixyVs5LoQbSmTyjRRm/e6k5swmDj9aLXuivWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UujM3Ku0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64DAC4CEE4;
	Wed, 21 May 2025 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867020;
	bh=KtrMHmhvN4xbjnCzz8O/Nof1SVudiyJjNyQ/F1K3kJY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UujM3Ku01mspIZNmKOJc84+cCrtqzgje7Y+CKuDxdDFhnMK6W66oXkFupWGQLycmz
	 2+yMQYJr6ZyMJNzCyI/30Ch5kL/kAWoHeTpUu8PlTqUs3Oeu6gbWJgikaJMIxPTdlE
	 5KeZIzO6c0aVIwdXc1fzuVIScnbTvV9H8T/eatORpm5UEYGNh2+FXRUVRqnErDvdoa
	 J3IC3sC4gYVrq546SRxYbeLtWB5q+CwhdmKUgVqhgwYWRzQhybHFyBJzVD37v9WDBM
	 7U9rgAw0Z0xO+vREgPD95gf9MLPzW4JAGWG6DF3yp/JyWCPDl/4LijzNH7UmMnI0kC
	 f7NDo2azfd2GA==
Date: Wed, 21 May 2025 15:37:00 -0700
Subject: [PATCH 08/29] fuse2fs: flip parameter order in __translate_error
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174786677693.1383760.5102016357729108965.stgit@frogsfrogsfrogs>
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

Flip the parameter order in __translate_error so that it matches
translate_error.  I wasted too much time debugging a memory corruption
that happened because I converted translate_error to __translate_error
when developing the next patch and the compiler didn't warn me about
mismatched types.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 74f1ca81aebc61..e60065402a0a43 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -173,9 +173,9 @@ struct fuse2fs {
 	return translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC); \
 } while (0)
 
-static int __translate_error(ext2_filsys fs, errcode_t err, ext2_ino_t ino,
+static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *file, int line);
-#define translate_error(fs, ino, err) __translate_error((fs), (err), (ino), \
+#define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
 			__FILE__, __LINE__)
 
 /* for macosx */
@@ -4164,7 +4164,7 @@ int main(int argc, char *argv[])
 	return ret;
 }
 
-static int __translate_error(ext2_filsys fs, errcode_t err, ext2_ino_t ino,
+static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *file, int line)
 {
 	struct timespec now;


