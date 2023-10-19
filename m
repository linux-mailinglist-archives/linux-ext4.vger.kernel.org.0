Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BC7CF6CD
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbjJSL3K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345364AbjJSL3I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 07:29:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449110C7;
        Thu, 19 Oct 2023 04:28:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A89C433C7;
        Thu, 19 Oct 2023 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697714932;
        bh=frnWz1sFRBQuYonb5RmQwPk5jf/lF7GP4WLN8JSXa7M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HBA7HSvGoIRn7e8pKkbEW9dLvkhR6UbP9YryXoyb0yOjeGBF3+t2/uXVAqhO8+5XZ
         g0zjGzFjnXF/LfXiIIdiO8O+s2WH1DbOU5PxZHMy5BGmXDF1pxMFXw5belLfcYtN7H
         99/gEqDLZv0OG5nrh2/sMZTcmW/PdfrhuOSXelnXPQnJC1BordF3CwVUQNbDT7FTNG
         nn177O3fNCLQE2ooDHVnWEyFQh2gHAsFOuYPrlz1K/YrfOpU/ht9vUd3N/Bwu8Bm8m
         10CRzoGlUcfNESgswU4BLKxSdAsGBM5bqEhUzQbS/iUBrFcZX0/oc11HUt7teGBqNa
         7K8NLvWb7IZrw==
Message-ID: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Thu, 19 Oct 2023 07:28:48 -0400
In-Reply-To: <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
         <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
         <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
         <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
         <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
         <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
         <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > Back to your earlier point though:
> >=20
> > Is a global offset really a non-starter? I can see about doing somethin=
g
> > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> > as ktime_get_coarse_ts64. I don't see the downside there for the non-
> > multigrain filesystems to call that.
>=20
> I have to say that this doesn't excite me. This whole thing feels a bit
> hackish. I think that a change version is the way more sane way to go.
>=20

What is it about this set that feels so much more hackish to you? Most
of this set is pretty similar to what we had to revert. Is it just the
timekeeper changes? Why do you feel those are a problem?

> >=20
> > On another note: maybe I need to put this behind a Kconfig option
> > initially too?
>=20
> So can we for a second consider not introducing fine-grained timestamps
> at all. We let NFSv3 live with the cache problem it's been living with
> forever.
>=20
> And for NFSv4 we actually do introduce a proper i_version for all
> filesystems that matter to it.
>=20
> What filesystems exactly don't expose a proper i_version and what does
> prevent them from adding one or fixing it?

Certainly we can drop this series altogether if that's the consensus.

The main exportable filesystem that doesn't have a suitable change
counter now is XFS. Fixing it will require an on-disk format change to
accommodate a new version counter that doesn't increment on atime
updates. This is something the XFS folks were specifically looking to
avoid, but maybe that's the simpler option.

There is also bcachefs which I don't think has a change attr yet. They'd
also likely need a on-disk format change, but hopefully that's a easier
thing to do there since it's a brand new filesystem.

There are a smattering of lesser-used local filesystems (f2fs, nilfs2,
etc.) that have no i_version support. Multigrain timestamps would make
it simple to add better change attribute support there, but they can (in
principle) all undergo an on-disk format change too if they decide to
add one.

Then there are filesystems like ntfs that are exportable, but where we
can't extend the on-disk format. Those could probably benefit from
multigrain timestamps, but those are much lower priority. Not many
people sharing their NTFS filesystem via NFS anyway.
--=20
Jeff Layton <jlayton@kernel.org>
