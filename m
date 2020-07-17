Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A922307A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGQBfm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jul 2020 21:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGQBfi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jul 2020 21:35:38 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B7C08C5DC
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:35:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jx16so6665090pjb.6
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=;
        b=tlDHCdVZLG0m6L9levsiz5n7YIyjIML7yueebl4I+pd4oD2GbC2//CVbku08QwfyVK
         Io6VHBtaFJ92KS1ZOJeZ+gL4I3EE9eCj84H9hWFhQZqN8fQQ85l7TS5gW7erlfNnkmzA
         h57MTGXvkvtREa2Qo1rEyo9lXW31xuTk1ugMXZ6T1CiepMhKbsP1mrjdiKiW3/Rvmu6c
         SZPzhAwx7+ulPeallP3vNIjd8m2ACUMFu9PQZzGNoethIWi21ML/Bzl/g8EenyLMa7F8
         oq0OBvD9rkYG9V07cK0ln918JiY2QNGYAxh/nFT9nNV7Px5YVBoGsAhCgLPzOODa5J1Q
         a24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=;
        b=GdTsAaXcGcMHyRDqF8a4jJn6M2L8GqgwJx+l63IuD1yQsjkBjiTg32tTKJfAwjqv3R
         dF41WAjAt2r4mN0DurluKhBt1CdMXwJrg7OMq9Kr7CtNxzEfsgNyBs99m5uSd+lP81Vl
         mMWPCXrkKyZeYOCGjsclaFx9CT30NJ+hY2zJKxXvFP7yO4Bf+ZQ1bh2exba3GAh+1MiH
         1QIqqTjIwAyZUFaG6WUliyyBp3I9zc1/XoeXmcC9QvTRSSrd8EVdCGVLBB/rYsnJJ0+0
         wO8oUY3EUQJvdyPb2DlhaaChRLCi44o6yGsNISMcp9+dMFULFf1DHdzCFvK/LqYvQ40Y
         uujA==
X-Gm-Message-State: AOAM5318hG/s2J3xv4qkIHa3F/8sleS+p1Np/J03dlnBsv74cCjLc7ha
        ZWkKMe0ArDKkrfR5ThTmlMPJq1fis5s=
X-Google-Smtp-Source: ABdhPJzDMFCY+G8Oa8F4K0HKeSD+Xc66nsFn69r8yuQKIuJ5CCaPUQ42wZhUaa7Xlm1W8gsHMjhI0okL6Kg=
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr5918685pls.266.1594949737873;
 Thu, 16 Jul 2020 18:35:37 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:35:18 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-8-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2 7/7] fscrypt: update documentation for direct I/O support
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
index f3d87a1a0a7f..95c76a5f0567 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some circumstances
+  (see `Direct I/O support`_ for details). When these circumstances are not
+  met, attempts to use direct I/O on such files will fall back to buffered
+  I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1257,6 +1259,20 @@ without the key is subject to change in the future.  It is only meant
 as a way to temporarily present valid filenames so that commands like
 ``rm -r`` work as expected on encrypted directories.
 
+Direct I/O support
+------------------
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
 Tests
 =====
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

