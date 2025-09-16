Return-Path: <linux-ext4+bounces-10096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A7B588C4
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62C97A25A0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBCF507;
	Tue, 16 Sep 2025 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgWzkbVu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEF610D
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980979; cv=none; b=BL1ZKeBEb1iVvo8wDJn/xfqNyGmQH+EOUp+bNX/9pKnnp0PyCjslKlJO3/J+JJGFsTTQZIBj8ngBOELk1ybaqLO2hMjZRcnWVOgf3XMYER2LYGgpQNQ3k3em6cWo4xF6cdzeilw+BRGWyd9qdSCTgvzGCZHzDm4NPS5rV0chIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980979; c=relaxed/simple;
	bh=QeMFocaaTynzKTnjfUsnG3bAVsQaPlneBrLBe1nv8UE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuF433H6WpOMqubG0819uYh+cF3dCtTzOo1OMlN76f9LdgT0OcWwgPQUBC1CsfAwwEnNqywk7MW+zGqHxI2Gi5UpN4aYtFfoqZ45yBQgU6ImD/cH3+tfxTTycqFtvg+PNPJwZMPyl4QmPFG5LO5zh3Cp0Crcfp6s33B/ufRKnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgWzkbVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDC5C4CEF1;
	Tue, 16 Sep 2025 00:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980979;
	bh=QeMFocaaTynzKTnjfUsnG3bAVsQaPlneBrLBe1nv8UE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EgWzkbVu64LoB3yhSYRSr+P8VForV2EsoB90JvmdizYqNUlaGkrDszEUpEViI9ub8
	 SWIOALrl6pyHUYxo7B3ZtAg25SgX42IMxHNvepQCeUma851r6YUSl9OE+54tn89Til
	 NGpjkpVh5UzEfx2y5uANjODkYsXIzpRm9vnfld4GNFgCQhzpQp2r7zOnCpoRZJ18tw
	 JlTM9Xf8lSJd5THhdWO7FGHXovNU3dzSl82LxdKRlSfwlbNeTb/Kgtdou6oBDleW0W
	 kJJMmeapGnTfBlbFCMbIBp2kH7hXDKqft7uXBGlFigXRsOg0Ho/MQEsVD4Vs/sYdCM
	 gBDJKGoSb+RjQ==
Date: Mon, 15 Sep 2025 17:02:58 -0700
Subject: [PATCH 3/3] fuse2fs: recheck support after replaying journal
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064633.349841.13728896501759012525.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
References: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The journal could have contained a new primary superblock, so we need to
recheck feature support after recovering it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5917569c0a8d32..48473321f469dc 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1045,6 +1045,10 @@ static int fuse2fs_mount(struct fuse2fs *ff)
 			fs = ff->fs;
 			ext2fs_clear_feature_journal_needs_recovery(fs->super);
 			ext2fs_mark_super_dirty(fs);
+
+			err = fuse2fs_check_support(ff);
+			if (err)
+				return err;
 		}
 	}
 


