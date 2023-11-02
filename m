Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F27DEFA2
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbjKBKPT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjKBKPS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 06:15:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89A8128;
        Thu,  2 Nov 2023 03:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3897C433C8;
        Thu,  2 Nov 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698920115;
        bh=Q2Pw88Smwr2tP11TBVI1gQsAdzs/pokawrj4+qe5P3o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GZJ9pBBpUlY69n1aPU0VTU2Nb/im1AXs0bYUAdqqHUvx80F3Pni3V0mAHxi6nJnL9
         xKer34VF3ykecUHUrKHi6CjlqBJp5lBq568F3gAIt55L21QnCydXqEXkKbItSfgTUG
         jYkwZ0XkLZVxiwZ3B1q1wRuKtFgVajJL19+tnsuFgQUc1hHrm+iIEv0ZHMRPrYgqap
         SuGPqC/4K8YM+rT3O0tru3SquBHNU7/YJxMuonL22dCgE0hyj9ypyDnQOgxxnwBsQr
         KHJfaTCu3Lo3fBx2/lt1iIS14RL/+rFrGqejCCKJmdGTy0sf+IhgClCvCf2aJXRVdi
         Tbxy/yjqnFaZw==
Message-ID: <d28e527ebb9375f3aad89532e09ff875bd9572eb.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.de>, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Thu, 02 Nov 2023 06:15:11 -0400
In-Reply-To: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
         <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
         <ZTnNCytHLGoJY9ds@dread.disaster.area>
         <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
         <ZUAwFkAizH1PrIZp@dread.disaster.area>
         <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
         <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
         <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
         <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
         <ZUF4NTxQXpkJADxf@dread.disaster.area>
         <20231101101648.zjloqo5su6bbxzff@quack3>
         <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2023-11-01 at 10:10 -1000, Linus Torvalds wrote:
> On Wed, 1 Nov 2023 at 00:16, Jan Kara <jack@suse.cz> wrote:
> >=20
> > OK, but is this compatible with the current XFS behavior? AFAICS curren=
tly
> > XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk wi=
ll
> > have some mostly random garbage in low bits of the ctime.
>=20
> I really *really* don't think we can use ctime as a "i_version"
> replacement. The whole fine-granularity patches were well-intentioned,
> but I do think they were broken.
>=20

I have to take some issue here. I still the basic concept is sound. The
original implementation was flawed but I think I have a scheme that
could address the problems with the multigrain series.

That said, everyone seems to be haring off after other solutions. I
don't much care which one we end up with, as long as the problem gets
fixed.

> Note that we can't use ctime as a "i_version" replacement for other
> reasons too - you have filesystems like FAT - which people do want to
> export - that have a single-second (or is it 2s?) granularity in
> reality, even though they report a 1ns value in s_time_gran.
>=20
> But here's a suggestion that people may hate, but that might just work
> in practice:
>=20
>  - get rid of i_version entirely
>=20
>  - use the "known good" part of ctime as the upper bits of the change
> counter (and by "known good" I mean tv_sec - or possibly even "tv_sec
> / 2" if that dim FAT memory of mine is right)
>=20
>  - make the rule be that ctime is *never* updated for atime updates
> (maybe that's already true, I didn't check - maybe it needs a new
> mount flag for nfsd)
>=20
>  - have a per-inode in-memory and vfs-internal (entirely invisible to
> filesystems) "ctime modification counter" that is *NOT* a timestamp,
> and is *NOT* i_version
>=20
>  - make the rule be that the "ctime modification counter" is always
> zero, *EXCEPT* if
>     (a) I_VERSION_QUERIED is set
>    AND
>     (b) the ctime modification doesn't modify the "known good" part of ct=
ime
>=20
> so how the "statx change cookie" ends up being "high bits tv_sec of
> ctime, low bits ctime modification cookie", and the end result of that
> is:
>=20
>  - if all the reads happen after the last write (common case), then
> the low bits will be zero, because I_VERSION_QUERIED wasn't set when
> ctime was modified
>=20
>  - if you do a write *after* a modification, the ctime cookie is
> guaranteed to change, because either the known good (sec/2sec) part of
> ctime is new, *or* the counter gets updated
>=20
>  - if the nfs server reboots, the in-memory counter will be cleared
> again, and so the change cookie will cause client cache invalidations,
> but *only* for those "ctime changed in the same second _after_
> somebody did a read".
>=20
>  - any long-time caches of files that don't get modified are all fine,
> because they will have those low bits zero and depend on just the
> stable part of ctime that works across filesystems. So there should be
> no nasty thundering herd issues on long-lived caches on lots of
> clients if the server reboots, or atime updates every 24 hours or
> anything like that.
>=20
> and note that *NONE* of this requires any filesystem involvement
> (except for the rule of "no atime changes ever impact ctime", which
> may or may not already be true).
>=20
> The filesystem does *not* know about that modification counter,
> there's no new on-disk stable information.
>=20
> It's entirely possible that I'm missing something obvious, but the
> above sounds to me like the only time you'd have stale invalidations
> is really the (unusual) case of having writes after cached reads, and
> then a reboot.
>=20
> We'd get rid of "inode_maybe_inc_iversion()" entirely, and instead
> replace it with logic in inode_set_ctime_current() that basically does
>=20
>  - if the stable part of ctime changes, clear the new 32-bit counter
>=20
>  - if I_VERSION_QUERIED isn't set, clear the new 32-bit counter
>=20
>  - otherwise, increment the new 32-bit counter
>=20
> and then the STATX_CHANGE_COOKIE code basically just returns
>=20
>    (stable part of ctime << 32) + new 32-bit counter
>=20
> (and again, the "stable part of ctime" is either just tv_sec, or it's
> "tv_sec >> 1" or whatever).
>=20
> The above does not expose *any* changes to timestamps to users, and
> should work across a wide variety of filesystems, without requiring
> any special code from the filesystem itself.
>=20
> And now please all jump on me and say "No, Linus, that won't work, becaus=
e XYZ".
>=20
> Because it is *entirely* possible that I missed something truly
> fundamental, and the above is completely broken for some obvious
> reason that I just didn't think of.
>=20

Yeah, I think this scheme is problematic for the reasons Trond pointed
out. I also don't quite see the advantage of this over what Dave Chinner
is proposing (using low-order bits of the ctime nsec field to hold a
change counter).
--=20
Jeff Layton <jlayton@kernel.org>
