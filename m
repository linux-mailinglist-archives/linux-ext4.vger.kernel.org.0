Return-Path: <linux-ext4+bounces-11612-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A37C3DA92
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C671734FC58
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CA34CFBD;
	Thu,  6 Nov 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhObkaVT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285B2E11A6
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469112; cv=none; b=PC4690ljWd7HCJuArd/9X0aNzx0GtgK65XY8MxMW8nO269tuw5DSSzI58sZ/92HiscA8BIUpV5g0DLmj3aYGDZBnhvEMkBWeSLjKXXin6a25N8DovEZkX/ZnwsUAybWxkTNfDaCT1TRsF4e8NUDgK2QVNeYufhjHe+TIXRzFqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469112; c=relaxed/simple;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSYZaHGzOBGp373FHn/Sbm5s6cQr7B/tkX5/M6a/i4W98hB06VPgSghDgNGS1eoQrto7RoNT0u6MHF6urB6U8lqymJ1AZ3sE/BGH1AY1EBsvMDh4h4F+U6KFzinWWT3Yb0WqCKLY+9uJ/klSCoPXRuh7bnuKRnJL6u/7FmS8ack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhObkaVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4D1C4CEFB;
	Thu,  6 Nov 2025 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469112;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FhObkaVTKK48yMYl/+MNE0ipuTssL3skuoR3ScTW1QM+zrH5TdDWgjyKTeAeMlCIa
	 Oh3GKGxEJnSfiLHR6rIKVSduFJaPk0bg2GJBQW9gAilfE/6Zw2k0hdukVVzY9Y4yUV
	 Lqg+6BWvNKWRrKG8wM2LwG/tqD1rUkcGTEslPe+0wRIBYuy17mxHV19n26ROofLU8R
	 vc/Up+V67mLJ0SH+zRz7NBPkxOHKCSAgvOQAGVrWi+g9rQixVWKljfPqQeB2gaRSr5
	 SMtAlNkeh4Uy07l4rHOW+RxUkJE6hYhDWKM3JJvsxgybOxT+qWtyUoJFDf1IK6xe7p
	 b0AUkqLulCvZQ==
Date: Thu, 06 Nov 2025 14:45:11 -0800
Subject: [PATCH 08/23] cache: disable debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795712.2864310.1041788708806001570.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Not sure why debugging is turned on by default in the xfsprogs cache
code, but let's turn it off.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/lib/support/cache.c b/lib/support/cache.c
index fe04f62f262aaa..08e0b484cca298 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -17,9 +17,8 @@
 #include "cache.h"
 #include "xbitops.h"
 
-#define CACHE_DEBUG 1
 #undef CACHE_DEBUG
-#define CACHE_DEBUG 1
+/* #define CACHE_DEBUG 1 */
 #undef CACHE_ABORT
 /* #define CACHE_ABORT 1 */
 
@@ -28,6 +27,8 @@
 #ifdef CACHE_DEBUG
 # include <assert.h>
 # define ASSERT(x)		assert(x)
+#else
+# define ASSERT(x)		do { } while (0)
 #endif
 
 static unsigned int cache_generic_bulkrelse(struct cache *, struct list_head *);


