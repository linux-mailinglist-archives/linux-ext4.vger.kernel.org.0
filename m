Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1633DE92B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHCJEg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhHCJEf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 05:04:35 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D0C06175F
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 02:04:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a14so18918672ila.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qj2aAMaCKOkOv3pjuNvGaLuywLSjBRkzfGuW2WwxrvU=;
        b=GXcoo/MYpIuIhshrZOXb5tmNzVDbDzsHjUs6su3z6pmeH+vJFapVmYgll7/xhpAcLo
         0iTwdztjuQ2vy4uJY3tKdJaSi7rDYQnII23epgmnHPNp8DKQAzKq3Pdnsz8yrANdSXym
         QGNyb/bJTseedvnsK1KimIXg8XDhCEpJs8mOHfxkHO8Au00qLlR3ouNwglTnEwe6hXKy
         knt8F2rVxkRABak1buwtRjd0tTTWj0Vvrtht6v6ZmmAUbxBmC6k9scNBBBUUlg1FA+1T
         KnUcjv5uHQGIFbK3iU6PViWvqIkF2dSOrCKASOB2pwh0ktDV0v9gzm+Uml2z9GKEP7m6
         tG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj2aAMaCKOkOv3pjuNvGaLuywLSjBRkzfGuW2WwxrvU=;
        b=Klx0xODkxXgVbEJARSX939YtXenKBqinqedGfnReVNZ/35ILIB1Su302mH7SgC20F1
         6r/mT0SfzDiCHPqo9sB7GOx0j8jPzpxFYr1PeMsDyB6WhQ7IzRhDOiJoJbajzj3kb7TC
         oHRuFcJrO0ifoxUm1oqTYesKEJiGqlPCd+46iZOWt2t3uMKw2UQDRVV6IlpQ8wYzckA0
         Ml0lbBmCvN3cdN4kmB1pyr9pPTJk4Kt4c2CED73WJLL0kfYEKCwqDDooyBzku0AjFErp
         ebdmJfBlZclfXubyLiqyamcwUdjjD62PXnth3iL6NBPxJ4wdoi0+hxtEOq8AdYst5IUv
         Ey2g==
X-Gm-Message-State: AOAM532FULYq/TyLY5Eg0hlX7/nZcVy7+70Z+3eCm8Rp78uz438DPaXg
        y1huaEe6ucyeJsdi4ZMFTaNNDsMx5bBSa+QsYs4=
X-Google-Smtp-Source: ABdhPJywg/32gcJfmOoe0KUQKoC8WWd8mK2awKsaAOOxPey+N5VGaF0M8XLl//l/Naf3UX+dEJzFhaJFml2HvSRF/hU=
X-Received: by 2002:a05:6e02:1bcc:: with SMTP id x12mr900886ilv.275.1627981464743;
 Tue, 03 Aug 2021 02:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com> <20210802214645.2633028-7-krisman@collabora.com>
In-Reply-To: <20210802214645.2633028-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 12:04:13 +0300
Message-ID: <CAOQ4uxg3MPfMeMPpzompend0n3rH3b1+fFbzUSHsMGRJX0ruEg@mail.gmail.com>
Subject: Re: [PATCH 6/7] syscalls/fanotify20: Test file event with broken inode
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
> This test corrupts an inode entry with an invalid mode through debugfs
> and then tries to access it.  This should result in a ext4 error, which
> we monitor through the fanotify group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index e7ced28eb61d..0c63e90edc3a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
>                    MS_REMOUNT|MS_RDONLY, "abort");
>  }
>
> +#define TCASE2_BASEDIR "tcase2"
> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
> +
> +static unsigned int tcase2_bad_ino;
> +static void tcase2_prepare_fs(void)
> +{
> +       struct stat stat;
> +
> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
> +
> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
> +       tcase2_bad_ino = stat.st_ino;

Better use fanotify_save_fid(MOUNT_PATH"/"TCASE2_BAD_DIR, &tcase2_bad_fid)

Thanks,
Amir.
