Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770EE1B1C5C
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDUDCQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 23:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgDUDCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 23:02:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46175C061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 20:02:16 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t199so10843484oif.7
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HMy0dCH6YyQhrin4Dzk1pRAf6VOOeshobzC6QtTdbtw=;
        b=TFfGXmiJK/UvExVJm7sK7PvdbvX6yqWBuXEH/CWArzig4+LuMusBDub2emoqVAG64/
         HxGl5G7TcG31i2Kgg40o75SdTfyKbOyDYuQ4yTke56ahiRIJcof84jWWqzrr29ePDSFW
         fTSDUwCpiFbO6+U7tzGDm3SFIeEsM4pHDjje8mwQdyhDHm3MXPY4vMFxpHE7UMZeXvJA
         oph7wjVI9M150lHMKa5l71AB8DEpkxbzA102EtsFKZyoj4b5WhlCLqZoeea5ka7PlQmc
         jKEfDsKQC/c9tn2xbdC2/y1VSyzJ7QBSGC17g463hvq0xuTVX/XsFrd1bnTFcIXsrfgX
         pdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HMy0dCH6YyQhrin4Dzk1pRAf6VOOeshobzC6QtTdbtw=;
        b=NH2W7B0O9RxRpGG+2lwxBwdj0gsMNLgOKvbD7h1TBuba++JHcybIPZOXctO5hyUs7h
         pL3FoT1tqC8tnKJtZLiVKD1wGmhtXDpKIKvrNr2nNhl9EwwwWNhRLnmKItYzgHf8OVNV
         JtMGcg+eH8vU9NTnJfDY5tKs0fvRAx9B695UlB8gQbA6Dlt4wfUEO8rGj75V/ZDzy+dx
         YO9lB0ytsKEQeVLLXXgzdGMQ166plxZYDKmrPlWn7y0siJpNBDkVFMe9hv9vvPGeKcIk
         APtGBoqaDrrrKlSbQAr6o1JzZ0ipIxjC54dHhh7+i4oc9Kx3i41uHzawAc35+JrBHRUp
         8ARg==
X-Gm-Message-State: AGi0PuYCn7JmagwYAvIcANREXCRsjfaPX5UeH1AKiXUxTKGHyxqcpbH0
        zmycyx6F2bNjRUzvhg4yPvPcS1rAgGlrhRudovTUG0uE
X-Google-Smtp-Source: APiQypLb//fsc9JhGXdPZmJ/U6X8iWBVB3XwP/ya0tj4vN2wcIi5a6p5O9zUr3morESM6g0e2S20mOBmAtJBfuKhD2M=
X-Received: by 2002:aca:4155:: with SMTP id o82mr1855754oia.16.1587438135033;
 Mon, 20 Apr 2020 20:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
In-Reply-To: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 20 Apr 2020 20:02:03 -0700
Message-ID: <CAD+ocbzDoOkvtM4KKhmhv9Tke=D9B8q_PfGezfd4H+H_auDJ5w@mail.gmail.com>
Subject: Re: [PATCH] ext4: don't ignore return values from ext4_ext_dirty()
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 20, 2020 at 7:40 PM Harshad Shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Don't ignore return values from ext4_ext_dirty, since the errors
> indicate valid failures below Ext4.  In all of the other instances of
> ext4_ext_dirty calls, the error return value is handled in some
> way. This patch makes those remaining couple of places to handle
> ext4_ext_dirty errors as well. In the longer run, we probably should
> make sure that errors from other mark_dirty routines are handled as
> well.
>
> Ran gce-xfstests smoke tests and verified that there were no
> regressions.
>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/ext4/extents.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a0..f62f55a16fe3 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3244,8 +3244,7 @@ static int ext4_split_extent_at(handle_t *handle,
>
>  fix_extent_len:
>         ex->ee_len = orig_ex.ee_len;
> -       ext4_ext_dirty(handle, inode, path + path->p_depth);
> -       return err;
> +       return ext4_ext_dirty(handle, inode, path + path->p_depth);
>  }

I realized that this is not correct. That's because fix_extent_len is
an error path and this change would make ext4_split_extent_at() return
success if ext4_ext_dirty succeeds in this path. I think instead I
should be adding a comment here explaining why we are not handling
ext4_ext_dirty(). Sorry for that.

- Harshad

>
>  /*
> @@ -3503,7 +3502,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>         }
>         if (allocated) {
>                 /* Mark the block containing both extents as dirty */
> -               ext4_ext_dirty(handle, inode, path + depth);
> +               err = ext4_ext_dirty(handle, inode, path + depth);
>
>                 /* Update path to point to the right extent */
>                 path[depth].p_ext = abut_ex;
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
