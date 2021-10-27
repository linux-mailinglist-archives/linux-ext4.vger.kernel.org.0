Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452F243C33A
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJ0GvS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhJ0GvR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:51:17 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA423C061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:48:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i14so2307901ioa.13
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH2jDgjkZqM0c/Z2XA4KwmpdoZJ1Ms7cYMsi0KTSDzo=;
        b=AQuzx96z6KSI3OzEkPMnGtSC90KILepbtfJ3bsfqrKMRZj7F93OAnh5+6Qo871ldzv
         aAeYQk7V4vODcXSRg0iriOe3zyYLYHIajsmG6LE+3EiQ/jnj0IEzL+aTiy5U4K/jW48g
         mLHC2Yx4Szdd1r46zWvPVDddVwud1D6CoN678vzosstSl8npoHEEnvisG9JhOx2pBFKn
         As4JObmIGbg/RI4xdpsVGUFHSQkgPDvh8JhKSviLTelorDltd/3AETD8B5I490n9yKwO
         Lnb8ln9J20vIUl0dLXIl0ISdxH1f7N3Nw1sl026fKyPJUe6A8iT/kuKXlerLFUcf0Jne
         mVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH2jDgjkZqM0c/Z2XA4KwmpdoZJ1Ms7cYMsi0KTSDzo=;
        b=jXNXQ8GD8/QmuOY/LmBxmhH+UZDF49dbxUMfGr6da/Z52pJvBpivz5IiG2KVdU8aKV
         4yzz988/EQwr9wfq7AkMWRLH4W8XCkL+MUDUDLXUt4LNx6B0uvB7WTBEm24ej4CNx1HV
         n72yqFWmI2V7Xg2z4ngVG34SX0kEAXeOMYoxBy0JdZETleSJrkYTTpNydueKTySqJLlx
         jn0Es0yI+BUhQK2r9AN09raKCD9iQgCmZop3kP4sVfsvBrUDJDHhoVp7FVObQi1zjoFw
         +ZJNMlKCw8V6ZRXCTTxSnE26eUmalLWMP7VrZE0UZ3XK+3agKvoUXYg5q8hBT37vqKik
         QwkQ==
X-Gm-Message-State: AOAM531rMmzrQQVoMT3bokvPAWLCKhSqp/7HtLxggNOJ000enN/quHvB
        UGqz4c5OrBNpqiJ/H2CiqoXecoRomM5+jmpz7ts=
X-Google-Smtp-Source: ABdhPJyYCNTsxl0HvixDf2KeW6VzQrseg8hlkG6g8MWIuVh9dNvjHkxylHYh+IL/wfHgdfrMpYH05bdXWwtF7s1p1yY=
X-Received: by 2002:a02:270c:: with SMTP id g12mr18464820jaa.75.1635317332105;
 Tue, 26 Oct 2021 23:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-6-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-6-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:48:41 +0300
Message-ID: <CAOQ4uxj2b5ckh8VS19ALzU8rjuv0svJg7amCz2j1Cyemi3B+Ww@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] syscalls/fanotify20: Validate incoming FID in FAN_FS_ERROR
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
> Verify the FID provided in the event.  If the FH has size 0, this is
> assumed to be a superblock error (i.e. null FH).
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Except maybe move define of FILEID_INVALID to header.

>
> ---
> Changes since v1:
>   - Move defines to header file.
>   - Use 0-len FH for sb error
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h |  4 ++
>  .../kernel/syscalls/fanotify/fanotify20.c     | 63 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 58e30aaf00bc..9bff3cf1a3fe 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -435,4 +435,8 @@ struct fanotify_event_info_header *get_event_info(
>         ((struct fanotify_event_info_error *)                           \
>          get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
>
> +#define get_event_info_fid(event)                                      \
> +       ((struct fanotify_event_info_fid *)                             \
> +        get_event_info((event), FAN_EVENT_INFO_TYPE_FID))
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 6074d449ae63..220cd51419e8 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -34,20 +34,61 @@
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
>
> +#ifndef FILEID_INVALID
> +#define        FILEID_INVALID          0xff
> +#endif
> +
>  #define BUF_SIZE 256
>  static char event_buf[BUF_SIZE];
>  int fd_notify;
>
>  #define MOUNT_PATH "test_mnt"
>
> +/* These expected FIDs are common to multiple tests */
> +static struct fanotify_fid_t null_fid;
> +
>  static struct test_case {
>         char *name;
>         int error;
>         unsigned int error_count;
> +       struct fanotify_fid_t *fid;
>         void (*trigger_error)(void);
>  } testcases[] = {
>  };
>
> +int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> +                                const struct test_case *ex)
> +{
> +       struct file_handle *fh = (struct file_handle *) &fid->handle;
> +
> +       if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> +               tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> +                       ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +                       FSID_VAL_MEMBER(ex->fid->fsid, 0));
> +
> +               return 1;
> +       }
> +       if (fh->handle_type != ex->fid->handle.handle_type) {
> +               tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
> +                       ex->name, fh->handle_type, ex->fid->handle.handle_type);
> +               return 1;
> +       }
> +
> +       if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
> +               tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
> +                       ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
> +               return 1;
> +       }
> +
> +       if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
> +               tst_res(TFAIL, "%s: Received wrong handle. "
> +                       "Expected (%x...) got (%x...) ", ex->name,
> +                       *(int*)ex->fid->handle.f_handle, *(int*)fh->f_handle);
> +               return 1;
> +       }
> +       return 0;
> +}
> +
>  int check_error_event_info_error(struct fanotify_event_info_error *info_error,
>                                  const struct test_case *ex)
>  {
> @@ -91,6 +132,7 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>         struct fanotify_event_metadata *event =
>                 (struct fanotify_event_metadata *) buf;
>         struct fanotify_event_info_error *info_error;
> +       struct fanotify_event_info_fid *info_fid;
>         int fail = 0;
>
>         if (len < FAN_EVENT_METADATA_LEN) {
> @@ -109,6 +151,14 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>                 fail++;
>         }
>
> +       info_fid = get_event_info_fid(event);
> +       if (info_fid)
> +               fail += check_error_event_info_fid(info_fid, ex);
> +       else {
> +               tst_res(TFAIL, "FID record not found");
> +               fail++;
> +       }
> +
>         if (!fail)
>                 tst_res(TPASS, "Successfully received: %s", ex->name);
>  }
> @@ -125,12 +175,25 @@ static void do_test(unsigned int i)
>         check_event(event_buf, read_len, tcase);
>  }
>
> +static void init_null_fid(void)
> +{
> +       /* Use fanotify_save_fid to fill the fsid and overwrite the
> +        * file_handler to create a null_fid
> +        */
> +       fanotify_save_fid(MOUNT_PATH, &null_fid);
> +
> +       null_fid.handle.handle_type = FILEID_INVALID;
> +       null_fid.handle.handle_bytes = 0;
> +}
> +
>  static void setup(void)
>  {
>         REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                                 FAN_MARK_FILESYSTEM,
>                                                 FAN_FS_ERROR, ".");
>
> +       init_null_fid();
> +
>         fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                        O_RDONLY);
>
> --
> 2.33.0
>
