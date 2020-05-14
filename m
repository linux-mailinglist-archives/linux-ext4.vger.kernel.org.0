Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233AF1D23F1
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 02:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgENAiJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 May 2020 20:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733240AbgENAhv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 May 2020 20:37:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF060C05BD0D
        for <linux-ext4@vger.kernel.org>; Wed, 13 May 2020 17:37:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so1725386ybc.11
        for <linux-ext4@vger.kernel.org>; Wed, 13 May 2020 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=55QkT4XKq8mxRSoFTXYC1SQTqi8PeYRTuEggeVVcKMg=;
        b=FSAR9aVsI4Fqie7/PXkkDI8Y5GUjTkPwa4yPhNhy081BetakXjp2/T+HFhP7i1+jje
         E+77VaVI8DExiI50gAzT+1sVBifCQAsD4Iuj7Vx4k3eLChOi3L0EEOkG/ctWNZDFmosz
         dincGlPfrOyQ2hvnuusxDe81Gvr09ObdELXbyZRT59AQP1askJ5J0y93drtA7pgYfPqK
         58BqOlAMvpPVvsB380SSrFExwEf+FXA0+3cxjhFZkS/tyewv7/tymBXeCjcfXEdWaawb
         MXslNYJD3F0lPpZKrL4FBdhG80RKUgs4aLPHmixHtsc75/nDy6pOADX/NqjUV9XdyGN3
         BtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=55QkT4XKq8mxRSoFTXYC1SQTqi8PeYRTuEggeVVcKMg=;
        b=s6IiK+Zn2/TkQCSWhvdy93DJxuaWod4RSIa1W2fRX8fBSgcTSbR2BIgaNZr6JpizuB
         3X4uE2lnrll0uIcpcEKFYO67TYst+v9d+tYmq9hz2EIw503RRlcsITTVagLhk7EFhSAE
         W3XzY2oI69sNupyoYiL+dIKqomFkIcq9eU0jnYXJut6qcvWklgCeQcHtWIuIWF+8LcAT
         ltHnTE11Kd8Ssab43YZqu6d5zCMA06q37JPX96vNliGYIRMWyyzDGriYtVTqB3dZ357x
         x/WDE3pm07e8KJzydttQsouM1sEXwLRHtm5eXkJ6fCgJEXZfntkIGNk0EDK9Ezrm5DF+
         GYXg==
X-Gm-Message-State: AOAM531huk+sLs3CNkv2kuWj5JtdSBHd8NagZVzQmI/Bgq6GQKD1ihom
        HtP4e/QoRK5qPWZPOYzPqyRyL8bFFBI=
X-Google-Smtp-Source: ABdhPJzYcXxCqDOzC/K2ZR7nIKEHI38RLh83qXdlxtWE7t4EU9eemainBQhkiuOi2LGdK5129XlL1c7RPiI=
X-Received: by 2002:a25:3044:: with SMTP id w65mr2908668ybw.207.1589416669011;
 Wed, 13 May 2020 17:37:49 -0700 (PDT)
Date:   Thu, 14 May 2020 00:37:24 +0000
In-Reply-To: <20200514003727.69001-1-satyat@google.com>
Message-Id: <20200514003727.69001-10-satyat@google.com>
Mime-Version: 1.0
References: <20200514003727.69001-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v13 09/12] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
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
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa97..8bf195d3bda69 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d3ebb49189df2..da6551c8d96fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1376,6 +1376,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.26.2.645.ge9eca65c58-goog

