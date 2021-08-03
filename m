Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7B3DE906
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhHCI4x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhHCI4x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 04:56:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD35BC061764
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 01:56:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z7so22621149iog.13
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SsFV2iOXhu6gJLnc6G6fBI8/OQbVqmopZT5kD/FcIs=;
        b=hahqrRRSNDxZMk6jEqqdCYQMZnmFhozTgz/v2l2OyEpN0XE9axp4g+uUg0B4IVXtJl
         F8FojYZGy7QoKv/o8/73A+2islxAtMxqrWMb0vHD0d5rixpjAWEwIOlA8uA7ClO4eOtH
         v0WfzPwU+iE+doh5PSZDmUV6dFXL9OIR0cV3p1ehfyw0azdChf3HbahiTMbi1N/PKZks
         WXJfjhngcQa70rOz3AVDuROoTuHCogbGDL3nnpogMQh0fINLmn6ZiZQDw2hRxGH7Pe4K
         JeIGAXr/FRFQ+yBHyVYmbjmRzsuRA/q5XVIj1y3pzhmLI+eEA7ge+hA2IJu/rXe6we8E
         yQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SsFV2iOXhu6gJLnc6G6fBI8/OQbVqmopZT5kD/FcIs=;
        b=SP/o8gNzHpE2VyNPNpBr/YeZ/ZUVwri3dejDKSkrDYfifKWMs4j9refHF6mFB4D+cR
         tIKpcQWHAxURrhAI9fUHYlpjjVWQf4CxL8SukuDAJoi6fbnwGn3BQfZaI1vxy0h27MDz
         PYqkJBjvAuyvv0kD1qdWV0JdfiNc8Fcj2qihAjXnMA47kdM62br8VAnlbREWu6RGr960
         /7hwtWrJZW+Z2IS97w5Bp2/+BCJnmMUNdBqdh+QG7ort7PLOWaNGi8oIh3JDYdJFN8nL
         Wc40yJSbZaxjS6r8YZW78u6CiszzoCMNfJjwz7NaPfC2fsumHo+04RGH3Zt39SJVURir
         IzIQ==
X-Gm-Message-State: AOAM533QjtA29CENPUxzmUVVs+ovkrDgXI5dzTrEgHXdYnKJeLT6VA84
        mtIn4SyIxNwGA2wHxo8YgaPalQwQRhLP0JLN0Ok=
X-Google-Smtp-Source: ABdhPJy0vwWcnNizvdeVjYXwq4nHkZgMGj0gupr2wyZ17s8UZye0j+4lfNn2qmtR3XhFEfpxNQ3Mj9FxzlZaECwRnPo=
X-Received: by 2002:a05:6638:1928:: with SMTP id p40mr4348179jal.93.1627981002326;
 Tue, 03 Aug 2021 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com> <20210802214645.2633028-4-krisman@collabora.com>
In-Reply-To: <20210802214645.2633028-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 11:56:31 +0300
Message-ID: <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
Subject: Re: [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in FAN_FS_ERROR
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
> Verify the FID provided in the event.  If the testcase has a null inode,
> this is assumed to be a superblock error (i.e. null FH).
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index fd5cfb8744f1..d8d788ae685f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -40,6 +40,14 @@
>
>  #define FAN_EVENT_INFO_TYPE_ERROR      4
>
> +#ifndef FILEID_INVALID
> +#define        FILEID_INVALID          0xff
> +#endif
> +
> +#ifndef FILEID_INO32_GEN
> +#define FILEID_INO32_GEN       1
> +#endif
> +
>  struct fanotify_event_info_error {
>         struct fanotify_event_info_header hdr;
>         __s32 error;
> @@ -57,6 +65,9 @@ static const struct test_case {
>         char *name;
>         int error;
>         unsigned int error_count;
> +
> +       /* inode can be null for superblock errors */
> +       unsigned int *inode;

Any reason not to use fanotify_fid_t * like fanotify16.c?

Thanks,
Amir.
