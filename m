Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7419735C855
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhDLOIR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhDLOIP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 10:08:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943FC061574
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 07:07:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e14so8853552lfn.11
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LFbCDECmR3HF16yAKPgIyYYU8nhfmxVTfwHNg+FEz3Q=;
        b=QQ1TuisBMnG1q2InFzsnAoMoTtTEX8Sl9lP+oRno68anqi+Ks9/55gj9AuvdiWIFs7
         fN8AwqqL57M+VhktvpBIyIpF1vWm0Iq6QblJrnXOQdiZTVR92nS8ePNGP+m2qbkz/F8I
         9srxj64/L9NpIDGm55houaFBr7I8pneTL0tHDbyIhc61+jbVjiGk9wWSDdd5s028XZrI
         Asg8Ai3JXW2d/EtxeMhBR/VA4HMTYVg+6IBreQsi1Con0MKGFjpfUgCKZdBQmkUCuqG9
         zTEm3rVU/YvKTwPZ98EHqkghHgjUT5tDLHRSKSksug/E2BEd6wOzkCSMhgxRXExiFRSl
         /l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFbCDECmR3HF16yAKPgIyYYU8nhfmxVTfwHNg+FEz3Q=;
        b=VHzLmpDytRjm66yNnxwWQpT0QF1GIbDdv5aSduWY4ovrIkb6tuR91DNHJX8ZYGqR+/
         9lUvJZtN8H7xIu6yABhsD5zg/A6wZbOSIwnsHWjBetwI66zfLvgZyGyg0us84s+3OzxC
         pwCadBn9nD2q/g3KcSS7EGpZe6Hsl98skHIG958X3CrV3QKF62RKRKgTz2LaoU193pwH
         u/CGPYNFExFsWkzt5PCr10Mcbf/T5m+OQirfsurSNuBGLWaooM1dLocehCZlnzU1ZxuS
         C0cPcLU3Qqm9sn/rUDNZQXTx3qkgBCfNxTdfRf0MvieV6l1oENGuYjMYSVj8Br62ts5D
         US4w==
X-Gm-Message-State: AOAM5317+drJ2i7JusCCnFUaZ8INEAtLPOgTpZ19TFbX2nK+qCkXEQwO
        TCdYwWU+nS99foSxSYkMxyIR4qqBXfqaRQ==
X-Google-Smtp-Source: ABdhPJz8O46PiNEzZUix8bG5DswHE4V0/Rk8w1CzWyISrTXYalhek41xgu6lVSX0BhQFcW2fC+QXPA==
X-Received: by 2002:a05:6512:2143:: with SMTP id s3mr7991773lfr.556.1618236475179;
        Mon, 12 Apr 2021 07:07:55 -0700 (PDT)
Received: from localhost.localdomain ([83.234.50.67])
        by smtp.gmail.com with ESMTPSA id m9sm2444122lfo.241.2021.04.12.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 07:07:54 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH] e2fsck: zero-fill shared blocks by default
Date:   Wed,  7 Apr 2021 21:23:23 -0400
Message-Id: <20210408012323.110199-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When e2fsck detects multiply-claimed blocks, the default repair
behavior is to clone the duplicate blocks. This is guaranteed to
result in data corruption, and is also a security hole. Typically,
one of the inodes with multiply-claimed blocks is valid, the others
have corrupt extent data referencing some of the same disk blocks
as the valid inode. e2fsck has no way to determine which inode is
the rightful owner of the blocks. When e2fsck is run with the -y
option and duplicate blocks are cloned, those duplicate data blocks
from the valid inode or object are replicated to other objects.

e2fsck has some extended options that provide different ways of
handling duplicate blocks:

clone=dup|zero
shared=preserve|lost+found|delete

The default behavior can be changed with modifications to the
e2fsck.conf file. Let's set clone=zero and replace the shared
blocks with private, zero-filled blocks. Leave shared=preserve
because there are no reasons to move zeroed blocks somethere.

This change doesn't touch e2fsprogs tests because they use
their own enviroment and build their own e2fsck.conf

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
Reported-by: Peggy Gazzola <peggy.gazzola@hpe.com>
HPE-bug-id: LUS-8408
---
 e2fsck.conf | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 e2fsck.conf

diff --git a/e2fsck.conf b/e2fsck.conf
new file mode 100644
index 00000000..751b34cc
--- /dev/null
+++ b/e2fsck.conf
@@ -0,0 +1,3 @@
+[options]
+# Replace the shared blocks with private, zero-filled blocks
+clone = zero
-- 
2.18.4

