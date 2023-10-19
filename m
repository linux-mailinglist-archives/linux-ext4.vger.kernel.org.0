Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22677CF410
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbjJSJ3Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 05:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344979AbjJSJ3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 05:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0298;
        Thu, 19 Oct 2023 02:29:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8202C433C8;
        Thu, 19 Oct 2023 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697707761;
        bh=pxF/qlOAYAx3vhRa3N2z4pQJEwL4Rx1j8JuRrkeWQ9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Akk8XbjDzYlsS3LMaveazcyIGPYT4DucacgiYEdLUsG9DE37MYww77gNzF8oD0aIz
         ivYs6S62MDqSkKZ2FSGs0EmDEo8tocNJK8foS47nkvwPPrwXEYbvlmNJREcl85jaSo
         W2BVMZYKsVeUTLgaD8Glg3bCDKmcsXMB4TQ+drVb8NJMw3lHm496br86KHTQZ/8Zyb
         g/RsWsns1nYNpbj9jPm/YNq9u/5F+tr6mqZODsyxp9EIv/pRppQ674gaTd+0b+V+Cj
         snsoxrWMyEcUDbEv+U6dRWrQlgFx/kgAx8uWCE3zgeH8LlxfATd2AlTC/m2t5XRPaa
         Uokex6cURRqGw==
Date:   Thu, 19 Oct 2023 11:29:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>,
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
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Back to your earlier point though:
> 
> Is a global offset really a non-starter? I can see about doing something
> per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> as ktime_get_coarse_ts64. I don't see the downside there for the non-
> multigrain filesystems to call that.

I have to say that this doesn't excite me. This whole thing feels a bit
hackish. I think that a change version is the way more sane way to go.

> 
> On another note: maybe I need to put this behind a Kconfig option
> initially too?

So can we for a second consider not introducing fine-grained timestamps
at all. We let NFSv3 live with the cache problem it's been living with
forever.

And for NFSv4 we actually do introduce a proper i_version for all
filesystems that matter to it.

What filesystems exactly don't expose a proper i_version and what does
prevent them from adding one or fixing it?
