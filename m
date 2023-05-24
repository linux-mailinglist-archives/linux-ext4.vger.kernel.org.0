Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037AB70F765
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjEXNLo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjEXNLd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 09:11:33 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE80BF;
        Wed, 24 May 2023 06:11:25 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-783e4666739so713125241.0;
        Wed, 24 May 2023 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684933884; x=1687525884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G31wejBjL+4kjEavesvY6oEVELOI7iO2IwbPn4/JT/s=;
        b=Il4ilej/xc3Qe9cqiV7VpVCk6jTpK5AdOcbKei4aKmbiFZV7GoIsmA1P5NjINj72OT
         WVb/dM4JgK5bwhP/5hHBwMwuE8pfcGICyaeUMRxKGIcTwluSQPRROenH6dQSB6vyWI3w
         2D2iMW6HRHNvMPP/WT8qWVJzj+4yduJyd+h9uRbgwCGgnrpCSUw5Gltksq7E5V9BD7cO
         Dl7LVbiSXTExqcgwdHLgeQcbwB1oYUq0xYyN89qA/CFp8BhIu1NFX9D9KlpHvIsTsSQ0
         EB19OrW33L/k+bZIlYazMW+xSbQDykGPZrCFWOTHtQ3v2XhvicAYr4NnVbqWm8xjP/hq
         tccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933884; x=1687525884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G31wejBjL+4kjEavesvY6oEVELOI7iO2IwbPn4/JT/s=;
        b=YLzRH5baNnEZOU12WdEYP5A0nEX8FPMeX1EV76YdKS/twDfnd19T6vmE3hSGNyrT4x
         hLYHh+BkmcRPbEYO1qP6J79QeGWVVlzN+PV2yecrFLqUQNZOs9DejWgnoeR/Lw0+uzmF
         tvamKtvHijCxdP41mne7ULmkoG9ZDqa+ACVehxurdsH0IVtoazv+1qqSjHUYrX76cd+K
         9yDQLnQOoWGkvLIs0AeRFNBqj1aI0p/ltkURGe0Wphyx/fJCpUzViK+fy32gLixvBjg9
         aOteTlZFMHzjoY2+sSB5u3CkNkGfa9LMOxKCEANiH7rWbqW6izJcHvIHIQl2dkJ0hj08
         dTuw==
X-Gm-Message-State: AC+VfDy+eJGz9QBPQSTmp8Strf0GMdtvr9Dx2YWLTcGmv6+ur+hOlnVe
        A9oX4gYinpyRKe8Q0ewn72UhrAi5cu75bsjttws=
X-Google-Smtp-Source: ACHHUZ4e99H2/SNv18stYWc/0y1Kz3DnBSdPO5nareXigxCs2j8hQs3CaVIX5Px9Wy+ZcM27zmZ8ubeAlIKXlethBi8=
X-Received: by 2002:a67:e9d0:0:b0:434:71c2:a4d9 with SMTP id
 q16-20020a67e9d0000000b0043471c2a4d9mr5260990vso.7.1684933884325; Wed, 24 May
 2023 06:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230523131408.13470-1-jack@suse.cz> <48d1f20b2fc1418080c96a1736f6249b@AcuMS.aculab.com>
 <20230524105148.wgjj7ayrbeol6cdx@quack3>
In-Reply-To: <20230524105148.wgjj7ayrbeol6cdx@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 16:11:13 +0300
Message-ID: <CAOQ4uxgizNA9e3rXmktU-pqCzoxg-=n4u_PAHczo1bgquba5Og@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
To:     Jan Kara <jack@suse.cz>
Cc:     David Laight <David.Laight@aculab.com>, Ted Tso <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 24, 2023 at 2:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 23-05-23 13:50:01, David Laight wrote:
> > From: Jan Kara
> > > Sent: 23 May 2023 14:14
> > >
> > > Commit 0813299c586b ("ext4: Fix possible corruption when moving a
> > > directory") forgot that handling of RENAME_EXCHANGE renames needs the
> > > protection of inode lock when changing directory parents for moved
> > > directories. Add proper locking for that case as well.
> > >
> > > CC: stable@vger.kernel.org
> > > Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a dir=
ectory")
> > > Reported-by: "Darrick J. Wong" <djwong@kernel.org>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/namei.c | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index 45b579805c95..b91abea1c781 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -4083,10 +4083,25 @@ static int ext4_cross_rename(struct inode *ol=
d_dir, struct dentry *old_dentry,
> > >     if (retval)
> > >             return retval;
> > >
> > > +   /*
> > > +    * We need to protect against old.inode and new.inode directory g=
etting
> > > +    * converted from inline directory format into a normal one. The =
lock
> > > +    * ordering does not matter here as old and new are guaranteed to=
 be
> > > +    * incomparable in the directory hierarchy.
> > > +    */
> > > +   if (S_ISDIR(old.inode->i_mode))
> > > +           inode_lock(old.inode);
> > > +   if (S_ISDIR(new.inode->i_mode))
> > > +           inode_lock_nested(new.inode, I_MUTEX_NONDIR2);
> > > +
> >
> > What happens if there is another concurrent rename from new.inode
> > to old.inode?
> > That will try to acquire the locks in the other order.
>
> That is not really possible because these two renames cannot happen in
> parallel due to VFS locking - either old & new share parent which is lock=
ed
> by VFS (so there cannot be another rename in that directory) or they have
> different parents which are also locked by VFS (so again it is not possib=
le
> to race with another rename in these two dirs).

Unless D1/A ; D1/B are hardlinks of D2/B ; D2/A respectively
and exchange (D1/A, D1/B) is racing with exchange (D2/B, D2/A)

There is a simple solution of course, same as xfs_lock_two_inodes()

Another possible deadlock (I think) is if D/A ; D/B are subdirs that
are exchanged and after taking inode_lock of D and A, rename comes
in D/B/foo =3D> D/A/foo and lock_rename() tries to
lock_two_directories(B, A).

So it seems that both lock_two_directories() and to be helper
lock_two_inodes() need to order the two inodes by address?

Thanks,
Amir.
