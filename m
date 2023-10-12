Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10E07C6D86
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347304AbjJLL7d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378379AbjJLL7V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 07:59:21 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F93C31
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 04:58:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c623d55b98so136401a34.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697111880; x=1697716680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyGUJUaUxtBI/FpNzwBLZSlbUGFBoOGV46mhMpMSmpc=;
        b=BK4SmIxKn/q/hzT3k4LvcVp/OTDw/8E7R7eA8Ot2onC7OemqY9o9Z74kRKy1ZrciDi
         cC+LGBQ+Ye6LY1ulR15CtEwWPBH5iUgMpc2OsHZ7ygXagNVj9LLJMGJVsNchazIMOe8E
         UL+bLw1qbX2xJwPKw+Qc6BKoEz59TGiSLor43DvghAPG9j9xIgHcQv5bejrssRm5C5vu
         OnK3OXpjw1vcUNUQjxWKGhP83AerubMet4VJuRm0IGgMGBXFSp7htuzoJXGIo+pBdOJj
         qHhclXw48IHHoHHRg9aWWCdyerz5jtkUVFxprlJCtpqpZF/d2bRNuNo4+MuEBBuIRgLH
         Oqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111880; x=1697716680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyGUJUaUxtBI/FpNzwBLZSlbUGFBoOGV46mhMpMSmpc=;
        b=qjo92AMxsvw0gF/n7IzEcDnO+kXxIaor2J5uxQ1lU7t6Q8c5ak9NW6up5lMdoeMM8y
         5dfsNmoYzkGz2l2m6qI1VOtuYW7nJmTdeIMrRkl+Gyhd7NViupAQMAXYkC8+01liFPjI
         rD3ItFUh9Z4pc9eqolwlahNY3Fho3LG6L0R4GrHcBHWnmBm3cVc+LRM5H6s3uoLCrPic
         MHN7rZGuCqsCSmyAcqHqSb5x5xhBpVOM7Z+DUWzuNEPsxSL8HZZG3k9GygKXxAiwssNZ
         ljfSfGvoxLqDTaZA19iFOZIxRlgm4EtitmyYwbXcz9MoOzDgzOKBa866NiGwhszwZW1I
         wIfA==
X-Gm-Message-State: AOJu0YwFDNcl9EeB+SbaPOU487yBsC82hz/f9FnyFY/5xyO7I2cxb3Wq
        oLP+y5nxwX8BLjCT+a9mpis/lXIJr8FSdLvBVZt9d/pe6UIheypvg+Y=
X-Google-Smtp-Source: AGHT+IHNmwLh6/ILqp9gpKAnPgGSXaM8/gcnLdgpyXEeltcy5/H+9AM0RYK9eDjPeteh/wp1K7e3mLcvuJ7PGaZ6rtw=
X-Received: by 2002:a05:6808:6408:b0:3af:6453:2d83 with SMTP id
 fg8-20020a056808640800b003af64532d83mr22400513oib.2.1697111879707; Thu, 12
 Oct 2023 04:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230901092820.33757-1-changfengnan@bytedance.com>
In-Reply-To: <20230901092820.33757-1-changfengnan@bytedance.com>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Thu, 12 Oct 2023 19:57:48 +0800
Message-ID: <CAPFOzZvxbg-tkRLF_Un=9qr-OWtNKbinj9MhOXFDRzGUDgEuJw@mail.gmail.com>
Subject: Re: [PATCH v6] ext4: improve trim efficiency
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted:
    any new comments ?

