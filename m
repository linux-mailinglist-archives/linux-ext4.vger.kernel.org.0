Return-Path: <linux-ext4+bounces-4898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DB9B999F
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 21:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5851F22057
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80431E0DEB;
	Fri,  1 Nov 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkAG1wxT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD1154BFC;
	Fri,  1 Nov 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493929; cv=none; b=mZ5WD2Ger/n/29I/IfLUyJ2J4hCNJ4nBXn9f5AcB4HRg51WRqQIgyW4y0okrZyTCUCUIQ5FQLSvRVC3JfVqVCLXrJpQueblsu7M1BekHcZZrsXkjjMvATsYQ4fvvHxVbbNdTnV7qv+RJdxdARiyJUhaOKloqo63CTKhplx1hnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493929; c=relaxed/simple;
	bh=diFOF7xkuvBii4nhu7rBCrs4zdrQcuFj04D5kOLrVtY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=czHOYYpqar9oB+mzorgKe268EXw7/yG6iKoCqITz6k9siEj/POzWOV4pKQMVVJXEWJcuxDj4sdHkTcZe5epHI2kNKWLcjmriLJAHtEd/IRj1bH89M61lX7LMhY8KFJUNEzIQOyt9DvvxCW1FeOXqaA41eK3wSwiSvi/pCMVn/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkAG1wxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B17C4CECD;
	Fri,  1 Nov 2024 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730493928;
	bh=diFOF7xkuvBii4nhu7rBCrs4zdrQcuFj04D5kOLrVtY=;
	h=Date:From:To:Cc:Subject:From;
	b=VkAG1wxTxfr31YdbAJQqbs3kgVyHLSBRc2QWMW/ugRZLKRvfiG+9YrxUij7NM/hhx
	 m42Sbzx5bKL1kVkbQPUt/P9ia8Exzr2E+crdmeSjyjSz7exizT4n6uoWyx2MeeeT2E
	 XtxN9ZNJS8FvMXil3wSo03QwV5dfoXVgNLxyX6Fjh1ZjU+CoMgBkR17aCeVUt4VFlz
	 p5sTW7k0vgMP5ngmWBtgxA9HxbvNgmoQWkLxEA4ZW/xn00ksYaKqwXDN9CQWBdDu/8
	 4QmqlZZYM2VjnkNrmEi7nSnAIKzpj7b980VkOvbp9a0UAqGxyffEpm6ByPOl8YuU/m
	 M51GmCbuv+Txg==
Date: Fri, 1 Nov 2024 14:45:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZyU94w0IALVhc9Jy@kspp>
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
Changes in v2:
 - Use DIV_ROUND_UP() to compute the number of elements for the flex
   array. (Jan Kara)

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZxvyavDjXDaV9cNg@kspp/

 include/linux/jbd2.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad57..50f7ea8714bf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1796,22 +1796,21 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
 			      const void *address, unsigned int length)
 {
-	struct {
-		struct shash_desc shash;
-		char ctx[JBD_MAX_CHECKSUM_SIZE];
-	} desc;
+	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
+		DIV_ROUND_UP(JBD_MAX_CHECKSUM_SIZE,
+			     sizeof(*((struct shash_desc *)0)->__ctx)));
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
2.43.0


