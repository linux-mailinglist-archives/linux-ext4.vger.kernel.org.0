Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3943C30C
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbhJ0GgV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0GgU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:36:20 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71DC061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:33:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w15so1845671ilv.5
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIqGrm4WaQz+Kb4+hu8wwNjJh4Ob0G8KE2322BysY6Y=;
        b=CGVJlKtBzxO0vkAtdjDzjIeb0QmgxeXaBg6tRVZ+fBTIerOIyYZLPHaVhD3DhaejHH
         KmUU2Z+ns3hRvKYQljSOxnqiSOPE2tbGJ4vchFEtfrzC/Jm8dsgEcJK6sCgs1MKDeF9g
         d/Gaf6jf1beENcFoOXCsEzjHGB14w67Xkx1PF7zYPm4FOSqEyxIXZO72Ah7iTzrrLSrP
         b2QPoAvD5Rb2N30V2G0v484XJLqQ3lKHr8AQB8aZ3qwgtzu3ontEfxvZsBld8Vnb2UhD
         hmMOZ15ZXMmNHbwE8/QzrNrNubuZkMOh0xLH/x/2apfAwpvQGtfyeO/DgwxyQv4eicJw
         UctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIqGrm4WaQz+Kb4+hu8wwNjJh4Ob0G8KE2322BysY6Y=;
        b=RKBC45VgokAfAfolYcoGPqixLcSFpDaOmC7SiUV/+MUm3aNG3jbuVlfaPTs6OjNnTL
         CdLWPpp8BivNi9vfO9I6jurRl8leeqWRoULOENhSCCWrQiNWKz9ufcTiWGVaeC813OEJ
         NOt6G5FQGfICqjng2gikO9gAoznx27tGMLRN5kJNnyuHGFRmHb/OmMySoFn6GQeehcAW
         iFDea5vjH/Ki4Y22HxKjXx9yT1oIvD7C9XL4fbga8ywUCkd322PGv1zp0t2CLgDt4gIi
         zsCnoMod9mccFzeGokJyUOev9BHh6viPCYHcTGbMrAkBkG4LP/tBj/ljawz89KqlMSIC
         zFNg==
X-Gm-Message-State: AOAM533CF99SCef4+Djw/ulau9vAtmWHYLYcMo+e651MmlKWnrlWpA7/
        cWrNcG8umjrZhNjdDetbrNceFfVW8EvDK2KbxuA=
X-Google-Smtp-Source: ABdhPJyPGkInEUiQbhKFVgP56C3U2evCJ5iXHm1gk5IO1DAMK7feKgux2WJmFUmWWkHHhrcPNWTBwD/qe9S5rLRCygU=
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr18729497ilv.254.1635316434886;
 Tue, 26 Oct 2021 23:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-4-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:33:44 +0300
Message-ID: <CAOQ4uxg=H=ytn+-zENmJnEp_7SF2W5WCK6yZJqEB3bsjo1cmBg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] syscalls/fanotify20: Introduce helpers for
 FAN_FS_ERROR test
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
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
>
> ---
> Changes since v1:
>   - Move defines to header file.
> ---
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
>  .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++++++++++++
>  3 files changed, 132 insertions(+)
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
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index b2b56466d028..8828b53532a2 100644
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
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> new file mode 100644
> index 000000000000..7a522aad4386
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -0,0 +1,128 @@
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
> +static struct test_case {
> +       char *name;
> +       void (*trigger_error)(void);
> +} testcases[] = {
> +};
> +


Does LTP accept .tcnt = 0 gracefully?
or maybe LTP project does not care much about failing tests during bisection?

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
> +       tcase->trigger_error();
> +
> +       read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
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
> +
> +       SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +                          FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);

I think it is better to have the mark add/remove inside do_test
This way when running fanotify -i 10 (which testers do)
we also get test coverage for add/remove of mark with FS_ERROR mask.

Thanks,
Amir.
