Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858F57298B
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 00:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiGLW5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGLW5H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 18:57:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31234A439F
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 15:57:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso754452pjo.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3DcFq2hujP2SWoxqAx1HTzIjIvPMeHxctP3lmuzeWE=;
        b=R8/pV9trGxH8r7HEHW7Wml8J1Pc2IKK+XCCo0ZI0qbRCtz8QQWieTAaKM6w9jPw13+
         co14EXXxrQYiladtAylRycmaV5O6a7AEt4qxv14mw6yz+pDTrtqtMnxQ0H3BpkkTCs1J
         CeXZuh3+9gEi5pnImqaOklnsb07yCoFBiu5/Oh5Yr79to9hRAx0HsUPUUSKj50HcZRcx
         cAGkU55ynn8BFw8e7daR2TXxwGghtuTjzx6RGgZsQW01XQFLicLO4Rhc757eUj2p+DOb
         +vPz7gAY4e7slOMaeUL5QsLpGdt9LRrVKhVHPZJC3LZ70/uEi44wma7jyGFdVMNKIi/d
         gqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3DcFq2hujP2SWoxqAx1HTzIjIvPMeHxctP3lmuzeWE=;
        b=L8rWIP5URC1Zmz3Na3466a80lJoQ9tXNXTkBw9ks7KoVjGTcA3dY4N4gv/Gk/V8Elr
         EOgFWgIhRxVa1p6xXyAr7MjjlV9nnZj2Zpz+9sLXyhIghlMhKKp/1kGG5X2tuXPZrLDs
         R+EK+8D4N+ZH4AQ0eX6h3sNMIuWWhuxfdMQS8VYGT8eAcZhNiwVEXsy6tXTJjNg/WLlB
         4PnePQpFCfETL9RGSgiAO9szm9vQp74+1VuGlhbTlWs+j0/vTa2J1V4Wq1PmZVDjGLzk
         Xs/0rNH6ygsLjoOEwJSXWfy4OETx5PSdT8LyjFj0V202OgS8Yqa/EqU9VpaCIXvHR4Ld
         eUzw==
X-Gm-Message-State: AJIora+oOetyM5FctrwfkzUI5jJS07OpvzMiJFf7oSZsBHh5WF6anFxF
        kjNK2mmmTJTUa98ccCsUgy4=
X-Google-Smtp-Source: AGRyM1vBU6Miyaw1BVnwtnmx7fQUnrjLnB4+TFXnzLsLl6oVOuK17nJMeYxaAiGX+vo5wRT4lnNing==
X-Received: by 2002:a17:90b:1b51:b0:1f0:3350:6854 with SMTP id nv17-20020a17090b1b5100b001f033506854mr7024036pjb.52.1657666625611;
        Tue, 12 Jul 2022 15:57:05 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:789:4c69:4c88:9c0c])
        by smtp.googlemail.com with ESMTPSA id d21-20020a63fd15000000b0040ca587fe0fsm6600597pgh.63.2022.07.12.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:57:05 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH] Add manpage for get/set fsuuid ioctl.
Date:   Tue, 12 Jul 2022 15:56:53 -0700
Message-Id: <20220712225653.536984-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This manpage written for the case where xfs or other filesystems will
implement the same ioctl.

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---
 man2/ioctl_fsuuid.2 | 110 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 man2/ioctl_fsuuid.2

diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
new file mode 100644
index 000000000..db414bf59
--- /dev/null
+++ b/man2/ioctl_fsuuid.2
@@ -0,0 +1,110 @@
+.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
+.\"
+.\" SPDX-License-Identifier: GPL-2.0-or-later
+.TH IOCTL_FSUUID 2 2022-07-08 "Linux" "Linux Programmer's Manual"
+.SH NAME
+ioctl_fsuuid \- get or set a filesystem label
+.SH LIBRARY
+Standard C library
+.RI ( libc ", " \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <linux/fs.h>" "      /* Definition of " *FSLABEL* " constants */"
+.BR "#include <uuid/uuid.h>" "     /* Definition of " *UUID_MAX* " constants */"
+.B #include <sys/ioctl.h>
+.PP
+.BI "int ioctl(int " fd ", FS_IOC_GETFSUUID, struct " fsuuid ");"
+.BI "int ioctl(int " fd ", FS_IOC_SETFSUUID, struct " fsuuid ");"
+.fi
+.SH DESCRIPTION
+If a filesystem supports online uuid manipulation, these
+.BR ioctl (2)
+operations can be used to get or set the uuid for the filesystem
+on which
+.I fd
+resides.
+.PP
+The
+.B FS_IOC_GETFSUUID
+operation will read the filesystem uuid into
+.I fu_uuid.
+.I fu_len
+must be set to the number of bytes allocated for the uuid.
+.I fu_uuid
+must be initialized to the size of the filesystem uuid.
+The maximmum number of bytes for a uuid is
+.BR UUID_MAX.
+.I fu_flags
+must be set to 0.
+.PP
+The
+.B FS_IOC_SETFSUUID
+operation will set the filesystem uuid according to
+.I fu_uuid.
+.I fu_len
+must be set to the number of bytes in the uuid.
+.I fu_flags
+must be set to 0. The
+.B FS_IOC_SETFSUUID
+operation requires privilege
+.RB ( CAP_SYS_ADMIN ).
+.PP
+This information is conveyed in a structure of
+the following form:
+.PP
+.in +4n
+.EX
+struct fsuuid {
+       __u32       fu_len;
+       __u32       fu_flags;
+       __u8        fu_uuid[];
+};
+.EE
+.in
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
+Either the pointer to the
+.I fsuuid
+structure is invalid or
+.I fu_uuid
+has not been initialized properly.
+.TP
+.B EINVAL
+The specified arguments are invalid.
+.I fu_len
+does not match the filesystem uuid length or
+.I fu_flags
+has bits set that are not implemented.
+.TP
+.B ENOTTY
+The filesystem does not support the ioctl.
+.TP
+.B EOPNOTSUPP
+The filesystem does not currently support changing the uuid through this
+ioctl. This may be due to incompatible feature flags.
+.TP
+.B EPERM
+The calling process does not have sufficient permissions to set the uuid.
+.SH VERSIONS
+These
+.BR ioctl (2)
+operations first appeared in Linux 5.19.
+They were previously known as
+.B EXT4_IOC_GETFSUUID
+and
+.B EXT4_IOC_SETFSUUID
+and were private to ext4.
+.SH CONFORMING TO
+This API is Linux-specific.
+.BR UUID_MAX.
+.SH SEE ALSO
+.BR ioctl (2)
+
-- 
2.37.0.144.g8ac04bfd2-goog

