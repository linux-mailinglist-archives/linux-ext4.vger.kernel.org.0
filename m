Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DA7D5AC5
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjJXSkN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Oct 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJXSkM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Oct 2023 14:40:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C89F;
        Tue, 24 Oct 2023 11:40:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1AC433C7;
        Tue, 24 Oct 2023 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698172810;
        bh=Xe0wF7mgvmZCFWwP7fcGH+Eub1oED/IAnnGG5PkQ1xU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aR5dfj2B+9L9WTja+3SyJ8WB9QMgZo4R+vxoFDhQoAUL1rtUOh+Oh5Q8DQmdfVTO4
         yGp5tE/69QdXH5HxMqJHG7wcibIkHLtTyOezwvPMxpAm86wk65poIE/uewxy/Ie6v3
         hSHpwvYzQ6e9UEWsvO3SaWQYijZfMxf09CUdubjLB4ttXC80RueJZB863KJ470NSzB
         NMRpUvxtODKii5ufHHS1e4VgM9qMeTvQltU7KO0D7dMhAnpxAiASNlUi/neKfJiDK+
         xe5dn9XSPdXwMQCwnpFDi/Iua7ZyggSyeH4EgK4Vnte8CUNiPzFVJE4c5FjHvkEK1O
         cyliPAfxW2aoA==
Message-ID: <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Tue, 24 Oct 2023 14:40:06 -0400
In-Reply-To: <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
         <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
         <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
         <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
         <ZTGncMVw19QVJzI6@dread.disaster.area>
         <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
         <ZTWfX3CqPy9yCddQ@dread.disaster.area>
         <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
         <ZTcBI2xaZz1GdMjX@dread.disaster.area>
         <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
         <ZTc8tClCRkfX3kD7@dread.disaster.area>
         <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromorbit.com=
> wrote:
> >=20
> > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrot=
e:
> > > >=20
> > > > The problem is the first read request after a modification has been
> > > > made. That is causing relatime to see mtime > atime and triggering
> > > > an atime update. XFS sees this, does an atime update, and in
> > > > committing that persistent inode metadata update, it calls
> > > > inode_maybe_inc_iversion(force =3D false) to check if an iversion
> > > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bump=
s
> > > > i_version and tells XFS to persist it.
> > >=20
> > > Could we perhaps just have a mode where we don't increment i_version
> > > for just atime updates?
> > >=20
> > > Maybe we don't even need a mode, and could just decide that atime
> > > updates aren't i_version updates at all?
> >=20
> > We do that already - in memory atime updates don't bump i_version at
> > all. The issue is the rare persistent atime update requests that
> > still happen - they are the ones that trigger an i_version bump on
> > XFS, and one of the relatime heuristics tickle this specific issue.
> >=20
> > If we push the problematic persistent atime updates to be in-memory
> > updates only, then the whole problem with i_version goes away....
> >=20
> > > Yes, yes, it's obviously technically a "inode modification", but does
> > > anybody actually *want* atime updates with no actual other changes to
> > > be version events?
> >=20
> > Well, yes, there was. That's why we defined i_version in the on disk
> > format this way well over a decade ago. It was part of some deep
> > dark magical HSM beans that allowed the application to combine
> > multiple scans for different inode metadata changes into a single
> > pass. atime changes was one of the things it needed to know about
> > for tiering and space scavenging purposes....
> >=20
>=20
> But if this is such an ancient mystical program, why do we have to
> keep this XFS behavior in the present?
> BTW, is this the same HSM whose DMAPI ioctls were deprecated
> a few years back?
>=20
> I mean, I understand that you do not want to change the behavior of
> i_version update without an opt-in config or mount option - let the distr=
o
> make that choice.
> But calling this an "on-disk format change" is a very long stretch.
>=20
> Does xfs_repair guarantee that changes of atime, or any inode changes
> for that matter, update i_version? No, it does not.
> So IMO, "atime does not update i_version" is not an "on-disk format chang=
e",
> it is a runtime behavior change, just like lazytime is.
>=20

This would certainly be my preference. I don't want to break any
existing users though.

Perhaps this ought to be a mkfs option? Existing XFS filesystems could
still behave with the legacy behavior, but we could make mkfs.xfs build
filesystems by default that work like NFS requires.

--=20
Jeff Layton <jlayton@kernel.org>
