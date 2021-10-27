Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF143C6F0
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhJ0J6y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJ0J6x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 05:58:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C83C061570
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 02:56:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v65so2912947ioe.5
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx5FzWh2+59FwhLxH/OLbyER5DUWkW4P2Xv38wbcQjU=;
        b=d7ogYK5tLAAnWI91+5STK2KZv9RY3Vt6QbtNhht/d0Zek5hMvaPweKqhSO3Qs43AeD
         LnoE8E0AYOfOrJYuypEUzxMJYCGDF/zRPy1Unk66YjqgfbqRZjhG+RGgiOuT38kRDRIy
         J6zPKebnfAkORuiS0BmjESsFu2zR9p5dnxd0vc3RahRe3sIW8kDvcZI7Ts8G1FX6tm+A
         Z5SIUBaHHS6Wtstk1WdiuVlAbWSAl2TojvRji6mxM4Fagjbf0wzHnDmwi9M0F8f9/2n9
         nw1m3w1v3ci3zUu8LfIzUKBxhsdQG3QVYQaba6kmf6nNgINlnqAYqlXAPmSW77Pggn5L
         F6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx5FzWh2+59FwhLxH/OLbyER5DUWkW4P2Xv38wbcQjU=;
        b=Lkr9z5mYwoR19LkxjYIiH8KlgNbhbARtD2+Txmht+NYJ0/t4TK2EghtwfpLvRCyNQK
         O0hC9Ro6h5hGM+DZ4hSW4qisoW7kfqnP2BOYBafU4LCUX3OieKunWmz0897aLR123Qpv
         /gMYqHUl0mNyUGWx/ueKq4bad2MAhgOBnaWfhzjJzcqHA4RWO90IvaPgEdwkcjDJS0jz
         jiy3dzz9+DJL3E5HmljNYMPqWjWyxMhuZQAcLFy1VdI4edOtKsE756CrAOboHY1xiauq
         Yc4TFBXtwyege7BAPWg6obk7DNArx9Zx1PyiqdeJiKAhYAulpNckpmk1qZKEkLCGMLSm
         dm8A==
X-Gm-Message-State: AOAM532NIxlZ6GuBdYU9BORXbl++kajVA6Fe7uReLJ4shZs6sKMI9dK6
        Tkdn9BsrqTkEWPkirLS/+yhLbwId9w+c4WDLDw4=
X-Google-Smtp-Source: ABdhPJxAQJ7QqmNYNTgpydiMiD9Fqi3RePMvC6sqsrzeKZZHkBUTxyMa2ToG1l6/IseYxNQSHKNzOAVuSzKdIqydW+Q=
X-Received: by 2002:a02:270c:: with SMTP id g12mr19016049jaa.75.1635328585201;
 Wed, 27 Oct 2021 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-9-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-9-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 12:56:14 +0300
Message-ID: <CAOQ4uxh=Wmso0O6aXsE2Y3JAQte5Q0NYaUKJWLvLUuY_u-a__A@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] syscalls/fanotify20: Test event after filesystem abort
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
> This test monitors the error triggered after a file system abort.  It
> works by forcing a remount with the option "abort".  This is an error
> not related to a file so it is reported against the superblock with a
> zero size fh.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 298bb303a810..5c5ee3c6fb74 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -57,6 +57,12 @@ static void do_debugfs_request(const char *dev, char *request)
>         SAFE_CMD(cmd, NULL, NULL);
>  }
>
> +static void trigger_fs_abort(void)
> +{
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> +                  MS_REMOUNT|MS_RDONLY, "abort");
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -64,6 +70,13 @@ static struct test_case {
>         struct fanotify_fid_t *fid;
>         void (*trigger_error)(void);
>  } testcases[] = {
> +       {
> +               .name = "Trigger abort",
> +               .trigger_error = &trigger_fs_abort,
> +               .error_count = 1,
> +               .error = ESHUTDOWN,
> +               .fid = &null_fid,
> +       },
>  };
>

I suppose you did not try to run fanotify20 -i 10 ...?
I guess you will need to end the setup() stage with unmounted fs and perform:
mount; fanotify_init; fanotify_mark; at beginning of do_test()
finishing do_test() with closing fanotify fd and unmount.
I never checked it there are pre-test/post-test callbacks available in LTP,
but setup/clean are called at start/end of test loop.

Thanks,
Amir.
