Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF92999AA
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Oct 2020 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394424AbgJZW24 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 18:28:56 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35119 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394413AbgJZW24 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Oct 2020 18:28:56 -0400
Received: by mail-ej1-f65.google.com with SMTP id p5so16181908ejj.2;
        Mon, 26 Oct 2020 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5TvNsaVlP/v1waQo2fJokFjg82jq6VV+7J94XPAoyE=;
        b=WzDyNwYol8TFmAY+cXVbW1Sx8M+rtCj2/MQaZtq/gX20miib2yDtzcZXIsXy5v2qDF
         ELoLTBMIsWlNg5Je+Xnk1nNEgb2x20eA1mQzDGmSbzojjfwOY0Zlldg1nfG25CvD4Zhz
         P4127mdv4gu29bClbLg5W51lnc1LJtoSLe06Xa4ettFQqEwuEKNw/NUhaAwpEYyl9Con
         dh5VRa9asNBlMtBwBBkPs2uOOD+Ch6uMwmL26I/PbPKpu9VeVfHs5kAkHZzGnhi9cge5
         oHCFiSwBI/wk/R2WXNB/3DLaOYXQCV5OZCguyyqiwjZBSRBlpDYehZ/1w4JxhGUvFrdV
         wDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5TvNsaVlP/v1waQo2fJokFjg82jq6VV+7J94XPAoyE=;
        b=Xj4hG7CvrNAtwuDwi/Vp6VwzG4CjExqZg1ivSeX8e95QjlvYNONJzyosJBbfPkfd+2
         jhETAPNYvqTeWLc4PS4FVu8PmEMW2QGGmTNYmsNcWN1yCjtUJx3IIKTdTRiTYhDMXnWe
         oEND4zMn9JLuP0ZGpz3f9EQI08A1qaYrvza/NVi6oHu2tBX0sWhvWnZpP6F7YnROsiWl
         /m2pF3fTInb4D9uu/qQtW0ekkKywx7SwWy99ACDabcKld90ZiobWgiVpHXp7LPAePeAr
         UNIAINScC3f521gScKDuOdoJVy6Z5N0i0znbIB1IDac9vYAVA1BufhGtAIRqYVX/06Rm
         B6CQ==
X-Gm-Message-State: AOAM531pJWBxwKbRFM+WiD1vdzoVqsYyRcOUel6+2eDvrnBJFmV408xW
        Ut0JjBblfI7PnVTrbMSsFgcEFJr02Yic+WGeciytoUfKEEI=
X-Google-Smtp-Source: ABdhPJwU+t4RWyZuNxhOsEjApL1SJaJADNHEQda/2rxM+wohJn5ppqqhvuqZF3QlV/4qesSn2R68LyzGIJWRdeXGQxY=
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr17345666ejm.223.1603751332639;
 Mon, 26 Oct 2020 15:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201024140115.GA35973@xps-13-7390>
In-Reply-To: <20201024140115.GA35973@xps-13-7390>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 26 Oct 2020 15:28:41 -0700
Message-ID: <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
Subject: Re: [PATCH] ext4: properly check for dirty state in ext4_inode_datasync_dirty()
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Andrea for catching and sending out a fix for this.

On Sat, Oct 24, 2020 at 7:01 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> ext4_inode_datasync_dirty() needs to return 'true' if the inode is
> dirty, 'false' otherwise, but the logic seems to be incorrectly changed
> by commit aa75f4d3daae ("ext4: main fast-commit commit path").
>
> This introduces a problem with swap files that are always failing to be
> activated, showing this error in dmesg:
>
>  [   34.406479] swapon: file is not committed
>
> Simple test case to reproduce the problem:
>
>   # fallocate -l 8G swapfile
>   # chmod 0600 swapfile
>   # mkswap swapfile
>   # swapon swapfile
>
> Fix the logic to return the proper state of the inode.
>
> Link: https://lore.kernel.org/lkml/20201024131333.GA32124@xps-13-7390
> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  fs/ext4/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 03c2253005f0..a890a17ab7e1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3308,8 +3308,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>         if (journal) {
>                 if (jbd2_transaction_committed(journal,
>                                         EXT4_I(inode)->i_datasync_tid))
> -                       return true;
> -               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) >=
> +                       return false;
> +               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
>                         EXT4_I(inode)->i_fc_committed_subtid;
In addition, the above condition should only be checked if fast
commits are enabled. So, in effect this overall condition will look
like this:

if (journal) {
    if (jbd2_transaction_committed(journal, EXT4_I(inode)->i_datasync_tid))
        return false;
    if (test_opt2(sb, JOURNAL_FAST_COMMIT))
        return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
EXT4_I(inode)->i_fc_committed_subtid;
    return true;
}

Thanks,
Harshad

>         }
>
> --
> 2.27.0
>
