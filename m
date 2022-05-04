Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CC51ACE2
	for <lists+linux-ext4@lfdr.de>; Wed,  4 May 2022 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiEDSfn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 May 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377165AbiEDSff (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 May 2022 14:35:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE874A91F
        for <linux-ext4@vger.kernel.org>; Wed,  4 May 2022 11:17:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q130so2702180ljb.5
        for <linux-ext4@vger.kernel.org>; Wed, 04 May 2022 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=TGN9imabgriFl447VR+LtalCql2Ru1FM30YxNTrRXmNp2/aqSQe997eejilXBWN//u
         GLL7PEuW6j459zsXmON4fgRMpLVmy4AeFXc6ipyOPPq4NZahAq6TXZNADjmVrlQQdnt5
         DczkC/efB8FuKeTl9T9HqInWj7/2oPQ1dOleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=MchJY1pYmQRieA1u0xG5Pzcjt3/i7f8U6+Pf6nT7EMtuYnlMRPNHEyKoBUK5sIyfuF
         7GaNU99bAh5nY2Lz948k3rkTHXmEenjQ4W+no6Plzr7demefhdiQ5DWFGXVpccDTwApZ
         wYWy5NNrtnDapBc+oXogxqJQJrvOQEGbFl8gTtE36KzAw3wIzYPAdrMR6Y5vK6us1o4T
         ekO7BH68vyo7tzpIZjx1oPFql0zytyn0FF2QZGVZrP0TJbQEAtDGY+VDDPdScXRxXwGs
         XVl3RRuFNecVToY6fj7/8kki3tTwEVNEoLN6LcUXPsClEA7muo4xEkOsnZGtSYMTYyzT
         CCXA==
X-Gm-Message-State: AOAM530SZX+perbQWufpfm8/aBwoaIYgicRKYE6BjXGaoAyFj8RzpB5W
        p1wgrDHuwsM4Xkromr6P6zVq2uDnKUeyFpEK
X-Google-Smtp-Source: ABdhPJxXmHKfm+n8IYYIItgbu0HR4y/A4819fDf0GTFB79iCJWQKB84KPyoIxkDfi61stK36iotktQ==
X-Received: by 2002:a05:651c:1038:b0:24f:148e:b532 with SMTP id w24-20020a05651c103800b0024f148eb532mr13196218ljm.139.1651688241096;
        Wed, 04 May 2022 11:17:21 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m11-20020ac24acb000000b0047255d21130sm1266508lfp.95.2022.05.04.11.17.19
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:17:19 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x17so3729414lfa.10
        for <linux-ext4@vger.kernel.org>; Wed, 04 May 2022 11:17:19 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr15410699lfu.449.1651688238925; Wed, 04
 May 2022 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@lge.com, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, sj@kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
        linux-block <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        jack@suse.com, Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
>
> Hi Linus and folks,
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms.

So what is the actual status of reports these days?

Last time I looked at some reports, it gave a lot of false positives
due to mis-understanding prepare_to_sleep().

For this all to make sense, it would need to not have false positives
(or at least a very small number of them together with a way to sanely
get rid of them), and also have a track record of finding things that
lockdep doesn't.

Maybe such reports have been sent out with the current situation, and
I haven't seen them.

                 Linus
