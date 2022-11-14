Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF362878A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Nov 2022 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiKNRyO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Nov 2022 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiKNRxt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Nov 2022 12:53:49 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C1D51;
        Mon, 14 Nov 2022 09:53:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AEHr3it015824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 12:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668448387; bh=0oY2FHq6aam4ViqDXvERuEDXT+lWMYAi0k7t0ceXGtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=T9jIyOKT6a9ZXBo5B45dK908bfA8wWFMu1z6LujbTJTlNSMlBf8ZzOQ+et6xCQ6x0
         xTzBiiWDsrbYShdtJ3r4k6VkH2LITjVbkBSGaa2kDDJqKgnt7HI5TaouvAvBwOpLI0
         CFD41/h4aBfC9r6k77/89pKxwDzXc4lyZfo4uzvnMKmgICxhgWMTDSiCBYThAyuOLF
         JneBERVwGpadBtlN0oncGjkfbXJLpIzXxH0hTiCrKcbB2fMO8IcQLLtDWERVg3VpRH
         HTjy5zGARrPldeCwcFuRuhNxGDCsamEAZ2ZTb/qWl+R9wducW5cOLKcH7JrjlF792k
         3YxI3FaICDjNQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C5C4615C34C3; Mon, 14 Nov 2022 12:53:03 -0500 (EST)
Date:   Mon, 14 Nov 2022 12:53:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     syzbot <syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ext4_enable_quotas
Message-ID: <Y3KAfyQOf6GvEo/x@mit.edu>
References: <0000000000006a74dd05e9931449@google.com>
 <000000000000073a4a05ed620676@google.com>
 <Y3Jb1Wcs/mQlZP32@mit.edu>
 <8c3757ae-1aeb-49a4-47af-598d1d4737ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c3757ae-1aeb-49a4-47af-598d1d4737ea@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 14, 2022 at 11:21:33AM -0500, Waiman Long wrote:
> 
> lockdep_set_subclass() should be translated into a call to
> lockdep_init_map_type():
> 
> #define lockdep_set_subclass(lock, sub)                                 \
>         lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key,
> sub,\
> (lock)->dep_map.wait_type_inner,          \
> (lock)->dep_map.wait_type_outer,          \
>                               (lock)->dep_map.lock_type)
> 
> All memory access should be within the bound of the given "&ei->i_data_sem".
> Also lockdep_init_map_type() is not in the stack trace. So it is not a
> problem within this lockdep_init_map_type() function. So is it possible that
> the given inode pointer is invalid?

Well, the inode pointer would be coming from iget().  And since this
is coming from ext4 mount operation, we would be getting a fresh inode
that should be freshly allocated.  So the possibilities which comes to
mind is some kind of use-after-free (probbly in f2fs) that was
smashing the inode itself, such that ei->i_data_sem was pointing off
into la-la-land, or in the inode cache's internal data srtuctures.

The reason why I would assume it would be in f2fs is I *assume*
syzkaller would have pruned down the test case enough to remove the
messing around with mounting the invalid f2fs file system.  But the
other mystery here is why didn't KASAN report the use-after-free (if
that it is what it was) in the thousands of f2fs mount and
unmount operations before it finally triggered?

Anyway, I plan to ignore this Syzkaller unless report Syzkaller (or
someone else) can come up with a more minimal/reliable reproducer.  (I
mean, we could open a bug, but with kind of reproducer, it would get
prioritized P3 or P4 and ignored for years until it finally got closed
in a buganizer bankruptcy, so I figured I would just skip a few steps.  :-)

Cheers,

						- Ted
