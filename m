Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAE43C2EF
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhJ0G03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbhJ0G03 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:26:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8CC061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:24:04 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h20so1825284ila.4
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nifpTdCcHwHaGWD0xx8h0ZK8AhVVy4TOxLNadO5pWM=;
        b=IS2NsVmzSLJILLdlP5WnnS8DeDGkTXfJIRvEZIcCI3bVUdjQbr1kRbiTwAhnCB56Dw
         DNqcNdJAvXusBnHnIJBSmCRAImGG1R/5u3beXd1/CRilBXKbjoN55zPT6bK9kUrn13WE
         REIfvsBWQKxO6AmP/3zGtI3jG0DyQY22vkumV5mUGW8gU3KDhiYAiJaYnbaAEg7LnimD
         c/IHU+yikNMOpjTTvr5ZubLu09bIG1UgtNbwJrBqQeqKgJIm+CZ7cWPx9Ak8FSsOvS+k
         AgaI3SJ5bfynfK/exx+ZiMUbJCwf22zMawZNjfgnav4Dq5HgT5VDonCTnHPgwSActHfk
         NVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nifpTdCcHwHaGWD0xx8h0ZK8AhVVy4TOxLNadO5pWM=;
        b=3YL0Z194g14gFTL+pHA4Jas9VN2CjaNcjFJH59kogicpegIj2/gxXAtWoEjIbO+lq1
         7Ni/M0CEusFNWlYqaNzt8SVzryLoM4AB5icjUDbaZHb+kDjP5pa5Fp+X+wo7GHlSTpqV
         akZI9C9EwGGfj/gb7V8klOM3VUfa4z2pwBZueTEo8aVEcfaLKoIMouVbY4hyx1vpOZcf
         HDixsZ9fJmKLaQERPIIFWM6fuVKQnsIEoMXohkdz1XmUSm3Dx0HxTB5pFTCq6s4/T15M
         tIAqpRyaI4sGNHNCDv10Jr+rzt+eleSqHloknJ854hqqOaoILiq0/Y8sQTtP0nhMr6OA
         SsbA==
X-Gm-Message-State: AOAM530ZFaTPAJgxACgApuu90x8XMSBHMlF7sIQpgs6jd5rY561RjCfz
        RSTB5CcnZfm6/U6jkbnz3tOIVOwYd0EdgdCBWNZMzDyVLxo=
X-Google-Smtp-Source: ABdhPJyKTW8S4WMDU9FJqz9VBOB4VsMlnc9uPJyKrwYu4WqyfWDN6TlHcWzDPKFvqAiANoHv6tX0XNqqDzdCdRnKkCw=
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr16649456ilv.24.1635315842456;
 Tue, 26 Oct 2021 23:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-3-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:23:51 +0300
Message-ID: <CAOQ4uxijJhPUR11c2SU1FBYs8TNuwcRhNfYf-ienLhFsGp6a1A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] syscalls: fanotify: Add macro to require
 specific events
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
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 28 +++++++++++++++++--
>  .../kernel/syscalls/fanotify/fanotify03.c     |  4 +--
>  .../kernel/syscalls/fanotify/fanotify10.c     |  3 +-
>  .../kernel/syscalls/fanotify/fanotify12.c     |  3 +-
>  4 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..b2b56466d028 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,26 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
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
> +       fd = fanotify_init(init_flags, O_RDONLY);
>
> -       if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +       if (fd < 0) {
> +               if (errno == EINVAL) {
> +                       rval = -1;
> +               } else {
> +                       tst_brk(TBROK | TERRNO,
> +                               "fanotify_init (%d, FAN_CLASS_CONTENT, ..., 0_RDONLY", fd);

init flags in the print are incorrect, but I don't think you should
bother with that.
I think you should leave SAFE_FANOTIFY_INIT, because none of the existing
tests are going to fail the init flags and seems like your new test is
going to use the
REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS macro that will fail
on unsupported init flags (with correct print) anyway.

> +               }
> +               goto out;
> +       }
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>                 if (errno == EINVAL) {
>                         rval = -1;
>                 } else {
> @@ -284,6 +296,7 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask)
>
>         SAFE_CLOSE(fd);
>
> +out:
>         return rval;
>  }
>
> @@ -378,4 +391,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
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
> index 76f1aca77615..d863ae1a7d6d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>
>  static void do_setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_CONTENT, 0);
>

The hardcoded FAN_CLASS_CONTENT was the common flag to use for all
test, but this
test in particular does not use FAN_CLASS_CONTENT it uses FAN_CLASS_NOTIFY, so
let's express the requirements accurately.

Thanks,
Amir.
