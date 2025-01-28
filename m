Return-Path: <linux-ext4+bounces-6258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C8A2063D
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C91888B28
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5C1DF971;
	Tue, 28 Jan 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KiZy6m6/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6541DDC22;
	Tue, 28 Jan 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052893; cv=none; b=ivKhjOc4QaUNU4qrMMs/5WREVWsEN+IwNovYrPC4TCFPEgNij1s8BoVYRryelvNMDWYf/N64WmtO6te7Ed4ryF6lGPuZD7i9uDmNOzopCcDpw1qK91XrL730O3nYI4U/gC4BxW0ayph5yfNVAOLcB9Mfxdoi1i2bNGDx/WV7ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052893; c=relaxed/simple;
	bh=LPM40brnTJ2o/aChTalckr1MK0e3W1owl3WgBKynuz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kz40pvS9EOqgQpEX/9U9owTJZq+yb8WnwfVi+ajYeTSFDLJGlsaZRcuWuxCR/hLv/uYQUve5ehIjzdMoVcJFNlSaIVm7KUlvYXy2IXy/UrXsVFcGEtFD0sdWnC2vV6Gvu7IitKaOKUo2KrzTZyOtlBxp//vo1/p1L4L+OJjf7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KiZy6m6/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GizObG1c6aGFToHOXvqwxOfsWXQQRJGo64/YXvK8T+E=; b=KiZy6m6/llHH5z8o6+dKjQBejR
	9Pe8SaO30BUK2LADn8Fun5EqZpGBSR8pCKsS4+M7eW8559EHhqrsyUS3Z0lLdgFI5hoVEJMGnsf3O
	4V0vNOruaTUp04ojbLndmjNUamzK7i2MKXWOijAwRd9oMor+1cLfzmL/Z1ZWfXZQhBbjXlf4MPWMl
	neS3jW4UFZUxXKpA1Cgz3NB80s6fzcwLsbWC+uP3XNBC0H3AANmiJdbTbwXw4kKKIMm8qvUIuRDeN
	bW4x5cpWUS2+6sYj5xdVhK/QG0o9jtzjhvMW9eer8zawsFld9oEgY07csgyZNzW7qJskJ2QK0pMFt
	oxhLt1lw==;
Received: from [223.233.66.58] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tcgx4-003dn0-Kh; Tue, 28 Jan 2025 09:28:06 +0100
From: Bhupesh <bhupesh@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: bhupesh@igalia.com,
	tytso@mit.edu,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	revest@google.com,
	adilger.kernel@dilger.ca,
	cascardo@igalia.com
Subject: [PATCH v2 2/2] fs/ext4/xattr: Check for 'xattr_sem' inside 'ext4_xattr_delete_inode'
Date: Tue, 28 Jan 2025 13:57:51 +0530
Message-Id: <20250128082751.124948-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250128082751.124948-1-bhupesh@igalia.com>
References: <20250128082751.124948-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once we are inside the 'ext4_xattr_delete_inode' function and trying
to delete the inode, the 'xattr_sem' should be unlocked.

We need trylock here to avoid false-positive warning from lockdep
about reclaim circular dependency.

This makes the 'ext4_xattr_delete_inode' implementation mimic the
existing 'ext2_xattr_delete_inode' implementation and thus avoid
similar lockdep issues while deleting inodes.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/ext4/xattr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6ff94cdf1515..b98267c09b00 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2935,7 +2935,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 	struct ext4_iloc iloc = { .bh = NULL };
 	struct ext4_xattr_entry *entry;
 	struct inode *ea_inode;
-	int error;
+	int error = 0;
+
+	/*
+	 * We are the only ones holding inode reference. The xattr_sem should
+	 * better be unlocked! We could as well just not acquire xattr_sem at
+	 * all but this makes the code more futureproof. OTOH we need trylock
+	 * here to avoid false-positive warning from lockdep about reclaim
+	 * circular dependency.
+	 */
+	if (WARN_ON_ONCE(!down_write_trylock(&EXT4_I(inode)->xattr_sem)))
+		return error;
+
+	if (!EXT4_I(inode)->i_file_acl)
+		goto cleanup;
 
 	error = ext4_journal_ensure_credits(handle, extra_credits,
 			ext4_free_metadata_revoke_credits(inode->i_sb, 1));
@@ -3024,6 +3037,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 cleanup:
 	brelse(iloc.bh);
 	brelse(bh);
+	up_write(&EXT4_I(inode)->xattr_sem);
 	return error;
 }
 
-- 
2.38.1


