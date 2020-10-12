Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1869A28C487
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 00:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgJLWIi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbgJLWIh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 18:08:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42851C0613D1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 15:08:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l2so19917879lfk.0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er9outiRWHyk/leMtSr3CNlG0IeLWwXg/xMOKQHeA64=;
        b=TJLs0p8ef4M8/2cD6lB9hj/ouQXXIQ/K0meIiWe4zNhqW2s0ngXyIXQSYlacBFeFlj
         kAIAmHPxQb1/ujaGBZFb+dfwSePuqxvopJiXkpGgjipwT732nRx+BxQq5xTHYgdGIOAs
         isyVPJDcayUq1+Kq2+ze6a/bcqxsM1zaKE47QWncvbSgkZIu/P+xBkVlu92rPPdxxhCJ
         uf6IILkn1+fZNd5nT3ek4QfnUSzfvR1vnFUHYKQRBnDdsyUfUshec2t1/Eul5nz6vq2e
         iiMoUngpjYSAUATlZWlh89jleNr2DKD+euTyWeVfSZAdLsydM7LuN5j4+86z26nK9/j5
         rqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Er9outiRWHyk/leMtSr3CNlG0IeLWwXg/xMOKQHeA64=;
        b=mdxLs5TnCL4XwucrLwy5PLVQAmMDfIYKPF0+HDpO8+GwQX7i4v/EzcFppiNKVDxlsH
         e7pZBmeQF1aal7r1QZQ3hR+kp1i1Ki2rrI/EK6amZP7W6eYj/OsPp3Bug/803wQ1yLN8
         gxFF01zK7GpeNtyR8tAknIwykL9y5r9WMskq+b91c/Hy3DSrm7YrTLXNtmXRCHRbhzhN
         WQnUimY9sIvtWOBH56gEqd1uMP83vbxCsmTEsoLx0zWSo3FpVPO8sAaXsQLQiAkJx6gS
         tekISVqfdUwvF7UsmmPg3nXuJ0k+yJYCsV+pAqjgUTJoZq44b0/seWd6HTPu1mn3T9mq
         ihWw==
X-Gm-Message-State: AOAM5318DR51uMCgB7tnKWetNb0TV94nongTnVZL1IrBpv3w5efCsNXc
        IFsJmVEa8jDx0+K6uhEJChCSGA==
X-Google-Smtp-Source: ABdhPJxmiM6IlJtuyaoQ8VZOOBemBYKqhzqgDG6ZrEeg+bRyV1gNNd+WNqR3yadfn3+/FcWbnCxyLA==
X-Received: by 2002:a19:824f:: with SMTP id e76mr6874758lfd.572.1602540515605;
        Mon, 12 Oct 2020 15:08:35 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id a201sm3039261lfd.213.2020.10.12.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:08:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
Date:   Tue, 13 Oct 2020 00:06:20 +0200
Message-Id: <20201012220620.124408-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

This adds a flag to the fcntl() F_GETFD and F_SETFD operations
to set the underlying filesystem into 32bit mode even if the
file handle was opened using 64bit mode without the compat
syscalls.

Programs that need the 32 bit file system behavior need to
issue a fcntl() system call such as in this example:

  #define FD_32BIT_MODE 2

  int main(int argc, char** argv) {
    DIR* dir;
    int err;
    int fd;

    dir = opendir("/boot");
    fd = dirfd(dir);
    err = fcntl(fd, F_SETFD, FD_32BIT_MODE);
    if (err) {
      printf("fcntl() failed! err=%d\n", err);
      return 1;
    }
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This can be pretty hard to test since C libraries and linux
userspace security extensions aggressively filter the parameters
that are passed down and allowed to commit into actual system
calls.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v3 RESEND 1:
- Resending during the v5.10 merge window to get attention.
ChangeLog v2->v3:
- Realized that I also have to clear the flag correspondingly
  if someone ask for !FD_32BIT_MODE after setting it the
  first time.
ChangeLog v1->v2:
- Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
  instead of a new fcntl operation, there is already a fcntl
  operation to set random flags.
- Sorry for taking forever to respin this patch :(
---
 fs/fcntl.c                       | 7 +++++++
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 19ac5baad50f..6c32edc4099a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
+		/* Report 32bit file system mode */
+		if (filp->f_mode & FMODE_32BITHASH)
+			err |= FD_32BIT_MODE;
 		break;
 	case F_SETFD:
 		err = 0;
 		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		if (arg & FD_32BIT_MODE)
+			filp->f_mode |= FMODE_32BITHASH;
+		else
+			filp->f_mode &= ~FMODE_32BITHASH;
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..edd3573cb7ef 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -160,6 +160,14 @@ struct f_owner_ex {
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define FD_32BIT_MODE	2
 
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
-- 
2.26.2

