Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9696E3DE874
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhHCIbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhHCIbB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 04:31:01 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE4C061764
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 01:30:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j18so15819344ile.8
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCcXlwSAKTIF37G9Oo5Jh0ZARuxw2IkE3sJLiIMH2tw=;
        b=i075z81cME7P4lYR3hb/d99BmR/hPnypw9laAJw02LW/p+NlpiSyc0xxRRh/bl2c+i
         CpxrWHOMCEuSTSo7UHB4Y8ejtYlsZ7OAvKJvW46KXq3bAFvXTw5eyvkStGeQYuEU15M+
         qH0pnVz4/KECR1JZpe6tQ5o/YqCAn7Juo6Dj4kc3NKgx8F7qqrDzf/CtjZPQYjaLDI82
         qoDOcddYcsY+ZaFUx2nioejc3aF5BuR1TJzg9GTNTu7CkdRdbGoe3quovx3FaJzghR41
         Jvnr+l2YifYVn2LUes+E4hcXjUFIdPuQRQArIKI4eb29d2zCNAHr9B7B+zbVTZGcJGhp
         C1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCcXlwSAKTIF37G9Oo5Jh0ZARuxw2IkE3sJLiIMH2tw=;
        b=laXQS5zQphM3xyU1F+RlQ/AewO5MLfcKYXZejKpr7zc30kpOc8YOV1iUR6/YYJBidD
         1Y8YaJ0uZgKGLUtr8k7mgyCtV3tGKyTwtD111ZIFTxaZz99+hB/X2we3YTWswsKGwenO
         RhjII7aNC70aX6nmzMB6JRsiWoKliq1vapVpnegxpnSVLql1oA0xTvUKclXYRsU6zFOF
         j4DkJ2KWDmhC5VYojUMuFbhw6xu36wpO8u4bv3OzBmoAMSKEASrArcEllzwbR0TR6mO0
         2qigcMtbgmV4dFgOXUCNKGdp5Vxqxarm5GgzU3IupCFVTXXKRq0zDZDCboj9nUbvLO6Q
         tb8g==
X-Gm-Message-State: AOAM530t6wQgxQGC5XZoyeWvrvYBASHa2Z32fmfalx1Gktnw8Ay01XWi
        G7PTkDuuL7WI5cZUFu1a6UD9Tjk0cRVLLvNZqMk=
X-Google-Smtp-Source: ABdhPJwEEJ35hjJ6F+z0GpDh3Qb3ZgcxyqkAjj++FMG7+Mg9vmXPQrHF5gslVyP+0WolsRdp8nDmyhvF8/bTSW/SeeA=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr275707ilh.9.1627979450356;
 Tue, 03 Aug 2021 01:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com> <20210802214645.2633028-2-krisman@collabora.com>
In-Reply-To: <20210802214645.2633028-2-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 11:30:39 +0300
Message-ID: <CAOQ4uxjRULAa_+n-6xf--7B=afEVN_7kzJ0H8QQP7ZQwA8Ahig@mail.gmail.com>
Subject: Re: [PATCH 1/7] syscalls/fanotify20: Introduce helpers for
 FAN_FS_ERROR test
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> fanotify20 is a new test validating the FAN_FS_ERROR file system error
> event.  This adds some basic structure for the next patches.
>
> The strategy for error reporting testing in fanotify20 goes like this:
>
>   - Generate a broken filesystem
>   - Start FAN_FS_ERROR monitoring group
>   - Make the file system  notice the error through ordinary operations
>   - Observe the event generated
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  .../kernel/syscalls/fanotify/fanotify20.c     | 135 ++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
>
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index 9554b16b196e..c99e6fff76d6 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -17,4 +17,5 @@
>  /fanotify17
>  /fanotify18
>  /fanotify19
> +/fanotify20
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> new file mode 100644
> index 000000000000..50531bd99cc9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Collabora Ltd.
> + *
> + * Author: Gabriel Krisman Bertazi <gabriel@krisman.be>
> + * Based on previous work by Amir Goldstein <amir73il@gmail.com>
> + */
> +
> +/*\
> + * [Description]
> + * Check fanotify FAN_ERROR_FS events triggered by intentionally
> + * corrupted filesystems:
> + *
> + * - Generate a broken filesystem
> + * - Start FAN_FS_ERROR monitoring group
> + * - Make the file system notice the error through ordinary operations
> + * - Observe the event generated
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/syscall.h>
> +#include "tst_test.h"
> +#include <sys/fanotify.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +#include "fanotify.h"
> +
> +#ifndef FAN_FS_ERROR
> +#define FAN_FS_ERROR           0x00008000
> +#endif
> +
> +#define BUF_SIZE 256
> +static char event_buf[BUF_SIZE];
> +int fd_notify;
> +
> +#define MOUNT_PATH "test_mnt"
> +
> +static const struct test_case {
> +       char *name;
> +       void (*trigger_error)(void);
> +       void (*prepare_fs)(void);
> +} testcases[] = {
> +};
> +
> +int check_error_event_metadata(struct fanotify_event_metadata *event)
> +{
> +       int fail = 0;
> +
> +       if (event->mask != FAN_FS_ERROR) {
> +               fail++;
> +               tst_res(TFAIL, "got unexpected event %llx",
> +                       (unsigned long long)event->mask);
> +       }
> +
> +       if (event->fd != FAN_NOFD) {
> +               fail++;
> +               tst_res(TFAIL, "Weird FAN_FD %llx",
> +                       (unsigned long long)event->mask);
> +       }
> +       return fail;
> +}
> +
> +void check_event(char *buf, size_t len, const struct test_case *ex)
> +{
> +       struct fanotify_event_metadata *event =
> +               (struct fanotify_event_metadata *) buf;
> +
> +       if (len < FAN_EVENT_METADATA_LEN)
> +               tst_res(TFAIL, "No event metadata found");
> +
> +       if (check_error_event_metadata(event))
> +               return;
> +
> +       tst_res(TPASS, "Successfully received: %s", ex->name);
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +       const struct test_case *tcase = &testcases[i];
> +       size_t read_len;
> +
> +       tcase->trigger_error();
> +
> +       read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
> +
> +       check_event(event_buf, read_len, tcase);
> +}
> +
> +static void setup(void)
> +{
> +       unsigned long i;
> +
> +       for (i = 0; i < ARRAY_SIZE(testcases); i++)
> +               if (testcases[i].prepare_fs)
> +                       testcases[i].prepare_fs();
> +

Why is prepare_fs called up front and not on every test case?

> +       fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
> +                                      O_RDONLY);
> +
> +       SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +                          FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);

This will cause test to fail on old kernels.
You need to start this test with
fanotify_events_supported_by_kernel(FAN_FS_ERROR)
but you cannot use it as is.

Create a macro like
REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS
which calls fanotify_init_flags_err_msg(...fanotify_events_supported_by_kernel())
and pass init flags as argument to fanotify_events_supported_by_kernel()
instead of using hardcoded flags FAN_CLASS_CONTENT.


> +}
> +
> +static void cleanup(void)
> +{
> +       if (fd_notify > 0)
> +               SAFE_CLOSE(fd_notify);
> +}
> +
> +static struct tst_test test = {
> +       .test = do_test,
> +       .tcnt = ARRAY_SIZE(testcases),
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .mount_device = 1,
> +       .mntpoint = MOUNT_PATH,
> +       .all_filesystems = 0,

This is 0 by default

Thanks,
Amir.