Fengnan Chang <changfengnan@bytedance.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=88=
1=E6=97=A5=E5=91=A8=E4=BA=94 17:28=E5=86=99=E9=81=93=EF=BC=9A
>
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
>
> In my test:
> 1. create 10 normal files, each file size is 10G.
> 2. deallocate file, punch a 16k holes every 32k.
> 3. trim all fs.
> the time of fstrim fs reduce from 6.7s to 1.3s.
>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>  fs/ext4/mballoc.c | 95 +++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1e4c667812a9..9fc69a92c496 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6874,70 +6874,61 @@ int ext4_group_add_blocks(handle_t *handle, struc=
t super_block *sb,
>         return err;
>  }
>
> -/**
> - * ext4_trim_extent -- function to TRIM one single free extent in the gr=
oup
> - * @sb:                super block for the file system
> - * @start:     starting block of the free extent in the alloc. group
> - * @count:     number of blocks to TRIM
> - * @e4b:       ext4 buddy for the group
> - *
> - * Trim "count" blocks starting at "start" in the "group". To assure tha=
t no
> - * one will allocate those blocks, mark it as used in buddy bitmap. This=
 must
> - * be called with under the group lock.
> - */
> -static int ext4_trim_extent(struct super_block *sb,
> -               int start, int count, struct ext4_buddy *e4b)
> -__releases(bitlock)
> -__acquires(bitlock)
> -{
> -       struct ext4_free_extent ex;
> -       ext4_group_t group =3D e4b->bd_group;
> -       int ret =3D 0;
> -
> -       trace_ext4_trim_extent(sb, group, start, count);
> -
> -       assert_spin_locked(ext4_group_lock_ptr(sb, group));
> -
> -       ex.fe_start =3D start;
> -       ex.fe_group =3D group;
> -       ex.fe_len =3D count;
> -
> -       /*
> -        * Mark blocks used, so no one can reuse them while
> -        * being trimmed.
> -        */
> -       mb_mark_used(e4b, &ex);
> -       ext4_unlock_group(sb, group);
> -       ret =3D ext4_issue_discard(sb, group, start, count, NULL);
> -       ext4_lock_group(sb, group);
> -       mb_free_blocks(NULL, e4b, start, ex.fe_len);
> -       return ret;
> -}
> -
>  static int ext4_try_to_trim_range(struct super_block *sb,
>                 struct ext4_buddy *e4b, ext4_grpblk_t start,
>                 ext4_grpblk_t max, ext4_grpblk_t minblocks)
>  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  {
> -       ext4_grpblk_t next, count, free_count;
> +       ext4_grpblk_t next, count, free_count, bak;
>         void *bitmap;
> +       struct ext4_free_data *entry =3D NULL, *fd, *nfd;
> +       struct list_head discard_data_list;
> +       struct bio *discard_bio =3D NULL;
> +       struct blk_plug plug;
> +       ext4_group_t group =3D e4b->bd_group;
> +       struct ext4_free_extent ex;
> +       bool noalloc =3D false;
> +       int ret =3D 0;
> +
> +       INIT_LIST_HEAD(&discard_data_list);
>
>         bitmap =3D e4b->bd_bitmap;
>         start =3D max(e4b->bd_info->bb_first_free, start);
>         count =3D 0;
>         free_count =3D 0;
>
> +       blk_start_plug(&plug);
>         while (start <=3D max) {
>                 start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
>                 if (start > max)
>                         break;
> +               bak =3D start;
>                 next =3D mb_find_next_bit(bitmap, max + 1, start);
> -
>                 if ((next - start) >=3D minblocks) {
> -                       int ret =3D ext4_trim_extent(sb, start, next - st=
art, e4b);
> +                       /* when only one segment, there is no need to all=
oc entry */
> +                       noalloc =3D (free_count =3D=3D 0) && (next >=3D m=
ax);
>
> -                       if (ret && ret !=3D -EOPNOTSUPP)
> +                       trace_ext4_trim_extent(sb, group, start, next - s=
tart);
> +                       ex.fe_start =3D start;
> +                       ex.fe_group =3D group;
> +                       ex.fe_len =3D next - start;
> +                       /*
> +                        * Mark blocks used, so no one can reuse them whi=
le
> +                        * being trimmed.
> +                        */
> +                       mb_mark_used(e4b, &ex);
> +                       ext4_unlock_group(sb, group);
> +                       ret =3D ext4_issue_discard(sb, group, start, next=
 - start, &discard_bio);
> +                       if (!noalloc) {
> +                               entry =3D kmem_cache_alloc(ext4_free_data=
_cachep,
> +                                                       GFP_NOFS|__GFP_NO=
FAIL);
> +                               entry->efd_start_cluster =3D start;
> +                               entry->efd_count =3D next - start;
> +                               list_add_tail(&entry->efd_list, &discard_=
data_list);
> +                       }
> +                       ext4_lock_group(sb, group);
> +                       if (ret < 0)
>                                 break;
>                         count +=3D next - start;
>                 }
> @@ -6959,6 +6950,22 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>                         break;
>         }
>
> +       if (discard_bio) {
> +               ext4_unlock_group(sb, e4b->bd_group);
> +               submit_bio_wait(discard_bio);
> +               bio_put(discard_bio);
> +               ext4_lock_group(sb, e4b->bd_group);
> +       }
> +       blk_finish_plug(&plug);
> +
> +       if (noalloc && free_count)
> +               mb_free_blocks(NULL, e4b, bak, free_count);
> +
> +       list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
> +               mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_=
count);
> +               kmem_cache_free(ext4_free_data_cachep, fd);
> +       }
> +
>         return count;
>  }
>
> --
> 2.20.1
>
