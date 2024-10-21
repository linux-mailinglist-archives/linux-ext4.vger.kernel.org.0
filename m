Return-Path: <linux-ext4+bounces-4666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA09A6FB3
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41A31C2247C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534781E47AB;
	Mon, 21 Oct 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TzOvSN86"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8181CEE82;
	Mon, 21 Oct 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528669; cv=none; b=hDXrrguzCY1Nj/GrKj4hf/UMfqbiYxxpb9aDlzBVmzQvioFAo8sWRFzAW5keFjUgbCBIZKhn3H/h0HdDJPJtLV3btoMzycKrtJXLwfNcCRa6Bgg+Ig/RY19u3BmAfNxpQ8mzD3eddLL5sdwv6cHPctL8y/bArvNZSvTEWp2lqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528669; c=relaxed/simple;
	bh=Y1+TqC1QSPzsw327ZOelozQfHwXx4r/BkSAID2hIpxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJwrbDEMz3vHH7smqphDdee85oeVc+VJraovmAk3xyuCFtzGt9VlC2V75q3lxekrdnDNu4vDsk6CyO302mYniV3yew/SExEWOzM7/b7Xk8MNnaQ7EjXfIJN1QAmB4jX7uzRNUSgbK7y+BslrEeF5t5CDT2sHlr7cS59v1pmc8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TzOvSN86; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=obDU9EHbEhqof+DC3Mpb90bnlOdtfiD2TGUUZBgS1/4=; b=TzOvSN86Pc5lOEJyIyNaopXvpo
	pXtrTFCTvteTp4CsMQc2j3sz+uwaQGRL3vXhHKdUBCR0UDWeJhnePOpF32OB8TROfpZSJexcW7Nt2
	L0DgsV3sWGDWMgstbgBiuyxDNZAad/yNAX5NubC3zf4bkMtBHishTKKeKeXXkFEBjL4Lj1pk/6FKN
	o+2nw9fFaQUTZ6Dfr9zssLw50nWf3/+wU+TsFYkTg8nvvpMOHtH+0VuqwUyGOnlnmpJwF/sG6gNSa
	+3T3MhfiVC7KKag5fLdXGYf7eDTVA/lo/WHREEPwf6jCH5yiJ9VXX0Uj34rVZsr4iPjztD3en9SJO
	VLVbeL5A==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vPa-00DECf-1w; Mon, 21 Oct 2024 18:37:42 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 21 Oct 2024 13:37:17 -0300
Subject: [PATCH v8 1/9] libfs: Create the helper function
 generic_ci_validate_strict_name()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-tonyk-tmpfs-v8-1-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
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
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Create a helper function for filesystems do the checks required for
casefold directories and strict encoding.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v6:
- Correctly negate utf8_validate() return

Changes from v4:
- Inline this function

Changes from v2:
- Moved function to libfs and adpated its name
- Wrapped at 72 chars column
- Decomposed the big if (...) to be more clear
---
 include/linux/fs.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c152c70b7f1f3e0154f6e66a5aba33..403ee5d54c60a0a97e2eba9ef80d8fb4bbd2288f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/unicode.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3456,6 +3457,50 @@ extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *folded_name,
 			    const u8 *de_name, u32 de_name_len);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+/**
+ * generic_ci_validate_strict_name - Check if a given name is suitable
+ * for a directory
+ *
+ * This functions checks if the proposed filename is valid for the
+ * parent directory. That means that only valid UTF-8 filenames will be
+ * accepted for casefold directories from filesystems created with the
+ * strict encoding flag.  That also means that any name will be
+ * accepted for directories that doesn't have casefold enabled, or
+ * aren't being strict with the encoding.
+ *
+ * @dir: inode of the directory where the new file will be created
+ * @name: name of the new file
+ *
+ * Return:
+ * * True if the filename is suitable for this directory. It can be
+ * true if a given name is not suitable for a strict encoding
+ * directory, but the directory being used isn't strict
+ * * False if the filename isn't suitable for this directory. This only
+ * happens when a directory is casefolded and the filesystem is strict
+ * about its encoding.
+ */
+static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+{
+	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
+		return true;
+
+	/*
+	 * A casefold dir must have a encoding set, unless the filesystem
+	 * is corrupted
+	 */
+	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
+		return true;
+
+	return !utf8_validate(dir->i_sb->s_encoding, name);
+}
+#else
+static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+{
+	return true;
+}
+#endif
+
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)

-- 
2.47.0


