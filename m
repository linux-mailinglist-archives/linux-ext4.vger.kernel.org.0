Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E322731B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 01:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGTXh4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jul 2020 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgGTXhz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jul 2020 19:37:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B020C061794
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jul 2020 16:37:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b69so13755601pfb.14
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jul 2020 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=;
        b=dpz3hRRXJhzFYY0/pCX+Y/eePZpWFCADC/kjj4qZk3jOrPT6G6tdSjuyh9Qw+Wrue9
         9f6dhzx0VvfFcrv4a6Firxihch6LbPRbw8QtUFYbwd4f1tEtLpf5bbkhowqe2WfQ2faw
         kB23eVk86fVuNkCwvfPS/vFUeGyQ4ajGNPlCM2T5YJCzs0iVMV+giOYth8pP1IoNiIus
         FwA5zN/b6t+kqlz18awv5ni7cMS7s5ikKECiJK6Jzuibq8sR3hYMa51fZAjxbYwbSer4
         WjNWu50cQeiODtlqpxegUVzn2ulDcCCSBkWeQKnwEj276YUVPDg3kVr0Rfiy1ajwok15
         JZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=;
        b=bXQODd5h6pPcGiemH0Jxm8YFavxN9j2Z/g8Up2XRLCNY3lXc5mbanRLCmjRmTyJfvJ
         952dw4oZUH6E0KQabvI/8b6otIumrkyVhooyvQy0PKlYQ4wOh0o0QMsImc0fqnXIYkXj
         25Dk1K+b6PhUokPk6mKFgPbLS1ws7xMhTS6U+KLn6VRIZz9vjE8jnzFvaVXJp8l/pFQ8
         f9RDbkrPixFZfiVt5i0ByDu8Ux3RI3q77h6ebJVe6vNK3c9VXveuB9f3hvjc4h9qgIHT
         M2hR4kTDxiqSRHOvj5F3rIN/T54qYRemtyZiDgdSRweLaXk0C9N0sF0zR3PQB98m/i8l
         xJIg==
X-Gm-Message-State: AOAM531TCXlikOB6t8OgXa9nLkjmRbi68U/I5YPONzqjnPaF1K/2D6cS
        NGKsBhGPA+9wOSyPUI6G1b+7LJ2xE9g=
X-Google-Smtp-Source: ABdhPJzD4zyxL6NAWP8CBEO3nWgs3IY5xzymZloYi6QDkienrJ3ha/vZk0REiujEDejgnVubHrJvYSOYoFY=
X-Received: by 2002:a17:90a:bd8b:: with SMTP id z11mr82498pjr.0.1595288274362;
 Mon, 20 Jul 2020 16:37:54 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:37:39 +0000
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Message-Id: <20200720233739.824943-8-satyat@google.com>
Mime-Version: 1.0
References: <20200720233739.824943-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v4 7/7] fscrypt: update documentation for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/fscrypt.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index ec81598477fc..5367c03b17bb 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
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
@@ -1123,6 +1125,20 @@ It is not currently possible to backup and restore encrypted files
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
+any I/O must be aligned to the filesystem block size (*not* necessarily
+the same as the block device's block size) - in particular, any userspace
+buffer into which data is read/written from must also be aligned to the
+filesystem block size. If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O.
+
 Encryption policy enforcement
 =============================
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

