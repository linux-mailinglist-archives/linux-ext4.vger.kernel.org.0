Return-Path: <linux-ext4+bounces-8718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F1AEE5B3
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E10189A667
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044052E426A;
	Mon, 30 Jun 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyfFghiR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB082E3B1E;
	Mon, 30 Jun 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304249; cv=none; b=CS+AiDmFP8wBeMdnJantIw1Pdsq0cdsfX2n06yOHFg3+6ruoMA5gKxNDo7VO6W4TjW4WHz8Buxf36d0I4Hw9ANkh53NAIfYn/QlT6g3ADMKQhEOvZ9Umz1fgQG9CUx/jM9s+J5tBcZpI+nzDYMwE5eaOOhF47LTDxHSdrp7HttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304249; c=relaxed/simple;
	bh=05eIsjfDMuZi5Fi3Zt00IWUTPN1TFM68UljYfUCnOjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocGl/dO54560eHGevJbOt9DvEBdnakIWJz6mjdRP4JYz69tSfJilVaKSfeFdZHZ1VpqhT8Cigm6f7AsDoo/osBxPWQd9MtWSQgjfNioHLCerWQAXDCQ5KePCsCikYN+ovfV0QGbBs7n/vLOH7L8W/yDAV0250DTZboqPILd4Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyfFghiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB53C4CEEF;
	Mon, 30 Jun 2025 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751304249;
	bh=05eIsjfDMuZi5Fi3Zt00IWUTPN1TFM68UljYfUCnOjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyfFghiRLoFUvHJsn4kFSOQqXBFgD1XAtC4khHBTP+zdrMHIIh1l567vYkMbaVN2S
	 skBXd85PTVk811uNOQWb6aBwVgO73NidRwFgE3DCHYE1VnBYtpiG0qQYBpa/pn3cM+
	 1TstBKj9aPXtTCNQQjnCsqHMAQqQHPiMz13rhVmAYMSWB1SUI/ClQtAI2m5j05WcTe
	 Zd4JXUSl0O3KZiHabGxqc2hBtS/l3GM8+pIQ+Azusy2yQa2FzAYwSbsCZxWLsNARXG
	 dooaqhZSyCMHclyMgWPuvGONFdVL8zECb1BFAtZqrV9udkuvhAoTLHAqJOywENfuPa
	 RkTUuaQWZZPVw==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/2] lib/crypto: hash_info: Move hash_info.c into lib/crypto/
Date: Mon, 30 Jun 2025 10:22:23 -0700
Message-ID: <20250630172224.46909-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630172224.46909-1-ebiggers@kernel.org>
References: <20250630172224.46909-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypto/hash_info.c just contains a couple of arrays that map HASH_ALGO_*
algorithm IDs to properties of those algorithms.  It is compiled only
when CRYPTO_HASH_INFO=y, but currently CRYPTO_HASH_INFO depends on
CRYPTO.  Since this can be useful without the old-school crypto API,
move it into lib/crypto/ so that it no longer depends on CRYPTO.

This eliminates the need for FS_VERITY to select CRYPTO after it's been
converted to use lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig                     | 3 ---
 crypto/Makefile                    | 1 -
 lib/crypto/Kconfig                 | 3 +++
 lib/crypto/Makefile                | 2 ++
 {crypto => lib/crypto}/hash_info.c | 0
 5 files changed, 5 insertions(+), 4 deletions(-)
 rename {crypto => lib/crypto}/hash_info.c (100%)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3ea1397214e02..5d4cf022c5775 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1420,13 +1420,10 @@ config CRYPTO_USER_API_ENABLE_OBSOLETE
 	  already been phased out from internal use by the kernel, and are
 	  only useful for userspace clients that still rely on them.
 
 endmenu
 
-config CRYPTO_HASH_INFO
-	bool
-
 if !KMSAN # avoid false positives from assembly
 if ARM
 source "arch/arm/crypto/Kconfig"
 endif
 if ARM64
diff --git a/crypto/Makefile b/crypto/Makefile
index 5098fa6d5f39c..816607e0e78ce 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -202,11 +202,10 @@ obj-$(CONFIG_CRYPTO_ECRDSA) += ecrdsa_generic.o
 # generic algorithms and the async_tx api
 #
 obj-$(CONFIG_XOR_BLOCKS) += xor.o
 obj-$(CONFIG_ASYNC_CORE) += async_tx/
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += asymmetric_keys/
-obj-$(CONFIG_CRYPTO_HASH_INFO) += hash_info.o
 crypto_simd-y := simd.o
 obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 
 #
 # Key derivation function
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 3305c69085816..cce53ae15cd58 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -3,10 +3,13 @@
 menu "Crypto library routines"
 
 config CRYPTO_LIB_UTILS
 	tristate
 
+config CRYPTO_HASH_INFO
+	bool
+
 config CRYPTO_LIB_AES
 	tristate
 
 config CRYPTO_LIB_AESCFB
 	tristate
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index a887bf103bf05..533bb1533e19b 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -6,10 +6,12 @@ quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) > $(@)
 
 quiet_cmd_perlasm_with_args = PERLASM $@
       cmd_perlasm_with_args = $(PERL) $(<) void $(@)
 
+obj-$(CONFIG_CRYPTO_HASH_INFO)			+= hash_info.o
+
 obj-$(CONFIG_CRYPTO_LIB_UTILS)			+= libcryptoutils.o
 libcryptoutils-y				:= memneq.o utils.o
 
 # chacha is used by the /dev/random driver which is always builtin
 obj-y						+= chacha.o
diff --git a/crypto/hash_info.c b/lib/crypto/hash_info.c
similarity index 100%
rename from crypto/hash_info.c
rename to lib/crypto/hash_info.c
-- 
2.50.0


