Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824307DD922
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbjJaXMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Oct 2023 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345439AbjJaXMy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Oct 2023 19:12:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392DB9;
        Tue, 31 Oct 2023 16:12:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F876C433C7;
        Tue, 31 Oct 2023 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698793971;
        bh=HUHN15gYL1zUQAZ/9kbQyYuReBV1adG4NcrFQI5O1EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWVsN5tO54rx3f5rm/2Q31gDwhbSjKfQC6V5qBLtEVr4Rwpj7I7yMkvepTMR/lTtT
         VZqTAW/Ni44oDy4DxIjDO6jVJnB3XhJ1iXh/jS/mwEM6mkBwXfzeYhmhhzk0O3GH1C
         FpD5ET6CpsJs564xQRPuK4enmdSn0K5L9FR73kX/HjPNJDmk0zU7wpeb5rhu5lYajK
         tqce7Z3t64Zk3H+3LHPpkEK22xLM57Jc8HFHfmu9721nBL0Xsq/svRRP9VsvB3XdNt
         WDyDN0dl8KXCOPtrduLbhpDz2EwAI3OEgEsUZRP0GYvAfodXBg89A0KEIH+Eygdi1J
         T4yRHuxrW0+lQ==
Date:   Tue, 31 Oct 2023 16:12:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
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
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <20231031231250.GA1205221@frogsfrogsfrogs>
References: <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 31, 2023 at 09:03:57AM +0200, Amir Goldstein wrote:
> On Tue, Oct 31, 2023 at 3:42 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> [...]
> > .... and what is annoying is that that the new i_version just a
> > glorified ctime change counter. What we should be fixing is ctime -
> > integrating this change counting into ctime would allow us to make
> > i_version go away entirely. i.e. We don't need a persistent ctime
> > change counter if the ctime has sufficient resolution or persistent
> > encoding that it does not need an external persistent change
> > counter.
> >
> > That was reasoning behind the multi-grain timestamps. While the mgts
> > implementation was flawed, the reasoning behind it certainly isn't.
> > We should be trying to get rid of i_version by integrating it into
> > ctime updates, not arguing how atime vs i_version should work.
> >
> > > So I don't think the issue here is "i_version" per se. I think in a
> > > vacuum, the best option of i_version is pretty obvious.  But if you
> > > want i_version to track di_changecount, *then* you end up with that
> > > situation where the persistence of atime matters, and i_version needs
> > > to update whenever a (persistent) atime update happens.
> >
> > Yet I don't want i_version to track di_changecount.
> >
> > I want to *stop supporting i_version altogether* in XFS.
> >
> > I want i_version as filesystem internal metadata to die completely.
> >
> > I don't want to change the on disk format to add a new i_version
> > field because we'll be straight back in this same siutation when the
> > next i_version bug is found and semantics get changed yet again.
> >
> > Hence if we can encode the necessary change attributes into ctime,
> > we can drop VFS i_version support altogether.  Then the "atime bumps
> > i_version" problem also goes away because then we *don't use
> > i_version*.
> >
> > But if we can't get the VFS to do this with ctime, at least we have
> > the abstractions available to us (i.e. timestamp granularity and
> > statx change cookie) to allow XFS to implement this sort of
> > ctime-with-integrated-change-counter internally to the filesystem
> > and be able to drop i_version support....
> >
> 
> I don't know if it was mentioned before in one of the many threads,
> but there is another benefit of ctime-with-integrated-change-counter
> approach - it is the ability to extend the solution with some adaptations
> also to mtime.
> 
> The "change cookie" is used to know if inode metadata cache should
> be invalidated and mtime is often used to know if data cache should
> be invalidated, or if data comparison could be skipped (e.g. rsync).
> 
> The difference is that mtime can be set by user, so using lower nsec
> bits for modification counter would require to truncate the user set
> time granularity to 100ns - that is probably acceptable, but only as
> an opt-in behavior.
> 
> The special value 0 for mtime-change-counter could be reserved for
> mtime that was set by the user or for upgrade of existing inode,
> where 0 counter means that mtime cannot be trusted as an accurate
> data modification-cookie.

What about write faults on an mmap region?  The first ro->rw transition
results in an mtime update, but not again until the page gets cleaned.

> This feature is going to be useful for the vfs HSM implementation [1]
> that I am working on and it actually rhymes with the XFS DMAPI
> patches that were never fully merged upstream.

Kudos, I cannot figure out a non-pejorative word that rhymes with
"**API". ;)

--D

> Speaking on behalf of my employer, we would love to see the data
> modification-cookie feature implemented, whether in vfs or in xfs.
> 
> *IF* the result on this thread is that the chosen solution is
> ctime-with-change-counter in XFS
> *AND* if there is agreement among XFS developers to extend it with
> an opt-in mkfs/mount option to 100ns-mtime-with-change-counter in XFS
> *THEN* I think I will be able to allocate resources to drive this xfs work.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API
> 
