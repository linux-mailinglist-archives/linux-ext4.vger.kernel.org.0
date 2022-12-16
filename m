Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB964F027
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Dec 2022 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiLPRPE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Dec 2022 12:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPRPD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Dec 2022 12:15:03 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA55B6F4AE
        for <linux-ext4@vger.kernel.org>; Fri, 16 Dec 2022 09:15:02 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id q128so2862508vsa.13
        for <linux-ext4@vger.kernel.org>; Fri, 16 Dec 2022 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtMTy3xD/YIIJO7mogDtwIJ/KFVv5XuLkhBv3fM/Tn8=;
        b=lyj42c62QPSypdqG7GLNN3i2/cQoZpa+utzANMIFx97g8gqQMRmMZHX790g36afuiu
         Q4EPORPLYwnd56QHiMbRb4x7OWPQid0pP5vAwIEGxaXr53pcKN7ACTIbw/LAUKVprpYC
         rRakx+eLmwTqpj3I6wRKVaxbe2wOy7CUmZMbcULvIF7U/7ogbcaW8iBau9XGyY8a3z0H
         KZJbg6Vw32CoU+BJiAB89sFkRqbhFgqUPk5LDnsdGoyEmhc/D9MLTdRjQ1bbmEQtF131
         UN83FonIYdEcW0BLkzQpR7GONe24epAHIchTdyBtICVOwSZG7BkqBEmMduvXBaiqaL9U
         mwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtMTy3xD/YIIJO7mogDtwIJ/KFVv5XuLkhBv3fM/Tn8=;
        b=aYqqbAuDhhr/WqgJDTWubIvCZImIJv03HA/aO4FHbIfFdh3VPWBLW9xP2GsteiNhvB
         I42RepbPc2idPImdgmguRXqjjwARe5Rd9Ps5YeqvnacnQF4n8WFK+RZbOdF4Xf32Ivd8
         oESBkjAIxZDvGqLuBbpelT37AwHTHkH3fjN3wOuQ+OdNF4UoZph3GVfU5WSR9SkG3qJ2
         M1l7rW2+yCl3eHvV86fE72RgC2YR2GyTWKqYTv0NphgTrOys4Lq2zEOGoyduiXvT2MZK
         EYHDp4+U9MCKLYEZXc5/Xu/eVH6K/4uU6CR6hXaF/Xy7uRDSdK3Zl2wpobW9XLvkUMlT
         gu4g==
X-Gm-Message-State: ANoB5pkqH8kNDtvO6iY33mZlKeXShwbMTj4Olod+cLn1gN76Me5wWGSY
        5xAl7pwS6Y887Pdf8nLU7Mjm714IjZmKXFoqacK2PBy6lNmfXStq
X-Google-Smtp-Source: AA0mqf6BLokz7R9cQcWdhXwpvwEVngT1W67P7kJHUedJP0xJL3QcWm9I1GLdaBqKhgaamYVtXl4pd8gAH5NDwF0srac=
X-Received: by 2002:a67:eb8b:0:b0:3b5:23b1:e56 with SMTP id
 e11-20020a67eb8b000000b003b523b10e56mr1887743vso.51.1671210901695; Fri, 16
 Dec 2022 09:15:01 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006c411605e2f127e5@google.com> <000000000000b60c1105efe06dea@google.com>
 <Y5vTyjRX6ZgIYxgj@mit.edu> <Y5xsIkpIznpObOJL@google.com> <CANp29Y6KHBE-fpfJCXeN5Ju_qSOfUYAp2n+cNrGj25QtU0X=sA@mail.gmail.com>
 <Y5ylNxoN2p7dmcRD@mit.edu>
In-Reply-To: <Y5ylNxoN2p7dmcRD@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 16 Dec 2022 18:14:50 +0100
Message-ID: <CANp29Y4QVp1G83pSqpxeETbw_+kQQ5CZUz+Vgi767WxE8AuhHQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 16, 2022 at 6:05 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Dec 16, 2022 at 03:09:04PM +0100, Aleksandr Nogikh wrote:
> >
> > Syzbot is actually reacting here to this bug from the Android namespace:
> >
> > https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
>
> Thanks for the clarification; stupid question, though -- I see
> "upstream" is listed on the dashboard link above.  Assuming that
> "usptream" is "Linus's tree", why was it still saying, "I can't find
> this patch in any of my trees"?  What about the upstream tree?

Bugs from different namespaces are treated independently, so in this
particular case syzbot was expecting the fixing commit to reach the
Android trees that it fuzzes.

--
Aleksandr

>
> > > Although this does appear to be a Stable candidate, I do not see it
> > > in any of the Stable branches yet.  So I suspect the answer here is to
> > > wait for the fix to filter down.
>
> The reason why it's not hit any of the long-term stable trees is
> because the patch doesn't apply cleanly, because there are
> pre-requisite commits that were required.  Here are the required
> commits for 5.15:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4_for_5.15.83
>
> % git log --reverse --oneline  v5.15.83..
> 96d070a12a7c ext4: refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
>     [ Upstream commit 8ac3939db99f99667b8eb670cf4baf292896e72d ]
> 2fa7a1780ecd ext4: add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
>     [ Upstream commit 6bc6c2bdf1baca6522b8d9ba976257d722423085 ]
> 8dc76aa246b1 ext4: add strict range checks while freeing blocks
>     [ Upstream commit a00b482b82fb098956a5bed22bd7873e56f152f1 ]
> deb2e1554497 ext4: block range must be validated before use in ext4_mb_clear_bb()
>     [ Upstream commit 1e1c2b86ef86a8477fd9b9a4f48a6bfe235606f6 ]
>
> Further backports to LTS kernels for 5.10, 5.4, etc., are left as an
> exercise to the reader.  :-)
>
>                                              - Ted
>
> P.S.  I have not tried to run gce-xfstests regressions yet. so the
> only QA done on these backports is "it builds, ship it!"  (And it
> fixes the syzbot reproducers.)  Then again, we're not running this
> kind of regression tests on the LTS kernels.
>
> P.P.S.  If anyone is willing to volunteer to be an ext4 backports
> maintainer, please contact me.  The job description is (a) dealing
> with the stable backport failures and addressing the patch conflicts,
> potentially by dragging in patch prerequisites, and (b) running
> "gce-xfstests ltm -c ext4/all -g auto" and making sure there are no
> regressions.
>
>                                               - Ted
