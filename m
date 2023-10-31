Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8C7DCE55
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Oct 2023 14:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344686AbjJaNzQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Oct 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbjJaNzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Oct 2023 09:55:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D377F9;
        Tue, 31 Oct 2023 06:55:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C6C433C8;
        Tue, 31 Oct 2023 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698760512;
        bh=qIx7b2aoxjsw7TSGPFkMkmmuPqzNI4IGu1YwuirwcKE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BlTYxX8bg/TyNm9k1G7hqu+6cgvScqLMmrYdwjXbvP2dLhoZwu81/Hd86RFZNrRU0
         1xr5Y7vFw1ElqKWf1uTmJEmuJvF5L9j3yFfh7ymcf50H/LGvdULGaZ9r81Rim15VMH
         4BUULsumVrnHeBwimSaTDD/NGbj2ueM3Eg/nxhkdFB1V+ajGM0vsdulmLTlFZNgwMn
         vt13jgmtUQuW2BcVFTQDAsGHT0Gmcoujtaha2sh9SXpVB++uDD9vrm6H7Cx6inillP
         sk1nXdn297tkqDQqx2pR+3iapmU6fN1aVLAWEUbQ/flcaA2j5xZmgzrdZMzAsb7osR
         s91m60OYKHeag==
Message-ID: <b0cd1f921c2c9d9e76cb324c6fa7c48747eafaed.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Tue, 31 Oct 2023 09:55:09 -0400
In-Reply-To: <20231031-stark-klar-0bab5f9ab4dc@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
         <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
         <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
         <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
         <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
         <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
         <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
         <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
         <20231031-stark-klar-0bab5f9ab4dc@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 2023-10-31 at 11:26 +0100, Christian Brauner wrote:
> On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> > On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > > Back to your earlier point though:
> > > >=20
> > > > Is a global offset really a non-starter? I can see about doing some=
thing
> > > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as c=
heap
> > > > as ktime_get_coarse_ts64. I don't see the downside there for the no=
n-
> > > > multigrain filesystems to call that.
> > >=20
> > > I have to say that this doesn't excite me. This whole thing feels a b=
it
> > > hackish. I think that a change version is the way more sane way to go=
.
> > >=20
> >=20
> > What is it about this set that feels so much more hackish to you? Most
> > of this set is pretty similar to what we had to revert. Is it just the
> > timekeeper changes? Why do you feel those are a problem?
>=20
> So I think that the multi-grain timestamp work was well intended but it
> was ultimately a mistake. Because we added code that complicated
> timestamp timestamp handling in the vfs to a point where the costs
> clearly outweighed the benefits.
>=20
> And I don't think that this direction is worth going into. This whole
> thread ultimately boils down to complicating generic infrastructure
> quite extensively for nfs to handle exposing xfs without forcing an
> on-disk format change. That's even fine.
>=20
> That's not a problem but in the same way I don't think the solution is
> just stuffing this complexity into the vfs. IOW, if we make this a vfs
> problem then at the lowest possible cost and not by changing how
> timestamps work for everyone even if it's just internal.

I'll point out that this last posting I did was an RFC. It was invasive
to the timekeeping code, but I don't think that's a hard requirement for
doing this.

I do appreciate the feedback on this version of the series (particularly
from Thomas who gave a great technical reason why this approach was
wrong), but I don't think we necessarily have to give up on the whole
idea because this particular implementation was too costly.

The core idea for fixing the problem with the original series is sane,
IMO. There is nothing wrong with simply making it that when we stamp a
file with a fine-grained timestamp that we consider that a floor for all
later timestamp updates. The only real question is how to keep that
(global) fine-grained floor offset at a low cost. I think that's a
solvable problem.

I also believe that real, measurable fine-grained timestamp differences
are worthwhile for other use cases beyond NFS. Everyone was pointing out
the problems with lagging timestamps vs. make and rsync, but that's a
double-edged sword. With the current always coarse-grained timestamps,
the ordering of files written within the same jiffy can't be determined
since their timestamps will be identical. We could conceivably change
that with this series.

That said, if this has no chance of ever being merged, then I won't
bother working on it further, and we can try to pursue something that is
(maybe) XFS-specific.

Let me know, either way.
--
Jeff Layton <jlayton@kernel.org>
