Return-Path: <linux-ext4+bounces-5504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1169E9E7741
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684AB188252E
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280182206B2;
	Fri,  6 Dec 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E1pRIEDI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF50220697;
	Fri,  6 Dec 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506134; cv=none; b=mQk/5B02Fl3R77uCfWXjMtODBvv3MlWkbzNJaEL3TeiL1vEli94/pVPCJ1LxVS0CeEK2/00/401WsOA2ekG8SJQ04N2feAUS7OgdxVWHyBX/GhIhee2GYswwUYMJIAVJ+ZcaSLfv0v5Jej3BvapGwQS6N+PYVV1TDtfiA6An750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506134; c=relaxed/simple;
	bh=FCFFp4lJ0eHx/aMpS3OCV9F9xnKYBez2NRREyrb7Mls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crXpPkRFbD+6amv3MY23rlT703lLyEZW6nVuK7OgMbiAeSd71C7AUpu0sLPkC/keSpGT1qLTZ+ATq9yFt5abEWac5OzUNxg9uUA3oWD2Uro6WAnOmmD6WFPPCh9po+GkzA8pFzEu+UCv0HuZvhdq0LCHIunLrP++4Rzv0zV5hjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E1pRIEDI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6iVLZzEIOo2SG6lIQurpFi2Z8md7I09POZIXP4exDHM=; b=E1pRIEDI1wKeFHkrrH/0Foyd1x
	RNcECO4K/F+4skd09UweOVPubR97tFkqzQQjJJoSl1eCMTiRUJdYtiwR6WvaHweYGjeFivPq3Lb79
	h/RqcNqFJD1o5k/almU7x4CcVkZ3aal35J3KXVL4+SY5VtKYf2C/PP/Tn551EImuQg4CxZzYDKwoO
	UjZ8MZNtmYWSdhJ90K4w1cGFbWbHFN9fzG1MYDB4ISjVqUB5WM2Eqi7av1UKS8K5KFJfUqw5C5gb6
	IhdVal6eYLl5xaYlZD8Hd7O36/jMonW5ilg1kJRmE1aacRyGC8n/BHQ/lL4ykg+TnIKMFerT0h5Tg
	oXydGHYA==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8H-00HUmO-2Y; Fri, 06 Dec 2024 18:28:49 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 1/5] ext4: inline: remove extra size check when writing data
Date: Fri,  6 Dec 2024 14:28:24 -0300
Message-Id: <20241206172828.3219989-2-cascardo@igalia.com>
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

ext4_prepare_inline_data which is called right after the removed check has
the same check. This avoids extra calls to ext4_get_inode_loc and having to
traverse all xattrs in the inode twice for that check.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 401a224f0956..0611a050668b 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -668,9 +668,6 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	struct folio *folio;
 	struct ext4_iloc iloc;
 
-	if (pos + len > ext4_get_max_inline_size(inode))
-		goto convert;
-
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
 		return ret;
-- 
2.34.1


