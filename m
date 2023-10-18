Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0D7CEA47
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 23:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjJRVwu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRVwt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 17:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541A98;
        Wed, 18 Oct 2023 14:52:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1335C433C7;
        Wed, 18 Oct 2023 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697665967;
        bh=TvWB9COV3obY2cRmOb+aflk7pQdFiGa+OAaSrwETeEg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o6Q0dDst3pq/rMdgcEn29wGOr+tB/JTAgagUCnU56jV7OWRmJc2hkL3p9bHJkpAk5
         bBi0Z6MGrjmsLyeAMt2TCWzNkWQmkZanzskokbXQ4JY1Hek5WHmBttXyjyTwnJrQvQ
         BF5sIw6EON3aFSB+xQ+qbTxzcUZ0IR5ZVw5Vx+/YxRH0ZTZgBdtkm6sh/qjWIdz7AP
         6tOdFsB64ry67vRYl2pUxG6vDUpPUIm2wMinWfSYg/1MigQVuYNI0W7C6ZPBBjUAS0
         1j0o76eqA7TBI8aa+lP7BHgSNwMRRzxrphVbke3vh7niZzVFyi874ON8uDsDkVKwiP
         P1a4eT4ra12zA==
Message-ID: <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
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
Date:   Wed, 18 Oct 2023 17:52:43 -0400
In-Reply-To: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
         <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
         <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
         <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
         <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
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

On Wed, 2023-10-18 at 14:31 -0700, Linus Torvalds wrote:
> On Wed, 18 Oct 2023 at 13:47, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > >         old_ctime_nsec &=3D ~I_CTIME_QUERIED;
> > >         if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
> > >                 return ts64;
> > >=20
> >=20
> > Does that really do what you expect here? current_time will return a
> > value that has already been through timestamp_truncate.
>=20
> Yeah, you're right.
>=20
> I think you can actually remove the s_time_gran addition. Both the
> old_ctime_nsec and the current ts64,tv_nsec are already rounded, so
> just doing
>=20
>         if (ts64.tv_nsec > old_ctime_nsec)
>                 return ts64;
>=20
> would already guarantee that it's different enough.
>=20

Yep, and that's basically what inode_set_ctime_current does (though it
does a timespec64 comparison).

> > current_mgtime is calling ktime_get_real_ts64, which is an existing
> > interface that does not take the global spinlock and won't advance the
> > global offset. That call should be quite cheap.
>=20
> Ahh, I did indeed mis-read that as the new one with the lock.
>=20
> I did react to the fact that is_mgtime(inode) itself is horribly
> expensive if it's not cached (following three quite possibly cold
> pointers), which was part of that whole "look at I_CTIME_QUERIED
> instead".
>
> I see the pointer chasing as a huge VFS timesink in all my profiles,
> although usually it's the disgusting security pointer (because selinux
> creates separate security nodes for each inode, even when the contents
> are often identical). So I'm a bit sensitive to "follow several
> pointers from 'struct inode'" patterns from looking at too many
> instruction profiles.

That's a very good point. I'll see if I can get rid of that (and maybe
some other mgtime flag checks) before I send the next version.=20

Back to your earlier point though:

Is a global offset really a non-starter? I can see about doing something
per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
as ktime_get_coarse_ts64. I don't see the downside there for the non-
multigrain filesystems to call that.

On another note: maybe I need to put this behind a Kconfig option
initially too?
--=20
Jeff Layton <jlayton@kernel.org>
