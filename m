Return-Path: <linux-ext4+bounces-8835-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E7AFA731
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE60618914E7
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD719F421;
	Sun,  6 Jul 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNa7wXAt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503051891AB
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826724; cv=none; b=fQ5b7WPPFpPQFvhrjt8YHsMtacY6O1OVIndHs4qbLQjpzA+EjHnbtKaSS8eDjcwPGMUNfXOdMO6HkPjTiVAw2v9mt4tik776rHcSyJ2LThXmCw//EG1lJeTLA/fv7wbZYa5UqyhXNytiWRUXDfevEz13bv/dO+LINpVUDE5fvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826724; c=relaxed/simple;
	bh=dWI29C2Cxh4gC3N6rxA5yCYfYyJ/y5nPGveRCw0TVKk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJp1Dx9OFTJL8neOA9vQ5gyx0jJim6WzwBRO0Mw180GJeiSvY2jn6ooPIWcsEsAgij7nc8ffbaVLhEJcxrg6fcwGV5i10FJ7Uh5IIHLgQiU3onBEPViSBuzVMogE0RNT5N74ZLxypBT3tG9Bt0sYQAPj5zRbLLkZqoGsfbPyvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNa7wXAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F18C4CEED;
	Sun,  6 Jul 2025 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826723;
	bh=dWI29C2Cxh4gC3N6rxA5yCYfYyJ/y5nPGveRCw0TVKk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JNa7wXAtmYZxbLXbwAVRFO9xGwzKLlZBQQb9CC+bsNI7vAUv2+2rAbRNQ8bfH7hqW
	 sGkjCg/dxIltelOQLA+6wqlfmG89qkUYI1yH7WmzUVXrE4fdUzkP8sD6mSt5IsMKVW
	 PR/Jtx+BQ+OLLXNKWjIFzTay4X937K+U4LxGG8FgPnWJ8pgE5gXhpxnMVF/O82c4hp
	 Zg5GmGRYhfzGd24y8qZ9NiSDCeLeXCCQ4F+9dwEwp5rzkLHh1+H2l/bRzCs8xOTSM1
	 v7gAnoS2TjaZ3KvJf0mU+lyoHTkU4pOcCcXN32Y3oJWgGpmQe8rRv5wGlZ7fiAomIH
	 HRMvTBQeolo6A==
Date: Sun, 06 Jul 2025 11:32:03 -0700
Subject: [PATCH 5/8] fuse2fs: don't truncate when creating a new file
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182663059.1984706.11656403223439904537.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

New files can't have contents, so there's no need to truncate them,
which then messes with ctime/mtime.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0e9576b6ca6aa7..5b866aed98237f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3376,6 +3376,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	if (ret)
 		goto out2;
 
+	fp->flags &= ~O_TRUNC;
 	ret = __op_open(ff, path, fp);
 	if (ret)
 		goto out2;


