Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1978F9FB
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjIAIcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjIAIc2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 04:32:28 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F319E
        for <linux-ext4@vger.kernel.org>; Fri,  1 Sep 2023 01:32:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76eecd12abbso36931585a.0
        for <linux-ext4@vger.kernel.org>; Fri, 01 Sep 2023 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693557121; x=1694161921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbpMyQ29dC1MA1RQHor5J9Oahj6ESL2AFyW72pjA8io=;
        b=PnNBOQQszYqZRx8HHeTcUA3EYTD3vB7cbGlsaxdPR1qeSBKh8TdZOqCWQsHKA7zAL6
         9AAkmcpwvGXqp3SYFZhLKHcAQoU27MTc2yhi21jC9nlP4oqBbFhL1S+lvp+e4f/JzEVt
         WpeKgc8P5s2SBvc9yBLUxdSMXVdI2+OyM1M9iDJLlpMKjF/Bc3BFbeKugi14gZsM0Hw9
         ZRegaqs0fxo7Qh9QuaqSaYQn8tQkoXKrjUPdJIEUTUovdNg4jwiz1E2NrzBEgJFN0AxU
         UtY36K12ZAPL8HldRsdWLo0nQ7OtzkcRcLApj1llzYkludhF+sZEpqMp3xhUz2477zu0
         omsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693557121; x=1694161921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbpMyQ29dC1MA1RQHor5J9Oahj6ESL2AFyW72pjA8io=;
        b=eFrs9DoJfuVBxMngaU1rNzUyFaDVPFKf0k48ITBDEjej1a0UGFdr0JKv6wXY4nugX3
         U2Lj5lVYIlzHugO97sFTmMi9MR6C0FDNwHs0OpYzO7txUIRoCUl7o5cUlhOycI/cIk76
         MxUcqBhXy5Sv+qgXfHXCva1NM48caeJE9xn8nU1pKA8wErtV2FhNIS7PcDWRt+ISTc+a
         96bIbmrcWT/Oh8/t4sH3NJ2WvgusrlFtPGa6MyoNHv7Ybw7rheDYjlNwTWQYIiTuiuFU
         4NQfnlAZjtwT7G8To7TF4iWJyx0ZEp0IWw56Tw1ys6tet5VELU0nmUB6cAzqWBJMIBbk
         AhbA==
X-Gm-Message-State: AOJu0YxCQy7SzbIEb724/ooSkvoHnY/LCSBI/8IeFFNc0u3NtlsA+ZJV
        BUXOG6YtyDJHS4j7/4L3fnYKCi3Fy+4gEcn5fV5ymaNnV+y+BT+powo=
X-Google-Smtp-Source: AGHT+IEEIq8V1YmoVjUX3Jseki7r7qnfdoeD8hwpJ1rXOAgQypphxq1AvdAm41NZKWvKsDlg16B8bVErE0OQrMers7o=
X-Received: by 2002:a05:622a:1a9b:b0:410:88c6:cf22 with SMTP id
 s27-20020a05622a1a9b00b0041088c6cf22mr2082193qtc.3.1693557121084; Fri, 01 Sep
 2023 01:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230824062129.36346-1-changfengnan@bytedance.com>
In-Reply-To: <20230824062129.36346-1-changfengnan@bytedance.com>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Fri, 1 Sep 2023 16:31:50 +0800
Message-ID: <CAPFOzZtbst7XuaEWe=H8G2tpPDBDHbFuR3PR064pMbyDEzkyJg@mail.gmail.com>
Subject: Re: [PATCH v5] ext4: improve trim efficiency
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fengnan Chang <changfengnan@bytedance.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=88=
24=E6=97=A5=E5=91=A8=E5=9B=9B 14:21=E5=86=99=E9=81=93=EF=BC=9A
>
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> In my test:
> 1. create 10 normal files, each file size is 10G.
> 2. deallocate file, punch a 16k holes every 32k.
> 3. trim all fs.
>
> the time of fstrim fs reduce from 6.7s to 1.3s.
>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>  fs/ext4/mballoc.c | 95 +++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1e4c667812a9..86857b22c4bc 100644
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
In old way, when the device not support discard, it still continue the loop=
.
I modified this logic and let it break the loop in this patch, but it may c=
ause
free_count =3D 0, and cause a wan log in mb_free_blocks, I'll fix this in t=
he
next version.

Thanks.

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
> +       if (noalloc)
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
