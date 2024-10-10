Return-Path: <linux-ext4+bounces-4554-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A069992C6
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CCC1C22930
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54E1E5732;
	Thu, 10 Oct 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DWh5LAbu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00F1E379F;
	Thu, 10 Oct 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589272; cv=none; b=h9DmgyVP1Tt+gG04RaBzhPU588IxZW/QouBcDOOQ9EwxRhY2jaT7VsfaIsnTI50M4PhNRYk7ohLAaI0KhPQg3FC0kGo/EX3aKj9SbLEPsq8c9f4sprVUvg670yjIyIo868vGEe4bVoVBJG+RA11a1hdYaY9U5HB6PehCqWTJgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589272; c=relaxed/simple;
	bh=3NOu1Q+Yns95EfGtXDCM6tiXYbYx0Sjfavo/kztUt8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQuXhgilZnAg5OU7QcBAKWcsvGHNptIASKML4cL+lz0QyN6lwwiGa92y+wtEstyPkDORlJ8zFFNIDGkSFth+DRkkOHHTknS1U32M411Dc/wfPXqNC8Mv9S5DbF2Yq4NSwT6aVxkzOwo2hM5v155XLBPM9o1yh0YSOA0grOTl0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DWh5LAbu; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sdXGjKgs/rhRe8l19F01/brI44jeC/ablpb8vlTIOo4=; b=DWh5LAbuzvrFfI8q3pnduTIg0s
	RXIu8j3fHbDuSLBLGVQsUPFVBhbhX9XL5iBvP0PfwDrJpJFWYfbEJJVexYEcByIq/md6nNcVKO9VX
	lsEGXuYGUFtfvKdlEHpZGscyOON7IxJcGXhF17P3W5tmsZwb8RUgSusxruV+oi4LkGgHCkmPPbGO8
	toQDAbyZixKMWnkXBYJx5F2P/77DtFxkskUlpuuhpUJ6NN3nDwuPfGlPeasXsW1TNA9yWA2wCscvs
	KypErmDLlSXacL7q+CPiTmQjQ2JHvTXQVrlp872EyvNHKj14nv+tAAmtcgWIgRvQHzjJaNWBDg/ci
	07QFXuew==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz23-007SHz-7a; Thu, 10 Oct 2024 21:41:07 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:37 -0300
Subject: [PATCH v6 02/10] ext4: Use generic_ci_validate_strict_name helper
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-2-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Use the helper function to check the requirements for casefold
directories using strict encoding.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
Changes from v4:
- Now we can drop the if IS_ENABLED() guard
---
 fs/ext4/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2ad5e1790e363e4ac273162e35013..612ccbeb493b8d901c123221ef6573457193dd16 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2395,11 +2395,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	if (fscrypt_is_nokey_name(dentry))
 		return -ENOKEY;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    utf8_validate(sb->s_encoding, &dentry->d_name))
+	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
-#endif
 
 	retval = ext4_fname_setup_filename(dir, &dentry->d_name, 0, &fname);
 	if (retval)

-- 
2.47.0


