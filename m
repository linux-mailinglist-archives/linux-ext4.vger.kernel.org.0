Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694831A1A90
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 05:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDHD53 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 23:57:29 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52658 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgDHD53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 23:57:29 -0400
Received: by mail-pg1-f201.google.com with SMTP id m185so4375733pga.19
        for <linux-ext4@vger.kernel.org>; Tue, 07 Apr 2020 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xJkP8e59/n7iIujiMcl7X5Pc4Tz1txAW1Gmb+VI1O1Y=;
        b=ibNVbWoN51vmsJrnlJSyk7S/HV0c8UIXlHKsiPBuqewKjm5llKIxkJQ2Ji6nSQ5LST
         n0AJzKnewfPtpxdakzl7dwb2+91zGQKDysHCziHYKo0tFR1ScmRd04hvJVWaY2YcVM+F
         OKQ5wPf19y5SXFt/ZT+JbE01LhU7PYsjJLNBM1vFzPxEjpOakDSmt31RSKSr0HCnMJhE
         /xcirmTzPlVcDhcSinZQBr8QECGNh2xp6qMaKKhgembnsheFqD++bhOCQy9chtUO67+e
         V2zC3D3KjJuEpzTMN9m6sZK1ZubjNyZ/RcYtK5PwdKmyKiOze6MxP6o4u9iNwoAloouL
         u/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xJkP8e59/n7iIujiMcl7X5Pc4Tz1txAW1Gmb+VI1O1Y=;
        b=tyjC+hHL2Jvuv/XOqGmoEhfpAC5sW8LMHt35KhP3Zetiay7bberQU8460RwSV+tQpf
         8FB7yNKR+rsyCIss9aeHlq82K3TeravwwEK5A9vHzHeTSzIYXxLkjsYE8ilY7J64wxZF
         EZTuhjvAjXxMUh4dMTw864woiIzMKiPyx6d5hSS3CM8t0ki6hZoQRBH7iPpUZ3uMusyo
         hqdgFmaL4jZc7y9Lhq9FedDBZ0Jtlf3aaGwdlQvEKDGgGC7SY0h2NMZBQ1RUE2xUW7yx
         Tz99nx9LVS8E8p49afqnE9kpt5TzX7kokpgrV6m5c00ybOjusVV5cIt6VVGYBvZ87qm8
         gPSQ==
X-Gm-Message-State: AGi0PuYSqy8nlkGWTXvX7qRDU2C4hPuA667ITk/PoryUK90WctwGwhKX
        w+oekvDNwzF/mLVYMOVrtf9hzBMAkvk=
X-Google-Smtp-Source: APiQypJm4U6exMkrVHaCaR+Jox2XVDnJ+ZVZwcNOltIQvdyFK8OCQp3/sfrcru/EGGInehFptE8sLZbx4Vs=
X-Received: by 2002:a17:90a:3547:: with SMTP id q65mr3138844pjb.118.1586318248079;
 Tue, 07 Apr 2020 20:57:28 -0700 (PDT)
Date:   Tue,  7 Apr 2020 20:56:51 -0700
In-Reply-To: <20200408035654.247908-1-satyat@google.com>
Message-Id: <20200408035654.247908-10-satyat@google.com>
Mime-Version: 1.0
References: <20200408035654.247908-1-satyat@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v10 09/12] fs: introduce SB_INLINECRYPT
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
index 4f6f59b4f22a8..38fc6c8d4f45b 100644
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
2.26.0.110.g2183baf09c-goog

