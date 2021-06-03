Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18837399E15
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFCJvv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 05:51:51 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34484 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFCJvu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 05:51:50 -0400
Received: by mail-qk1-f201.google.com with SMTP id o6-20020a05620a1106b02903a9f97c808bso1088164qkk.1
        for <linux-ext4@vger.kernel.org>; Thu, 03 Jun 2021 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vmZCbqngTpm7tAp2K8sNJMCUQyvM+b4ETSTvf8bhdN0=;
        b=I7wdB9K8vmtF6uC4zn9AcunlOO/tAjuLKc1fWLguyixo+evPcpqGbTf6imz6wCbgoF
         FO4xknowcBjYgFodM6oHda646Ppe2+0/fTlP6bqHyN0Obmdda2M9FGpwZ/2alTEK0zFu
         jdSHK3AclAKFA0HdpMvGVTLbLdk7cz4TJlTUKLTrApjp5xAfu85QwmzUD72GMzW0pu09
         u8DKcHBLr7dogtgFbOmt6VKaBg3PXkE9jDFGlG3/Ml3xmueXd44MFN7ta8TMcWpEo++I
         62CUt6+ivNQehaxdDNklwLHk+su3nveYgviTr47LdeUepqOhpz8cCw9U1ENvAEt04M+n
         Al0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vmZCbqngTpm7tAp2K8sNJMCUQyvM+b4ETSTvf8bhdN0=;
        b=V5ZVjAKlxQ/GUwx1wXlUVUCak0A7hVVl2Pxn1pp6R5GQLewKoK1MF7g+9JEjxwKAk5
         efyC6n8jo+jmXb98AE3yfctq94uSMCrb+wERGoKt84+pBi6H18BPb64ap2stYWOkafRV
         47pra711yVvuHOXKx3n4fUoRcsXQdcTmu7KlXrr7vPtpi+0aRnytU6eVr3azYgd5yiFb
         EeRDUTFZOInsLWD4Fopx4aGvpzcJ6HlO616OVD7BdHjq+avjnE4/W0lDrs9g+lSEY92z
         SrtTYxiot7Q9TKEIp0NdjsUZU3toreFaANQYYbZlBbOaO/VmSKImWmSt5Q8Tfg0RZ4Tx
         k8zw==
X-Gm-Message-State: AOAM530OMmeJ1VU2aKO6h096nBit39q7o8llaZLQJrg7BI34PCDXPIUN
        y35sBShaFxoZI+iEW1bW1tI5T1DGnZU=
X-Google-Smtp-Source: ABdhPJzQPM//koouAcGyOQfMwmc6RaUBZhppCtAOxPKFOiL6nD4RMfqevmtLMtegRNt5ClQAwmTec0eXbU8=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:ad4:4c0c:: with SMTP id bz12mr21689604qvb.21.1622713733247;
 Thu, 03 Jun 2021 02:48:53 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:48:49 +0000
Message-Id: <20210603094849.314342-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2] ext4: Correct encrypted_casefolding sysfs entry
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Encrypted casefolding is only supported when both encryption and
casefolding are both enabled in the config.

Fixes: 471fbbea7ff7 ("ext4: handle casefolding with encryption")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/ext4/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6f825dedc3d4..55fcab60a59a 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -315,7 +315,9 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
+#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 EXT4_ATTR_FEATURE(encrypted_casefold);
+#endif
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -333,7 +335,9 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
+#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 	ATTR_LIST(encrypted_casefold),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4_feat);
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

