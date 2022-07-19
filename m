Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF557A8CD
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jul 2022 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiGSVQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGSVQt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 17:16:49 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A211468
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 14:16:48 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 125so4201928vsd.5
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYOQ5FpxyPJTidYtmT7od7Xt1E+geWmRSC6sk5ZFN+Y=;
        b=hOH7mK+Zc3JZJTBRzN3U0x3COH7bnNJAoXafl6ICDkmURstc5c7bLWMCtQxBRxtRHi
         uwU+0g4JejekFSfkTKTcDUd6eNMqN2APkMWK0KnQZyJn9oP2T7eUNc9OaeeNacImItEA
         MF4EJcTLNSdLCcz/iCg8uOT+8XVHUpefNxhPxvpEpQHLwce9unk65USWumSlEtgIwUL3
         5CixVrcU+ZctP/qwGfQHnSAiHYytAMr6jbuC5vJjzeGyjExunwHbOJaUY6/2gSN9ln4+
         3E6ZyqIu6VJXrAkM+pg1jZCf/LlLWx2l3EHEI3vJTZnBrI6M4hG0X4qQnCvTzQXdD2ML
         6FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYOQ5FpxyPJTidYtmT7od7Xt1E+geWmRSC6sk5ZFN+Y=;
        b=GCDzQHNXprGuDaFIgUNE9etBqRehUkH9gJ1i7iThFCg70SBBD0oiXQuyKAyfPLFXAa
         OGcsiWWcsxXQTk7FiPOC7bl2zsGABaGA3gvEKXJibiQNEXpGYFcWTjQMSHjuEBQxvSFP
         3aq6QPMVHkv5Emhhzcv9S9DUWVTonqIQ42N9UOIpqyX4Z3j86bpD86KGSqgX67m94ic0
         2Yzm9UK2i13uPWug0y83PtE5os1q0kS2gRArQihRHBehfmAB6hegSmXoNhCdPUTwx3Vy
         /cTFlrbD/7TjvqAFtU7KWsrC70wZDCaVQR92PNs0KCebE4MF7mo/xP/f3S+brQSvM2uS
         4OFQ==
X-Gm-Message-State: AJIora/4tldXseoNoOs+CzoOCzYjtnFWUVThXORnlzOfuX3l72lAYXfX
        6VBFO48XzzkUi5uM0iW+SQMRJ9cyz2gOw0FcPiw=
X-Google-Smtp-Source: AGRyM1v/NSjGEcVIo/9kmC7sQ4JH91VZEPsHIKHjIeyoyvNvRjKRKJtdJP8COBkzHxnFfhr2c3MOMUA75RElA//GLgk=
X-Received: by 2002:a67:ac05:0:b0:357:ccab:9a7a with SMTP id
 v5-20020a67ac05000000b00357ccab9a7amr4918122vse.86.1658265407868; Tue, 19 Jul
 2022 14:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220719065637.154309-1-bongiojp@gmail.com> <YtbK8LJSYfCRx5B1@magnolia>
In-Reply-To: <YtbK8LJSYfCRx5B1@magnolia>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Tue, 19 Jul 2022 14:16:36 -0700
Message-ID: <CANfQU3yFomkM9Gfhnz=FfkzJj0MtPMGTrXMHnnBRzLPQk7imbg@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for get/set UUID ioctls.
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 19, 2022 at 8:17 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> > Subject: [PATCH v2] Add support for get/set UUID ioctls.
>
> Quick tip: Many people explicitly tag these userspace patches with the
> name of the tool in the subject line, e.g.
>
> [PATCH v2] tune2fs: add support for get/set UUID ioctls.

Oh good idea. I will do that in the next version.

