Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D843C325
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbhJ0GqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0GqT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:46:19 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AFC061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:43:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f9so2308080ioo.11
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0tjnH7cGTMnJZzZdMCwY+OSK2Wv5tgvwfL8n26UIvo=;
        b=UF1qxaetdU5AaUk6+ECLYk0yoLF0rVQNlSxRSaZjonb0cHU4UmqxlzN61h2XEl1JG3
         HJEozkQZCGaozcHP6nknXZ5Jph0k8dFd+ByJJlTqxpCupwtJ67c2smndLzwQNBu47hRh
         w30tTahJs1BApnSgchFtILE5TnIUJxKhYQsq8DS3eKY3jQfKi/0gVnVMLO65mP0cNslp
         k4G947RCPezqUI+dfsErFF4MJLyDkHKZvzuWKH33Pa7KGt2Fv95zLS7LIN8H1zUdbk2E
         /XgiTZ3jHyR7H97UlB1q5X2NhYuqzwTQsMDUqH9o+frjsv94dnqc7onNjyp9RZumvVnT
         s85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0tjnH7cGTMnJZzZdMCwY+OSK2Wv5tgvwfL8n26UIvo=;
        b=CxEcidEWvuiaQIZnYJYwMfXk5pAbK5SKI4tDKwYAE3ORNPjY6VD4UPvJaXuqr4rzaY
         l9tcuIgUDG8Ekz17HQ3X2AqeHZX2QcWswixvgSykFoU33WJsl1ebFLDt8Gr+C5XYiAng
         W6CfimVWIj/+JamMte73p5IfBgjo144/0kSDI4eaZQ0UL9FOVL+SabTqkTTpU53BYA7w
         kO400UGa10/uOOoT590d4Xji0njeEawBrGojXae18slHNQ5fVKX2UZx6hwA81JfuvD/4
         lC4twpwE8cYy5ofnBjRGFM2bif4l2tDUpMglk9h7YBLeHiDnfX96i4o3aUf5NfKi64FT
         9Dyg==
X-Gm-Message-State: AOAM531Okl0yFpryWtFWsE7U88wAXZ+tLvfBF3ol+BwB9Xb+9B1UaJwV
        QBT13cPR0N8eqCW+sswZWATKoOD8vgl0S3EdbiE=
X-Google-Smtp-Source: ABdhPJyKujfwG5lyx6ez8ZuzrwIya1B8KTWqM2an447uNxze1QzsZtuA4yrpiMDK7tkacAefrUY9SkclGg/fUmgnfec=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr18314463ion.52.1635317033899;
 Tue, 26 Oct 2021 23:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-5-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:43:43 +0300
Message-ID: <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] syscalls/fanotify20: Validate the generic error info
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
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

After fixing and testing configure.ac you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
>   - Move defines to header file.
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify20.c     | 35 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 8828b53532a2..58e30aaf00bc 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -167,6 +167,9 @@ typedef struct {
>  #ifndef FAN_EVENT_INFO_TYPE_DFID
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #endif
> +#ifndef FAN_EVENT_INFO_TYPE_ERROR
> +#define FAN_EVENT_INFO_TYPE_ERROR      5
> +#endif
>
>  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
>  struct fanotify_event_info_header {
> @@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
>  };
>  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
>
> +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
> +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */

Need to add in configure.ac:

AC_CHECK_TYPES([struct fanotify_event_info_error, struct
fanotify_event_info_header],,,[#include <sys/fanotify.h>])

(not tested)

> +
>  /* NOTE: only for struct fanotify_event_info_fid */
>  #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
>  # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
> @@ -403,4 +414,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>                 fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
>  } while (0)
>
> +struct fanotify_event_info_header *get_event_info(
> +                                       struct fanotify_event_metadata *event,
> +                                       int info_type)
> +{
> +       struct fanotify_event_info_header *hdr = NULL;
> +       char *start = (char *) event;
> +       int off;
> +
> +       for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
> +            off += hdr->len) {
> +               hdr = (struct fanotify_event_info_header *) &(start[off]);
> +               if (hdr->info_type == info_type)
> +                       return hdr;
> +       }
> +       return NULL;
> +}
> +
> +#define get_event_info_error(event)                                    \
> +       ((struct fanotify_event_info_error *)                           \
> +        get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7a522aad4386..6074d449ae63 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -42,10 +42,32 @@ int fd_notify;
>
>  static struct test_case {
>         char *name;
> +       int error;
> +       unsigned int error_count;
>         void (*trigger_error)(void);
>  } testcases[] = {
>  };
>
> +int check_error_event_info_error(struct fanotify_event_info_error *info_error,
> +                                const struct test_case *ex)
> +{
> +       int fail = 0;
> +
> +       if (info_error->error_count != ex->error_count) {
> +               tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
> +                       ex->name, info_error->error_count, ex->error_count);
> +               fail++;
> +       }
> +
> +       if (info_error->error != ex->error) {
> +               tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
> +                       ex->name, info_error->error, ex->error);
> +               fail++;
> +       }
> +
> +       return fail;
> +}
> +
>  int check_error_event_metadata(struct fanotify_event_metadata *event)
>  {
>         int fail = 0;
> @@ -68,6 +90,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>  {
>         struct fanotify_event_metadata *event =
>                 (struct fanotify_event_metadata *) buf;
> +       struct fanotify_event_info_error *info_error;
> +       int fail = 0;
>
>         if (len < FAN_EVENT_METADATA_LEN) {
>                 tst_res(TFAIL, "No event metadata found");
> @@ -77,7 +101,16 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>         if (check_error_event_metadata(event))
>                 return;
>
> -       tst_res(TPASS, "Successfully received: %s", ex->name);
> +       info_error = get_event_info_error(event);
> +       if (info_error)
> +               fail += check_error_event_info_error(info_error, ex);
> +       else {
> +               tst_res(TFAIL, "Generic error record not found");
> +               fail++;
> +       }
> +
> +       if (!fail)
> +               tst_res(TPASS, "Successfully received: %s", ex->name);
>  }
>
>  static void do_test(unsigned int i)
> --
> 2.33.0
>
