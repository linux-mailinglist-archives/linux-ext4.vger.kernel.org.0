Return-Path: <linux-ext4+bounces-5505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE39E7745
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35220188849B
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E787203D45;
	Fri,  6 Dec 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LftnPVdM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9048220693;
	Fri,  6 Dec 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506136; cv=none; b=UfABRAro3CpbGvOZmkLIBU/vM0jg4ITeiuVByFU7C/HHECwuG0fTGNNGhG3JLcoiSbpy3MMpf7EUVZqN7WqFdMnD+OrqV1Vnk+qJbMk6Son/ERT7OQjW2f24v9krndlkS3m1XNJB+h787lmHM0OAWHHsNxJ12UY4oBG/SaOYrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506136; c=relaxed/simple;
	bh=pHWZa4vK1ZlwFD/lHE6eNlpJdnbNeWot04QpsBn/bQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPG+rhQ9S2Erp6r5sj8OKZmIX3YSUxHwsE5nHEsYp0e5KQkbkgW0yT93YIGJu2QB8oCYeTk9qm8s1GM6MDJSKPEKRmCj0su1lyztnd1DTC+8ZWzIix/f8wq11CAgTbCaWmz5mInN98Q5DBZrW6hxv2GPYZFTW7KsepCFJKC6dvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LftnPVdM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G7aF1n7cH8I2dw6cg9IiqZOJN473ZcdDet5KDFTx97w=; b=LftnPVdMUxF2ArEa1LcLttfVwl
	G3XIZNndG/B2Ojua4U2B1edSFQaSXHa6xEP3zW2Qq+IY+iXD+42LQ9y8jQoJ0H5fKAc3rtFZr203O
	gXvRMnVk9Xu7cJexe4RhQd/ZgLlCrSR9DjkxxooSC+J+yV9gMBtDPOACfYEwdGie37jf8iLtYhQ/H
	TfGTVR4ta5U3Kf30bozBm9i5tU6IqW8oROvaWB5YdohbtFJs8RC2edn2jndiHmozIIwfBAyJlOYAf
	PXBxrgqUvARAYWWnc+2o/7ZLWPgTaOUW6qe6InkGudZiR4wUUt1jyx6DMXjphHOJc6HAFCuJ58Hbb
	o3AttEZQ==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8J-00HUmO-GJ; Fri, 06 Dec 2024 18:28:51 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 2/5] ext4: inline: use cached i_inline_size instead of e_value_size
Date: Fri,  6 Dec 2024 14:28:25 -0300
Message-Id: <20241206172828.3219989-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206172828.3219989-1-cascardo@igalia.com>
References: <20241206172828.3219989-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i_inline_size caches the total size of the inline data, it is always
EXT4_MIN_INLINE_DATA_SIZE plus the size of the system.data xattr value.

This avoids looking up for the entry again, which allows i_inline_off to be
used to point directly to the inline data.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 0611a050668b..b49cfcadbd36 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -80,10 +80,8 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
 
 	if (EXT4_I(inode)->i_inline_off) {
-		entry = (struct ext4_xattr_entry *)
-			((void *)raw_inode + EXT4_I(inode)->i_inline_off);
-
-		free += EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size));
+		free += EXT4_I(inode)->i_inline_size -
+				EXT4_MIN_INLINE_DATA_SIZE;
 		goto out;
 	}
 
-- 
2.34.1


