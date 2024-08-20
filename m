Return-Path: <linux-ext4+bounces-3790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4695854A
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FC7B21DDD
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5718DF70;
	Tue, 20 Aug 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWyQqVwv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5D18E375;
	Tue, 20 Aug 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151551; cv=none; b=M1f0GoWPPOyqEilAw5ev018lNvdPTF3P47b9Q9H54KHlpQIStTH7aYEtor/VQSOKLhzEv8WyjLF/QERl8stZf+9WwiEWpuVG0pwaIup1h7n4tXDdJxwfVdy/x9D8A+rVYdwoJXnozU6VkTLm+tHWiTxHxfUWXaVFwrx46zELcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151551; c=relaxed/simple;
	bh=3Og+tiSfir93LZrEHOVhD/etjKB31Cdx407jfgvkUKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mZjn/xPgE2BXjZwSUTYilsU+HUssm6V1mUMZ2k/kmbpOR7310lkl/NQFqEQXsjOoy2YKfpWcPUGt8Roj4CN9eAF2qsnKjfgGBsJL5IFX0KDL8+Gta302mgPv9YL13r2cJdpXrd/kowRbFOTH/fU4tnI8MG2O5DvKRQWQb7JaLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWyQqVwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48C49C4AF0F;
	Tue, 20 Aug 2024 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724151551;
	bh=3Og+tiSfir93LZrEHOVhD/etjKB31Cdx407jfgvkUKg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uWyQqVwvsZrmGbxN+Umg87Dp787H89goQln7q65Yh0SQsGE0bXmhyPNZRT/siyiAW
	 SBJfACvQ8f1DBpIKwKP86LdxgIdQnuXzy8Egb/6zhCPLb9SnzHNF+fLi6EsI7bbryT
	 OasP0hdSbNpczmBtSm1Zp7kuhUt+CwUpN+6pNvL2VYbphiN5K81pjpf+SCwzJbWZXg
	 Q/A/8n3UczTA5QcfGBpYjvGhgo7xrGVp0drMlv+G4UAEZYuXjqcTpGgrpVHjScQ7gO
	 aZcgeCh/RmiFJZmvMCX4ZKWlJe4RLbp4dnFPNWSWseGLXDhM/6zAolvSDg4Vkl1CED
	 mjx0lZECPf1Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346BAC531DF;
	Tue, 20 Aug 2024 10:59:11 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Tue, 20 Aug 2024 16:28:59 +0530
Subject: [PATCH] Fix missing description in struct member for journal_s
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-journal_s-missing-description-fix-v1-1-578b218e646d@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAPJ2xGYC/x2N0QrCMAxFf2Xk2UAXZBZ/RURmG2tEu5HoGJT9+
 4KP58K5p4GxChucuwbKi5hM1aE/dJCeYy2Mkp2BAh1DpICv6ad1fN8MP2ImtWBmSyrz1018yIp
 87ymmMOR4IvCfWdnnf+Ny3bYd+nV2xXMAAAA=
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724151549; l=849;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=w1+MRLpQlqWk+mrt0yJy8pQkb3cf8RgO7noQOxVKLCA=;
 b=nWb0FIVRoU7+fyLBkHM9tXMnfqm6Flnn2gHKxXt0krC45Pm5HUIqkb9w/Dc/PB/96rkrQ8ukC
 Xknx9ml/9kdAUdUZYkVn23a4SGYGVDZCfNXM7snM2cVA0QRXZqbO14A
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

The struct member 'j_transaction_overhead_buffers' in 'journal_s' was
commented with partial name. 'make htmldocs' warned about this.

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 include/linux/jbd2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5157d92b6f23..17662eae408f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1086,7 +1086,7 @@ struct journal_s
 	int			j_revoke_records_per_block;
 
 	/**
-	 * @j_transaction_overhead:
+	 * @j_transaction_overhead_buffers:
 	 *
 	 * Number of blocks each transaction needs for its own bookkeeping
 	 */

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240820-journal_s-missing-description-fix-eb128c06d872

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



