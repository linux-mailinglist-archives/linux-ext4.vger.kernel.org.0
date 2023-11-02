Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A37DEFC0
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjKBKSD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346318AbjKBKSC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 06:18:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A31128;
        Thu,  2 Nov 2023 03:17:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42655C433C8;
        Thu,  2 Nov 2023 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698920276;
        bh=bpWiJO3vrZtaIhf4lJAzkNfBmBiB4Rlew74U352mP2c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GPzXf+02TCcU8r7ah904XYsjziscTwo8ubIMx0FnRpAc0grUJB/LjtGbUvypwzPWH
         z2YGVH+Ieghb7Zv8phNGcsZo29LVQp/tUIkwbgrRts8XVe0VPs8Ln/n+1DqHBiDgCQ
         GkeZKPYeW1hxdR7F51croDYL7gTK40NJo0vo/TjFs4zUFq9SPFfx9nCBsUz54pqcFZ
         IjmMGHHIGM9YLTJ+Qmd5jyiQrDbf69piUW4JCbvNhBWw6UUr7YnzF3c1T2MkcWYMWf
         AVnlg5GKxgAMrRf7y9VnmNDhbKnB7WDGuraRJr0U3ut39E/oV6N8iyoCLIDPbeuhqL
         FKjqFi4uhzMCg==
Message-ID: <3ec97baef1ebbbd7ace97a7d7023bf3f36e1cbc7.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Thu, 02 Nov 2023 06:17:53 -0400
In-Reply-To: <CAOQ4uxgGxtErFEcSdxoFDnZZ1XfmVKn2LT1dQcJqhNj5_rnC6A@mail.gmail.com>
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
         <CAOQ4uxgGxtErFEcSdxoFDnZZ1XfmVKn2LT1dQcJqhNj5_rnC6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 2023-11-01 at 13:38 +0200, Amir Goldstein wrote:
> On Wed, Nov 1, 2023 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >=20
> > On Wed 01-11-23 08:57:09, Dave Chinner wrote:
> > > 5. When-ever the inode is persisted, the timestamp is copied to the
> > > on-disk structure and the current change counter is folded in.
> > >=20
> > >       This means the on-disk structure always contains the latest
> > >       change attribute that has been persisted, just like we
> > >       currently do with i_version now.
> > >=20
> > > 6. When-ever we read the inode off disk, we split the change counter
> > > from the timestamp and update the appropriate internal structures
> > > with this information.
> > >=20
> > >       This ensures that the VFS and userspace never see the change
> > >       counter implementation in the inode timestamps.
> >=20
> > OK, but is this compatible with the current XFS behavior? AFAICS curren=
tly
> > XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk wi=
ll
> > have some mostly random garbage in low bits of the ctime. Now if you lo=
ok
> > at such inode with a kernel using this new scheme, stat(2) will report
> > ctime with low bits zeroed-out so if the ctime fetched in the old kerne=
l was
> > stored in some external database and compared to the newly fetched ctim=
e, it
> > will appear that ctime has gone backwards... Maybe we don't care but it=
 is
> > a user visible change that can potentially confuse something.
>=20
> See xfs_inode_has_bigtime() and auto-upgrade of inode format in
> xfs_inode_item_precommit().
>=20
> In the case of BIGTIME inode format, admin needs to opt-in to
> BIGTIME format conversion by setting an INCOMPAT_BIGTIME
> sb feature flag.
>=20
> I imagine that something similar (inode flag + sb flag) would need
> to be done for the versioned-timestamp, but I think that in that case,
> the feature flag could be RO_COMPAT - there is no harm in exposing
> made-up nsec lower bits if fs would be mounted read-only on an old
> kernel, is there?
>=20
> The same RO_COMPAT feature flag could also be used to determine
> s_time_gran, because IIUC, s_time_gran for timestamp updates
> is uniform across all inodes.
>=20
> I know that Dave said he wants to avoid changing on-disk format,
> but I am hoping that this well defined and backward compat with
> lazy upgrade, on-disk format change may be acceptable?


With the ctime, we're somewhat saved by the fact that it's not settable
by users, so we don't need to worry as much about returning specific
values there, I think.

With the scheme Dave is proposing, booting to a new kernel vs. an old
kernel might show a different ctime on an inode though. That might be
enough to justify needing a way to opt-in to the change on existing
filesystems.
--=20
Jeff Layton <jlayton@kernel.org>
