Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF01D20E0D2
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgF2UuB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbgF2TNi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jun 2020 15:13:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9AC00E3C0
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 05:04:15 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z26so12036382qto.15
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hiq5qeIacI3jGarX6UGdwdJ7Wd6uQ2S/6tth3Y47uPg=;
        b=W942yi6ZvwWs08XjF1OBZSPhGTep6OxGoiZAsN4TEdSnXuGw/s4/oimk9+OXUKeqCm
         fMFD56doo4N+otqevAazQeYnmjmwtYAHES6H4ggroUDAScTjB2D+SQsZy9Pbn9x3DghG
         uT3MkPhGSwJG4h1SGXNdkq6pJ/PW2ULa9k+qcf4JJdoFlDbLW7CWYVgmZ71wnZ73cVIm
         SP1un8MWpk07oH29gWfAnD+VHgMhQsyWCKV4anmu/I22tmdUxRjFs/B3gaIBTDmisDBk
         phEVoVee7yfVX0tTmEElUNguACz9+p/5xgl8iPoWTapWzIktFX8pBh1vTyWQzT9KdBau
         72kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hiq5qeIacI3jGarX6UGdwdJ7Wd6uQ2S/6tth3Y47uPg=;
        b=lUmd9jb2r5UsLghnt8sPDE3FcKb20xrDBtaCDiCZzGEFBP/ua7jfLkl/wxHaVBRT9k
         QNStq2Fs01Z0S2H9kRLiNYzjfzv9QQqcaS7WPd0lPbw1GwJCb4UjpfPTEu38h877VZNc
         pvHNAwDqkPfrujoDnnSmMsAMJbG5ZOIep5vR556s3CmakEgRbjvI9mmRLJGws4C+w/Yt
         j4qwI6VqETUNat9nGHY8ET0xG5D4VBo3PXh4+PUSMvjHyC2qExv1t6qYKEGCb1+Zobjc
         6tBH8oi4N+ekY926J3M5d8UOOtlD8oriQAQb8bGfTLFB8k5nFxlozABBs4KZlszjYVSZ
         NNAQ==
X-Gm-Message-State: AOAM532N1NiiFK7Wunv7XxN+6fQa+fF2Ljno90G5qW7cMdkpG/K2+8rT
        vM7htSJG+PseEfiKEwf7ZJgbel4N4h0=
X-Google-Smtp-Source: ABdhPJwkgBLEZTIYTMq7DREhCsBG00chjwS1TzedYP/fncY46dZiXawch5b0/0qtKz7xaJvmqJxSEf7VXIU=
X-Received: by 2002:ad4:4a81:: with SMTP id h1mr15062556qvx.102.1593432254291;
 Mon, 29 Jun 2020 05:04:14 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:04:02 +0000
In-Reply-To: <20200629120405.701023-1-satyat@google.com>
Message-Id: <20200629120405.701023-2-satyat@google.com>
Mime-Version: 1.0
References: <20200629120405.701023-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 1/4] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..b5e07fcdd11d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,6 +1380,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.27.0.212.ge8ba1cc988-goog

