Return-Path: <linux-ext4+bounces-8088-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC11ABFFAB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9454E8C81C0
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D41754B;
	Wed, 21 May 2025 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjmpJjVE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9234236453
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867037; cv=none; b=cbqQ1D/TzeqpdtuU9DS/Rj74NQj8ApWIje1Qh49Uhv+UeJMTIhJbQ/1n5LgXQKH1kAr/tCPaDAaJ34frWuEYcXktCv9MCubQk7NbuOJuDQG0hg/z6p+rSb+kGAMDJ45D/B3zN1NmzQb7ime68X/mUZqe6jUfu/0waG1nnfOoMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867037; c=relaxed/simple;
	bh=nOHBfOstkjIVp0ivvzuqAh0W0lGltp4k3guLqt+Hf7w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1OyVKwxNzGaIgYe0iAJ7ZtINfPiUmM7w8cePCowTmihqGrVlf0ijRSPM4xa4nyIjLaN4vJKvakPlBVsZfQ7w54yoqOIRHSBAipcqvf0o52JdmR5kd1coMXsZ7S45B/nhoQnPcwsigLI1cWyf53Z0g3SAHM6VCIO6lRAQp5YF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjmpJjVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B318C4CEEF;
	Wed, 21 May 2025 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867036;
	bh=nOHBfOstkjIVp0ivvzuqAh0W0lGltp4k3guLqt+Hf7w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BjmpJjVExykMaj19oqh4SDrkkX5NvSRgLj4cr8lP5z25JA7iV+cQgoyHGrhQlxL3d
	 YLWdd6Z2JKz/H3DJFgmwXl5Ucs6+8t1zsFe/laOSfOyBHrvm+aSJynga04VyFEHjrX
	 A3RMHvSwqBHd8En0OfC0UjMCAWMbKDLCsTf4PoehEE+gV9YJyU2S95CsDIEBrzHGCp
	 R+wQYC0w02DmeLX0F+UND78UTEMxv7kBgdDLDACTmEVOb6SgKjxWfwcxa1zX7flO6n
	 vwRRNSY80S8D9wW8ZN59OISAEBZ8nUMz8Uf4rv1FYLEIlVecenJ0MNyOiaiDyldK/8
	 tdGFB/4831g4Q==
Date: Wed, 21 May 2025 15:37:15 -0700
Subject: [PATCH 09/29] fuse2fs: fix CLI argument parsing leaks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677711.1383760.4278826288377195178.stgit@frogsfrogsfrogs>
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

Fix some memory leaks in the argument parser.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e60065402a0a43..40105368775a93 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4161,6 +4161,9 @@ int main(int argc, char *argv[])
 			com_err(argv[0], err, "while closing fs");
 		global_fs = NULL;
 	}
+	if (fctx.device)
+		free(fctx.device);
+	fuse_opt_free_args(&args);
 	return ret;
 }
 


