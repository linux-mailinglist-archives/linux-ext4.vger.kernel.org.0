Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA3EA2CB
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfJ3Rvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 13:51:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41883 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfJ3Rvi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Oct 2019 13:51:38 -0400
Received: by mail-io1-f68.google.com with SMTP id r144so3548909iod.8
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAJAbO6qwXhLEfUbw+AhujMFfUXjrUZjKzqtdegXcpE=;
        b=BPlFogKNwpXdEhzfBA3vrd5InmBVlOAbu5jJZ69b6mMYO56ZV/S6tJfSnU5azKMjfk
         nTrUrFAtkDIw7vI63ZDJuuN6W1CvRnbjCYF8r3+YhE5mv0JoypVBxb2+StYO2fqB7x5Q
         j4JbvB5ILE2TW4sNBxA+9XI+Id64EYF4rjq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAJAbO6qwXhLEfUbw+AhujMFfUXjrUZjKzqtdegXcpE=;
        b=XCsV3mfX53xeW2EHl5bsUvHEg07pn55/GYHOyeixKDgpcg2pDE2JH9Oezx7/WEJ7NV
         rBF5+x7u+P4Bb8xm2QSSZt+mqdBClK3HFgRE5pgSsHdEDvXoLQQK2qBiqzKFUM1yJ44z
         4Cfk9hKtxM1Vth4WyXcbx6fbhMSgN/kJTMStd1Wb8HwOiHlIbAIFzSCwOKjL2HyaARV2
         IIs8JKxuZaGjJMpVSqA5cPaxJq6fPNKwhbC7G+4OJ2IJbapN8ghbRxO8dd+lmZ7pnGv1
         bjUNkq1pYOKhmDkR5uY0PZIFMKtKupm3vKgQABNMApdf72BK/fkTciEMEy26m4/koJVJ
         Xd/g==
X-Gm-Message-State: APjAAAWuiWfOlWh2QI+qlrGp4I1zmy7zwb2BLSGCR5630c0NZdDkHMjh
        di1/pWyd8/aJFUgegBvR125vw30ZlHY=
X-Google-Smtp-Source: APXvYqyqQ+Rlexfo0XbEObKkLAVE3nq1q2wgmyaVeHo3J0jPTbDCHeo/58NkI+Z+Z3+EsL/640dHGQ==
X-Received: by 2002:a05:6602:198:: with SMTP id m24mr988258ioo.34.1572457895419;
        Wed, 30 Oct 2019 10:51:35 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id v10sm121406ila.81.2019.10.30.10.51.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 10:51:33 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r144so3548691iod.8
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 10:51:32 -0700 (PDT)
X-Received: by 2002:a5d:9059:: with SMTP id v25mr996377ioq.58.1572457892344;
 Wed, 30 Oct 2019 10:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191030100618.1.Ibf7a996e4a58e84f11eec910938cfc3f9159c5de@changeid>
 <20191030173758.GC693@sol.localdomain>
In-Reply-To: <20191030173758.GC693@sol.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Oct 2019 10:51:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
Message-ID: <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
Subject: Re: [PATCH] Revert "ext4 crypto: fix to check feature status before
 get policy"
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Chao Yu <chao@kernel.org>,
        Ryo Hashimoto <hashimoto@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Guenter Roeck <groeck@chromium.org>, apronin@chromium.org,
        linux-doc@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 10:38 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Douglas,
