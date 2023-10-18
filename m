Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223527CE95E
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 22:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJRUrq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjJRUrn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 16:47:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39705FE;
        Wed, 18 Oct 2023 13:47:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB2EC433C8;
        Wed, 18 Oct 2023 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697662060;
        bh=ur7fcft+INev6z8sCndtms845O1A1/aPF0TIAWbDkS0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fr/C19MvlG9QXl+vWS+SXplZgTRgBQJ3oLvKh1kARFT7tBHh79vH1tQShLD9PgLut
         yPZrIF6BgYRMGKSa+4ap23iDicA29QlHgzuc9wqzo0Nftd/kvOQdbsaY6bOG1qheYd
         Y9a+XBPDNkWWvKeE21tf85ThZM1Yvzaxd6qJkorN/EjBNO6hEAj1453J1cA1zPxRg8
         d73AoURNDxaS06VsO2r0Ebq1GKLSGcS8s+x9s7VDua0bPXIME2bPgCmGsdgY5GC1n0
         728Bvsyu5URh5eysAXOVYsTdp1fk/mIc49hpShHVLnYnU22T1HYUNgKffNe2HDOjRA
         oYHiZjfKG+3KQ==
Message-ID: <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Wed, 18 Oct 2023 16:47:37 -0400
In-Reply-To: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
         <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
         <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2023-10-18 at 12:18 -0700, Linus Torvalds wrote:
> On Wed, 18 Oct 2023 at 10:41, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > One way to prevent this is to ensure that when we stamp a file with a
> > fine-grained timestamp, that we use that value to establish a floor for
> > any later timestamp update.
>=20
> I'm very leery of this.
>=20
> I don't like how it's using a global time - and a global fine-grained
> offset - when different filesystems will very naturally have different
> granularities. I also don't like how it's no using that global lock.
>=20
> Yes, yes, since the use of this all is then gated by the 'is_mgtime()'
> thing, any filesystem with big granularities will presumably never set
> FS_MGTIME in the first time, and that hides the worst pointless cases.
> But it still feels iffy to me.
>=20

Thanks for taking a look!

I'm not too crazy about the global lock either, but the global fine
grained value ensures that when we have mtime changes that occur across
filesystems that they appear to be in the correct order.

We could (hypothetically) track an offset per superblock or something,
but then you could see out-of-order timestamps in inodes across
different filesystems (even of the same type). I think it'd better not
to do that if we can get away with it.


> Also, the whole current_ctime() logic seems wrong. Later (in 4/9), you do=
 this:
>=20
>  static struct timespec64 current_ctime(struct inode *inode)
>  {
>         if (is_mgtime(inode))
>                 return current_mgtime(inode);
>=20
> and current_mgtime() does
>=20
>         if (nsec & I_CTIME_QUERIED) {
>                 ktime_get_real_ts64(&now);
>                 return timestamp_truncate(now, inode);
>         }
>=20
> so once the code has set I_CTIME_QUERIED, it will now use the
> expensive fine-grained time - even when it makes no sense.
>=20
> As far as I can tell, there is *never* a reason to get the
> fine-grained time if the old inode ctime is already sufficiently far
> away.
>=20
> IOW, my gut feel is that all this logic should always not only be
> guarded by FS_MGTIME (like you do seem to do), *and* by "has anybody
> even queried this time" - it should *also* always be guarded by "if I
> get the coarse-grained time, is that sufficient?"
>=20
> So I think the current_ctime() logic should be something along the lines =
of
>=20
>     static struct timespec64 current_ctime(struct inode *inode)
>     {
>         struct timespec64 ts64 =3D current_time(inode);
>         unsigned long old_ctime_sec =3D inode->i_ctime_sec;
>         unsigned int old_ctime_nsec =3D inode->i_ctime_nsec;
>=20
>         if (ts64.tv_sec !=3D old_ctime_sec)
>                 return ts64;
>=20
>         /*
>          * No need to check is_mgtime(inode) - the I_CTIME_QUERIED
>          * flag is only set for mgtime filesystems
>          */
>         if (!(old_ctime_nsec & I_CTIME_QUERIED))
>                 return ts64;
>         old_ctime_nsec &=3D ~I_CTIME_QUERIED;
>         if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
>                 return ts64;
>=20

Does that really do what you expect here? current_time will return a
value that has already been through timestamp_truncate. Regardless, I
don't think this function makes as big a difference as you might think.

>
>         /* Ok, only *now* do we do a finegrained value */
>         ktime_get_real_ts64(&ts64);
>         return timestamp_truncate(ts64);
>     }
>=20
> or whatever. Make it *very* clear that the finegrained timestamp is
> the absolute last option, after we have checked that the regular one
> isn't possible.

current_mgtime is calling ktime_get_real_ts64, which is an existing
interface that does not take the global spinlock and won't advance the
global offset. That call should be quite cheap.

The reason we can use that call here is because current_ctime and
current_mgtime are only called from  inode_needs_update_time, which is
only called to check whether we need to get write access to the
inode.=A0What we do is look at the current clock and see whether the
timestamps would perceivably change if we were to do the update right
then.

If so, we get write access and then call inode_set_ctime_current(). That
will fetch its own timestamps and reevaluate what sort of update to do.
That's the only place that fetches an expensive fine-grained timestamp
that advances the offset.

So, I think this set already is only getting the expensive fine-grained
timestamps as a last resort.

This is probably an indicator that I need to document this code better
though. It may also be a good idea to reorganize
inode_needs_update_time, current_ctime and current_mgtime for better
clarity.

Many thanks for the comments!
--=20
Jeff Layton <jlayton@kernel.org>
