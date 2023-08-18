Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC37D780634
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjHRHPS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358095AbjHRHPL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 03:15:11 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7730D6
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 00:14:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d34c010d6so5335585a.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692342885; x=1692947685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97w6PmCpXMu5QBKjRi2llw3MfoCmM7xB6BoKBXyhagw=;
        b=KNmjMgupOML3+sbKcozxhhSifTk3JbQEFJcJE3Ex1vq1b/HRfPWmMx56dJpIsT+x9p
         sgw5qkX7j205iqX94RjP2gCmiK9RY98An6Io8cUaBO2RHylNsQpLHZBFzmO1lNJLZRtf
         3n3IhPawT6nFYR3Eily8Ab7AuXNwinsvtWnbe026w6wsUPPIPkdPtUpmHdFIJ1R6bf7x
         UqRIBhwNZSOsdGQojs6BZXk7wOIPMN68Y3xL3zLHvD7s/didKrjQHHX/BmvU7dzg5kiM
         kis9S8KNQHfrfHDKnJH/qHNXC4EXnUZMBN1cMh8p6PI9Yg98XnQtOS4HHLjkFtZ/b3de
         LgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342885; x=1692947685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97w6PmCpXMu5QBKjRi2llw3MfoCmM7xB6BoKBXyhagw=;
        b=Ka+IhWhrQkNjgggPp7SOf5zHrRQiG+vlqhtd0gngB3oWNMtGDUJ8ds8piccNpbC7Ur
         Gh/n2qm+wBkOp7TCmDWP+GfchDqg9iog89x0nTIZgX/izir0hwf77z0obosSPgAgCVpY
         4RwDgt6jCUph5VqpsE8gWNRS6d9/HVMIUV1uWxsDUAxBPAdJMr3gCFKM0hai72DQYMPG
         73R7XyZdmweThF9cC0CsZV4Vvn96yIgj+L6UuQhDTH7PFWmngBxx3yoR6oGLneH5+pyl
         8EUaWjx4kEge0fOPSKssxh7OG7QFFuI97uC76VHvU5FHCVuXUviY+i+luSjw3FT2KWGx
         5I0w==
X-Gm-Message-State: AOJu0YwU0M/8njFauXn+Bvr0/KZeK5i2gThYmo2y3pA0LDqeLc7ZiREC
        cfpRNxIB9Wez3W+VvBgXfbEBWa8J+CIcl1jQeFU4S2WIBYP27rmMq8g=
X-Google-Smtp-Source: AGHT+IE3WEdgECX5yL75uMRwX5mXwB8rwybKDq2/ftvyrcnvn73E/ELw7n2imkf2nbYfGAfB5gJGhBYvr/H8u5OAujk=
X-Received: by 2002:a05:622a:1998:b0:40c:8ba5:33e0 with SMTP id
 u24-20020a05622a199800b0040c8ba533e0mr2105235qtc.3.1692342885155; Fri, 18 Aug
 2023 00:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230725121848.26865-1-changfengnan@bytedance.com> <20230818034330.GE3464136@mit.edu>
In-Reply-To: <20230818034330.GE3464136@mit.edu>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Fri, 18 Aug 2023 15:14:34 +0800
Message-ID: <CAPFOzZvwvSioyiCW8K7sDpzB7Grq==5-9i-wODGKw0E_4DFaPQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] ext4: improve trim efficiency
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, guoqing.jiang@linux.dev,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> =E4=BA=8E2023=E5=B9=B48=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 11:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 25, 2023 at 08:18:48PM +0800, Fengnan Chang wrote:
> > In commit a015434480dc("ext4: send parallel discards on commit
> > completions"), issue all discard commands in parallel make all
> > bios could merged into one request, so lowlevel drive can issue
> > multi segments in one time which is more efficiency, but commit
> > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > seems broke this way, let's fix it.
>
> Thanks for the patch.  A few things that I'd like to see changed.
>
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index a2475b8c9fb5..b75ca1df0d30 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struc=
t super_block *sb,
> >   * be called with under the group lock.
> >   */
> >  static int ext4_trim_extent(struct super_block *sb,
> > -             int start, int count, struct ext4_buddy *e4b)
> > +             int start, int count, bool noalloc, struct ext4_buddy *e4=
b,
> > +             struct bio **biop, struct ext4_free_data **entryp)
>
> The function ext4_trim_extent() is used in one place, by
> ext4_try_to_trim_range().  So instead of adding the new parameters
> noalloc and extryp...
>
> > @@ -6812,9 +6813,16 @@ __acquires(bitlock)
> >        */
> >       mb_mark_used(e4b, &ex);
> >       ext4_unlock_group(sb, group);
> > -     ret =3D ext4_issue_discard(sb, group, start, count, NULL);
> > +     ret =3D ext4_issue_discard(sb, group, start, count, biop);
> > +     if (!ret && !noalloc) {
> > +             struct ext4_free_data *entry =3D kmem_cache_alloc(ext4_fr=
ee_data_cachep,
> > +                             GFP_NOFS|__GFP_NOFAIL);
> > +             entry->efd_start_cluster =3D start;
> > +             entry->efd_count =3D count;
> > +             *entryp  =3D entry;
> > +     }
> > +
>
> ... I think it might be better to move the allocation and
> initialization the ext4_free_data structure to ext4_trim_extent()'s
> caller.
If we move the allocation and initialization the ext4_free_data
structure to ext4_try_to_trim_range, we need move
ext4_lock_group too, because we can't do alloc memory when
hold lock in ioctl context.
How about just remove ext4_trim_extent, and do all work in
ext4_try_to_trim_range?  it will be easier to read.

>
> In the current patch, we are adding the entry to the linked list, and
> we actually *use* the linked list in ext4_try_to_trim_range().  By
> move the code which allocates the entry to the same place, we
> eliminate some extra variables added to the ext4_trim_extent()
> function, and it makes the code easier to read.
>
> In fact, given that ext4_trim_extent() is used only once by its
> caller, we could just inline the code (which isn't actually all that
> much) into ext4_Try_to_trim_range().  That would eliminate the need
> for the __acquires(bitlock) and __release(bitlock) sparse annotations,
> as well as the "assert_spin_locked()".
>
> That also keeps the mb_mark_used() and mb_free_blocks() calls in the
> same function, which again improves code readability.
>
> Thanks,
>
>                                                 - Ted
