Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD333C284
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 17:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhCOQxX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhCOQxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 12:53:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF4C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 09:53:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r17so67406204ejy.13
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WfjukaUYQrWHiKEaJlFv8ElPEcamSibEoC+lwBDP0U4=;
        b=QDZq39iHhSElX7BFWxEXYW5pB+oevFX3YCk0rhmBKFLNMVTUdjFYXCV7+62/yEkpjC
         Ws63YUh1S3MuN+1qHxlvdRmZ0pLtL3p2rBzzi94v5HdJoOwBgwkxGHjXF6GjaN5KNfQd
         LIlvf0NHRv+mqxqq/Z0vggq4947AdtZLfPhPyXHm73kUNbm1B/xLARHxV+UUIOjIZtbf
         +S7nUZDaogA5XxCwmhy6cDz2AteTJNWQlhwzwjPTuwNZBieX9mjHHY9qQ+Gp/eeyzvli
         GzhgE/9KZmhv9Kbmq2vw2NgD26+vaHldXuAwBlsokakTM2gYDDAM8CxpVX0D3MhOho+D
         Waew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WfjukaUYQrWHiKEaJlFv8ElPEcamSibEoC+lwBDP0U4=;
        b=lTcjHJ/ig1e8FZaGQCKy29FsUdxIjJuEKDe62K2zo4tjK2/zLzwmUA9b7X0pAn6Qwu
         W7zByFTComkXOguddgMwxiknPZAY1t1QchWxU7irrk/c5EMUDf3DBFnkLl7UkWKqsYd2
         HOpBlNoMD6EFxehGN4U5JDdgtyKYPV/Aj7hNv0uaRJ4FxcFYgC2K8C3qztWH5abIiRtE
         wxamNRiur+s5GHpMK2M0kS/PpcrI9U4AM8BRmIleoJSfCLhL+YsFY5dhfr9rWyxHetcZ
         myqAbLT2E/hGMP/N/5+8aZNwglfm5808A8G1lhneWpvBwT2CYiBUj3jqRVRC1RFuUUlc
         J3NA==
X-Gm-Message-State: AOAM530639T5tLfC7K71Oiq1uNslf/BK9VF+vCJKq6p+m8UZqmxLlmP1
        ZscXzn5k8heAA2rCkwVFVhwbr60UwMfOBJZ0st21kuVsYMA=
X-Google-Smtp-Source: ABdhPJzYe56OsCKigYgGXVlKd5y0eeE3A7D6TY/Y3lYO14FcwTt5hYzrRWQc2j7WZh+5GwwCJK75sn8/ObldJ1XFMhk=
X-Received: by 2002:a17:907:c16:: with SMTP id ga22mr24804139ejc.120.1615827194609;
 Mon, 15 Mar 2021 09:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <b7c93630-9b74-994a-8a82-8ab827ca5a2d@huawei.com> <76b59f75-3308-10bd-34ea-8ab961861ecd@huawei.com>
