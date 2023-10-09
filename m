Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B07BE33F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Oct 2023 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjJIOns (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Oct 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJIOnr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Oct 2023 10:43:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044868F
        for <linux-ext4@vger.kernel.org>; Mon,  9 Oct 2023 07:43:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40684f53d11so46501495e9.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Oct 2023 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696862624; x=1697467424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp8oeCHkXnZ8PoMfDAewrEbM2hzEMNE0S/oIdHJqQHU=;
        b=KbxDPeGE97rYRx2p2uojWNblc2edIjGQvh6H+zrw1U1rxHuEof+uIBTSkR12YdxAiB
         X9SomFgE7mFfxZGPcceWMBF3bq7JRYKUZtKtUMzYN8ERVgjDROBIFbzXxFWT65x32yfT
         JW6wzh7ZXdGWp8HpVbpf/a1W/TxfP4khssEggkONfPMiWB84061fdO/VmGBYaCWlVJDf
         DP7X0phi+dkLUbsQxeHtmjh5Fn0VS1CqXs924qC4iBkfhk+oAO5r+etf9HmZrHOWg7u4
         Hpv0o385C3vti9wN39OkgV/M1I2qJ97shKuSlnSmWhXoQDP6daoFw2NO7zebnrccvXgn
         xnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862624; x=1697467424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp8oeCHkXnZ8PoMfDAewrEbM2hzEMNE0S/oIdHJqQHU=;
        b=HpoC1efT6jwb+dit7z7llxM4m+0WepwkNeicLy9STPOazJjTTe0ko5p5rnX2nRKszJ
         m8a4MW+SELx3vgtETmCjf91XbrEMaTNpcm/jLRiRDU/MEI96DQXYw92uoM4V6GT0n7QH
         yqkhW+kOQp/ZdxlKyyJf34f0spQOOCCxZhI23YbvpulT5POPlltMU98ZzOUiznPOOkKK
         XPDiyEs0kqhtC+zBMETCVi8CFVZvx9rdXCY3VA64S+CEtq4YEa6TBqIC2kp9L2vYC30I
         2Zc7/9stul1sYpzbjL3BrZe0S0XAqsg3+axq+sP01970iMzF4GuSw7NMBinay5ifRvi6
         KqrQ==
X-Gm-Message-State: AOJu0YxMB/6JNO80N1bkazCgjDI2aQsH0Y5S4wF70D2BpfE5LEoJmZ1+
        Cjdz4V6Je76S0shgxUDE1FGb3g==
X-Google-Smtp-Source: AGHT+IFB1VcFZ4y7Snikt2+wlwEWsrBD1X8xjvYbCePNHvXgt5pS497npCfYbvtTbkx9mmpnSiyiPw==
X-Received: by 2002:a7b:c419:0:b0:402:f5c4:2e5a with SMTP id k25-20020a7bc419000000b00402f5c42e5amr13938953wmi.37.1696862624328;
        Mon, 09 Oct 2023 07:43:44 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b004068def185asm11433113wms.28.2023.10.09.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:43:44 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Subject: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL support is disabled
Date:   Mon,  9 Oct 2023 16:43:39 +0200
Message-Id: <20231009144340.418904-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

One important implementation detail of the posix_acl_create() function
is that it applies the umask to the "mode" parameter.  If
CONFIG_FS_POSIX_ACL is disabled, this detail is missing and the umask
may not get applied.

This patch adds the missing code to posix_acl_create() and to three
filesystems that omit the posix_acl_create() call if their individual
ACL support is disabled (CONFIG_EXT2_FS_POSIX_ACL,
CONFIG_JFS_POSIX_ACL, CONFIG_CEPH_FS_POSIX_ACL).  If
posix_acl_create() never gets called, the umask needs to be applied
anyway.

This bug used to be exploitable easily with O_TMPFILE (see
https://bugzilla.kernel.org/show_bug.cgi?id=203625) but that part was
fixed by commit ac6800e279a2 ("fs: Add missing umask strip in
vfs_tmpfile") last year.  The bug may not be reachable by userspace
anymore, but since it is apparently still necessary to apply the umask
again in posix_acl_create(), there is no reason to assume it's not
necessary with ACL support is disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h           | 6 ++++++
 fs/ext2/acl.h             | 6 ++++++
 fs/jfs/jfs_acl.h          | 6 ++++++
 include/linux/posix_acl.h | 1 +
 4 files changed, 19 insertions(+)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 51c7f2b14f6f..58349639bd57 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1194,6 +1194,12 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
 static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 				     struct ceph_acl_sec_ctx *as_ctx)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	 * ACL support is disabled at compile time, we need to do it
+	 * here, because posix_acl_create() will never be called
+	 */
+	*mode &= ~current_umask();
+
 	return 0;
 }
 static inline void ceph_init_inode_acls(struct inode *inode,
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 4a8443a2b8ec..0ecaa9c20c0c 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -67,6 +67,12 @@ extern int ext2_init_acl (struct inode *, struct inode *);
 
 static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	 * ACL support is disabled at compile time, we need to do it
+	 * here, because posix_acl_create() will never be called
+	 */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index f892e54d0fcd..64a05e663a45 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -17,6 +17,12 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
 static inline int jfs_init_acl(tid_t tid, struct inode *inode,
 			       struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	 * ACL support is disabled at compile time, we need to do it
+	 * here, because posix_acl_create() will never be called
+	 */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 0e65b3d634d9..54bc9b1061ca 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
 static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 		struct posix_acl **default_acl, struct posix_acl **acl)
 {
+	*mode &= ~current_umask();
 	*default_acl = *acl = NULL;
 	return 0;
 }
-- 
2.39.2