>
> On Mon, Jul 18, 2022 at 11:56:37PM -0700, Jeremy Bongio wrote:
> > When mounted, there is a race condition between changing the filesystem
> > UUID and changing other aspects of the filesystem, like mounting, resizing,
> > changing features, etc. Using these ioctls to get/set the UUID ensures the
> > filesystem is not being resized.
> >
> > Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> > ---
> >
> > fu_* fields are now named fsu_*.
> >
> > Removed EXT4_IOC_SETFSUUID_FLAG_BLOCKING flag.
> >
> > fsu_flags is initialized to 0.
> >
> >  misc/tune2fs.c | 104 ++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 86 insertions(+), 18 deletions(-)
> >
> > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > index 6c162ba5..39399d83 100644
> > --- a/misc/tune2fs.c
> > +++ b/misc/tune2fs.c
> > @@ -82,11 +82,25 @@ extern int optind;
> >  #define FS_IOC_GETFSLABEL    _IOR(0x94, 49, char[FSLABEL_MAX])
> >  #endif
> >
> > +struct fsuuid {
> > +     __u32   fsu_len;
> > +     __u32   fsu_flags;
> > +     __u8    fsu_uuid[];
> > +};
> > +
> > +#ifndef EXT4_IOC_GETFSUUID
> > +#define EXT4_IOC_GETFSUUID   _IOR('f', 44, struct fsuuid)
> > +#endif
> > +
> > +#ifndef EXT4_IOC_SETFSUUID
> > +#define EXT4_IOC_SETFSUUID   _IOW('f', 44, struct fsuuid)
> > +#endif
> > +
> >  extern int ask_yn(const char *string, int def);
> >
> >  const char *program_name = "tune2fs";
> >  char *device_name;
> > -char *new_label, *new_last_mounted, *new_UUID;
> > +char *new_label, *new_last_mounted, *requested_uuid;
> >  char *io_options;
> >  static int c_flag, C_flag, e_flag, f_flag, g_flag, i_flag, l_flag, L_flag;
> >  static int m_flag, M_flag, Q_flag, r_flag, s_flag = -1, u_flag, U_flag, T_flag;
> > @@ -2102,7 +2116,7 @@ static void parse_tune2fs_options(int argc, char **argv)
> >                               open_flag = EXT2_FLAG_RW;
> >                               break;
> >               case 'U':
> > -                     new_UUID = optarg;
> > +                     requested_uuid = optarg;
> >                       U_flag = 1;
> >                       open_flag = EXT2_FLAG_RW |
> >                               EXT2_FLAG_JOURNAL_DEV_OK;
> > @@ -3078,6 +3092,52 @@ int handle_fslabel(int setlabel) {
> >       return 0;
> >  }
> >
> > +/*
> > + * Use EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID to get/set file system UUID.
> > + * Return:   0 on success
> > + *           1 on error
> > + *           -1 when the old method should be used
> > + */
> > +int handle_fsuuid(__u8 *uuid, bool get)
> > +{
> > +     errcode_t ret;
> > +     int mnt_flags, fd;
> > +     char label[FSLABEL_MAX];
> > +     int maxlen = FSLABEL_MAX - 1;
> > +     char mntpt[PATH_MAX + 1];
> > +     struct fsuuid *fsuuid = NULL;
> > +
> > +     fsuuid = malloc(sizeof(*fsuuid) + UUID_SIZE);
> > +     if (!fsuuid)
> > +             return -1;
> > +
> > +     memcpy(fsuuid->fsu_uuid, uuid, UUID_SIZE);
> > +     fsuuid->fsu_len = UUID_SIZE;
> > +     fsuuid->fsu_flags = 0;
> > +
> > +     ret = ext2fs_check_mount_point(device_name, &mnt_flags,
> > +                                       mntpt, sizeof(mntpt));
> > +     if (ret || !(mnt_flags & EXT2_MF_MOUNTED) ||
> > +             (!get && (mnt_flags & EXT2_MF_READONLY)) ||
> > +             !mntpt[0])
> > +             return -1;
> > +
> > +     fd = open(mntpt, O_RDONLY);
> > +     if (fd < 0)
> > +             return -1;
> > +
> > +     if (get) {
> > +             if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid))
> > +                     ret = -1;
> > +     } else {
> > +             if (ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid))
> > +                     ret = -1;
> > +     }
> > +     close(fd);
> > +     return ret;
>
> ret is probably zero here, right?

No, it could be -1 if the ioctls return an error.

