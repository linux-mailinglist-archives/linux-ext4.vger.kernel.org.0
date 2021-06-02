Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4E397FEE
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jun 2021 06:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFBEDW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Jun 2021 00:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhFBEDF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Jun 2021 00:03:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5258C061574
        for <linux-ext4@vger.kernel.org>; Tue,  1 Jun 2021 21:01:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e19-20020aa78c530000b02902e9ca53899dso743782pfd.22
        for <linux-ext4@vger.kernel.org>; Tue, 01 Jun 2021 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Z8TWrZ1N+kpmDT3P7kRs0ATN9eESgaJlrgr88tTLyBk=;
        b=nqoqK4bXyYWNKPHsGGPnWTOhxk08WuJn4CiwSPoMWatITZOP+2QBsfuwPVae8UEdsF
         oVThx3Km2KlLAhvs+ilooIMZb8ZPKQTZquUUEhr5cOzWXJXpcFzJkgMMP0VMTZOoY57k
         u5xZyibHXAVVzf2SAoAkbXn3xMHtVsZlGghpeWQCbIFQeuLu27tll2ooJhNk41F78Df0
         pMBVzNkBzYXYPc4sMAbzF7IG1syqYcD/AKavpYukgUqOdBPykT4pWg+eQ8LMaQOkat5L
         6arIrAQnE2zGUo3ekmtnNvF3ACkvkbRrf/ZW1vMrNHRJm00Ubi7gvQRFWPrHzC93Uzuh
         ty8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Z8TWrZ1N+kpmDT3P7kRs0ATN9eESgaJlrgr88tTLyBk=;
        b=SEggLgL0rL2SxVfNzegbnHDkxCP4qAxIFACqRLlgh+eT0plet0fqD8EIskEYAX2K0/
         Kky2I+Rttwn4LjanYpe5dc12fHepQZAQ3L3bJ+feuU7Pi1novryZ0F5VTV6ciIPQzkoI
         J71WZM5zG3kMuMiQsfSkPTHgRjUKRjTcBs3UHxVz8qu+N3zCJrSj2aciRxo7a/JJQMbn
         XhFaQmLEhfoDy932UzaKTVYuh8zvJgGq5kzShSLYlXRaZvx70oImhw4Kwdhqf5/QvfUQ
         6RtmD6WZPdtDHQS7GdXs6unsjGpC0mqrHXR6Th1R3/ZD07pWUReENCVCbPxgadNQSwei
         zHvw==
X-Gm-Message-State: AOAM533rBg+0Nu3nEyGSggRcKjinwWeVsExY5vL7xvkseHR+aLrLVIy9
        XIo1zv+Z8jzL+Yzjhr2UMpnErsQNXM4=
X-Google-Smtp-Source: ABdhPJx/LBxE4zrDN/L8cOC9B8hUfYcxBJA2Un0jyImpFvETNt39frGfayI7c0PlMb2fqxe4Y+C/v3V0ZuQ=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:902:9886:b029:f9:c8d6:4cee with SMTP id
 s6-20020a1709029886b02900f9c8d64ceemr28909072plp.82.1622606465244; Tue, 01
 Jun 2021 21:01:05 -0700 (PDT)
Date:   Wed,  2 Jun 2021 04:01:00 +0000
Message-Id: <20210602040100.121327-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH] ext4: Correct encrypted_casefold sysfs entry
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Encrypted casefolding is only supported when both encryption and
casefolding are both enabled in the config.

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

