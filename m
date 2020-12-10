Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9926B2D5341
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 06:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgLJFZa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 00:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLJFZa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 00:25:30 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA91C0613CF
        for <linux-ext4@vger.kernel.org>; Wed,  9 Dec 2020 21:24:50 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so4138061edt.9
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 21:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDVAs55dk7p3Mkah113BT0lKKQOSA1y70iTGP96/G6A=;
        b=pz9VElvnyCYTFa2Ka7K6B0YEGxAQ7lg2zsLmSqkHKRX1DP+VkFeL1cQ65/T+gCKlBi
         UflFZyjrusUEiFoodEQFgM31RIld9iH2Qa29f5c5Ga7CcNBlBlc4GMuCZN085Wy2NpWq
         kUe6NTHzZxCy+44yWckvcEZbYATbHHTDtdSnHBv/vQtDhLShxeOICsm15WFAe3HZTpOk
         nU7EwNw7lv1QcJy6NOwM3Egvu9WQm6YxSz2Yef668JNWCajd3hAimdxVNMpA3oudkEUA
         BaoRtOfMgtuO8Fwa3G1eTYuDdbpBnXlOp3yWrfMtZY0oj1DFj0Z0QX21KERm4uWl/mcJ
         wPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDVAs55dk7p3Mkah113BT0lKKQOSA1y70iTGP96/G6A=;
        b=L5ShL82G2QtSA2R9fLnzk9HzKidcYa9TMMDZxjxinXO8ES1ae2MNtKs/jE+NUOyRWF
         NndLB+yC8ch6xceLFlwjPiIgrC2qykV1l3SlUbdPS4GaJ3pQLjk5796nVdNxS6nrbaeg
         AN0myOxMybXEGzOhxzXcQYt6n4f3/UqUI2aM33Cey6Id0VAWrQ/13u0hEchgH+hYkSaj
         cXhuAny0SFzRu0bZaIFg8+Xl81FH8VY/U12qlDD13TsQb+6/q1psVhho4Rvl6PtMQz9N
         o4IzGY440CiDBNVRrhF6nKbekVrdmA2I7Mlmk0JJOxe2yfqKhbbZlWEGVWlk2cX9EWAj
         zd7Q==
X-Gm-Message-State: AOAM532iyk3U2NivyJ9rezhG4tNSzo+WBwxd329nDi4broJ/MTbW3CBX
        iCkhtnaGkBTrgdOnT6lhOGy/W3f1hZHtUHGelF6TGDzXkr6MLQ==
X-Google-Smtp-Source: ABdhPJxYxvx34UtikFAGuP1XNVQ38shCNoj5UuPrZQ1yT4V1FTiXi7jl4ci84GX9aqDQqjfPMoweDDyUNNnmMdq+AL0=
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr781270edt.213.1607577888748;
 Wed, 09 Dec 2020 21:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-6-harshadshirwadkar@gmail.com> <20201202183327.GI390058@mit.edu>
In-Reply-To: <20201202183327.GI390058@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 9 Dec 2020 21:24:37 -0800
Message-ID: <CAD+ocbzhhgpdVdMU6TDMAppjuJkD3P_Tnq=5rdaQpr7+Q1DNDw@mail.gmail.com>
Subject: Re: [PATCH 05/15] mke2fs, tune2fs: update man page with fast commit info
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 2, 2020 at 10:33 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Nov 20, 2020 at 11:15:56AM -0800, Harshad Shirwadkar wrote:
> > This patch adds information about fast commit feature in mke2fs and
> > tune2fs man pages.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> So this is a bit more of a personal preference thing, but I like to
> keep the libext2fs changes from the changes to the userspace
> applications, and then combine the changes to the userspace progams
> (mke2fs and tune2fs in this case) with the man page updates.
>
> So you might want to consider moving the mke2fs and tune2fs changes
> from the previous patch and then combining them with this patch, and
> adjusting the commit message appropriately?
Sounds good, will do that.
>
> > diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> > index e6bfc6d6..2833b408 100644
> > --- a/misc/mke2fs.8.in
> > +++ b/misc/mke2fs.8.in
> > @@ -521,6 +521,27 @@ The size of the journal must be at least 1024 filesystem blocks
> >  and may be no more than 10,240,000 filesystem blocks or half the total
> >  file system size (whichever is smaller)
> >  .TP
> > +.BI fast_commit_size= fast-commit-size
> > +Create an additional fast commit journal area of size
> > +.I fast-commit-size
> > +kilobytes.
> > +This option is only valid if
> > +.B fast_commit
> > +feature is enabled
> > +on the file system. If this option is not specified and if
> > +.B fast_commit
> > +feature is turned on, fast commit area size defaults to
> > +.I journal-size
> > +/ 64 megabytes. The total size of the journal with
> > +.B fast_commit
> > +feature set is
> > +.I journal-size
> > ++ (
> > +.I fast-commit-size
> > +* 1024) megabytes. The total journal size may be no more than
> > +10,240,000 filesystem blocks or half the total file system size
> > +(whichever is smaller).
> > +.TP
>
> So as I recall, aren't we currently calculating the fast commit size
> as a fraction of the total journal size?  I'm not sure this is in sync
> with was in the last patch.
So there are following three cases of journal area configuration:

1) User provides fast commit size and journal size as arguments to mke2fs
2) We are using internal journal and user asks mke2fs to calculate
journal size by default
3) We are using external journal and user asks mke2fs to calculate
journal size by default

So, for (1), we just provide an option "fast-commit-size" which is an
added area on top of the normal journal area. That's why total journal
size becomes the normal journal size + fast commit area size. However,
things become tricky for option (2) and (3). For (2), I'm *adding*
1/64th of the total journal area as a fast commit area on top of
existing journal. So, with fast commits enabled, the default total
journal size becomes 65/64 times the journal default journal area that
would have been created by mke2fs before these changes. For (3)
however, we don't have an option to use above logic since the external
device size is fixed. So, we have to divide the total journal area
into two parts. We split the external journal as 1:64 (fast commit :
normal commit).

Does this make sense?

Thanks,
Harshad
>
>                                         - Ted
