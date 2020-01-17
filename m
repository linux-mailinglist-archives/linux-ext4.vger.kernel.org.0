Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DD141375
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 22:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgAQVnH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 16:43:07 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37615 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgAQVnG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 16:43:06 -0500
Received: by mail-vk1-f202.google.com with SMTP id c1so10364470vko.4
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jan 2020 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q4rBdwTpu0kgcesfAqettRZRoe3eJIs+PO2/oZPudMI=;
        b=HgH/cjvrF4Zia0V0+IeU5NYRKU1aapr1ropmrp6wIQEhHKtyjKZuynqRYZXyB6R0iK
         M2gvpJkEsO67KRph9gY05tFOH+FqKAIxduQZ1V9cE1pI6KCoFEgF5hiXeUyBak4o5CHB
         pC2wEBiQBi7O2M65FW7rjDF5NwtzLRJEXal88aPC8G+3EUBIwKRyt9hrc0SevGsO2q9V
         ZhhpNLkkikMSEdps2HlgtM/v/nAVY60CZKzDcl1eyYCbY8yr3hu3NggL9wcq8AT0cych
         /o5RTDmU82+mRI5AKUX31wCwtJqLzhwEPgaDpYSI+MsIUhkkkYw3NWF7A95mbwJx1ey0
         itxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q4rBdwTpu0kgcesfAqettRZRoe3eJIs+PO2/oZPudMI=;
        b=qDRrg32phhr70ZbxZNcsKFsXlXrKEkrqV54hmBqmjDp4EwcpF344hS1lWTOHrP+0Uu
         FIJ4IW8CJU2t3Ue9emQvKfcLy7HT00zcWhX2QKouLBj4+OH4b0Tew+ikHyH5sVwZEgFS
         V08O120e9CjYNamnu9TjZEYLKgKY78I9jQWFwR/R/nFi+Js0CHZJCpZgIn5mtfYvqETW
         sw3/GgQoahQKNPsp+gAzUH/C/VR54VQiw5bM5OR7ATEPvww0BM6qXGm0EyA6orgZXq1M
         NY2NZ1zjm4Fmsxy1kwb1JvsD0hLbsm+JX/zfiy+thlLQLlD+xIa2U8XBhFnIa6xJsS5M
         dZyQ==
X-Gm-Message-State: APjAAAUUXvhKVCmIVGBTrOBbVmHWwy0RAl12bFny/scWBUK1Kn0ij616
        6XOugdZdnucKoqNLPLsPW3pyfyq590c=
X-Google-Smtp-Source: APXvYqxzCff7DvKzBojWKyAGZ3dq8QFpSmD6KoOeo/TuurTUuCeKd0w8VmzzbGwNUGOYIzxOpi9DPxWBE9M=
X-Received: by 2002:ab0:48cf:: with SMTP id y15mr24885192uac.26.1579297385289;
 Fri, 17 Jan 2020 13:43:05 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:42:41 -0800
In-Reply-To: <20200117214246.235591-1-drosen@google.com>
Message-Id: <20200117214246.235591-5-drosen@google.com>
Mime-Version: 1.0
References: <20200117214246.235591-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 4/9] fscrypt: Only create hash key when needed
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If a directory isn't casefolded, it doesn't need the hash key. Skip
deriving it unless we enable it later.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/keysetup.c |  2 +-
 fs/crypto/policy.c   | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 7445ab76e0b32..c0db9e8d31f15 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -217,7 +217,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 	if (err)
 		return err;
 
-	if (S_ISDIR(ci->ci_inode->i_mode)) {
+	if (S_ISDIR(ci->ci_inode->i_mode) && IS_CASEFOLDED(ci->ci_inode)) {
 		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
 					  HKDF_CONTEXT_FNAME_HASH_KEY,
 					  ci->ci_nonce,
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 2cd9a940d8f46..632ca355e1184 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -10,6 +10,7 @@
  * Modified by Eric Biggers, 2019 for v2 policy support.
  */
 
+#include <linux/key-type.h>
 #include <linux/random.h>
 #include <linux/string.h>
 #include <linux/mount.h>
@@ -591,6 +592,8 @@ int fscrypt_ioc_setflags_prepare(struct inode *inode,
 				 unsigned int flags)
 {
 	union fscrypt_policy policy;
+	struct fscrypt_info *ci;
+	struct fscrypt_master_key *mk;
 	int err;
 
 	/*
@@ -603,6 +606,28 @@ int fscrypt_ioc_setflags_prepare(struct inode *inode,
 			return err;
 		if (policy.version != FSCRYPT_POLICY_V2)
 			return -EINVAL;
+		err = fscrypt_require_key(inode);
+		if (err)
+			return err;
+		ci = inode->i_crypt_info;
+		if (ci->ci_hash_key_initialized)
+			return 0;
+		mk = ci->ci_master_key->payload.data[0];
+		down_read(&mk->mk_secret_sem);
+		if (!is_master_key_secret_present(&mk->mk_secret)) {
+			err = -ENOKEY;
+		} else {
+			err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+						  HKDF_CONTEXT_FNAME_HASH_KEY,
+						  ci->ci_nonce,
+						  FS_KEY_DERIVATION_NONCE_SIZE,
+						  (u8 *)&ci->ci_hash_key,
+						  sizeof(ci->ci_hash_key));
+		}
+		up_read(&mk->mk_secret_sem);
+		if (err)
+			return err;
+		ci->ci_hash_key_initialized = true;
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

