Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620E2EFB88
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jan 2021 00:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbhAHXBb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 18:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHXBb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 18:01:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A26C061574;
        Fri,  8 Jan 2021 15:00:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ce23so16631047ejb.8;
        Fri, 08 Jan 2021 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SerZUw76E8PWitt2ZWjFV34tgoYsGOgZpHOEqNd4RkE=;
        b=Y81vC8t/Ak3PmS6ldjrzwIzm7N25NQavW/Uk9dB1jZslPuIVnRpfjn7tsqoYZbdXg3
         YAV9UGJnAvXUG44hkcY70U1G7Ps+lEKaFJjdWbE+DKG2oC0qrE0KHa8iwiVxwTJgi7OB
         /t/Bu0jr9jlQg0pGbvXJiRECOHmbo/QQ19xaVoAnqZjxK4rQ0GWbTZrJx0nT2RKQOv8p
         i6CJlhpOVEBuw6+u72JMIAlwIiG6QcEjRn+MpnIyA5mPwxGKHCkQM2AuZemTMbzxtunT
         fbBq2bGFjNzCao37zv06fvUaGygrwvrPGDz2XVWzoAqvu8+j4WBYs+tXVz0vvxxoZ9TX
         GUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SerZUw76E8PWitt2ZWjFV34tgoYsGOgZpHOEqNd4RkE=;
        b=ZJ3M9/P365JGEQUuz4hoiDM/l2vkzJgVelZbR8y3nlQ4oaywyPcIHXzUMW8CC4ZHfl
         gBio+5LwnESnfX27vE6xEltqV7uslaIico7lfkwY3or2Kq/B+udKzE7l0xKwBp1VIq2X
         Tlt1sv1uwxfH3BFFwDFPIcP8u76KKQVmHScBFzvFHeNZ5Pjk1wuFX939wmAYxze3Sans
         ulQc3PmkQtfd/1ZDBRJGt2mqnVdXbO/w4N4bkTpZ++nvcEOG+k9O7sRK5Lwx6hLxcG5M
         l/7m2xcz8xpxbrejTrtOc3+LYNC8qQh83FYfLHDopIWJuYpJtrttPElV07fntr+ewo7o
         zvLg==
X-Gm-Message-State: AOAM5327ms29XwLIUA6IRXCDJATUxZ792nYcW0lylnq6JednMKnNrTkH
        BZpS66YPmNZxHoMMHRiCefHXB41LxYe3zDxF8R4=
X-Google-Smtp-Source: ABdhPJx4v+ylMlI3/5ZoK0zQHXFrto3kwca4fxGNrR1asEXTReDwb0ggK+r8/cuzWm+pa5plScxd+aDFk9DiacPWGsU=
X-Received: by 2002:a17:906:b0c2:: with SMTP id bk2mr4149276ejb.223.1610146848129;
 Fri, 08 Jan 2021 15:00:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
 <20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5> <CAD+ocbwjVsiPNnp3RShN7eRDm5ZRDMwgk5uPO1at-KeX-osyqg@mail.gmail.com>
In-Reply-To: <CAD+ocbwjVsiPNnp3RShN7eRDm5ZRDMwgk5uPO1at-KeX-osyqg@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 8 Jan 2021 15:00:37 -0800
Message-ID: <CAD+ocbwuZ-y--YoC=1khtaQ1A2oYqyQtKGsvVHNvngzsuN0ByA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Change list_for_each to list_for_each_entry
To:     daejun7.park@samsung.com
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Daejun,

I was taking a look at this again, and just noticed one quick thing:

On Tue, Jan 5, 2021 at 1:56 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Looks good to me, thanks!
>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> On Wed, Dec 30, 2020 at 5:56 PM Daejun Park <daejun7.park@samsung.com> wrote:
> >
> > list_for_each + list_entry can be changed to list_for_each_entry
> > It reduces number of variables and lines.
> >
> > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > ---
> >  fs/ext4/fast_commit.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 5b6bb3ef0f33..dc58471971db 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -915,13 +915,11 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
> >         struct super_block *sb = (struct super_block *)(journal->j_private);
> >         struct ext4_sb_info *sbi = EXT4_SB(sb);
> >         struct ext4_inode_info *ei;
> > -       struct list_head *pos;
> >         int ret = 0;
> >
> >         spin_lock(&sbi->s_fc_lock);
> >         ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
> > -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> > -               ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> > +       list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> >                 ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
> >                 while (atomic_read(&ei->i_fc_updates)) {
> >                         DEFINE_WAIT(wait);
> > @@ -1099,8 +1097,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
> >                 goto out;
> >         }
> >
> > -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> > -               iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
Variable "pos" isn't used anymore after this patch. You removed it for
the ext4_fc_submit_inode_data_all() function, but missed removing it
in this function. That's throwing me a warning.

Thanks,
Harshad

> > +       list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> >                 inode = &iter->vfs_inode;
> >                 if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> >                         continue;
> > --
> > 2.25.1
> >
