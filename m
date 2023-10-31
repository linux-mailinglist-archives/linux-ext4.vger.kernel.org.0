Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347517DCABD
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Oct 2023 11:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjJaK0u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Oct 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbjJaK0e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Oct 2023 06:26:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332EA9;
        Tue, 31 Oct 2023 03:26:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A722C433CD;
        Tue, 31 Oct 2023 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698747991;
        bh=oub4W8UR9eJvRxgd0x2K3FAODzLnOQX75kkj3Rb+xzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBQ79pKptpDj7180sdV3SpAcAZvHyawpezclc+dj2iFMxLVXbCbeH5YfqE4WcuoSQ
         /IEC+3qoroTC2lIkVBcGC1DX6llrEm61HMJO99f+TerLtsheVQsLE9AfPYgLhim3il
         BwxCV8atgTPe56WKD61JOc4sLVO6kH2+d24WzaTAZ7BS3WWrCrsQF+tGOsjU+AaLRA
         sYchDKCcENZca1LRCxGxYqUCuu6xVqJq2heeguzA/O1G/LaEcErOyMUJBqHuHm/NWG
         odXeR9D7iD7TDRylyP2HU+NvC56rx+jfWJiWfYSK0levv1XvEdMBDZqRx+QV8N29Ze
         bO3o0pYhWGntQ==
Date:   Tue, 31 Oct 2023 11:26:22 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
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
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <20231031-stark-klar-0bab5f9ab4dc@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > Back to your earlier point though:
> > > 
> > > Is a global offset really a non-starter? I can see about doing something
> > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> > > as ktime_get_coarse_ts64. I don't see the downside there for the non-
> > > multigrain filesystems to call that.
> > 
> > I have to say that this doesn't excite me. This whole thing feels a bit
> > hackish. I think that a change version is the way more sane way to go.
> > 
> 
> What is it about this set that feels so much more hackish to you? Most
> of this set is pretty similar to what we had to revert. Is it just the
> timekeeper changes? Why do you feel those are a problem?

So I think that the multi-grain timestamp work was well intended but it
was ultimately a mistake. Because we added code that complicated
timestamp timestamp handling in the vfs to a point where the costs
clearly outweighed the benefits.

And I don't think that this direction is worth going into. This whole
thread ultimately boils down to complicating generic infrastructure
quite extensively for nfs to handle exposing xfs without forcing an
on-disk format change. That's even fine.

That's not a problem but in the same way I don't think the solution is
just stuffing this complexity into the vfs. IOW, if we make this a vfs
problem then at the lowest possible cost and not by changing how
timestamps work for everyone even if it's just internal.
