Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26F657DA66
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiGVGhk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGhj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 02:37:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07C7CB6D;
        Thu, 21 Jul 2022 23:37:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so3837714plb.1;
        Thu, 21 Jul 2022 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjNStj/Ns6QIdcmGsxHjWgOPWcgILa0Rvv/9EZz3V5Y=;
        b=gpOapJ7S6v9oRcs7U47VgCoFyEgBlKDXo2ANlXNTqGHnqgwnqdZezVt8E2CQZO6F2D
         9cRjnoVBha887e5vy47Kk49aXQ+ZvWE29y2mhcDMLT02ZQSHR3TSO+Inn4uVJ2CnjPWh
         3ebUTZ80HsQaLNEIQoL7x63s+OTSM52ATXtwmHL3VR/oCRqanBva7JFb7atjq8VJBXtX
         GRrHc1C7ZBHU8Hla+GgPRQgu5//1dHdDOJq/Y7McM4Jm8JseTSOofLpy8+aC9k/sViA0
         PQG6AC29CKOKZ9Mss2MvzVT+A8z2q2qqQN7isnG+PoCUX3Fr6avVFW3MhAAnO2d8UqCy
         vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjNStj/Ns6QIdcmGsxHjWgOPWcgILa0Rvv/9EZz3V5Y=;
        b=1IX6mwNiaUEz/MjkkrH4rjhN8pzNbd/iDRP5hdDeFwqtd2vmH0xZk+YBrQRellI+iT
         0ShmZ3M6qpItDqga+QewGiOW5zMpaJhN3Bh11pBB91Ob+F4BQiyj8XiBp/nrvFxMSe88
         Rz1ofzb1PJitnw3aPf0ughTlicceiIu0gsro7gxDLlKDDKb8RgOgZQqmprldaUhQ0Cy6
         GJjcxRY7dyuhjjQ1XB3suTSs2Uudr4eWh7HYy8Q5iZBtQRNjfbUTECQiRwZPH5gMfhca
         8U9NynzH7ujqloVpvj3gXc8fM2C5BGB7acG94sSvW7x9Qy5uhUkrgCbgFnwFeJi/2Yav
         p3TQ==
X-Gm-Message-State: AJIora+cH0fN4VdvgkzB+62ObGKgu1oJ7ucCPu+7Y64kLVSC5dys+2s3
        0wFlrwDiJHsi2m6xIhBpCfU=
X-Google-Smtp-Source: AGRyM1tcz/xg9drbNXGkJB764ZZFq3d+GWtJeFDmonNcPZZTDINu3t6oj8npBqulkGKy6i7bClZydA==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr1942198plh.45.1658471857762;
        Thu, 21 Jul 2022 23:37:37 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id q27-20020a635c1b000000b0041a390f276esm2591266pgb.40.2022.07.21.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 23:37:37 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-man@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v3] Add manpage for get/set fsuuid ioctl for ext4 filesystem.
Date:   Thu, 21 Jul 2022 23:37:32 -0700
Message-Id: <20220722063732.466621-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---

Changes in v3:

Removed LIBRARY section since this ioctl won't be wrapped by a system library.

Code now uses 4-space indent.

Updated for semantic new lines. Please call out if I still break this rule.

Reworded based on Darrick's suggestions.

Unrecognized fsu_flags now results in EOPNOTSUPP error.

Added definitions of EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID which are not
contained in a library.

 man2/ioctl_fsuuid.2 | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 man2/ioctl_fsuuid.2

diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
new file mode 100644
index 000000000..c9e2789b9
--- /dev/null
+++ b/man2/ioctl_fsuuid.2
@@ -0,0 +1,113 @@
+.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
+.SH NAME
+ioctl_fsuuid \- get or set an ext4 filesystem uuid
+.SH SYNOPSIS
+.nf
+.B #include <sys/ioctl.h>
+.BR "#include <linux/fs.h>" "         /* Definition of " _IOR " and " _IOW " */"
+.PP
+.BI "#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)"
+.BI "#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)"
+.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
+.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
+.fi
+.SH DESCRIPTION
+If an ext4 filesystem supports uuid manipulation, these
+.BR ioctl (2)
+operations can be used to get or set the uuid for the ext4 filesystem on which
+.I fd
+resides.
+.PP
+The argument to these operations should be a pointer to a
+.IR "struct fsuuid" ":"
+.PP
+.in +4n
+.EX
+struct fsuuid {
+    __u32 fsu_len;      /* Number of bytes in a uuid */
+    __u32 fsu_flags;    /* Mapping flags */
+    __u8  fsu_uuid[];   /* Byte array for uuid */
+};
+.EE
+.PP
+The
+.I fsu_flags
+field must be set to 0.
+.PP
+If
+.BR EXT4_IOC_GETFSUUID
+is called with
+.I fsu_len
+set to 0,
+.I fsu_len
+will be set to the number of bytes in an ext4 filesystem uuid
+and the return code will be EINVAL.
+.PP
+If
+.BR EXT4_IOC_GETFSUUID
+is called with
+.I fsu_len
+matching the length of the ext4 filesystem uuid,
+then that uuid will be written to
+.I fsu_uuid[]
+and the return value will be zero.
+If
+.I fsu_len
+does not match, the return value will be
+.B EINVAL.
+.PP
+If
+.BR EXT4_IOC_SETFSUUID
+is called with
+.I fsu_len
+matching the length of the ext4 filesystem uuid,
+then the filesystem uuid will be set to the contents of
+.I fsu_uuid[]
+and  the return value will reflect the outcome of the update operation.
+If 
+.I fsu_len
+does not match, the return value will be
+.B EINVAL.
+.PP
+The
+.BR FS_IOC_SETFSUUID
+operation requires privilege
+.RB ( CAP_SYS_ADMIN ).
+If the filesystem is busy, an
+.BR EXT4_IOC_SETFSUUID
+operation will wait until it can apply the uuid changes.
+This may take a long time.
+.PP
+.SH RETURN VALUE
+On success zero is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+Possible errors include (but are not limited to) the following:
+.TP
+.B EFAULT
+Could not copy to/from userspace.
+.TP
+.B EINVAL
+.I fsu_len
+did not match the filesystem uuid length.
+.TP
+.B ENOTTY
+The filesystem does not support the ioctl.
+.TP
+.B EOPNOTSUPP
+The filesystem does not support changing the uuid through this ioctl.
+This may be due to incompatible filesystem feature flags or
+.I fsu_flags
+has bits set that are not recognized.
+.TP
+.B EPERM
+The calling process does not have sufficient permissions to set the uuid.
+.SH CONFORMING TO
+This API is Linux-specific.
+.SH SEE ALSO
+.BR ioctl (2)
-- 
2.37.1.359.gd136c6c3e2-goog

