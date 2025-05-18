Return-Path: <linux-ext4+bounces-7954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF01ABB0F1
	for <lists+linux-ext4@lfdr.de>; Sun, 18 May 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9973A64FC
	for <lists+linux-ext4@lfdr.de>; Sun, 18 May 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271A21D3C7;
	Sun, 18 May 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Vk7FKQQQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977B21CC55;
	Sun, 18 May 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747586947; cv=none; b=VSlT3Isq/onTBRh7eW3tVoPtHUsSkQnklab59gEp/FMQ1zfYrZYqmX4Ds6irntevkFA/ogh40Hc+q//vH6FzGw+yZvSGVcj98R0qnmvY/XP1qDdXxVv950OHGtfZKpVKHsbe+pKsFjc/oiubN8/kA2gmXTfvmYZvNs3twX3MlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747586947; c=relaxed/simple;
	bh=nURDTX3oA98c5WUnqRp3AZaFPfTyYRIqNcyheLeZwxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q/usRjNv47ZxU9ifk/vZcixmnmJeYUh3YprQm37uQ0ECtwlsw8/iNYsVGppwfGhdZv7pAh09hpI8xHNEBXqwbKXpytmQq4tLJk0FHHrNWTRsR9dmNGsuAJ3eBeyZZp/o5OyE9fbTQLHG4gk61UHUjcTeXbIVbvwOj1ydyX6VP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Vk7FKQQQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b0mx30FQmz9sqg;
	Sun, 18 May 2025 18:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1747586935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BxmCFkZ1O7ZrSEj+Oaqix6KX/+I1cvs+0DgBW5fJd/s=;
	b=Vk7FKQQQUFXwhl984H2BQO7pMrnxjtp4l3luxEV1p4zQArh0CAlXnixe/30rcyRIEfkoUn
	rmuAmfT7LShJ3v7OgDfHBbL9X8RiCRb/+KSNrNAh5LQN/ekIt3dWp/xdvNQO0FGILHkBY7
	jHejUTA4bKKbcRtoJBeuOC9QVHEYfJ1o4j5LQwR2JBnqTvMW8Ov6qloGiA9FACsD+sPIyv
	q3yOS1jp2/gBbgBc1WU9bpahmiYUw11gtyeR2s6r5jWFW6igIHwazuNU8bw2HsBR4Iym7W
	7lcFrq8CqkhgjgnVYd1rAcSQ+9Tb1XWSOiB5KTkx4+mD+jW8ypo/KHWy6pu/dg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 18 May 2025 12:48:50 -0400
Subject: [PATCH] ext4: replace strcpy() with strscpy() in
 ext4_init_dot_dotdot()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAHEPKmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0ML3dSKEhPd4pKi5IJKXUNTE9NkszRzyyRTQyWgjoKi1LTMCrBp0bG
 1tQC9rjcTXQAAAA==
X-Change-ID: 20250518-ext4-strcpy-1545c6f79b51
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=nURDTX3oA98c5WUnqRp3AZaFPfTyYRIqNcyheLeZwxA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpHanhGd1YvQ04vMWMwWDUwVGplcTZ4Skhvd3NvamZGCnJJNDd2SXJlMWFYVnQwSzRN
 cnlqbElWQmpJdEJWa3lSNVgrT2N0cER6UmtLTy8rNk5NSE1ZV1VDR2NMQXhTa0EKRTNHTlptUTR
 5OVFiZmJwbGNrV3hkT2pMSlAzUVRWZi81TWQ4NlJBMFdkbDFmTEo0d2hzRmh2OStqdXlwNzRXeQ
 pOOXlhTFRRbk43bHkrYW1HSU9jM0tpLzNpMCtlMUZsMnJwZ2RBS2ZGU1ZnPQo9clN6MAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4b0mx30FQmz9sqg

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/ext4/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e9712e64ec8f04586f5ebcd332431e6af92e4f36..85df7fbf8ebd2c5b2aa3a20813f5f8a1aec7f5b7 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2926,7 +2926,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->name_len = 1;
 	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
-	strcpy(de->name, ".");
+	strscpy(de->name, ".");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	de = ext4_next_entry(de, blocksize);
@@ -2940,7 +2940,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 		de->rec_len = ext4_rec_len_to_disk(
 					ext4_dir_rec_len(de->name_len, NULL),
 					blocksize);
-	strcpy(de->name, "..");
+	strscpy(de->name, "..");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	return ext4_next_entry(de, blocksize);

---
base-commit: 5723cc3450bccf7f98f227b9723b5c9f6b3af1c5
change-id: 20250518-ext4-strcpy-1545c6f79b51

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


