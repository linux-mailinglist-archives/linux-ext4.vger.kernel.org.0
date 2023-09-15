Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFE7A1A3D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Sep 2023 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjIOJTk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Sep 2023 05:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOJTj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Sep 2023 05:19:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C78E
        for <linux-ext4@vger.kernel.org>; Fri, 15 Sep 2023 02:19:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-415259e4831so1716181cf.0
        for <linux-ext4@vger.kernel.org>; Fri, 15 Sep 2023 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694769573; x=1695374373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0u6w7TnnZtzlj2UdL/6Thh9sy2TPV27BvGULORWLhk=;
        b=NGq2ZF8HKVScQGkgiIH0IDdfgD8eYEU562Vmy2H9tCatXfDqEXojjDo5DLTQtvjGij
         VivMVJ3ci2v1sjLS8uXblas7MfNjL9do+2PuNQEPXm/nqKKnel/wlYJgPj3NgHtXxoeq
         7rwuDAsp1ZZCFiLsy6XvjZurVd0hUDOlE0NDi2QtI6Q80SsM1VdVBYsF9NzhqwRds+lN
         ci+OQ7C6fJVPjnjWOnn62bRByVwwHnIh2e87qesFts/dXp296EeiWFbImc/2bDVytfzA
         B0/213TdJJiay71StD29/yq74StAZuciEYIRWJfMRFbteQD/CZ1zuw6ACUN3YuqI9nmU
         xCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769573; x=1695374373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0u6w7TnnZtzlj2UdL/6Thh9sy2TPV27BvGULORWLhk=;
        b=XwKFz0iFVasSFmkNfkyAKJhKTbUBkqq6zfHoi92p0QbMZ03SPH0TNLTpxeeHr6tsl1
         iadoJePwEIXvRUn+zxCQoOxHFlU7pzaJqryyOD8w2N++byilcTfCGk+mkUAIp8n2RgfC
         U87drjYFa34kuBQaVZtrIIvThagSovnGjZ7R7LdyOOpZMnXGbl0RZ6Nx1R7986yDUnJT
         Q3GhBvEoWCbWCJ7TBiRfPws+zXIZqOzzG3nXcAHaAAW2B3c99T+QIDUs+Cb0MtVpcMXg
         ed7ei+qkK6XRFx1dx5zVoZzkdnH7Aoizp89OYcIabhKSZ/knLKYp0DavMYsa19KjppoY
         GKxg==
X-Gm-Message-State: AOJu0Yx6w3m7PRhmFhS0N1+RChx1VoKa34lURLiSUhn6Qa7OZbdOItfQ
        06CsugAzFe7ljq1CSCqIX0pQX3Lkb0Zj1cETwIm7GQ==
X-Google-Smtp-Source: AGHT+IFAfziPLAPy1mvLUC5WQ2NoS7Ksq7nOCYchBg5fUD8oh5hMf6w+McIzE1RNGnAic7+ba48Tz0DyBK42JNEYmPE=
X-Received: by 2002:ac8:7e88:0:b0:403:b188:36cd with SMTP id
 w8-20020ac87e88000000b00403b18836cdmr1125806qtj.4.1694769573356; Fri, 15 Sep
 2023 02:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230901092820.33757-1-changfengnan@bytedance.com>
In-Reply-To: <20230901092820.33757-1-changfengnan@bytedance.com>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Fri, 15 Sep 2023 17:19:22 +0800
Message-ID: <CAPFOzZvjz8g0j-xLAzqb+cTxwmbWz29m8cNneN7VOu7NvfAY+Q@mail.gmail.com>
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

ping

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
