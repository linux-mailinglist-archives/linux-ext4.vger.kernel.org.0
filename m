Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476F34407A9
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Oct 2021 08:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhJ3GOk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Oct 2021 02:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhJ3GOj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Oct 2021 02:14:39 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73992C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:12:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r194so15205801iod.7
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tx3J4YDiJv8Ml2rc9Jz+9Mg6Bpu/TyE6I+xJK3BdtU=;
        b=HtC2qijfX1870Do6RX5NHIhet49VFKUo/7SMmfmqnNU1M1zvcFFJ+iWpsAiVDVK4Nm
         LRgYLYAUq0C82NlOuWm8ZFmy4mUvQFJgOeyhFs+TdXHNA0IfzDQ2wZSG5eAbphBSFaqm
         0nGaVrYan8CPo9JM6PyVFxcO6J8p/gvdMpnUqh6VX6DjBy+vSpj5iBI/jGQpfQIqdmhm
         nvOMazfBeyYHywAgPwDr81+20TLlyRfQaxVywGvnR7F8lI9rjO6Tb5MhwU4iMrNFsDH7
         opBG4hOqxvMtE9evjATJSjXU7i2ASItzmq89b30wl5FdCLXu1IIYFsW7GOP3wMXRcyea
         c2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tx3J4YDiJv8Ml2rc9Jz+9Mg6Bpu/TyE6I+xJK3BdtU=;
        b=ocK2+fx6vAH9pJuzMl4puXtBnUj8pth4SuE18l6FdwMebf5dN/uR7r3dXmuHI/8DC8
         0XoutQWQrZtW1Aj9FhwElk4OsKS1L3jy/rzpkE8GqcuP1jogI8idSiv476FjH1ENWiKt
         zrm7kkh0VGai9sHybdGfCEtINKL4KiJUf3xtSLd4/pmAYsK3nqHa+AZHJPWV2QMMaR40
         g3d5PuW0DwlOWBXLQsYx4AQKDCgVuHU755iDtkyBTD0LtbGzAWp5IjEm//K3Et6QOiuG
         kgUqz7V6kAeoHFoCEomhvhxsMKyOKeQjejwHNBh9KAkg9Mq+0N2WCrBzAszl03V8DCKX
         2JZA==
X-Gm-Message-State: AOAM530H6djWJVSGmtTPqkQwS0yaHhUkmdomlEyS0gLWaWp7f0UG+BYX
        nDTbiFh/FJ2PpVOV2coY9nZM8O6TZJMdo06D9qlOoMJ7wSI=
X-Google-Smtp-Source: ABdhPJyE5ab3UYfhtLCjFO6gog1byxOBOWebnHU18wcwrEQPCPzOmWNCgPLvZKGDksL06fdByjy726M9t1I65dGAahg=
X-Received: by 2002:a05:6638:2607:: with SMTP id m7mr11374582jat.136.1635574329846;
 Fri, 29 Oct 2021 23:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com> <20211029211732.386127-3-krisman@collabora.com>
In-Reply-To: <20211029211732.386127-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 Oct 2021 09:11:59 +0300
Message-ID: <CAOQ4uxhnNzfraGyMMNtipDgF2MuW2QCqsHR6jhPAgkFyP4h_ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] syscalls: fanotify: Add macro to require specific events
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
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
>   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
>   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
>  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
>  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
>  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
>  4 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..820073709571 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
>         SAFE_CLOSE(fd);
>  }
>
> -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> +                                                     unsigned int init_flags,
> +                                                     unsigned int mark_flags)
>  {
>         int fd;
>         int rval = 0;
>
> -       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +       fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
>
> -       if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +       if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>                 if (errno == EINVAL) {
>                         rval = -1;
>                 } else {
> @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>                                     fanotify_mark_supported_by_kernel(mark_type)); \
>  } while (0)
>
> +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> +       if (mark_type)                                                  \
> +               REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);       \
> +       if (init_flags)                                                 \
> +               REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> +       fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> +               fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 26d17e64d1f5..2081f0bd1b57 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -323,8 +323,8 @@ static void setup(void)
>         require_fanotify_access_permissions_supported_by_kernel();
>
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> -
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>         SAFE_FILE_PRINTF(fname, "1");
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 92e4d3ff3054..0fa9d1f4f7e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -509,7 +509,8 @@ cleanup:
>
>  static void setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
>         fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>                                                                           MOUNT_PATH);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index 76f1aca77615..c77dbfd8c23d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>
>  static void do_setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_NOTIF, 0);
>
>         sprintf(fname, "fname_%d", getpid());
>         SAFE_FILE_PRINTF(fname, "1");
> --
> 2.33.0
>