In-Reply-To: <76b59f75-3308-10bd-34ea-8ab961861ecd@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 15 Mar 2021 09:53:03 -0700
Message-ID: <CAD+ocby2BuhQRq=YLeV7E2gCiKDGXMKvfL4=RLdSVj6afrr9bw@mail.gmail.com>
Subject: Re: [PATCH v2] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Haotian Li <lihaotian9@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linfeilong <linfeilong@huawei.com>, liangyun2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the updated patch. Just have some a couple of minor nits
but other than that this looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Thu, Mar 11, 2021 at 3:50 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wro=
te:
>
> friendly ping..
>
> On 2021/3/6 15:27, Haotian Li wrote:
> > jbd2_journal_recover() may fail when some error occers such
> > as ENOMEM and EIO.  However, jsb->s_start is still cleared
> > by func e2fsck_journal_release(). This may break consistency
> > between metadata and data in disk. Sometimes, failure in
> > jbd2_journal_recover() is temporary but retry e2fsck will
> > skip the journal recovery when the temporary problem is fixed.
> >
> > Following harshad shirwadkar's suggestion=EF=BC=8Cwe add an option
> > "recovery_error_behavior" with default value "continue" to
> > e2fsck.conf. User may set it to "retry" or "exit" to adopt
> > different behavior when such journal recovery errors occur.
> >
> > Reported-by: Liangyun <liangyun2@huawei.com>
> > Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> > ---
> >  e2fsck/e2fsck.h  | 11 +++++++++++
> >  e2fsck/journal.c | 33 +++++++++++++++++++++++++++++++--
> >  e2fsck/unix.c    | 13 ++++++++++++-
> >  3 files changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> > index 15d043ee..22f9ad11 100644
> > --- a/e2fsck/e2fsck.h
> > +++ b/e2fsck/e2fsck.h
> > @@ -451,6 +451,9 @@ struct e2fsck_struct {
> >
> >       /* Fast commit replay state */
> >       struct e2fsck_fc_replay_state fc_replay_state;
> > +
> > +     /* Behavior when journal recovery fails */
> > +     int recovery_error_behavior;
> >  };
> >
> >  /* Data structures to evaluate whether an extent tree needs rebuilding=
. */
> > @@ -474,6 +477,14 @@ typedef struct region_struct *region_t;
> >  extern int e2fsck_strnlen(const char * s, int count);
> >  #endif
> >
> > +/* Different behaviors when journal recovery fails */
> > +#define RECOVERY_ERROR_CONTINUE 0
> > +#define RECOVERY_ERROR_RETRY 1
> > +#define RECOVERY_ERROR_EXIT 2
> > +
> > +/* Journal retry times if RECOVERY_ERROR_RETRY is set*/
> > +#define RECOVERY_TIMES_LIMIT 3
> > +
> >  /*
> >   * Procedure declarations
> >   */
> > diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> > index a425bbd1..c1c6f6ee 100644
> > --- a/e2fsck/journal.c
> > +++ b/e2fsck/journal.c
> > @@ -1600,11 +1600,26 @@ no_has_journal:
> >       return retval;
> >  }
> >
> > +static void set_recovery_error_behavior(e2fsck_t ctx, const char *reco=
very_behavior)
> > +{
> > +     if (!recovery_behavior) {
> > +             ctx->recovery_error_behavior =3D RECOVERY_ERROR_CONTINUE;
> > +             return;
> > +     }
> > +     if (strcmp(recovery_behavior, "retry") =3D=3D 0)
> > +             ctx->recovery_error_behavior =3D RECOVERY_ERROR_RETRY;
> > +     else if (strcmp(recovery_behavior, "exit") =3D=3D 0)
> > +             ctx->recovery_error_behavior =3D RECOVERY_ERROR_EXIT;
> > +     else
> > +             ctx->recovery_error_behavior =3D RECOVERY_ERROR_CONTINUE;
> > +}
> > +
> >  static errcode_t recover_ext3_journal(e2fsck_t ctx)
> >  {
> >       struct problem_context  pctx;
> >       journal_t *journal;
> >       errcode_t retval;
> > +     char *recovery_behavior =3D 0;
> >
> >       clear_problem_context(&pctx);
> >
> > @@ -1629,8 +1644,12 @@ static errcode_t recover_ext3_journal(e2fsck_t c=
tx)
> >               goto errout;
> >
> >       retval =3D -jbd2_journal_recover(journal);
> > -     if (retval)
> > +     if (retval) {
> > +             profile_get_string(ctx->profile, "options", "recovery_err=
or_behavior",
> > +                             0, "continue", &recovery_behavior);
> > +             set_recovery_error_behavior(ctx, recovery_behavior);
> >               goto errout;
> > +     }
> >
> >       if (journal->j_failed_commit) {
> >               pctx.ino =3D journal->j_failed_commit;
> > @@ -1645,7 +1664,15 @@ errout:
> >       jbd2_journal_destroy_revoke(journal);
> >       jbd2_journal_destroy_revoke_record_cache();
> >       jbd2_journal_destroy_revoke_table_cache();
> > -     e2fsck_journal_release(ctx, journal, 1, 0);
> > +     if (retval =3D=3D 0 || ctx->recovery_error_behavior =3D=3D RECOVE=
RY_ERROR_CONTINUE)
> > +             e2fsck_journal_release(ctx, journal, 1, 0);
> > +     if (retval && ctx->recovery_error_behavior =3D=3D RECOVERY_ERROR_=
EXIT) {
> > +             ctx->fs->flags &=3D ~EXT2_FLAG_VALID;
> > +             com_err(ctx->program_name, 0,
> > +                                     _("Journal recovery failed "
> > +                                       "on %s\n"), ctx->device_name);
> > +             fatal_error(ctx, 0);
> > +     }
> >       return retval;
> >  }
> >
> > @@ -1697,6 +1724,8 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
> >
> >       /* Set the superblock flags */
> >       e2fsck_clear_recover(ctx, recover_retval !=3D 0);
> > +     if (recover_retval !=3D 0 && ctx->recovery_error_behavior =3D=3D =
RECOVERY_ERROR_RETRY)
> > +             ext2fs_set_feature_journal_needs_recovery(ctx->fs->super)=
;
> >
> >       /*
> >        * Do one last sanity check, and propagate journal->s_errno to
> > diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> > index c5f9e441..25978471 100644
> > --- a/e2fsck/unix.c
> > +++ b/e2fsck/unix.c
> > @@ -1068,6 +1068,8 @@ static errcode_t PRS(int argc, char *argv[], e2fs=
ck_t *ret_ctx)
> >       if (c)
> >               ctx->options |=3D E2F_OPT_ICOUNT_FULLMAP;
> >
> > +     ctx->recovery_error_behavior =3D RECOVERY_ERROR_CONTINUE;
> > +
> >       if (ctx->readahead_kb =3D=3D ~0ULL) {
> >               profile_get_integer(ctx->profile, "options",
> >                                   "readahead_mem_pct", 0, -1, &c);
> > @@ -1776,6 +1778,7 @@ failure:
> >                                 "doing a read-only filesystem check.\n"=
));
> >                       io_channel_flush(ctx->fs->io);
> >               } else {
> > +                     int recovery_retry_times =3D 0;
> >                       if (ctx->flags & E2F_FLAG_RESTARTED) {
> >                               /*
> >                                * Whoops, we attempted to run the
> > @@ -1788,7 +1791,15 @@ failure:
> >                                         "on %s\n"), ctx->device_name);
> >                               fatal_error(ctx, 0);
> >                       }
> > -                     retval =3D e2fsck_run_ext3_journal(ctx);
> > +                     while (recovery_retry_times++ < RECOVERY_TIMES_LI=
MIT) {
> > +                             retval =3D e2fsck_run_ext3_journal(ctx);
> > +                             if (retval && ctx->recovery_error_behavio=
r =3D=3D RECOVERY_ERROR_RETRY) {
> > +                                     log_out(ctx, _("Try to recovery J=
ournal "
> > +                                                    "again in %s\n"),
(nit) I think there's no reason to break the string into 2 lines. This
will make this string searchable.
> > +                                             ctx->device_name);
> > +                             } else
> > +                                     break;
(style) Since you have {} brackets for if condition, please add it for
else too (or remove it for if condition too)

Thanks,
Harshad
> > +                     }
> >                       if (retval =3D=3D EFSBADCRC) {
> >                               log_out(ctx, _("Journal checksum error "
> >                                              "found in %s\n"),
>
