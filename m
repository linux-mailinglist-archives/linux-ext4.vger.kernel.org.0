Return-Path: <linux-ext4+bounces-5259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DC9D3095
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 23:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FA728424B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D51C57A5;
	Tue, 19 Nov 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5nPWNJJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC814A60C;
	Tue, 19 Nov 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055829; cv=none; b=Av91t4aJ6i7LALeUDCLFAE/L/mj6ejm1ss7hB6iK70XjcnpnsMBkTIrcMsJFnuBHMpMOR1Zkhg0SidWhiiQnyWi31SmkX/nIHmIZuKPGo0isdGNjnlBChIY2NDCU0R93D62+3433Dg5kjVbqiMdAsWjGNnuP1+nZcUBdQMpZoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055829; c=relaxed/simple;
	bh=8SGBCu5mk0sL2logKWtPMFKSLOyMLJxNXDLYRrrVOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J7/gQaKYUc+ise8nnaN35t3uEss1nTHfxJ9WBIw7zB1CWunIf9y6GpeWM5y/rPo68nPMg/MazfsYnanBN0flHxNSD+60qbE1Viu7tQOhSX+nj7I6fI/g35chx3caJlxSP+Hg7pbpW2OYh4kI+fAd9akphrSS9Gr9WWMNVQ4MO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5nPWNJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F75C4CED2;
	Tue, 19 Nov 2024 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732055829;
	bh=8SGBCu5mk0sL2logKWtPMFKSLOyMLJxNXDLYRrrVOxo=;
	h=Date:From:To:Cc:Subject:From;
	b=Z5nPWNJJP2EiR6S7xDh0NcwybchT8cFiSuhaUyIjBOn36CH/XH1NAC/bK/I1mPj00
	 H9B+VH2Lgio7SQUzOpCR7dpSrXjQZoxLslor7ecUGpzpviJVgC0oagjQza8D0eyGfb
	 fZXLwhAa2/jrMTx3D8C/7le66vwx5+2SnrT83M2c01GFbd34Khj9Lbk1hk9iaiDM9G
	 3LOJgHPmlBDdca9/gkaI2MyYhLamn/EJUcdnhJnq6OTLqiXIWG2PfigAr2PrgQ1NQ1
	 izLaCvC0gP4kKcKxe2xxB4mlfaNZILAK9DXl1ayI6aFEnREUmJFo1plvEVIk2+8g0b
	 ciscHBJ3qK+2g==
Date: Tue, 19 Nov 2024 16:37:05 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ext4: avoid dozens of -Wflex-array-member-not-at-end
 warnings
Message-ID: <Zz0TEX3GycUEmISN@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we
are getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure (`struct shash_desc`) where the size of the
flexible-array member (`__ctx`) is known at compile-time, and
refactor the rest of the code, accordingly.

So, with these changes, fix 38 of the following warnings:

fs/ext4/ext4.h:2471:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

Worth mentioning is that this issue is pretty much the same as this
other one:

	https://git.kernel.org/linus/2bd9077b6261

Thanks!

 fs/ext4/ext4.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 74f2071189b2..edcbe189ff34 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2460,22 +2460,24 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_SIPHASH			6
 #define DX_HASH_LAST 			DX_HASH_SIPHASH
 
+#define EXT4_MAX_CHECKSUM_SIZE	4
+
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
 {
-	struct {
-		struct shash_desc shash;
-		char ctx[4];
-	} desc;
+	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
+		DIV_ROUND_UP(EXT4_MAX_CHECKSUM_SIZE,
+			     sizeof(*((struct shash_desc *)0)->__ctx)));
 
-	BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));
+	BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver) !=
+		EXT4_MAX_CHECKSUM_SIZE);
 
-	desc.shash.tfm = sbi->s_chksum_driver;
-	*(u32 *)desc.ctx = crc;
+	desc->tfm = sbi->s_chksum_driver;
+	*(u32 *)desc->__ctx = crc;
 
-	BUG_ON(crypto_shash_update(&desc.shash, address, length));
+	BUG_ON(crypto_shash_update(desc, address, length));
 
-	return *(u32 *)desc.ctx;
+	return *(u32 *)desc->__ctx;
 }
 
 #ifdef __KERNEL__
-- 
2.43.0


