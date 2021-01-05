Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3B2EB516
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbhAEV5h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 16:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAEV5h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 16:57:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8BC061793;
        Tue,  5 Jan 2021 13:56:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c7so2463993edv.6;
        Tue, 05 Jan 2021 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHZ5REDjpJle5lrFl8ZV+4dbNhskDGBx1n4v2d4wOt8=;
        b=vAlAGBCO028G9ebUwvBeJT+o7F2l7DQuT+/8DVshecRijRjJxIIGENpWzcTGS2oX3g
         /QDRvziufmtisnBbjazGJHhMvuq2rBjVBewSSfUV0NLwZrex7eqgr8t5oxN55GRzT7Od
         Ji2hF6y0oAECJBqcjX1LsAn9Rq3xdVx8nRl9v/Wqh0Vint3i8EnfzhrSUa5mXJXzZdJl
         K9rjioaQP0qkqaZQ50vtrTCV7ibSYDz2h4HkO44aSb9VBidplpw4rayhDUqNTQ0SUkj0
         sK6rBdY/PO8iQosMOqHwpwMVPDPSJuHTe+T0EJXV8vb9YEUxo+gMoq8zoABTVsxyQ0Xl
         WB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHZ5REDjpJle5lrFl8ZV+4dbNhskDGBx1n4v2d4wOt8=;
        b=MJNwbyLvND7jbLXBFEPP79QGR2y8lu1DmKAICMZLEr1IcaVsWbsVeup+qXWKRiJhCs
         XVcbrvHbRwVvkLyno57wgc2syakrCk4/JgqJjtMfQUm3mkBQKmLGylPe0fhz2rddz1fz
         EVku0OwvKW9fyGFeSuaMsjBGixxCyfgMQDJLy0bgsD8oJeKuzmENx7rUtf0ss37q0Nu3
         TteMSx6dXvmN1T14mDCbePY6QecOjp+QlcpZEj7id8Hn2ACGlh2f/rJk9YARyjQdAJGx
         1R+zewLSmwey23gA8EXD7KF8AK4Q7fDEM0EPt5Go1IbJlPKGxWwd/bVQIOqhQWZCMtUS
         k7Aw==
X-Gm-Message-State: AOAM531hwEm3zjf5np4HMNUOwoIsl8xLHBZH4LqeDtughdoev1hPBL/4
        vs5rEOZG6BY6NGLcZwZPLoR5unq2kyjR/SYhekc=
X-Google-Smtp-Source: ABdhPJwSgE91gOnwTmR6BAb6Bin3o2zlwCrqfeBR+xxpMkTHrBvlIByFFbhZm2F1QC5AGD2asd+xt4WwiIzn6sDCYFc=
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr1814665edb.65.1609883815286;
 Tue, 05 Jan 2021 13:56:55 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
 <20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
In-Reply-To: <20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 5 Jan 2021 13:56:43 -0800
Message-ID: <CAD+ocbwjVsiPNnp3RShN7eRDm5ZRDMwgk5uPO1at-KeX-osyqg@mail.gmail.com>
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

Looks good to me, thanks!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Wed, Dec 30, 2020 at 5:56 PM Daejun Park <daejun7.park@samsung.com> wrote:
>
> list_for_each + list_entry can be changed to list_for_each_entry
> It reduces number of variables and lines.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/ext4/fast_commit.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5b6bb3ef0f33..dc58471971db 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -915,13 +915,11 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
>         struct super_block *sb = (struct super_block *)(journal->j_private);
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
>         struct ext4_inode_info *ei;
> -       struct list_head *pos;
>         int ret = 0;
>
>         spin_lock(&sbi->s_fc_lock);
>         ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
> -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> -               ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +       list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>                 ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
>                 while (atomic_read(&ei->i_fc_updates)) {
>                         DEFINE_WAIT(wait);
> @@ -1099,8 +1097,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>                 goto out;
>         }
>
> -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> -               iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +       list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>                 inode = &iter->vfs_inode;
>                 if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
>                         continue;
> --
> 2.25.1
>
