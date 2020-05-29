Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B371E7688
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2HW0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 May 2020 03:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2HWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 May 2020 03:22:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18003C08C5C6
        for <linux-ext4@vger.kernel.org>; Fri, 29 May 2020 00:22:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so1303161lji.12
        for <linux-ext4@vger.kernel.org>; Fri, 29 May 2020 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dl25yjAmJuE5AxkRwc5qz4dWHRUh+gkJVzHXFvs+rfg=;
        b=hswH03OEBTEgok3PtkSVa8NSZO20xTjVRoaF6RX18g3v51a3hFRNQq1utdUpGr9Z+q
         X0d8OiqCQkSgY7tBpDOoibOwLHpXeCKtZIfzhxr6OXnsSFPaccLBqztx6eRQDL6nQA96
         R7Gh7KWcHd0rcO+5eyuklKCsu2JYny3gaHcv7QnG5kdWnIe1mi12m0EC/ShEZa9D/27y
         Wt8TPxDCkKvjnK61EJeBc1ygn05qOqGBeSquohq7VPUR0fRff9mPKPVyr5aK7UVkIGkj
         xH5lh580rUwSSMLJCkZZM8WZLHeb5HXjjF5A/8ck/w7RyZP/fxxukcleq03s9CqprG8h
         JUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dl25yjAmJuE5AxkRwc5qz4dWHRUh+gkJVzHXFvs+rfg=;
        b=MOly0ewcCZl70raElnUPS/eibvrDd7qIwJJOaWgXYaN+xxzgeEtxpBuvWIoNzfiX8L
         bi+1YUtHZG0y9xHgc7I8VAWoQgh7vrcw3KogK2On7Pq8xuTCVmHkIURtUhdmB5dQ6AQz
         ByqSrH6KcUZdsHrFJakT2ogpJcq6IXzdxKaRMYQRHR5oWT1ji+KLBDZdgIvzdghDulrf
         DerciOW3vvh+7Gzjt7sDWsxczTbtN1+axRWdWtCTpkB/lk13PfOM9plaLL2h+H2MNOl/
         p04usa3A98g1VFksRKc6Kftcx6D/yS1LhZgM9oEPnQMK8vdTffkaRxYMDPpoKmL1gTWr
         DnWQ==
X-Gm-Message-State: AOAM530xTYEgaXp9agHIW1gQXZ8QtO5Bjs8nP7ivVbEP+S4xYvJLr9Xl
        mdPVBliKcB/bbDXZXgg1TL42eQ==
X-Google-Smtp-Source: ABdhPJw41qmTFNR1CsfUZRyTyoeD0cdsQ+X861XvpuY9BXFNpuN+0C0bxdkiKXtLjIsMiCEHv54kPQ==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3122624lji.315.1590736943242;
        Fri, 29 May 2020 00:22:23 -0700 (PDT)
Received: from localhost.localdomain ([92.34.219.140])
        by smtp.gmail.com with ESMTPSA id k27sm2068399lfe.88.2020.05.29.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:22:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] fcntl: Add 32bit filesystem mode
Date:   Fri, 29 May 2020 09:20:17 +0200
Message-Id: <20200529072017.2906-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
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
ChangeLog v1->v2:
- Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
  instead of a new fcntl operation, there is already a fcntl
  operation to set random flags.
- Sorry for taking forever to respin this patch :(
---
 fs/fcntl.c                       | 5 +++++
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..10a6b712d3a7 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,15 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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
2.25.4

