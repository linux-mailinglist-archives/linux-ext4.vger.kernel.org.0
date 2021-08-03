Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE663DE897
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhHCImk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhHCImj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 04:42:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC2C06175F
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 01:42:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f6so17613919ioc.6
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3V77oViv0XYlTBqXdkkWQBA0edv1sYPU0QfQcSuYzf4=;
        b=RxS1gZtRwZXokDQnkjXJJLbRZQn3nDzXZZFERpLvf7HhCKx2jPxmv7p2Fdm5rLqspq
         sp911Ba6LIpHi8RPMEGc8WdlbQA4+CEBaeWEiAWvTsLOVEucvTDXqDL4D5aBnCv3bc77
         kJLFo4At1VD3j6J5dC2TUJkKQdZ9cZehvxGVhHX1ADWGszUZHwXjLmymFLTLawXusyTf
         qBZ1hCb0UtqDVraXqhZ6Ktw5YgLTWt97maSnQ6Qqlc6+sl7qnNyFcJWJlYw6BOtBf64A
         eI5r1yMn5re++vUqASEbjkyKLvnRa3xUjxLK8f51g+ah+9X0sJh16hqiReoeQq9DL2Wx
         B4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3V77oViv0XYlTBqXdkkWQBA0edv1sYPU0QfQcSuYzf4=;
        b=Gbgx6zOJE953FCXQmVnZx/KthMRnXn9RDRSiqzW5ZdEalL34NcF/kxBaMKQmcGxiv4
         t51a+CXkK/th6TlocyLAevypekIT4iaS6mqho6gGEW93kocXI9VChRKEBTe4wEmeEotw
         gjP9AJZ7SZtT3KOTy1pdviC5BAY+y1UfeY40Zca67UF/uUBDz9FcyngGMYvn8woz5r+t
         5LCWNo376BCCskWcxo1dSA///8xBCaIgIesntJkMrQ/ZkHhJMYFU34+ULnuq8v0jetYM
         M6fDDZ5xWNipl/eOeNSgmx/7c+zPdvgCXlkGknwi2LG+brqdKVSZHfc9TJGn8yGp5FdF
         zFvg==
X-Gm-Message-State: AOAM5321LGyGUDLSz/EN6Vtb0/EImH0T97fCbdz1mlGtPmeqepo3J/sF
        itZYdiZxm/a9nOka8ZmWqRcnvVb2C4cZcLTJstg=
X-Google-Smtp-Source: ABdhPJy6QwItcOMWcc2V/SuuX+hs6i/S/v6H58kQ5Zkck7Slb4U/vQol3er0yx1TUMKcx+Eb8dt1uSTXK+CT651wC5A=
X-Received: by 2002:a05:6638:1036:: with SMTP id n22mr14836075jan.81.1627980147689;
 Tue, 03 Aug 2021 01:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com> <20210802214645.2633028-3-krisman@collabora.com>
In-Reply-To: <20210802214645.2633028-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 11:42:16 +0300
Message-ID: <CAOQ4uxhDUZND7Ak9vL-_vR50KSoewyKNzFsTsGP+UeDQmB2Rhg@mail.gmail.com>
Subject: Re: [PATCH 2/7] syscalls/fanotify20: Validate the generic error info
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
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 59 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 50531bd99cc9..fd5cfb8744f1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -37,6 +37,14 @@
>
>  #ifndef FAN_FS_ERROR
>  #define FAN_FS_ERROR           0x00008000
> +
> +#define FAN_EVENT_INFO_TYPE_ERROR      4
> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
>  #endif

Those defines go in fanotify.h

>
>  #define BUF_SIZE 256
> @@ -47,11 +55,54 @@ int fd_notify;
>
>  static const struct test_case {
>         char *name;
> +       int error;
> +       unsigned int error_count;
>         void (*trigger_error)(void);
>         void (*prepare_fs)(void);
>  } testcases[] = {
>  };
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

This helper and macro would be very useful in fanotify.h for other tests to use.

Thanks,
Amir.
