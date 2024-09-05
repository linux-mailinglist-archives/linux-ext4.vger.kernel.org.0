Return-Path: <linux-ext4+bounces-4072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AE96DFD5
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265571C238A3
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF61A0B1F;
	Thu,  5 Sep 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZQ4zSna"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C231A0737;
	Thu,  5 Sep 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553957; cv=none; b=XiZEBZyFdoI3v7+KVjQaXrdwjRBiolLU5IRwplYZbABjrl9FbIlLkG8ncjSW7QgANng4tLpSvPOjOJSq7Su6WATLZaa6XgNlJ//WDyN9vd9f0KkL+LmJx4h4RxxmeILDPq6f/H96KC3Aa1jexOuAmiSLzuRrUblqTi7xekIbTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553957; c=relaxed/simple;
	bh=bM8/Aky9cVDTyu6+CHOGv/cduQxzuGgQDvzKsFymVfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPiCn2mmHITMSXXwv+n+85VMefn7sZogXUjzTV4ZHUF2+pzEen+6nvu1gnegkvvP0tcXW6uLM10c2hqT9S+SK0mdeZHRnguTSO/8DxTm46ojCZvP0bkXXti13wowO1WUbYqduMovJpHnlI2C4JEgkoFZNJXLeIpubZR8zcYlahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZQ4zSna; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725553956; x=1757089956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bM8/Aky9cVDTyu6+CHOGv/cduQxzuGgQDvzKsFymVfU=;
  b=bZQ4zSnaNTmoIYXtBfjQlI8YTFTOmy0E+MXCJoQEyBYLCum4YWmEQ56g
   EiMtdujnJ9Y+JxpPaFoC0ih5mmcsZUC/TBZDqx+P2Fs1Vov2k/Y+i6vUc
   mH178g1qTtWcqnD10vYODq5Y77xYwON2BHfXu4zL8JGqOU4VnesvRRw1b
   VDMLu2zAYCNwOTg2w4wm/qSDljSoOuznrd2/Pg9mohkIPaDuKWKCjp2hV
   +m3cTROJsaWpC1lY6EFWWxbuehSunKwx6QK04h1D+Llls1OUF46xjynlk
   kVtm8QdNCrSF11gHKFGjg1M/RIb325IZPrBEYVF9c+J9X9gZeyEGX3H04
   w==;
X-CSE-ConnectionGUID: KGjChtu8R0WwXb6QEt23ow==
X-CSE-MsgGUID: +8uDIeyjTh+3FXtFzYrmbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34952585"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34952585"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:32:34 -0700
X-CSE-ConnectionGUID: 5FzCHLL9QUO3km3zapl2Zw==
X-CSE-MsgGUID: z9pulfogRiSFU0MeIpQb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65671184"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 05 Sep 2024 09:32:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 347B031E; Thu, 05 Sep 2024 19:32:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ext4: Mark ctx_*_flags() with __maybe_unused
Date: Thu,  5 Sep 2024 19:32:29 +0300
Message-ID: <20240905163229.140522-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ctx_set_flags() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

.../ext4/super.c:2120:1: error: unused function 'ctx_set_flags' [-Werror,-Wunused-function]
 2120 | EXT4_SET_CTX(flags); /* set only */
      | ^~~~~~~~~~~~~~~~~~~

Fix this by marking ctx_*_flags() with __maybe_unused
(mark both for the sake of symmetry).

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..8bbd84c2f3ca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2095,16 +2095,16 @@ static int ext4_parse_test_dummy_encryption(const struct fs_parameter *param,
 }
 
 #define EXT4_SET_CTX(name)						\
-static inline void ctx_set_##name(struct ext4_fs_context *ctx,		\
-				  unsigned long flag)			\
+static inline __maybe_unused						\
+void ctx_set_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name |= flag;					\
 }
 
 #define EXT4_CLEAR_CTX(name)						\
-static inline void ctx_clear_##name(struct ext4_fs_context *ctx,	\
-				    unsigned long flag)			\
+static inline __maybe_unused						\
+void ctx_clear_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name &= ~flag;					\
-- 
2.43.0.rc1.1336.g36b5255a03ac


