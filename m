Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC0779722
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHKSgM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHKSgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 14:36:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B530DC
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 11:36:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-65.bstnma.fios.verizon.net [173.48.112.65])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37BIZxcL019775
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 14:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691778961; bh=kLuDp+IG0Q1QVsHK+mpkpdcLU4KCYgoEk184V9qMsAQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=VwdMZmleJHVlOFZYvDQ7Vpr2xl5OY0xEVgD3xyyY/GDaS/hDTWofa53nWWZm5bJfe
         41PHGJjwN4r7fNR4vjBUgCod7Y0dq3191TJqT1qeXfNAkwdsBmAXcjhQAz0jMHpAbx
         FIR1lL+G0cCj7TrQwp4k3LKdY8mBDSH6CD9+nf8eNc2M6iUm7fVo6B++XAl6hVzBS6
         WqWTi2PR3BdoZg503PeUqbUWG/QfkwZ7x+WRpU18lM2Lloh/H3lel2wkzaxpTSPmCS
         7kpsxf/D6KLcA7TK73lGwsk9fLXT2V2K4bbpUJXwTKJ7RM8hZFiA1XFzb1+byrb3cj
         wZ/gu+T0B0suA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E511A15C04FF; Fri, 11 Aug 2023 14:35:58 -0400 (EDT)
Date:   Fri, 11 Aug 2023 14:35:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca, sihara@ddn.com,
        wangshilong1991@gmail.com
Subject: Re: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Message-ID: <20230811183558.GA1528742@mit.edu>
References: <20230811061905.301124-1-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811061905.301124-1-dongyangli@ddn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 11, 2023 at 04:19:04PM +1000, Li Dongyang wrote:
> Currently the flag indicating block group has done fstrim is not
> persistent, and trim status will be lost after remount, as
> a result fstrim can not skip the already trimmed groups, which
> could be slow on very large devices.
> 
> This patch introduces a new block group flag EXT4_BG_TRIMMED,
> we need 1 extra block group descriptor write after trimming each
> block group.
> When clearing the flag, the block group descriptor is journalled
> already so no extra overhead.

If we journalling is enabled (and it normally is enabled) then there
is also writes to the journalling.  Updating the block group
descriptor is also a random 4k write, which is not nothing.  So if we
are going to do this, then we should not try to set the flag if the
block group is unitialized, and we should actually send the discard in
that case, since presumably the blocks in question were discard when
the file system was mkfs'ed.

> Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
> we should honour EXT4_BG_TRIMMED when doing fstrim.
> The new super block flag can be turned on/off via tune2fs.

I don't see the point of having the superblock flag.  It seems to me
that either we should either do this via a proper feature flag, which
means that older kernels (and grub bootloaders that get release
updates at a super-lackadasical pace) won't touch file systems that
have the feature flag set --- or we don't have any kind of flag at
all, and kernels and userspace utilities which are EXT4_BG_TRIMMED
enlightened will honor and set/clear the flag.

This risk if we go down that path is that if we have a file system
which is normally used by a kernel that has support for this feature,
and that file system is mounted by an older kernel which doesn't have
this flag, there might be cases where the file system would be trimmed
without setting these flags, or blocks might get released on a block
group without clearing the flag.  Fortunately, trim is advisory, so if
we trim a block group that doesn't need it, or we don't trim a block
group where discard might be useful, it's not the end of the world.
And we could always have "e2fsck -E discard" ignore the
EXT4_BG_TRIMMED flag, and just trim all the blocks[1].

[1] https://photos.app.goo.gl/eVL9yHpjdXhjAnq88

						- Ted
