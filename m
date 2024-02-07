Return-Path: <linux-ext4+bounces-1142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD084C519
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04511C25782
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1D1CD31;
	Wed,  7 Feb 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0ZmrO1VO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309C17BA3;
	Wed,  7 Feb 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288224; cv=none; b=AMCeTjjY4o6LeLhSPRyv5pRzEDjX5ic17tK/AQAZxZ71Xy0OhwpQDk/kKLjFPDJBVcbtwzonLrsw/tMaKZ+2uQromLUzDo2hvAn1JH3SJX7TWxdl0JETaW+BU6aY1843ylIQibziOWVC2oNxncoqBnClk1QUR3wFIW2Ie1UuvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288224; c=relaxed/simple;
	bh=sYUTU/89PFPnPBoR5kfzfYqhAM5p15Bl509BAaBxeuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bcdcx+aCuVcVRlc4RALuhe3WMp1qrtCOk37UnZzMRjY/v6I5SX77E1YHDB7ZF1pjmjCer3+v1ConPCNu4WfgVcwj+EfkwDKMRqyWUKigl5LFVU8us7eHiIOx1lRX0iWHvmEd8Otwm8PHliKQv4SZQzqDf1GpLCy/rFlQ42EZLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0ZmrO1VO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707288219;
	bh=sYUTU/89PFPnPBoR5kfzfYqhAM5p15Bl509BAaBxeuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ZmrO1VOAw4pQq6H3dURVbvt4b44qK+PfK7EAijDa333nF+w4d74QKrKuW9ghoOu/
	 hybkEXhLvEHWYjDYA+eQoUbIfdTzZ30hVANGUPWMqMKsPnLCiPn02LqZUcN6NPPs0G
	 C4GyOxU93O2t6Owgy7BZ9RDjUXl+kUkln0nNylk4huut4D5JdUzE5e65RewB8SgU4a
	 l2MHw2UgavU9C+SQPZL3VGlHL9fTLRXHze2Vzg/qMXjH1jf6SpWbW7BJDWhVKabt3K
	 nuUoPeE6uezQcmlsIRsWhqbEajMqe5KyzapK1OXEwoUeURxnsYwMuSL1m8LeGEakKr
	 ytD2PlqBybZ9A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC20E3781F7D;
	Wed,  7 Feb 2024 06:43:36 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org,
	adilger.kernel@dilger.ca,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [RESEND PATCH v9 1/2] ext4: Simplify the handling of cached insensitive names
Date: Wed,  7 Feb 2024 08:43:01 +0200
Message-Id: <20240207064302.221060-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207064302.221060-1-eugen.hristev@collabora.com>
References: <20240207064302.221060-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.8-rc3]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..932bae88b4a7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2508,7 +2508,7 @@ struct ext4_filename {
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 05b647e6bc19..e554c5a62ba9 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1445,7 +1445,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1455,18 +1456,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return 0;
 	}
 
-	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
-	if (!cf_name->name)
+	buf = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
+	if (!buf)
 		return -ENOMEM;
 
-	len = utf8_casefold(dir->i_sb->s_encoding,
-			    iname, cf_name->name,
-			    EXT4_NAME_LEN);
+	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
 	if (len <= 0) {
-		kfree(cf_name->name);
-		cf_name->name = NULL;
+		kfree(buf);
+		buf = NULL;
 	}
+	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
+
 	if (!IS_ENCRYPTED(dir))
 		return 0;
 
@@ -1503,8 +1504,6 @@ static bool ext4_match(struct inode *parent,
 	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1513,8 +1512,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			return !ext4_ci_compare(parent, &cf, de->name,
-							de->name_len, true);
+			return !ext4_ci_compare(parent, &fname->cf_name,
+						de->name, de->name_len, true);
 		}
 		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
 						de->name_len, false);
-- 
2.34.1