>
> On Wed, Oct 30, 2019 at 10:06:25AM -0700, Douglas Anderson wrote:
> > This reverts commit 0642ea2409f3 ("ext4 crypto: fix to check feature
> > status before get policy").
> >
> > The commit made a clear and documented ABI change that is not backward
> > compatible.  There exists userspace code [1] that relied on the old
> > behavior and is now broken.
> >
> > While we could entertain the idea of updating the userspace code to
> > handle the ABI change, it's my understanding that in general ABI
> > changes that break userspace are frowned upon (to put it nicely).
> >
> > NOTE: if we for some reason do decide to entertain the idea of
> > allowing the ABI change and updating userspace, I'd appreciate any
> > help on how we should make the change.  Specifically the old code
> > relied on the different return values to differentiate between
> > "KeyState::NO_KEY" and "KeyState::NOT_SUPPORTED".  I'm no expert on
> > the ext4 encryption APIs (I just ended up here tracking down the
> > regression [2]) so I'd need a bit of handholding from someone.
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/cryptohome/dircrypto_util.cc#73
> > [2] https://crbug.com/1018265
> >
> > Fixes: 0642ea2409f3 ("ext4 crypto: fix to check feature status before get policy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  Documentation/filesystems/fscrypt.rst | 3 +--
> >  fs/ext4/ioctl.c                       | 2 --
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > index 8a0700af9596..4289c29d7c5a 100644
> > --- a/Documentation/filesystems/fscrypt.rst
> > +++ b/Documentation/filesystems/fscrypt.rst
> > @@ -562,8 +562,7 @@ FS_IOC_GET_ENCRYPTION_POLICY_EX can fail with the following errors:
> >    or this kernel is too old to support FS_IOC_GET_ENCRYPTION_POLICY_EX
> >    (try FS_IOC_GET_ENCRYPTION_POLICY instead)
> >  - ``EOPNOTSUPP``: the kernel was not configured with encryption
> > -  support for this filesystem, or the filesystem superblock has not
> > -  had encryption enabled on it
> > +  support for this filesystem
> >  - ``EOVERFLOW``: the file is encrypted and uses a recognized
> >    encryption policy version, but the policy struct does not fit into
> >    the provided buffer
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 0b7f316fd30f..13d97fb797b4 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -1181,8 +1181,6 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  #endif
> >       }
> >       case EXT4_IOC_GET_ENCRYPTION_POLICY:
> > -             if (!ext4_has_feature_encrypt(sb))
> > -                     return -EOPNOTSUPP;
> >               return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
> >
>
> Thanks for reporting this.  Can you elaborate on exactly why returning
> EOPNOTSUPP breaks things in the Chrome OS code?  Since encryption is indeed not
> supported, why isn't "KeyState::NOT_SUPPORTED" correct?

I guess all I know is from the cryptohome source code I sent a link
to, which I'm not a super expert in.  Did you get a chance to take a
look at that?  As far as I can tell the code is doing something like
this:

1. If I see EOPNOTSUPP then this must be a kernel without ext4 crypto.
Fallback to using the old-style ecryptfs.

2. If I see ENODATA then this is a kernel with ext4 crypto but there's
no key yet.  We should set a key and (if necessarily) enable crypto on
the filesystem.

3. If I see no error then we're already good.


> Note that the state after this revert will be:
>
> - FS_IOC_GET_ENCRYPTION_POLICY on ext4 => ENODATA
> - FS_IOC_GET_ENCRYPTION_POLICY on f2fs => EOPNOTSUPP
> - FS_IOC_GET_ENCRYPTION_POLICY_EX on ext4 => EOPNOTSUPP
> - FS_IOC_GET_ENCRYPTION_POLICY_EX on f2fs => EOPNOTSUPP
>
> So if this code change is made, the documentation would need to be updated to
> explain that the error code from FS_IOC_GET_ENCRYPTION_POLICY is
> filesystem-specific (which we'd really like to avoid...), and that
> FS_IOC_GET_ENCRYPTION_POLICY_EX handles this case differently.  Or else the
> other three would need to be changed to ENODATA -- which for
> FS_IOC_GET_ENCRYPTION_POLICY on f2fs would be an ABI break in its own right,
> though it's possible that no one would notice.
>
> Is your proposal to keep the error filesystem-specific for now?

I guess I'd have to leave it up to the people who know this better.
Mostly I just saw this as an ABI change breaking userspace which to me
means revert.  I have very little background here to make good
decisions about the right way to move forward.


> BTW, the crbug.com link is not publicly viewable, so should not be included in
> the commit message.

My apologies.  It's public now.  Annoyingly they've been experimenting
with making bugs on crbug.com private by default (argh) and I didn't
notice.

-Doug
