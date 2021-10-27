Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0BA43C34C
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhJ0Gxr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbhJ0Gxq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:53:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A54C061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:51:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e144so2413714iof.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wq3q1r1Bq8Lf3l3kvTqvUSL7TT/wJ+nebfaosFfNaMM=;
        b=LwORCAJanRiaTvI7SLVhkt0v8KyAQgy92x0Y5yT0akkWLyq23or4xTWJBIzFEYarRj
         wdeqOMBO5xDWtk5I1U4ZyOb9ymBtvNRzBxhWK8hTjgAHt1h5028uJoD5+J43fU2nMgjX
         arS8nNjYtIHi+5nUUpNFLuyfIcywNYh7f2RK/ikMrYtv4P+3nmRF8gShznMUk6t4HF/3
         fnPYax5PLX5Jfgkkp6er42irqpcmluc7lIQNxMA/V07t2hr8LIDp+l/gou/OQgQdgopK
         YalHDgq+SJ3cZXULyneaP4JvuPsaGZ4QpdTn5vBARn6ySNQdsf4B/5DDIpNXU+Xbpi/+
         iSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wq3q1r1Bq8Lf3l3kvTqvUSL7TT/wJ+nebfaosFfNaMM=;
        b=Av30JEK60FOZsq/WO5tFk+NUcKw+wcznd7uk3bmXYc7vnlDs00niBOzrYnmKuuUxz/
         6p5Qels5KPWp7P++PlMiIBhE+GL98hfnPatlwn1OYTy2pX3qUorJpptYMFeEdUT52PIX
         KHg1pofKXM5l5CbKWfhMEWw7JPdrE4dU/4Y3T2H9AW+Ebi4izMAYdNIrtd7nfRvnQ2Nn
         L6ng81i9WgZRnmXqXKHh0in6mq5YQVvkKL5Ep9SCirDfqxKT11KA17nVoZo8lCaHlMjr
         MkPdH0K9/Q6WkIUynlL33SlqWtE5yVst/l/cYFlb92tNyMfwf0AZoD6BL6ov79jRsaAi
         SPJA==
X-Gm-Message-State: AOAM532eRDq5z2NH4A2z1McJ/2sAVlEVlqM3TQYqrts+IGcF6hbzGVeb
        +2im7kkRShX0IFqOsBb0loJdok6sgrYJk2jb+iU=
X-Google-Smtp-Source: ABdhPJxDENSupnNqRfjT+iu+ricW2IpUD2Ks+WPQ7xtcrTV252/Njrrtkjg6m7xl22Z5vpd8r41EY6u7ckj3XUx1kAA=
X-Received: by 2002:a02:7f17:: with SMTP id r23mr14083415jac.47.1635317481086;
 Tue, 26 Oct 2021 23:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-8-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-8-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:51:10 +0300
Message-ID: <CAOQ4uxjWN9zn_YE1s9mODDX3RGZrL5sqCvRZoZ5FXEba_=rAPw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] syscalls/fanotify20: Create a corrupted file
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
> Allocate a test directory and corrupt it with debugfs.  The corruption
> is done by writing an invalid inode mode.  This file can be later
> looked up to trigger a corruption error.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7c4b01720654..298bb303a810 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -43,9 +43,12 @@ static char event_buf[BUF_SIZE];
>  int fd_notify;
>
>  #define MOUNT_PATH "test_mnt"
> +#define BASE_DIR "internal_dir"
> +#define BAD_DIR BASE_DIR"/bad_dir"
>
>  /* These expected FIDs are common to multiple tests */
>  static struct fanotify_fid_t null_fid;
> +static struct fanotify_fid_t bad_file_fid;
>
>  static void do_debugfs_request(const char *dev, char *request)
>  {
> @@ -182,6 +185,18 @@ static void do_test(unsigned int i)
>         check_event(event_buf, read_len, tcase);
>  }
>
> +static void pre_corrupt_fs(void)
> +{
> +       SAFE_MKDIR(MOUNT_PATH"/"BASE_DIR, 0777);
> +       SAFE_MKDIR(MOUNT_PATH"/"BAD_DIR, 0777);
> +
> +       fanotify_save_fid(MOUNT_PATH"/"BAD_DIR, &bad_file_fid);
> +
> +       SAFE_UMOUNT(MOUNT_PATH);
> +       do_debugfs_request(tst_device->dev, "sif " BAD_DIR " mode 0xff");
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> +}
> +
>  static void init_null_fid(void)
>  {
>         /* Use fanotify_save_fid to fill the fsid and overwrite the
> @@ -201,6 +216,8 @@ static void setup(void)
>
>         init_null_fid();
>
> +       pre_corrupt_fs();
> +
>         fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                        O_RDONLY);
>
> --
> 2.33.0
>
