Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1C36AF3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 06:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfFFEcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 00:32:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39083 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFEcj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 00:32:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so387100plm.6
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jun 2019 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bsZifgz0SIlDcXcSo3Ws+LcOmMza89DsMDLo0jxX0mY=;
        b=iqnSianw8jj6n3YvYj4BoeqYUzGQFttsmePpo2Xa7qRsjxDdHfwPayxO8qot8vHGtp
         ezAw7DHRwi8/wb7cVZowLav5POX7P5MuNWMUEn+HZ7qo9ROXOTxoshR0wHQVCF8DFDv7
         3jpd5FDPTBl+8r33hf6J6FPXrJXa3lK4r5eLYg1UbprusnFWdjGIzQogiKCBQY7efs32
         hbohwI8dCG0rYZmi8HZ1eBOSNJMbtdyh1PENUoaPM72IL3LRpzQtggZGnk6n4hmSaw3w
         +R+arcscxzXomdhqFYnbZoLuaz2ALLIOGAJzzG/Es9jPdcuMJpn5fcFQN72C166zCFDB
         1Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bsZifgz0SIlDcXcSo3Ws+LcOmMza89DsMDLo0jxX0mY=;
        b=lCMlNPhS3zqZ1EblNeU4jlvfH+5G6T2v29V1NOf/ro0eNDavyQmx6VrIkRQPlVjf+W
         A0hnHx9eIkMfPIJ8QuoaT5RBDQ23mtM4W/WxBSD7K8oJodWN7DQ9FOLKOgQLuEj7ONr/
         ljxpMozygBe1EZbVgg0dbWVEs4OdCxa2IkbtyqIf/KvWAqM8KqXy3jebwS2/2HbJeXmr
         TWU268+EaJcXy50pr6EoftaBFUq7Ll2a3VWkjh4C1W2cZJvuQPzFAFcQM47oP3J12rf4
         PzNeTdbCKxH0d55ON3+Pn498AYV9eCc+5AdZFxr5zI+34bIPvk79p65924E/X+TG1INd
         reSQ==
X-Gm-Message-State: APjAAAXz03140ZKJq5CsmEUg2odM4I5/DuyiaUNdoinlwKIuoH6juyi7
        G9t2tkCwsB8199aeJjcmLrsdfpoj
X-Google-Smtp-Source: APXvYqz8ZG4YsAqNUtDCsSY7OsdffZpO/uBq/9ITkVOMlwJV6SfZjN1yRmvoV+hHdsDXjpOSMbinPg==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr40026886plm.237.1559795558655;
        Wed, 05 Jun 2019 21:32:38 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id f17sm445069pgv.16.2019.06.05.21.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 21:32:37 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     Wang Shilong <wshilong@ddn.com>, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 1/2] ext4: only set project inherit bit for directory
Date:   Thu,  6 Jun 2019 13:32:24 +0900
Message-Id: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It doesn't make any sense to have project inherit bits
for regular files, even though this won't cause any
problem, but it is better fix this.

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 fs/ext4/ext4.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb67859e051..ceb74093e138 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -421,7 +421,8 @@ struct flex_groups {
 			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL))
+#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
+			   EXT4_PROJINHERIT_FL))
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
-- 
2.21.0

