Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B472B66F1
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Nov 2020 15:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbgKQOHq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Nov 2020 09:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbgKQOHl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Nov 2020 09:07:41 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB6C061A48
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 06:07:42 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id bn4so13093462qvb.9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yJkkPo7d0J6NtmBv7rzIbrBkhqskC5NsYDTAoyAGSwU=;
        b=CRCbMwpu14Qny/Fey+w65l3KTXcgMu/wKgUqWyt7la+sSuhY3Qh3bSLfvbmNmy2ohN
         d6CLetvPjrxg9HdcLQrwcUJI/t7E3dhAItIG3xDBSGqno0iPXS+Up8TqksLE2sx9De7b
         RnDWU7ZU+TwovEWzFLtOxWOaWhir5AxQO2FAkbTw00c9UXWqh58duX34o1osKQfPEqVH
         kKqjD9fQyxlm+X97TMmYjnC8FTr0DpcoshYQpZMqrkZkd8QOZGD/NcSiuteoNG9hyOLX
         0VnfOnPnKTkbYUbPzPkiA75vd3hEs8SLeW/KWNERv36yx+7UQx03bI8wWQFRjgua6eps
         yiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yJkkPo7d0J6NtmBv7rzIbrBkhqskC5NsYDTAoyAGSwU=;
        b=OOFwv4+811ydVIU2Xh4J4E19eRFpcR/snbVpyv2yuPHb2epabYNF7KPcc/LU8voRxZ
         TJZXqf6iJ6naod5FSczMfQxrjnKHjRjy+JlZ2wWlpFWninK21qixnvHbSvQ9uouijc9M
         oOXfWMkIU0DA3clkDnZ6W5vCi6LlVgo8Uu6SJXB1VWqpBjlf6+7QSmijijtyGl9GKMH+
         1S1c86k0pmObuw8Dcx1Tn7uWUvcBOfd0W8mvUl7hoAZih63YeQnXDJ5SKyNOzQMcUASb
         7vUfR19OKcuUI2ezQUAgQBg9rJFnqkMj467WujEtP2eZEIU2ktgYjCOq1EfUVfGTi09G
         aEhw==
X-Gm-Message-State: AOAM5336sosic4bY9A3CRnMrQ12eX59rk0OB9c3RO8i/4UeiS/CAA7XF
        7P50dGScCIM4bbuMoXeB5QEo//3rf3g=
X-Google-Smtp-Source: ABdhPJxEG4c+F9yJyuTls+kfuLbDaGW8pmeOfu1t4VEHHtaVEi94dVbJaunxNyEQ37dnM4o0k+oO8Td4NSk=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:386:: with SMTP id
 l6mr21357187qvy.49.1605622061201; Tue, 17 Nov 2020 06:07:41 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:07:08 +0000
In-Reply-To: <20201117140708.1068688-1-satyat@google.com>
Message-Id: <20201117140708.1068688-9-satyat@google.com>
Mime-Version: 1.0
References: <20201117140708.1068688-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v7 8/8] fscrypt: update documentation for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 44b67ebd6e40..757b8aa2af9b 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1047,8 +1047,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances (see `Direct I/O support`_ for details). When these
+  circumstances are not met, attempts to use direct I/O on encrypted
+  files will fall back to buffered I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1121,6 +1123,21 @@ It is not currently possible to backup and restore encrypted files
 without the encryption key.  This would require special APIs which
 have not yet been implemented.
 
+Direct I/O support
+==================
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+the length of any I/O must be aligned to the filesystem block size
+(*not* necessarily the same as the block device's block size). If any of
+these conditions isn't met, attempts to do direct I/O on an encrypted file
+will fall back to buffered I/O. However, there aren't any additional
+requirements on user buffer alignment (apart from those already present
+when using direct I/O on unencrypted files).
+
 Encryption policy enforcement
 =============================
 
-- 
2.29.2.299.gdc1121823c-goog

