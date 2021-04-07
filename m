Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0800035709C
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhDGPmV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhDGPmU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 11:42:20 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7CFC061756
        for <linux-ext4@vger.kernel.org>; Wed,  7 Apr 2021 08:42:09 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id h34so5859768uah.5
        for <linux-ext4@vger.kernel.org>; Wed, 07 Apr 2021 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqteTSf6p6nxzxiSU2r+6vOVftJyvMAoVhFVE+RjAhE=;
        b=KFFCm7rGDfV7cRYPmIQRhtr+NlW+TcMxcj3GVrHoBr7JQhobCSYK50Z1sv/Ow6PhY0
         85Ye7k1XNFQ7MtZ+gmnoFiIEZDFU+uU4lj+oUR/OHxa1UL+bcJDrFDKsP/gv2WFC0PJ+
         ahUaIrzf8ImPTDRhslvKBXpgOjsDYsRkJHSmiHyvaMxIIRIN+ExOvw/2KJnEiTkxjEDn
         z7taIoOS6ITL0YY9rfhVOeiELkDVVg/KNBZdjRF10OF1x3Kh4KaIqsdgyIQ2sVTEW+S/
         MSN4qUdcWJzQCogZ0u0EPGU4lZOtByfZzDZYKVIXkg/J8sp0Lrc9nVYR83QwGLLdCqgt
         n09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqteTSf6p6nxzxiSU2r+6vOVftJyvMAoVhFVE+RjAhE=;
        b=EFevbF8kuui3AMU+zqHRxRBwqFAuEZ+0sFxqyDu4BwCvj7Obp0YTSLFXpT3lJgKg+M
         0UoIq80kmLfmFnexWO+DyFvEVQ+4pF/jCb2sFUTOxWqJEr+qGnTcJRF5NG5hn3oju92k
         F5YqeKh8KSSJAR5Uwa/FlHUiqpjGleaYC+bWrbTHaS2a0UoTFW9WMwVF/Ac81bgJ/+qW
         forDA4bl+aO/6aElF8OFFV3lZlvu2X7S4tEM83L3Apzej2e3Pnw1J4FnHOAA5wR2PFkV
         i0km+/WOrw1W9bdVDfxNUGEa9teezshifnbImIqY0AUa3pv6vDd8SJnstu5m5qr34kAD
         pMCw==
X-Gm-Message-State: AOAM533wE3HMH5TS3SDD4Dw43qVRw/ExyhhWW6tCxEqh97A5OwRdFk24
        iR1sWCnv9FlhMAhmDs8mM+kpSceUzQ0=
X-Google-Smtp-Source: ABdhPJx4vViKWLQGlzdeQkjekwMy06sKCzon5UYhrVuX7s+C1asP2hV3wUk6SABIsq0EMHxcrnZ5fw==
X-Received: by 2002:ab0:6f98:: with SMTP id f24mr2609687uav.101.1617810128894;
        Wed, 07 Apr 2021 08:42:08 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.googlemail.com with ESMTPSA id 81sm1172630uaq.3.2021.04.07.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:42:08 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Date:   Wed,  7 Apr 2021 15:42:01 +0000
Message-Id: <20210407154202.1527941-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210407154202.1527941-1-leah.rumancik@gmail.com>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zero out filename and file type fields when file is deleted.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..0147c86de99e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
 			else
 				de->inode = 0;
 			inode_inc_iversion(dir);
+
+			memset(de_del->name, 0, de_del->name_len);
+			memset(&de_del->file_type, 0, sizeof(__u8));
+
 			return 0;
 		}
 		i += ext4_rec_len_from_disk(de->rec_len, blocksize);
-- 
2.31.0.208.g409f899ff0-goog

