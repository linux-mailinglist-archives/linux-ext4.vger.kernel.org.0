Return-Path: <linux-ext4+bounces-4805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF29B0F1E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 21:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CCA1F23719
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 19:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57D214428;
	Fri, 25 Oct 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt9YeX0i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790B15B97D;
	Fri, 25 Oct 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884782; cv=none; b=l4XRB2rBXKoN6OLXpEOKcxWjtEiW6ZPaKs084pgSuU8ikZk3HvYpdoDi7K0RZhcEQEQB6kkH9aRdGYNkvaZXKyv8GPeUf0Au+WDmkKuU/SPrVAHRS7Zjmfl6E/Jo5+uVZ6NeyCxOBaJOUDG51vQ+qAqxPxK43bHQK5kgYI3wzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884782; c=relaxed/simple;
	bh=BA3+cBbP7QEhMw0MSVRtPMBj356EX41KSXUTBGVN6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KzmEeo7tVfIFzV0TbUEUnqro9eyZiLbC4ueXhAZFdDsibmISbx/Hb9YwAgRm30vk9PdblfWDn+bEK5Ljtf4jCyhI9onufTjmSYhiJ1+MBw86TTDGyxFoUMpZFHJCFmg1V1OQDEPhhQPqxsjgYrl/odMsbruBGy0TG97KU1np8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt9YeX0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346D5C4CEC3;
	Fri, 25 Oct 2024 19:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729884781;
	bh=BA3+cBbP7QEhMw0MSVRtPMBj356EX41KSXUTBGVN6BQ=;
	h=Date:From:To:Cc:Subject:From;
	b=bt9YeX0i//wtnHMCOY+I9vFC1RBgfFA3khsSEIIUvzQdXr/XK4EwskEqBSNzW8UaA
	 Q5n6t0+RACsRjmqqYfjJWmDmKMp1CzsDBf/WnKU9vv6q0kz0YwIFEp05fTNdZW/r8U
	 6NHYyugmgQWqqEHJGCuEBNMictpsGyE38/o/45DQjjnkTpZz2pzL4oQx+GaUhsdQbE
	 3DYqOZZep/6kV1AkBW5XJ3lpvwDpx1NHYi/5sM7Rd7hTBSHChBJPiagzhVzq95ld2j
	 avLKuSTav+s10EjXnqpNlWiXRKdaySiq8YK2L1zqxg1WNOm2JwCuc6vdjDZJLWL90V
	 dkF8CZ/wmI9Kg==
Date: Fri, 25 Oct 2024 13:32:58 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] jbd2: Avoid dozens of -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZxvyavDjXDaV9cNg@kspp>
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

So, with this, fix 77 of the following warnings:

include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/jbd2.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad57..ce4560e62d3b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1796,22 +1796,19 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
 			      const void *address, unsigned int length)
 {
-	struct {
-		struct shash_desc shash;
-		char ctx[JBD_MAX_CHECKSUM_SIZE];
-	} desc;
+	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx, 1);
 	int err;
 
 	BUG_ON(crypto_shash_descsize(journal->j_chksum_driver) >
 		JBD_MAX_CHECKSUM_SIZE);
 
-	desc.shash.tfm = journal->j_chksum_driver;
-	*(u32 *)desc.ctx = crc;
+	desc->tfm = journal->j_chksum_driver;
+	*(u32 *)desc->__ctx = crc;
 
-	err = crypto_shash_update(&desc.shash, address, length);
+	err = crypto_shash_update(desc, address, length);
 	BUG_ON(err);
 
-	return *(u32 *)desc.ctx;
+	return *(u32 *)desc->__ctx;
 }
 
 /* Return most recent uncommitted transaction */
-- 
2.34.1


