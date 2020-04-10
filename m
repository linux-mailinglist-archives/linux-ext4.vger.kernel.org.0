Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1E1A498B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDJRwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Apr 2020 13:52:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39004 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRwE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Apr 2020 13:52:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id x11so2548418otp.6
        for <linux-ext4@vger.kernel.org>; Fri, 10 Apr 2020 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGlqgNrrGlA6czGpnHrGWFTa/LGqYJr8f3bHftYfeIw=;
        b=bVJsBg1AlcpTEg9CWE6riA1tvjWxi61pcg+g2VgoJX3p7ff4zkltQsDdGVGkyPjIw3
         QdMqT8A2Bf7nis7HQQM8k9ltAISG+ITmo88lF1nTB4k7Nk3Xcs0B0GI7W5MuIWYcX7VQ
         R5KgRcq/4bn8BoxDh5IxDP+YJINmGm5xKZkpldZ+oOPao+TJSwU1tNOHKHgtEU0V7Jf5
         ZE/3Pj+1Beh2IYA8bVeIrYTrljH0zTxoOmN3WgWlvRhY659OUacCCUzAmXbK151gtpxM
         EkFTkKJ1iqRDbhi5SWMiXbO/yQ+qx1fshpBRR5b/zrP4o+wZKvTr5PA1ybEyG6LGpF0y
         1MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGlqgNrrGlA6czGpnHrGWFTa/LGqYJr8f3bHftYfeIw=;
        b=TYezVS4eU2Xsp30+0D9CP4+Kq4FKxQUIkk5kBRkK2JJBVCmonHGk34rtJzGtYcXl6B
         HcspMIrTfX/cpzba4IyISoA3/NdFBR7/b3sfdXDjVRL/PAPaemGxpEF7gD38Ac0hQipL
         dlvNfYMsL+tmATf5OIEEsWw+cy8bHykWhNPbq/j54k4P3OkznPkHUMfyzz4kpX+/qr1n
         6hkw/pR1gAziq3zf5XqdetPJw4/IPI023WAvPcHHtdmqw6SXQhMNmEk/aJ0cJP9eH+rO
         KI8X33LUPT67eja0IWK8F5PCL4jxFe6X1l1HntgwZhT+uH7QZC4ZdVo0nWDhU52w1BnL
         275Q==
X-Gm-Message-State: AGi0PuZB4l5N4iy56Me7rY0NKkjfI6mmdP1rzX9OM205sxw5jVJyQb0I
        yp3B+32C6h5zGFqbGEwipNLIuV9eJaLB0fC3OSTf7CqK
X-Google-Smtp-Source: APiQypKoRe3e6Hw87ryxap7oXs/9q0+5iXnnoJW14elfLieFQbhj/qOGJX6adoz4TW05ymXJSv9Ctc5vFEGhEJr0wMs=
X-Received: by 2002:a9d:340b:: with SMTP id v11mr5069961otb.14.1586541123610;
 Fri, 10 Apr 2020 10:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200408215530.25649-1-harshads@google.com> <20200408215530.25649-3-harshads@google.com>
 <C29FFBAA-43A0-4307-B0A3-ED91A572308F@dilger.ca>
In-Reply-To: <C29FFBAA-43A0-4307-B0A3-ED91A572308F@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 10 Apr 2020 10:51:52 -0700
Message-ID: <CAD+ocbw=pvAAE59GiaTrzfS0eaYLWLJrZzHNP57X2M2E_-B=4A@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] ext4, jbd2: add fast commit initialization routines
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 10, 2020 at 5:12 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Apr 8, 2020, at 3:55 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > Define feature flags for fast commits and add routines to allow ext4 to
> > initialize fast commits. Note that we allow 128 blocks to be used for
> > fast commits. As of now, that's the default constant value.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> > +static inline int ext4_should_fast_commit(struct super_block *sb)
> > +{
> > +     if (!ext4_has_feature_fast_commit(sb))
> > +             return 0;
> > +     if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> > +             return 0;
> > +     if (test_opt(sb, QUOTA))
> > +             return 0;
> > +     return 1;
> > +}
>
> This function seems more complex than it should be.  In this patch the
> ext4_should_fast_commit() function is only called once during mount, but
> in later patches it looks like it is called many times per file/inode.
>
> Why not just check JOURNAL_FAST_COMMIT, and clear it at mount/remount
> time if the other conditions prevent fast commits being used at all?
> It seems that JOURNAL_FAST_COMMIT is only set if the FAST_COMMIT feature
> is already in the superblock, so always doing both checks seems redundant.
Sounds good, will fix that in the next version.
>
> Also, maybe I missed the discussion, but why does having quotas enabled
> on the filesystem disable fast commits entirely?  I see in patch 11/20
> that EXT4_FC_REASON_QUOTA is a reason not to do fast commit on the quota
> inodes themselves, which seems like a reasonable limitation if needed,
> but the above check disables FC for any filesystem with quota, and I
> can't find anywhere that this line is later removed in this series.

Thanks Andreas for catching this. Actually, there is nothing stopping
us from enabling fast commits for quota. As it turns out, this is an
unintended carry over from an earlier version of the patchset. I'll
re-enable it in the next version.

Thanks,
Harshad

>
> Cheers, Andreas
>
>
>
>
>
