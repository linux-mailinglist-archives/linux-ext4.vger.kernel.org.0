Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D27D17AB
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJTVFK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTVFJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 17:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB7D60;
        Fri, 20 Oct 2023 14:05:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056BC433C7;
        Fri, 20 Oct 2023 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697835907;
        bh=Elxhk2Dpng0QYormybPqQvqGrljIJdvhIjHnQugf8Aw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CxRn5Wen+tHmFyOjC5cErUb4FjXC/5aXJGY8YCKssgsr8mHrQ6FS4MqWkmUwlKa6O
         njiflYbjExbJJ4hmFju1xJi01RSXH4oemQqyQNGsTjbV2jEbsCLpu0+CEzMhSS+kPH
         qLHZGbGZ8re9P6Mgpk/IcJ+27RzSwckdZHUhZxagACHPGeIYfBcWITdudsTDqALdUx
         t9SSVavuWrkfW5vhC/g9L5WemB+jWjWlxzfHH6aYJ2P8WmEgK7zAe1adYDuOtMOzR1
         XwX2fAnz3V3D2eIBCalnWQDUdtWsh4JzFqOf3ISEKtU+d7C9zwH90UOwNXGOhznsYN
         Cmm9MoAgXB2qA==
Message-ID: <301d4acd4dd208239c00cec196d1c26c6bcf1a91.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
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
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Fri, 20 Oct 2023 17:05:03 -0400
In-Reply-To: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
         <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
         <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
         <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
         <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
         <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
         <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
         <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
         <ZTGncMVw19QVJzI6@dread.disaster.area>
         <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
         <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
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

On Fri, 2023-10-20 at 13:06 -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 05:12, Jeff Layton <jlayton@kernel.org> wrote:.
> >=20
> > I'd _really_ like to see a proper change counter added before it's
> > merged, or at least space in the on-disk inode reserved for one until w=
e
> > can get it plumbed in.
>=20
> Hmm. Can we not perhaps just do an in-memory change counter, and try
> to initialize it to a random value when instantiating an inode? Do we
> even *require* on-disk format changes?
>=20
> So on reboot, the inode would count as "changed" as far any remote
> user is concerned. It would flush client caches, but isn't that what
> you'd want anyway? I'd hate to waste lots of memory, but maybe people
> would be ok with just a 32-bit random value. And if not...
>=20
> But I actually came into this whole discussion purely through the
> inode timestamp side, so I may *entirely* miss what the change counter
> requirements for NFSd actually are. If it needs to be stable across
> reboots, my idea is clearly complete garbage.
>=20
> You can now all jump on me and point out my severe intellectual
> limitations. Please use small words when you do ;)
>=20

Much like inode timestamps, we do depend on the change attribute
persisting across reboots. Having to invalidate all of your cached data
just because the server rebooted is particularly awful. That usually
results in the server being hammered with reads from all of the clients
at once, soon after rebooting.

--=20
Jeff Layton <jlayton@kernel.org>
