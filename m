Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB362A4EF1
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgKCSeA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSeA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Nov 2020 13:34:00 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2AC0613D1
        for <linux-ext4@vger.kernel.org>; Tue,  3 Nov 2020 10:34:00 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o21so18599242ejb.3
        for <linux-ext4@vger.kernel.org>; Tue, 03 Nov 2020 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUGP0hKS1+AtvuOt45lakcWF0VAgfEfjxebL+1GM/Qg=;
        b=JTPGeP00C+KSEcusXs7VAOJ/dn3IS3KuYrTF6t1v6wKpv1l1qrYUs6wbYyexawv8wW
         E4yPO4hjMG+k4yCik5g0JVCaZGwbj5G7OE0td224WnDPAVUqOtjY94calceOXe0NBIp3
         ep7M0t2zmryk0Q5LYv3lrVGE71f075C9g3yLVCipuyw1v5da9vVCFgsuJ4isHoZ+Poml
         tAaUokkfF9rpdqCuUl1WDfjV6sZCi4YNwGGJ8zDVwvPfbYxqQYuNc1xfNsOhPcP3p8Xv
         nGxrnC1aNwo+oyUUKtmrF8S/csXQRVohehPeXyNo2bEGfNI39OfP+uh6hEnNPjWfwXwa
         pcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUGP0hKS1+AtvuOt45lakcWF0VAgfEfjxebL+1GM/Qg=;
        b=qW1DsN5M3VwG7rdO7N/eTNfDPvAIxreg6UASq6LnF/WaQqGS/MddmJ4WaPJ6RzmmfD
         /6xWsHyXUMs5y7+QFduMA3sFqyn/XyoH/zkNVFbFI8UdNjFwAVA9j7whoEiGUuWOii4t
         vIKdI4gaiw3khjNwy5pikSKtREIHa3c5NlkQ4Rwij5OcqV9zxUK4MBYbDKuxdEhIainj
         BmTJO8fj8evlzD5tKcn0WVq3NKgIYFMioWsvTFST3OejUSdMdWiddxwIiARHdwjmjtwQ
         l0IHn3wrfskOU61KWchpdOjFTpObQq/7msBeVB5TX4OPltiVrAzSgah8G/nGO17jQjci
         O7PQ==
X-Gm-Message-State: AOAM533A/kkHjBzapllcgAebFoNXfZI7kca+mVnxSIZgNwnOr34UJBA7
        NmBfsDKdlC+kl2eD2/MFd3nOYmasptQJjXzQEgo=
X-Google-Smtp-Source: ABdhPJws5puEoQqDWXrUK9gtyM+bltiTMvuFgXq9kJBMK9nuhpYgH45UZBuqf/KQOzS+rlfxLw1ulc+1xtHMw4vFqyo=
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr20694691ejm.223.1604428438701;
 Tue, 03 Nov 2020 10:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-3-harshadshirwadkar@gmail.com> <20201103141331.GF3440@quack2.suse.cz>
In-Reply-To: <20201103141331.GF3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 3 Nov 2020 10:33:47 -0800
Message-ID: <CAD+ocbyXyjA9AKS-us4dFmA=ExdFQttYeXH2bJ8bQUAm0qYRDg@mail.gmail.com>
Subject: Re: [PATCH 02/10] ext4: mark fc ineligible if inode gets evictied due
 to mem pressure
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 6:13 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:10, Harshad Shirwadkar wrote:
> > If inode gets evicted due to memory pressure, we have to remove it
> > from the fast commit list. However, that inode may have uncommitted
> > changes that fast commits will lose. So, just fall back to full
> > commits in this case. Also, rename the fast commit ineligiblity reason
> > from "EXT4_FC_REASON_MEM" to "EXT4_FC_REASON_MEM_CRUNCH" for better
> > expression.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> ...
>
> > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > index 06907d485989..cde86747faf8 100644
> > --- a/fs/ext4/fast_commit.h
> > +++ b/fs/ext4/fast_commit.h
> > @@ -100,7 +100,7 @@ enum {
> >       EXT4_FC_REASON_XATTR = 0,
> >       EXT4_FC_REASON_CROSS_RENAME,
> >       EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
> > -     EXT4_FC_REASON_MEM,
> > +     EXT4_FC_REASON_MEM_CRUNCH,
>
> Well MEM_CRUNCH doesn't really sound more understandable to me :). I'd
> rather call it MEM_RECLAIM or ENOMEM or something like that...
Okay, ENOMEM sounds good, since this is also used in case of memory
allocation failures.
>
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index b96a18679a27..52ff71236290 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -327,6 +327,7 @@ void ext4_evict_inode(struct inode *inode)
> >       ext4_xattr_inode_array_free(ea_inode_array);
> >       return;
> >  no_delete:
> > +     ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM_CRUNCH);
> >       ext4_clear_inode(inode);        /* We must guarantee clearing of inode... */
> >  }
>
> This will make fs ineligible on every inode reclaim. Even if the inode was
> clean, not part of any FC. I guess this is too aggressive...
Right, I missed that, so first checking if the inode is on FC list and
then marking the FS as ineligible should suffice?

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
