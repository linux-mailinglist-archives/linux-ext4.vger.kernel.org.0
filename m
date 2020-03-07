Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAC17CB13
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2020 03:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCGCgr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Mar 2020 21:36:47 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36782 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCGCgq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Mar 2020 21:36:46 -0500
Received: by mail-pl1-f201.google.com with SMTP id bg1so2530376plb.3
        for <linux-ext4@vger.kernel.org>; Fri, 06 Mar 2020 18:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=voLmfNHCEAsUj1t7nCxgSA9Y75G0q2ard7Ul69iPgyE=;
        b=ZUjBrxbfMPRhNcKXsujkMfTBsDi7260b6iA1v68ODA6TQ/zTU2NXDbEy5j2fpf2qKL
         fzlr30xIQkO7sFofoDb4XryOVTaSKoEdS2CTxOm3HC7bUwueB8pBc4P/aR24dCLInM3k
         ZX7c0iRim3aAYDsNxcgnSOr1U6vatlMLFlDh3gx6/nF0X6rj90nSenuRGG+m78B3jf9R
         Ep8sLbldqAxEvV+N4ZYRfRSQujF9+jWkPkc7EQDvmfuQkRlRwrTNAz3C5qMhYbCl9M4F
         vl8/SXOqD08TjRAub9L/5GhPse1lBiv4AzzaibZkva36DNVabBsTXOvtaYmQz8ehjIDv
         /bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=voLmfNHCEAsUj1t7nCxgSA9Y75G0q2ard7Ul69iPgyE=;
        b=gkq6fTgCcPVUiaer4F4HoX/9wAczxWz7pzVNuOuSsnalkfq58HnyI59C2nZUHcX/I0
         Wv0KRxmhlPAcvkGTWP7c29Lz+492MTYQaN1Pa51ZZia4S924KqijSV+Iqb8TGuS7WM2U
         0ExxITzT0thPaWXnptdm8sK2anQvnbHFnT6YqpXrdBNwFsJb4oVfD9TEi9mIeS/RM/DW
         2agwuRcMpP3t47KlQRvi7NNioIDykt1u5EeC0p9CRnJXxowwq6/r3FO7U0lEhHOdgXDd
         zNF2D5OxmeG8Oxl/RUiqL6nGf0LLwqgpFxS2Wz1Y0BBiDLhyLiY5j4r0dkEnnoJc/+NF
         nM3Q==
X-Gm-Message-State: ANhLgQ1K0mY8rEHc+13rRBw9uc1cXy0HTkHagto+SaybAjZOK1G3/u57
        o7/t6kSX/gdbwMuR4fpKed3mLx2NMlU=
X-Google-Smtp-Source: ADFU+vuqkVmleIVLhKPiL1OxVdIlhECjzIJTvPSZbDI75NgCC2aoisXFaecuThUwcuon+CY2/vgKdX0I5lQ=
X-Received: by 2002:a17:90a:37d0:: with SMTP id v74mr6656285pjb.0.1583548605689;
 Fri, 06 Mar 2020 18:36:45 -0800 (PST)
Date:   Fri,  6 Mar 2020 18:36:08 -0800
In-Reply-To: <20200307023611.204708-1-drosen@google.com>
Message-Id: <20200307023611.204708-6-drosen@google.com>
Mime-Version: 1.0
References: <20200307023611.204708-1-drosen@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 5/8] fscrypt: Export fscrypt_d_revalidate
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is in preparation for shifting the responsibility of setting the
dentry_operations to the filesystem, allowing it to maintain its own
operations.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/fname.c       | 3 ++-
 include/linux/fscrypt.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 4c212442a8f7f..73adbbb9d78c7 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -543,7 +543,7 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
  */
-static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
+int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *dir;
 	int err;
@@ -586,3 +586,4 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 const struct dentry_operations fscrypt_d_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
 };
+EXPORT_SYMBOL(fscrypt_d_revalidate);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 556f4adf5dc58..b199b6e976ce3 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -176,6 +176,7 @@ extern bool fscrypt_match_name(const struct fscrypt_name *fname,
 			       const u8 *de_name, u32 de_name_len);
 extern u64 fscrypt_fname_siphash(const struct inode *dir,
 				 const struct qstr *name);
+extern int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 extern void fscrypt_decrypt_bio(struct bio *);
-- 
2.25.1.481.gfbce0eb801-goog

