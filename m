Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6257C113
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 01:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiGTXpV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 19:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGTXpU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 19:45:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61256DE;
        Wed, 20 Jul 2022 16:45:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q16so82663pgq.6;
        Wed, 20 Jul 2022 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEaKQvm/NxARytV46Yo0/098MQt6QtYcYVz7xqviJd4=;
        b=dkkvcOmipq3l/S9vFdOtqMRcATTOhf/0PsKkjbKggBqjMI3Bo/oMmQ3PKYxyICyjmU
         bHnHwfMGsZlKGbBZ3YHm2wqBnqTqp22EiQEexS64OeaxlQ6KX+dMBsPQ/rKPlXOx3NST
         bEIUk8fT0ZTxO2jFnx4X2N8Upzm92jBvY39jHd/HVrB81+EhKOastI7ujKoUH+c46Y3N
         EySqi5B0Mn8hALfqNsFvabIg7ubZI/PrT8L54x1HDA7FwANcTlVGL+r8gtC3whUf+r5Y
         jdMx71R/RZkaelSyBi0JDyKUsJZO9bxLfzodei6TYMYWv8fSM06GiB9ZQvxejeBUqVwl
         4+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEaKQvm/NxARytV46Yo0/098MQt6QtYcYVz7xqviJd4=;
        b=xfqVjrlkR6ylX0xFSisNjqzWWbegSU1OostP7JGf1R19u9jMi8Y2trfjsz0qn+Zlss
         6p70lsIAEFrW5sl16tLBMLH0P50Ao2h9q5ksWv8aDLTbqwJ2OOjWuSbbpZflCJgmy6fz
         4IZ8w/F63UAb/GTEKKjevmvH7gKbOJXAOFoJZblS4xiRn6+zzZfuzBGQ4+iLvVpwk/pG
         XJxHswwkcubcH8sQGLo/r+LAA7fFGZR60J4N3eibTHMZrC2hq4NIWhHRtNarAFh3kplE
         UWjSUkB1RSzTPm8a0vaku7qIyioohoC+5u/kmyUPN/Azg5TnBJRTD50m4d/+F2LCpBeY
         b8ew==
X-Gm-Message-State: AJIora+zLUqkyy+Tg6/g9G1+kfbMwZuLkxf7gDU3vweYCsPMFxv4qg+q
        gaAUqEJuPfFnt94IUccNOTgyI5Qgpt2j8enA
X-Google-Smtp-Source: AGRyM1vFFzYOJBeKbSpBufrB70dlsWT9nvYD6ZrpKFS66NicfhO4SkGs4/p13KSWfIf5JGAW7wiODQ==
X-Received: by 2002:a63:fb01:0:b0:419:699f:a0bb with SMTP id o1-20020a63fb01000000b00419699fa0bbmr35309139pgh.4.1658360716885;
        Wed, 20 Jul 2022 16:45:16 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id mm3-20020a17090b358300b001ef95232570sm2192339pjb.52.2022.07.20.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:45:16 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-man@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4 filesystem.
Date:   Wed, 20 Jul 2022 16:45:12 -0700
Message-Id: <20220720234512.354076-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
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

This is a ext4 filesystem specific ioctl. However, this ioctl will
likely be implemented for multiple filesystems at which point this
manpage will be updated.

 man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 man2/ioctl_fsuuid.2

diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
new file mode 100644
index 000000000..53747684f
--- /dev/null
+++ b/man2/ioctl_fsuuid.2
@@ -0,0 +1,115 @@
+.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
+.SH NAME
+ioctl_fsuuid \- get or set an ext4 filesystem uuid
+.SH LIBRARY
+Standard C library
+.RI ( libc ", " \-lc )
+.SH SYNOPSIS
+.nf
+.B #include <sys/ioctl.h>
+.PP
+.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
+.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
+.fi
+.SH DESCRIPTION
+If an ext4 filesystem supports uuid manipulation, these
+.BR ioctl (2)
+operations can be used to get or set the uuid for the ext4 filesystem
+on which
+.I fd
+resides.
+.PP
+The argument to these operations should be a pointer to a
+.IR "struct fsuuid" ":"
+.PP
+.in +4n
+.EX
+struct fsuuid {
+       __u32 fsu_len;      /* Number of bytes in a uuid */
+       __u32 fsu_flags;    /* Mapping flags */
+       __u8  fsu_uuid[];   /* Byte array for uuid */
+};
+.EE
+.PP
+The
+.I fsu_flags
+field must be set to 0. 
+.PP
+If an
+.BR EXT4_IOC_GETFSUUID
+operation is called with
+.I fsu_len
+set to 0,
+.I fsu_len
+will be reassigned the number of bytes in an ext4 filesystem uuid
+and the return code will be -EINVAL.
+.PP
+If an
+.BR EXT4_IOC_GETFSUUID
+operation is called with
+.I fsu_len
+set to the number of bytes in an ext4 filesystem uuid and
+.I fsu_uuid
+is allocated at least that many bytes, then
+the filesystem uuid will be written to
+.I fsu_uuid.
+.PP
+If an
+.BR EXT4_IOC_SETFSUUID
+operation is called with
+.I fsu_len
+set to the number of bytes in an ext4 filesystem uuid and
+.I fsu_uuid
+contains a uuid with 
+.I fsu_uuid
+bytes, then
+the filesystem uuid will be set to
+.I fsu_uuid.
+.PP
+The
+.B FS_IOC_SETFSUUID
+operation requires privilege
+.RB ( CAP_SYS_ADMIN ).
+If the filesystem is currently being resized, an
+.B EXT4_IOC_SETFSUUID
+operation will wait until the resize is finished and the uuid can safely be set.
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
+Either the pointer to the
+.I fsuuid
+structure is invalid or
+.I fsu_uuid
+has not been initialized properly.
+.TP
+.B EINVAL
+The specified arguments are invalid.
+.I fsu_len
+did not match the filesystem uuid length or
+.I fsu_flags
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
+.SH CONFORMING TO
+This API is Linux-specific.
+.SH SEE ALSO
+.BR ioctl (2)
-- 
2.37.0.170.g444d1eabd0-goog

