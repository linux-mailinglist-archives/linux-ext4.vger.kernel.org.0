Return-Path: <linux-ext4+bounces-14244-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIFXL0GXo2neHgUAu9opvQ
	(envelope-from <linux-ext4+bounces-14244-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:32:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242351CAEB4
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 606573062946
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36E274B5F;
	Sun,  1 Mar 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwaKSHDF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884722BD0B;
	Sun,  1 Mar 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328143; cv=none; b=Jt88IppmTlOtHr9InH3qcb4OovXtJxuA/PLhwS6Es9KMwe2UliU5rscchMaa4qMkWHt5wFXy9dqAASXne6GhLiZaEW/6UnIjcZFuTsYix/4j2FwMu8s6nsg4V2RE0rd8txVOjsDE+eC7pZtJpWNzSoZLzNqqo5ymwrTlSi91Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328143; c=relaxed/simple;
	bh=3udxCldliSMHTiQ1S/MVj2hfIr5+GBtaPZMiJjz7lh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVVprKp2nHp1YyFaypaV4XjtsT6GkyNup9eaozDmYUnP5sGr5AjyGlyx7ajVpYKkGtoifiYNMWi+nJeqhz97iCoXZbpRpdwxsBXJJRH4ppdKu4EUFrsH1p5dyH5h0v9bJumknLJ2cEL5qLThqO7ydKOPRpRXUQ7mr3DbdReZtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwaKSHDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB00AC19421;
	Sun,  1 Mar 2026 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328143;
	bh=3udxCldliSMHTiQ1S/MVj2hfIr5+GBtaPZMiJjz7lh0=;
	h=From:To:Cc:Subject:Date:From;
	b=PwaKSHDFXQKXXk3+JilfE0iusK2PI+9eN7fXWipnCMqb2G0v04yt2Cjisnqw/e5C1
	 w6qqjSCj99znYPSoxZjxv2iofs4a+pcE+cgMPdM0fJsym0wKvrcxX7toGasQRP6rYI
	 e7epYKfVydp6c8jQ/jpyUeXBTal45xRrlU5W6Jn6RvIsTAaP5mzhROYO03/Nbs01At
	 u/29s2QkNfqZheWz9kE06SZUND6pjiKFtJ1ODomo+IUAW/Y/x0r0ARVQ5hT+0ycHAT
	 CBa61oBZOsVQR7yLIOFxHrYI7AH3MCd2dqhmtqKUyL9K/8gp6bmhA8SFniRCqaRVoY
	 QeisGsajMwbNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zilin@seu.edu.cn
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: fix memory leak in ext4_ext_shift_extents()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:21 -0500
Message-ID: <20260301012221.1678711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14244-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 242351CAEB4
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca81109d4a8f192dc1cbad4a1ee25246363c2833 Mon Sep 17 00:00:00 2001
From: Zilin Guan <zilin@seu.edu.cn>
Date: Thu, 25 Dec 2025 08:48:00 +0000
Subject: [PATCH] ext4: fix memory leak in ext4_ext_shift_extents()

In ext4_ext_shift_extents(), if the extent is NULL in the while loop, the
function returns immediately without releasing the path obtained via
ext4_find_extent(), leading to a memory leak.

Fix this by jumping to the out label to ensure the path is properly
released.

Fixes: a18ed359bdddc ("ext4: always check ext4_ext_find_extent result")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20251225084800.905701-1-zilin@seu.edu.cn
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 27eb2c1df0128..e0295e0339b49 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5406,7 +5406,8 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 		if (!extent) {
 			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
 					 (unsigned long) *iterator);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto out;
 		}
 		if (SHIFT == SHIFT_LEFT && *iterator >
 		    le32_to_cpu(extent->ee_block)) {
-- 
2.51.0





