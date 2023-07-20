Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681FD75B245
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGTPSI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGTPSH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 11:18:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AC26BA
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 08:18:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so75485e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866279; x=1690471079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ0NbXFA9avjbEQfqJk/EA+XEw1aR3Ivofcz45w0LCA=;
        b=4zsWWvMQRf761GwK0wlm8TqRImyAgBmtAtAiwi/z6R4ikcmlrCgZeNryjNAsaY6aBw
         2xPyQvkr8OVjDsAeSX0KbunAkAiDMK9gY0BP7VU9Kj907wT5RhuNe+d0CzQL9Vn61TMs
         BRnYLDdR5ER4vQe8luRVGrvaF+FnjyOJdqIPE0EbxqCBCWz9LpIfd+EMC5sK2Nepmn/f
         IIX9JWOG4xBkPdkWSk1XhYF/rkeVzXfSE5QTakqIKeQswJXucB8+v891O+2Na6jiOG6Z
         Dy0vhEgm3Sb74sQmVsDJU+qxHPacRi0QJElpxSpLpmcxMZnJz8xk7rlaoMZG/W1xm88P
         aL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866279; x=1690471079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJ0NbXFA9avjbEQfqJk/EA+XEw1aR3Ivofcz45w0LCA=;
        b=BDdYa/pEhQwBwrbNwAwrUfHMURLFOeZ9cexQeEpC7p4rWZu6lmFqs62HHuDTHBL4an
         IFPssSEdSOp4KAS2xVrlCUedeD3MwPFfHN445jRB4sqMEV7rLyoyZDNv7G/N4bvx3nHc
         qzXGubWvffSTisgBt4UU52mAVkiLkVHMvPV/jOQy16P5GwySgntola9CgBq28oTfxZKI
         pKyXk/a2+qGyEra3Es6NLBAPJ2PRad3hJvRz6owfuQzlQ9JDa0s21shHVlylNUnQp/Vt
         FldVGAjiI5c40fcKc/EGXNqFqP+PsK1ilynZp/JGukTpwzREK5eYvOsnuPo05zgIDP+2
         lk+Q==
X-Gm-Message-State: ABy/qLZk0C1FFWtCtUbLcFsTFXDsF69s45fpmZq+lkKlOzUr6r4lRHb8
        gwARm2X37zPq8Q6nOHzu7mlQycro/biem7nJr2vbm+VSxg4PUu5RsOA=
X-Google-Smtp-Source: APBJJlGWkMQZnMrS3KhKyX7lmKsFZcAyablJRMBmdfqLiT6WAZCJllQjO8G+cBO4WMYeMLZ1B8KzEuZd7hXfb8Lza4s=
X-Received: by 2002:a05:600c:4745:b0:3fd:e15:41e3 with SMTP id
 w5-20020a05600c474500b003fd0e1541e3mr120394wmo.2.1689866279099; Thu, 20 Jul
 2023 08:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006a74dd05e9931449@google.com> <000000000000073a4a05ed620676@google.com>
 <Y3Jb1Wcs/mQlZP32@mit.edu> <8c3757ae-1aeb-49a4-47af-598d1d4737ea@redhat.com> <Y3KAfyQOf6GvEo/x@mit.edu>
In-Reply-To: <Y3KAfyQOf6GvEo/x@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Jul 2023 17:17:46 +0200
Message-ID: <CACT4Y+Z83JvP9ifU7Bv8=KO8oZVYEoYA2K+Jwk7Vusoij1M8_w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ext4_enable_quotas
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Waiman Long <longman@redhat.com>,
        syzbot <syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 14 Nov 2022 at 18:53, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 14, 2022 at 11:21:33AM -0500, Waiman Long wrote:
> >
> > lockdep_set_subclass() should be translated into a call to
> > lockdep_init_map_type():
> >
> > #define lockdep_set_subclass(lock, sub)                                 \
> >         lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key,
> > sub,\
> > (lock)->dep_map.wait_type_inner,          \
> > (lock)->dep_map.wait_type_outer,          \
> >                               (lock)->dep_map.lock_type)
> >
> > All memory access should be within the bound of the given "&ei->i_data_sem".
> > Also lockdep_init_map_type() is not in the stack trace. So it is not a
> > problem within this lockdep_init_map_type() function. So is it possible that
> > the given inode pointer is invalid?
>
> Well, the inode pointer would be coming from iget().  And since this
> is coming from ext4 mount operation, we would be getting a fresh inode
> that should be freshly allocated.  So the possibilities which comes to
> mind is some kind of use-after-free (probbly in f2fs) that was
> smashing the inode itself, such that ei->i_data_sem was pointing off
> into la-la-land, or in the inode cache's internal data srtuctures.
>
> The reason why I would assume it would be in f2fs is I *assume*
> syzkaller would have pruned down the test case enough to remove the
> messing around with mounting the invalid f2fs file system.  But the
> other mystery here is why didn't KASAN report the use-after-free (if
> that it is what it was) in the thousands of f2fs mount and
> unmount operations before it finally triggered?
>
> Anyway, I plan to ignore this Syzkaller unless report Syzkaller (or
> someone else) can come up with a more minimal/reliable reproducer.  (I
> mean, we could open a bug, but with kind of reproducer, it would get
> prioritized P3 or P4 and ignored for years until it finally got closed
> in a buganizer bankruptcy, so I figured I would just skip a few steps.  :-)


Let's set the subsystem then, so it's in the f2fs bucket rather than in ext4:

#syz set subsystems: f2fs
