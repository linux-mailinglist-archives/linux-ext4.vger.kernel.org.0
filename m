Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573733DFB0B
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhHDF2L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhHDF2K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 01:28:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8211DC0613D5
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 22:27:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z7so1080486iog.13
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 22:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myrdhhON69Xr522LEUNLiwzWKFEr4/kgK5HyBkBCT/8=;
        b=JjcTHMcBmeemkKemmngFwCPa0WIeHGJFIT57s9r2IaxcWScthYEZgIHndhKbvfH6gC
         7bUCUIrXJaAZICtuXlznR4AzEJy+LbTfK+yJRy6Fa/c+FMh0AovRs1ynbccoukkY7ydb
         yrg1QjErBvv0u4wWOqAo+DfZByNcjFAfLaSKWjEXJo85au+K+RRKhCRI3/wq4UGEeFax
         j3VE4TZ5afX3PHf8IDRT/fCsKRT6rth7BvIsf+Mny213I+phifOsl/vxJTUu6IGpXq4o
         elDIfOArcNHX38E1n4lPqRkIXA7wrQJuo2aKyVFx58k4zqJqXBfc79uHhLg1FmilSk+T
         r5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myrdhhON69Xr522LEUNLiwzWKFEr4/kgK5HyBkBCT/8=;
        b=Kh0nvEq9hnfWQbK11ddQqPK2yyianxY/R2fWmtMJ44cecpH5B6GPctQWjsBcqcbhTj
         z8ZhneyGkbaL7EUBO35BBWNqkANuklq1M7a6J2cD0dFZCqAQioOU929LaJF2Z+dQW6fV
         ZLl9SPYgLs8rkMvqKJ23GpwUWukGQUwwnc7WGzs7iF0FWo5gAwGDN1KU8ByubbTVnf7A
         3BHAqRaQTwcoPy5ONM3pEyo/GvDyr/HyBCxTDB/UBjVToa9STPPfYycQlH9sh16aKxz2
         hhTcXCdSBE6kdPqcm5Sb8HYoLAdvIED1Kh+J/udEkxHutMPg2tUdZpuqTlKZxVEySPdf
         YeMQ==
X-Gm-Message-State: AOAM531woCUlZtIxW//WYhSlJuv+s8lwo4yJ7frt04ddnTWFOGu7xZij
        FBq3dMPbu0210DYgyOmPmU9p9EbNYnEvFSxam1g=
X-Google-Smtp-Source: ABdhPJxkzBjoVilk+g3RjAj5hq747ePxNnyTT1n5EGy0/sBUsXCPyShg6J4MajWobQI0T+jux/ZRfRg5CJO+vYPRmSQ=
X-Received: by 2002:a5e:9901:: with SMTP id t1mr273023ioj.5.1628054877917;
 Tue, 03 Aug 2021 22:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-7-krisman@collabora.com> <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
 <87k0l1hkuz.fsf@collabora.com>
In-Reply-To: <87k0l1hkuz.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Aug 2021 08:27:46 +0300
Message-ID: <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
Subject: Re: [PATCH 6/7] syscalls/fanotify20: Test file event with broken inode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 4, 2021 at 7:52 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> This test corrupts an inode entry with an invalid mode through debugfs
> >> and then tries to access it.  This should result in a ext4 error, which
> >> we monitor through the fanotify group.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> index e7ced28eb61d..0c63e90edc3a 100644
> >> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
> >>                    MS_REMOUNT|MS_RDONLY, "abort");
> >>  }
> >>
> >> +#define TCASE2_BASEDIR "tcase2"
> >> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
> >> +
> >> +static unsigned int tcase2_bad_ino;
> >> +static void tcase2_prepare_fs(void)
> >> +{
> >> +       struct stat stat;
> >> +
> >> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
> >> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
> >> +
> >> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
> >> +       tcase2_bad_ino = stat.st_ino;
> >> +
> >> +       SAFE_UMOUNT(MOUNT_PATH);
> >> +       do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
> >> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> >> +}
> >> +
> >> +static void tcase2_trigger_lookup(void)
> >> +{
> >> +       int ret;
> >> +
> >> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
> >> +       ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
> >> +       if (ret != -1 && errno != EUCLEAN)
> >> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
> >> +                       ret, TCASE2_BAD_DIR, errno, EUCLEAN);
> >> +}
> >> +
> >>  static const struct test_case {
> >>         char *name;
> >>         int error;
> >> @@ -92,6 +122,14 @@ static const struct test_case {
> >>                 .error_count = 1,
> >>                 .error = EXT4_ERR_ESHUTDOWN,
> >>                 .inode = NULL
> >> +       },
> >> +       {
> >> +               .name = "Lookup of inode with invalid mode",
> >> +               .prepare_fs = tcase2_prepare_fs,
> >> +               .trigger_error = &tcase2_trigger_lookup,
> >> +               .error_count = 1,
> >> +               .error = 0,
> >> +               .inode = &tcase2_bad_ino,
> >
> > Why is error 0?
> > What's the rationale?
>
> Hi Amir,
>
> That is specific to Ext4.  Some ext4 conditions report bogus error codes.  I will
> come up with a kernel patch changing it.
>

Well, I would not expect a FAN_FS_ERROR event to ever have 0 error
value. Since this test practically only tests ext4, I do not think it
is reasonable
for the test to VERIFY a bug. It is fine to write this test with expectations
that are not met and let it fail.

But a better plan would probably be to merge the patches up to 5 to test
FAN_FS_ERROR and then add more test cases after ext4 is fixed
Either that or you fix the ext4 problem along with FAN_FS_ERROR.

Forgot to say that the test needs to declare .needs_cmds "debugfs".

In any case, as far as prerequisite to merging FAN_FS_ERROR
your WIP tests certainly suffice.
Please keep your test branch around so we can use it to validate
the kernel patches.
I usually hold off on submitting LTP tests for inclusion until at least -rc3
after kernel patches have been merged.

Thanks,
Amir.
