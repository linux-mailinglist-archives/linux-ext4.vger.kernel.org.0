Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7736F2767
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjD3Czh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Apr 2023 22:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD3Czg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Apr 2023 22:55:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E551BD5
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 19:55:33 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U2tC0Y024382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Apr 2023 22:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682823318; bh=i2FgzlkJcrvcsFVmz+a9C1lvszBz+lDBlJrsbESK+dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HeryzVNSTeNLwLhcS1xhunWmFMcnF6zuy1EDbwTrL8gOb4PhXjdQXUWqk2H3raQwc
         dOQc6FLcHixZZttgGYCGbGJb/2YWKAZUhDP4Nh9PMxrQni6DkeUbtUVzxJXvHU76tn
         uDGyHGm9m4EPkoe9jWWUAV/88thNsOAGXTtlMLsHZPLUXjC6dRAOAzhM5R2tRzP4Q8
         BdLW8EimwGzGNXGmWeBQlLpR17cWM7YW8kex0e/OHunEoymxEJAp2zpPTSMilg2SzM
         R0bfFPJyY1jSd3njrUzOYvHJ5KB5S25FJ6gJvgLXMENKoqbUEeY8pye8S9JeQzs1O5
         63CZ0Yc1JjxtA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 80F4E8C012F; Sat, 29 Apr 2023 22:55:12 -0400 (EDT)
Date:   Sat, 29 Apr 2023 22:55:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, Lee Jones <joneslee@google.com>,
        syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com,
        syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 ext4_group_desc_csum
Message-ID: <ZE3YkAiGVLXMbHmb@mit.edu>
References: <000000000000ef6cf905f496e40b@google.com>
 <7e4a0f15-4d82-6026-c14b-59852ffab08e@linaro.org>
 <20230307103958.lo6ynoypgwreqmnq@quack3>
 <60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org>
 <976a7f24-0446-182f-c99e-98f3b98aef49@linaro.org>
 <20230313115728.2wxy2qj4mqpwgrx7@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313115728.2wxy2qj4mqpwgrx7@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 13, 2023 at 12:57:28PM +0100, Jan Kara wrote:
> > 
> > I can now explain how the contents of the super block of the buffer get
> > corrupted. After the ext4 fs is mounted to the target ("./bus"), the
> > reproducer maps 6MB of data starting at offset 0 in the target's file
> > ("./bus"), then it starts overriding the data with something else, by
> > using memcpy, memset, individual byte inits. Does that mean that we
> > shouldn't rely on the contents of the super block in the buffer after we
> > mount the file system?

It's not reasonable to avoid relying on the contents of the superblock
under all cases.  HOWEVER, sometimes it might make sense.  See below...

> So the result is that the reproducer modified the block device while it is
> mounted by the filesystem. We know cases like this can crash the kernel and
> it is inherently difficult to fix. We have to trust the buffer cache
> contents as otherwise the performance will be unacceptable. For historical
> reasons we also have to allow modifications of buffer cache while ext4 is
> mounted because tune2fs uses this to e.g. update the label of a mounted
> filesystem.

I've been taking a look at some of the syzkaller reports for ext4, and
there are a number of sysbot reports which are caused by the
reproducer messing with the block device while the file system is
mounted, including:

KASAN: slab-out-of-bounds Read in get_max_inline_xattr_value_size
    https://syzkaller.appspot.com/bug?id=731e35eeed762019e385baa96953d9ec8eb63c10
    syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com

KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
    https://syzkaller.appspot.com/bug?id=434a92f091e845da1ba387fb93f186412e30e35c
    syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com

kernel BUG in ext4_get_group_info
    https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
    syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com

(The easiest way to find them is to look at the Syzkaller reproducer,
and look for bind mounts of /dev/loopN to "./bus".  It's much less
painful than trying to find it in the C reproducer text file.)

As Jan has pointed out, we can't disable writing to the block device,
because this would break real-world system administrator workloads,
including the ability to set the label and uuid, use tune2fs to set
various parameters on the file system, etc.  We do have ioctls that
allow for setting the label and uuid, and in maybe ten years we should
be able to get to the point where all of the enterprise kernels still
supported by Red Hat, SuSE, etc. can be guaranteed to support all of
the necessary ioctls --- some of which still need to be implemented.

So this will take a *while*, and especially while senior management
types at many companies are announcing layoffs, cutting travel, and
talking about "year of efficiency" and "sharpening focus"[1], I don't
think we'll have much luck getting funded head count to impement
missing ioctls, other than slowly, on volunteer time, and maybe as
intern projects.  So what should we do in the intervening
year(s)/decade?  I'd propose the following priorities.

[1]  while simultaneously whining about "kernel (security) disasters"
and blaming the upstream developers.  Sigh...

From a quality of implementation (QoI) perspective, once we've
determined that it's caused by "messing with the block device while it
is mounted", if it just causes a denial of service attack, these should
be the lowest priority.  However, if there is an easy way to fix it,
AND if it fixes other issues OR makes the kernel smaller and/or more
efficient, I won't turn away those kind of proposed patches.

For example, in the case of the syzkaller report discussed in this
thread ("KASAN: slab-out-of-bounds Read in ext4_group_desc_csum"),
Tudor's proposed change of replacing

	le16_to_cpu(sbi->s_es->s_desc_size)

with
	sbi->s_desc_size

will actually reduce ext4's compiled text size, and make the code more
efficient (we remove an extra indirect reference and a potential byte
swap on big endian systems), and there is no downside.  In fact, in
many places we use sbi->s_desc_size in preference to accessing the
s_es variable; that's why we put it in the ext4_super_info structure
in the first place!  So sure, we should make this change, and if it
avoids a potential KASAN / syzkaller failure, that's a bonus.


Slightly higher in priority are those bugs which might allow kernel
state to be leaked ("kernel confidentiality").  Of course, if the
process with root access can write to the block device, it can almost
certainly read that block device as well; but there might be critical
bits of kernel state (for example, an RSA private key), in kernel
memory, that if leaked, it would be sad.


The highest priority would go to those where root access might be
leveraged to allow arbitrary code to be executed in kernel mode
("kernel integrity") --- which is unfortunate because it allows root
access to breach lockdown security.


Of course, since many of the people working syzbot reports for ext4
are volunteers and/or company engineers working on their own unfunded
personal time, we still can't *guarantee* anything.  In addition, I'd
still reject a patch which had an overly expensive CPU or memory
overhead with a "try harder".  So it would still be on a case-by-case
basis whether such patches would be accepted.  After all, some
business leaders have elected to disable some mitigations for
Spectre/Meltdown and related attacks because they were Too Damn
Expensive.  I reserve the right as upstream maintainer to make similar
judgement calls.

						- Ted

P.S.  As another example, over the weekend, I've been working on some
patches in the works to address the third syzbot report listed above
("kernel BUG in ext4_get_group_info").  When I evaluated these
patches, I found that they increased the compiled text size by 2k when
I added the additional checks, none of which were in hot paths.  But
after I un-inlined ext4_get_group_info(), the compiled test size
shrunk by 4k, for a net 2k byte *savings* in compiled kernel text
memory.

We already had similar checks and calls to ext4_error() in
ext4_get_group_desc(); this patch was just added a similar conditional
call to ext4_error() to ext4_get_group_info() --- and changing the
callers of that function to check for a NULL return from that
function.  While this change only prevents a denial of service attack,
in my judgement the QoI benefits outweigh the costs.