>
> That said, I don't think it's a great idea to go mixing errcode_t and
> "the normal libc int return value" like that, since (a) that's type
> confusion and (b)
>
> return 0;
>
> gets the point across with less effort.

I'm also never returning 1 on error. I'll clean this up.

>
> > +}
> > +
> > +
> >  #ifndef BUILD_AS_LIB
> >  int main(int argc, char **argv)
> >  #else
> > @@ -3454,6 +3514,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
> >               dgrp_t i;
> >               char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
> >               __u8 old_uuid[UUID_SIZE];
> > +             uuid_t new_uuid;
> >
> >               if (ext2fs_has_feature_stable_inodes(fs->super)) {
> >                       fputs(_("Cannot change the UUID of this filesystem "
> > @@ -3507,25 +3568,34 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
> >                               set_csum = 1;
> >               }
> >
> > -             memcpy(old_uuid, sb->s_uuid, UUID_SIZE);
> > -             if ((strcasecmp(new_UUID, "null") == 0) ||
> > -                 (strcasecmp(new_UUID, "clear") == 0)) {
> > -                     uuid_clear(sb->s_uuid);
> > -             } else if (strcasecmp(new_UUID, "time") == 0) {
> > -                     uuid_generate_time(sb->s_uuid);
> > -             } else if (strcasecmp(new_UUID, "random") == 0) {
> > -                     uuid_generate(sb->s_uuid);
> > -             } else if (uuid_parse(new_UUID, sb->s_uuid)) {
> > +             rc = handle_fsuuid(old_uuid, true);
>
> Might also be helpful to readers to wrap handle_fsuuid with something
> containing "get" and "set" in the name explicitly, e.g.
>
> static inline int get_mounted_fsuuid(__u8 *old_uuid)
> {
>         return handle_fssuid(old_uuid, true);
> }

sgtm. I'll put it in the next version.


>
> I /think/ the rest looks plausible, but oof tune2fs is a bear to read.
> My apologies for all the random cruft I've contributed over the years
> (rewriting every inode on the filesystem to add checksums? seriously??)
>
> --D
>
> > +             if (rc == -1)
> > +                     memcpy(old_uuid, sb->s_uuid, UUID_SIZE);
> > +
> > +             if ((strcasecmp(requested_uuid, "null") == 0) ||
> > +                 (strcasecmp(requested_uuid, "clear") == 0)) {
> > +                     uuid_clear(new_uuid);
> > +             } else if (strcasecmp(requested_uuid, "time") == 0) {
> > +                     uuid_generate_time(new_uuid);
> > +             } else if (strcasecmp(requested_uuid, "random") == 0) {
> > +                     uuid_generate(new_uuid);
> > +             } else if (uuid_parse(requested_uuid, new_uuid)) {
> >                       com_err(program_name, 0, "%s",
> >                               _("Invalid UUID format\n"));
> >                       rc = 1;
> >                       goto closefs;
> >               }
> > -             ext2fs_init_csum_seed(fs);
> > -             if (set_csum) {
> > -                     for (i = 0; i < fs->group_desc_count; i++)
> > -                             ext2fs_group_desc_csum_set(fs, i);
> > -                     fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
> > +
> > +             rc = handle_fsuuid(new_uuid, false);
> > +             if (rc == -1) {
> > +                     memcpy(sb->s_uuid, new_uuid, UUID_SIZE);
> > +                     ext2fs_init_csum_seed(fs);
> > +                     if (set_csum) {
> > +                             for (i = 0; i < fs->group_desc_count; i++)
> > +                                     ext2fs_group_desc_csum_set(fs, i);
> > +                             fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
> > +                     }
> > +                     ext2fs_mark_super_dirty(fs);
> >               }
> >
> >               /* If this is a journal dev, we need to copy UUID into jsb */
> > @@ -3549,8 +3619,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
> >                       if ((rc = fs_update_journal_user(sb, old_uuid)))
> >                               goto closefs;
> >               }
> > -
> > -             ext2fs_mark_super_dirty(fs);
> >       }
> >
> >       if (I_flag) {
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
