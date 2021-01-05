Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41D2EB543
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 23:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhAEWLF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 17:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbhAEWLF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 17:11:05 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA4C061574;
        Tue,  5 Jan 2021 14:10:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jx16so2492991ejb.10;
        Tue, 05 Jan 2021 14:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46Sdw8vdtEjJ6/+ChVrH3OLu9DIh3HiQWxhcNj27i24=;
        b=T7wMZo+anDWxGN0/m02t3B77fKqhZ29Q+VQkW4BCUbavkU0zbjEt/OZFqPxZboK45z
         iG1gvai3jRVQIN5lY5dRU2XfUP02eJR4W8tONnP2gUMe+jJsElVxE4yF8DnTHWgBWb1L
         aDSf9L+qC1dAJnDImSnIeE/RdDpfMHNqZh6ZAo5ksZFF8pmplgFfQjqelHYwCNzjU9h3
         USeN5ojDVqSEyXFq9MlPfFhEjNGLeg9VZLLZ2QNxZcNBIwzEv0a9VACJSqDiYuvIJqn9
         WBAnLAs6ykFAdOJwuZWjL4GY6Ar/8+C+Ttc8R0GgDTqLEl8lkDGbJ2t6K4J8y9H99w5X
         MxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46Sdw8vdtEjJ6/+ChVrH3OLu9DIh3HiQWxhcNj27i24=;
        b=AYNLJroUjSWcFxLCqxw1vayPYMdj+bHjaGENtVQbyCf7JhbcB/Zfz9N/7NhRfQrUSL
         HndPLk8bb+991J84ePblbgZn4daIo5NiJ9InoCfmwLR4PQeUraTzI93n6l45kA6uKb40
         V8m9HZN1kpuTkCBb3UsWJfir0aFxReyN9U9syqJaTvRrU0726oJEdOiz1vViYGTAvfvb
         3HPM+Lrc6dka5vqo4PxvLny1LBH2S2oXy9GQDhlkes+Wb136ZgT5riYQN3M6Mp/lGW+j
         M0M1AE8zCjP2tG1okC9fyPllNQ89rMdIdaJusS8TOopRWY2YrL1RSH269DbxDxclpeZo
         YRWA==
X-Gm-Message-State: AOAM533P8STELxBautG/LterPdvbK9GeSdm3Z9LK+SaoliaWMwwx+9YB
        38wn7oWIYX0JgFYf867ecEv/3TbbIOKdqycJmchh014n8dk=
X-Google-Smtp-Source: ABdhPJx1qUUEvPztnZcPzOLPbkdtZs/baDAEczgRiY/uFC6051ND0c7NtZmDNM200l9N9nVvG3M3BQSMo7pNmo98qhU=
X-Received: by 2002:a17:906:4a47:: with SMTP id a7mr968382ejv.345.1609884623519;
 Tue, 05 Jan 2021 14:10:23 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a@epcms2p6>
 <20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a@epcms2p6>
In-Reply-To: <20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a@epcms2p6>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 5 Jan 2021 14:10:12 -0800
Message-ID: <CAD+ocbyDV6CV2tF7kqJyyOKgrnPGLHyM4PA7w9UX3F+qXahmaw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix wrong list_splice in ext4_fc_cleanup
To:     daejun7.park@samsung.com
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, that's a good catch!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Wed, Dec 30, 2020 at 1:53 AM Daejun Park <daejun7.park@samsung.com> wrote:
>
> After full/fast commit, entries in staging queue are promoted to main
> queue. In ext4_fs_cleanup function, it splice to staging queue to
> staging queue.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/ext4/fast_commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4fcc21c25e79..5b6bb3ef0f33 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1268,7 +1268,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
>         list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
>                                 &sbi->s_fc_dentry_q[FC_Q_MAIN]);
>         list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
> -                               &sbi->s_fc_q[FC_Q_STAGING]);
> +                               &sbi->s_fc_q[FC_Q_MAIN]);
>
>         ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
>         ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> --
> 2.25.1
>
