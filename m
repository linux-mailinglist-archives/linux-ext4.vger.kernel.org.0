Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D080943C33E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhJ0GwJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhJ0GwI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:52:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4EC061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:49:43 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j6so1905687ila.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTcIThS3K4MSsezMWiyqdAkKQvdOCZHvQVYrx0/wUp4=;
        b=XSFGYIfVLHO02djNrgJC58hMvXON9OBKHZgy9wMGPZAKE68e21KxkBdxxAZdJLc50w
         Getp3m4EJkokSFrnpqaMhVB6peS+v36uve907pqP3E1hbf/nQeS5sijeb9XCitkqdsZQ
         O04iMEeY3z83acq7QIdC1UgWyk8GssIW24c5d/qJYPAdquKwiolCWM7EcfFuDbl7RY4z
         jr9l4ZlieMRcgufD76BW3v3vV/mY+KJM5fVVftYarjDgxHHGsvhkWJREIu1u727cBqbT
         QquZypA+AQfjnK6VUGB6HpjyHwptWMf2EHhKiGFagpvmde5Fgrt6LAZevJyxpN9x2tff
         YAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTcIThS3K4MSsezMWiyqdAkKQvdOCZHvQVYrx0/wUp4=;
        b=fOv/Do4JbPY3SnCjkQFxu5j7Iol6LhUj+npIB9oTTSmNTQj1BkqLBr9dpio99GQlLY
         ovKqMazVHsPc8LkcMtCHMVGvInduM/ALe4UEYXm9XcqEFFaVbRzDL1ceKRS8gfFIbG1q
         jmdcmUpSLpwYdY9tK6yKfkPwNFKAwYT5LkVdvh6H7PHfUTjt4EUlrLg49Zw07cWfnTHE
         T1wRVnChvSmB1ayzU6cAwgZWUcDp0swf+k2BDfEU2mrKzzEKv+rEvYViTqw1pM56u2zR
         acX3xoJxXpklPcAWZ3Myf/cU47CkliLpM3yNTCi5SBUYyhagIdg77oo3q69t+vIUZtAi
         iKqg==
X-Gm-Message-State: AOAM530jt9cduAC6Fx2t/2Z9QKHugxkerysc8f4CB9b/D/N33XLtIcSk
        1IJCwpQNuam6VGKJ4/jU77xQtRXi9/C4DzdKMhe4b5hydPw=
X-Google-Smtp-Source: ABdhPJyJcU0xlrzGHNr1JgWFdx5TG84DgZ0qg1n3aI2wt0Fa15e/O8oBBlRNKCCZ7b9xDX7jsfd9oMYpbUhq1YmTZGY=
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr16714378ilv.24.1635317383344;
 Tue, 26 Oct 2021 23:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-7-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:49:32 +0300
Message-ID: <CAOQ4uxjMgtSZX5oUV_0efg0RYSfxhszJo+pET4+vRqTL+9qDpg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] syscalls/fanotify20: Support submission of
 debugfs commands
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
> In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
> easiest way to do it is by using debugfs.  Add a small helper to issue
> debugfs requests.  Since most likely this will be the only testcase to
> need this, don't bother making it a proper helper for now.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> changes since v1:
>   - Add .needs_cmds to require debugfs
> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 220cd51419e8..7c4b01720654 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -47,6 +47,13 @@ int fd_notify;
>  /* These expected FIDs are common to multiple tests */
>  static struct fanotify_fid_t null_fid;
>
> +static void do_debugfs_request(const char *dev, char *request)
> +{
> +       const char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
> +
> +       SAFE_CMD(cmd, NULL, NULL);
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -216,7 +223,11 @@ static struct tst_test test = {
>         .mntpoint = MOUNT_PATH,
>         .all_filesystems = 0,
>         .needs_root = 1,
> -       .dev_fs_type = "ext4"
> +       .dev_fs_type = "ext4",
> +       .needs_cmds = (const char *[]) {
> +               "debugfs",
> +               NULL
> +       }
>  };
>
>  #else
> --
> 2.33.0
>
