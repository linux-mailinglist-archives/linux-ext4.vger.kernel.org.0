Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382C23DE979
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhHCJIe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 05:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhHCJIe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 05:08:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBFC06175F
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 02:08:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r6so15198785ioj.8
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPERkJDmUqGoRJFFlz2gKtkglfVn/RWj0tAIej+ZdiE=;
        b=RRfnOeKlylu8ywyvQb6H0cO0JtzkY429YJjwumfAFf/SZscQirLsajSf5EgYv2OhWq
         El+BUjtEFtcUKnb8LQHJUIkdSccZCEAekR984fMhJfaIs+Oo5IJzSuK4ha2cYZA0Abfv
         yR1boDQpLB3w44V+pyqykhPjYREzPCPFOzN0UL2nGkB92VQAW8lSmfAZUlQszGwvk9iE
         hp8ZO3kb2Xj76uy//HssJIQkcCQhbv2fJ2ZgqOjnsabOX8APjTMy+rMnXIDdoV9nhSoU
         LIrejgyCZpyOpATOn5nZV/JLAhcl0bpF+hAVvcGRloLJ6uaSrD0xfbSwQbuqLGSOAqhs
         VG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPERkJDmUqGoRJFFlz2gKtkglfVn/RWj0tAIej+ZdiE=;
        b=howlok290UPLhfeytbIBTVicWm+m7Zh2t9XJOiYByrIL0QMYEU6Zqe+gzEJ4MFzdcj
         gcunZan0jxAeoTIiQ3+EVhB66I/cnsC4xStUGJ03bt/o5vH8RALoKnnOhaSVkrFGOHfr
         1VTelzSGTz5pbL264C6kbj4cM0LaVAcrdNJaxfmPZeQLu8bNXRDTNImJekjnKieIX8Nt
         n95xsCTQwLnBzx08geh5FiY1D5Vb3PQzXSDY5Ym9C3A9cLA6ZnFrPaTmtn+tCIRDoGeq
         g+8t5ckBqJ97ptcxBcEGMQE1htB2R+kNwD/WaeHRztQG0T846qPmkH75o48FDsLrUXLw
         OgIA==
X-Gm-Message-State: AOAM530bno7FZZw7tx7qmBc/NTkxKZNkR7zSKvM/ic4lPyeTeEwZZ8sr
        zv6qw0Uv1byrRvZYZong8Ky0OiPq5S+u969nC3o=
X-Google-Smtp-Source: ABdhPJz6F+shkrmdHDJroNU389Y4xO819lFYsCQG85LzU0uSAHVf0Pu149/WHxn8436j5m8vlPMSZvLTUwVDR0kzFmY=
X-Received: by 2002:a02:908a:: with SMTP id x10mr17967649jaf.30.1627981702512;
 Tue, 03 Aug 2021 02:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com> <20210802214645.2633028-7-krisman@collabora.com>
In-Reply-To: <20210802214645.2633028-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 12:08:11 +0300
Message-ID: <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
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
> +
> +       SAFE_UMOUNT(MOUNT_PATH);
> +       do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> +}
> +
> +static void tcase2_trigger_lookup(void)
> +{
> +       int ret;
> +
> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
> +       ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
> +       if (ret != -1 && errno != EUCLEAN)
> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
> +                       ret, TCASE2_BAD_DIR, errno, EUCLEAN);
> +}
> +
>  static const struct test_case {
>         char *name;
>         int error;
> @@ -92,6 +122,14 @@ static const struct test_case {
>                 .error_count = 1,
>                 .error = EXT4_ERR_ESHUTDOWN,
>                 .inode = NULL
> +       },
> +       {
> +               .name = "Lookup of inode with invalid mode",
> +               .prepare_fs = tcase2_prepare_fs,
> +               .trigger_error = &tcase2_trigger_lookup,
> +               .error_count = 1,
> +               .error = 0,
> +               .inode = &tcase2_bad_ino,

Why is error 0?
What's the rationale?

Thanks,
Amir.
