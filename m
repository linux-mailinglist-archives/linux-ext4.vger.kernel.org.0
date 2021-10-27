Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3EA43C6F3
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhJ0KAJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhJ0KAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 06:00:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E12C061570
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 02:57:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i14so2827836ioa.13
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WrogrSAm5ZF8GRQoSCA7MqzK4VmLEjqv6Sj4BzXSI8=;
        b=gJ1kRlkb85aCjZRi5kTYIJXO6lIC/gpLa0Cr5Ip8nKJzgLQxdp+cifFEUdzA04LAF/
         F/7ZF1yeTU1zOFFnhmD12CUxT710VppK4ZIdHuJrJOykeiNr+QnWfm+fxk9JlSxtbeiy
         YZiO9Lpa6pV4yY2eMGk0L6CcafzLwyl7n1Ap7H4uSZ40pIqnAclbQkAgAkw633eqWPAj
         8f9SpTLjwwTp4VgG2d7kBnIae9R/jjuZFYeOoVRlYFyUdsvalNLe+hymWu8Cc8WNDlwM
         jTAWvC4wHrTJTfLfjR2PnloR/zaptnjFGc3o+hceICpr/NO5nhgTbRNCQKnMfeOGvnt7
         GesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WrogrSAm5ZF8GRQoSCA7MqzK4VmLEjqv6Sj4BzXSI8=;
        b=mYwRXIF2DiAiHqlOr3I5kfjh4rBtkiYzaXvkooVhQO/t10Q80WVaOvxOCW0C+Z2mtV
         8sUOM/SQ7d4QFF6nPQsK6IMSk37ph2K3exhJRp1IoRczAu9uM0a8n2BwQVXFLxXKOkhv
         3a8BPFWPzR4VyuXIS6IVWLkyGkN+Fo4yiq7kuSRHk1UD1VxC1wOJcaMpTbPWcWiCc8CC
         PTyDy4/wXxSr6OlBolp4QXoBMZCdT2qUUOR4LG/OvCzfAus/AtsF5jp5q1VO7oxROELu
         FMHpc2UR5cyDnedbpZPHS3T7HrcEOVhy2KRSVJCOirUoncTxfDKpsfeKwDFrMkitTEiz
         Cpgg==
X-Gm-Message-State: AOAM5327V6eRfyd4cT8IuznA8hLsFm/1qnb6DyU7Oc5anhJCYTXd3laZ
        Gk3Igl5qTDoU4qImsvmpTckMHpAaCNLpkZ7wd6uV44H2Z5M=
X-Google-Smtp-Source: ABdhPJzx7psvTUYqHw3i6cTwp33X5jb3phMbUzIV9BqhyvIQ0+6gEaiammThqsyGDp/MPYmQfT3RGNNu6gUx1ajQEAM=
X-Received: by 2002:a05:6638:2607:: with SMTP id m7mr13015209jat.136.1635328663364;
 Wed, 27 Oct 2021 02:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-10-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 12:57:32 +0300
Message-ID: <CAOQ4uxjUKEf1wTqt6qCc65pEhwy9A+cZL8TUV40UFRDPNoc7xA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] syscalls/fanotify20: Test file event with broken inode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> This test corrupts an inode entry with an invalid mode through debugfs
> and then tries to access it.  This should result in a ext4 error, which
> we monitor through the fanotify group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 5c5ee3c6fb74..7bcddcaa98cb 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -38,6 +38,10 @@
>  #define        FILEID_INVALID          0xff
>  #endif
>
> +#ifndef EFSCORRUPTED
> +#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> +#endif
> +
>  #define BUF_SIZE 256
>  static char event_buf[BUF_SIZE];
>  int fd_notify;
> @@ -63,6 +67,17 @@ static void trigger_fs_abort(void)
>                    MS_REMOUNT|MS_RDONLY, "abort");
>  }
>
> +static void tcase2_trigger_lookup(void)
> +{
> +       int ret;
> +
> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
> +       ret = open(MOUNT_PATH"/"BAD_DIR, O_RDONLY, 0);
> +       if (ret != -1 && errno != EUCLEAN)
> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
> +                       ret, BAD_DIR, errno, EUCLEAN);
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -77,6 +92,13 @@ static struct test_case {
>                 .error = ESHUTDOWN,
>                 .fid = &null_fid,
>         },
> +       {
> +               .name = "Lookup of inode with invalid mode",
> +               .trigger_error = &tcase2_trigger_lookup,
> +               .error_count = 1,
> +               .error = EFSCORRUPTED,
> +               .fid = &bad_file_fid,
> +       },
>  };
>
>  int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> --
> 2.33.0
>
