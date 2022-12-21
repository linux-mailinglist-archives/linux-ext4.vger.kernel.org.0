Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8AA65304E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Dec 2022 12:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLULei (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Dec 2022 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLULeh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Dec 2022 06:34:37 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A9FF0
        for <linux-ext4@vger.kernel.org>; Wed, 21 Dec 2022 03:34:35 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id m2so14426935vsv.9
        for <linux-ext4@vger.kernel.org>; Wed, 21 Dec 2022 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqp5h2G0o1D47DEepedTLD764sowPrFDF+33IDQEmnI=;
        b=I9qyMFSju8mqnAnv5jRtM119ICRMxcmggG4XNqO/FT6Nzz/iFzzgibduR8DDTNbheN
         Mqg6ooA0ZBaQOgRuuF0DzR1vJ94K+q9bvUnYiVvN8QfjNPfNitJBM3v5ZHQTmpxvIz7R
         hTi0k93A3rbs6B/vPvdHP9YccDtX5jI8BUD9gsBUvOzaQFN2l2yvhE2+7H2opVpzV6aR
         C4Telqqt3/sQttb4pL99RSC1cl/oCcUUnEqRBQwbKoWbIRk4d/tEl7ifZgFYdb8HmtTd
         /RfxPey6MBuQ+laGkscbaSbqiZahSF2N0eReK1sPukK0Bb/4kfUVnYoOzQZBKx+quRFg
         PcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqp5h2G0o1D47DEepedTLD764sowPrFDF+33IDQEmnI=;
        b=mOnRAPZTgQ3J8w5JuwhTU3nkdAqeGFGAmQN73JD5IRh3lPj5DX0Let/N2vmCb7DWH+
         2WymN2GUG0JQr/YAR3CmLdgynVrkyVGIRclXlnlm/pmNpI1gQKLm1TdMj97tmCamvn0l
         WB6zJ8oQTRInfKot5nYQ1EtRmEvaroiNhxam4bkpQTQ9k5xK5CdmztlDnEqiZ8B+TUpr
         /nMMKlKQq7E01+sX32mJ5zxNjdVH216j96sVBJ9oqnrnMaPwgHa2fVeKEmAT+tDAe3Jj
         CaD2d0804JDVbb77czT4BzthpAWkvoeK+ChRiA2g6dZXI3fNNRLQRkoBr+v7/x/2i5B8
         A+Yg==
X-Gm-Message-State: AFqh2koRBOyz6IYEhyPkSH60V8ih8Tnl/nl7mkhroa4U9VrsOSenQNjO
        Hjhj812sGIJlXeGvJr/3a4qij716X/O6omBXrMD9Yg==
X-Google-Smtp-Source: AMrXdXtp0v/R72NOTcUNN1rnRCk2XUHl09Jbcq47OJpk3jODl7hk8leumWQWjVG9FfNpnXRSK1dHn0/szrfn/Qa2EFY=
X-Received: by 2002:a67:d018:0:b0:3b3:560:f2ad with SMTP id
 r24-20020a67d018000000b003b30560f2admr215871vsi.17.1671622474909; Wed, 21 Dec
 2022 03:34:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006c411605e2f127e5@google.com> <000000000000b60c1105efe06dea@google.com>
 <Y5vTyjRX6ZgIYxgj@mit.edu> <Y5xsIkpIznpObOJL@google.com> <CANp29Y6KHBE-fpfJCXeN5Ju_qSOfUYAp2n+cNrGj25QtU0X=sA@mail.gmail.com>
 <Y5ylNxoN2p7dmcRD@mit.edu> <CANp29Y4QVp1G83pSqpxeETbw_+kQQ5CZUz+Vgi767WxE8AuhHQ@mail.gmail.com>
 <Y5y824gPqZo+vcxb@mit.edu> <CANp29Y4S0TTVjonA9ADpBKviNHR+n3nYi2hy2hcee-4ArD5t4Q@mail.gmail.com>
 <Y6CqJ8fgQQW8AhT6@mit.edu>
In-Reply-To: <Y6CqJ8fgQQW8AhT6@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 21 Dec 2022 12:34:23 +0100
Message-ID: <CANp29Y7T+sG4JYkZttpyBkz54SUwOz=BhJED+QmKOGp2CgceiA@mail.gmail.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Lee Jones <lee@kernel.org>,
        syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-android-bugs@googlegroups.com,
        tadeusz.struk@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 19, 2022 at 7:15 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
< ... >
> It's not obvious what you mean by the "main page" of the namespace.
> I'm guessing, but from the bug report page, there is a horizontal set
> of icons, "Open", "Fixed", "Invalid" .... (which all have the same
> icons), that the "Open" icon is the one that gets to the main page?

Yes.

>
> Assuming that this[1] is what was meant by "main page" (which is also
> implied by the URL, but it's otherwise **really** not obvious), where
> is the list of tested trees?
>
> [1] https://syzkaller.appspot.com/android-5-10

I've just deployed the changes that add the page with the list of the
tested repositories as well as a link to it from the "main page" (look
above the table with instances). For Android, we indeed don't test
many trees:

https://syzkaller.appspot.com/android-5-10/repos

For Linux upstream, there are more trees:

https://syzkaller.appspot.com/upstream/repos

> At least for the android-5-10 namespace, why not just
> say, "I don't see that commit on the git branch <explicit git repo and
> branch name>"?

Now such email messages will include the kernel name and some of the
tested repositories (with the link to the full list page). E.g.
https://github.com/google/syzkaller/blob/4067838e6b16173af08e062ce434ecfc46d45bda/dashboard/app/notifications_test.go#L106

--
Aleksandr
