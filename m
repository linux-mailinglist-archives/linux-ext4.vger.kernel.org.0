Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37E34407AB
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Oct 2021 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ3GSj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Oct 2021 02:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJ3GSj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Oct 2021 02:18:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC7C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:16:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h2so12886299ili.11
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFO/mNItEdLGjwxZFLAiQbdtG+89hH+XVHrgCIQ1kjQ=;
        b=TSn6oGtfLb6Hu4226KjooxKl9PXinGu4eo319lwYNr6n68MUxallOQL3uGe2GP/uCr
         gRlYE4Lz2Jun0gvJqdtlTYOHO86H3epHCf0LBIVj4Mdk2spUmKVVsZV1/c4hb2tDNWe5
         kPxCG1/j3eJn5KKhJXYrV4vkZVAeiBMwiN/NFkUXsMsnWlNUmCZuEUTjjFpq7Cal8bHt
         V9gpaKnVuNW2dhID1jz3ItYaDwIStrjpYAdChxfQjYMUWczEIst8rslvLH6NLK6ThPGc
         ushF2HXCAD6BbGdufq1GSdrnQuCis2QaXfmkMpLj1nwmbtcdOAPbdD+/ZQ18lrrIDsUA
         +/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFO/mNItEdLGjwxZFLAiQbdtG+89hH+XVHrgCIQ1kjQ=;
        b=VYOADUBIVPkD6h6EB2tq9lRU/NqKCHhTVyFcrMgEKqrwAVjtMXO0xil4m54QizM9Uw
         uzyOC/PiM8kCOaMEhpx0mLXV5TmaBPSWY7pvmBByCydKypzWmwDEg1EYQXw21cyJmuc5
         a+B2TgHZnaLXvOkwQDAA8L8aziV2j+tpEZrPx7Zhw7w+VhiEEiL/OvtAIjsM929xCxBo
         Dai8BRXBrqI1vCMJ4kjI5Jhb39pcbYAhoEUNm6Sv3tW8UBBXmferVv1LY7uGA2z7dB7I
         LdNCqhCKWtkkhzD/KeJTOVn6Gt//7I90ztJWy1wsczHAHj/mpxgtwA0yRaAWvV7ONr/2
         Mzbg==
X-Gm-Message-State: AOAM531MgTSHgg3bTvd3fTOu+gTWLf3PP74EYLwhyrzbr3NQNtQsONeb
        y/LRHAf9peRwqxJr9rFZY/iOQbLVd7190KwMavhCGZ6lpyM=
X-Google-Smtp-Source: ABdhPJxBXwq1zk+qt1ch19lfSNm4NOMLxHhLzvJUXLwnfmzmvxPl/B4I+Xvyp5M+rpq29p2i6R8D8ZGff4a55Z+IQCs=
X-Received: by 2002:a92:dc0c:: with SMTP id t12mr2027470iln.198.1635574568787;
 Fri, 29 Oct 2021 23:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com> <20211029211732.386127-4-krisman@collabora.com>
In-Reply-To: <20211029211732.386127-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 Oct 2021 09:15:58 +0300
Message-ID: <CAOQ4uxiwodQm_9+XVY-cWhV6aWKkqTosBfZ0HyAQTVNijJrwuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] syscalls/fanotify21: Introduce FAN_FS_ERROR test
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Matthew Bobrowski <repnop@google.com>,
        LTP List <ltp@lists.linux.it>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 30, 2021 at 12:18 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> fanotify21 is a new test validating the FAN_FS_ERROR file system error
> event.  This adds some basic structure for the next patches and a single
> test of error reporting during filesystem abort
>
> The strategy for error reporting testing in fanotify21 goes like this:
>
>   - Generate a broken filesystem
>   - Start FAN_FS_ERROR monitoring group
>   - Make the file system  notice the error through ordinary operations
>   - Observe the event generated
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
>   - Move defines to header file.
>   - Move fanotify_mark(2) to do_test (Amir)
>    - Merge abort test here
> ---
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
>  .../kernel/syscalls/fanotify/fanotify21.c     | 141 ++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c
>
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index 9554b16b196e..79ad184d578b 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -17,4 +17,5 @@
>  /fanotify17
>  /fanotify18
>  /fanotify19
> +/fanotify21
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 820073709571..99b898554ede 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -124,6 +124,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
>  #ifndef FAN_OPEN_EXEC_PERM
>  #define FAN_OPEN_EXEC_PERM     0x00040000
>  #endif
> +#ifndef FAN_FS_ERROR
> +#define FAN_FS_ERROR           0x00008000
> +#endif
>
>  /* Flags required for unprivileged user group */
>  #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> new file mode 100644
> index 000000000000..9ef687442b7c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -0,0 +1,141 @@
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
> +#define BUF_SIZE 256
> +static char event_buf[BUF_SIZE];
> +int fd_notify;
> +
> +#define MOUNT_PATH "test_mnt"
> +
> +static void trigger_fs_abort(void)
> +{
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> +                  MS_REMOUNT|MS_RDONLY, "abort");
> +}
> +
> +static struct test_case {
> +       char *name;
> +       void (*trigger_error)(void);
> +} testcases[] = {
> +       {
> +               .name = "Trigger abort",
> +               .trigger_error = &trigger_fs_abort,
> +       },
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
> +       if (len < FAN_EVENT_METADATA_LEN) {
> +               tst_res(TFAIL, "No event metadata found");
> +               return;
> +       }
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
> +       SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +                          FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
> +
> +       tcase->trigger_error();
> +
> +       read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
> +
> +       SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
> +                          FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
> +
> +       check_event(event_buf, read_len, tcase);
> +}
> +
> +static void setup(void)
> +{
> +       REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
> +                                               FAN_MARK_FILESYSTEM,
> +                                               FAN_FS_ERROR, ".");
> +
> +       fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
> +                                      O_RDONLY);
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

That's probably redundant and the default value anyway.
If you want to stress out that this test cannot be run on other filesystems
maybe add a comment why that is above dev_fs_type.


> +       .needs_root = 1,
> +       .dev_fs_type = "ext4"
> +};
> +

Thanks,
Amir.
