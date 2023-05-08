Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE26FB857
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjEHUf2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 16:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEHUf1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 16:35:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0E9D
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 13:35:25 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.216] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 348KZHbO020025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 16:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683578119; bh=NcleiIM/pIJcJl2FICwVL7dtxLix3rEheNFsBQzEAy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CBtPeJy0p2DMMgqcApaiqKEy9+W8LX0g6oV3lv40IAPm0qdLOj/y5vce3UA9VX22k
         Pw3SfSaqokHSyO0X6mAAXfzSNR5a3El+U78a/s0lkf4Jw7C0ngKs/6ElId+75Asr+I
         OmqwGJYI0DXZLJIK99CSQvCabarO8fY72G0FkBu+io2VhK+fAJymrH6iFOh5v4Teq5
         g0l7XQPfWFDmI9iDd6n01p2P4pPveEBiKPwgQOxk6kexPNuNpmrUEXC/5W2NhLlMdk
         fwecHlznJ1dJfNE7zwKR52h007BJHf9qKtMA5OP2Dpf2HxOnkwCoeAXn06zAFWQsY5
         AR8NwzbNtmEzQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id D7F858C03B2; Mon,  8 May 2023 16:35:15 -0400 (EDT)
Date:   Mon, 8 May 2023 16:35:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] ext4: remove a BUG_ON in ext4_mb_release_group_pa()
Message-ID: <ZFldA72PlRBDOrRD@mit.edu>
References: <20230430154311.579720-1-tytso@mit.edu>
 <20230430154311.579720-3-tytso@mit.edu>
 <20230507182833.ma7fugevh7imz2tj@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507182833.ma7fugevh7imz2tj@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 07, 2023 at 08:28:33PM +0200, Jan Kara wrote:
> OK, looks good to me. But frankly there are many other interesting ways how
> bogus group numbers output when this happens can return is fun stuff - e.g.
> ext4_group_first_block_no() is going to return invalid blocks etc. So it
> feels a bit like endless whack-a-mole game. Anyway I agree the series seem
> to fix a big chunk of these sites so feel free to add:

The main thing I'm trying to avoid is a kernel crash or possible
out-of-bounds read or write, which could lead to a security
vulnerability.  If a a bad block number being returned by. say,
ext4_group_first_block_no() "only" results in an I/O error when or
(further) corruption of the block device, that's not a problem as far
as I'm concerned.  After all, if a malicious root access has
read/write access to the block device, they can corrupt the file
system *anyway*.

I wasn't able to find cases where a crazy return value from
ext4_group_first_block_no() which would cause a BUG or a buffer
overrun.  If we (or syzbot) finds a case where this could happen, we
could copy s_es->s_first_data_block to sbi->s_first_data_block and
then validate it during the file system mount.

I also did a quick spot check what nastiness could be caused by
real-time frobbing of s_blocks_count s_inodes_count and couldn't find
anything there either.  So it looks like s_first_data_block is the one
which is the most problematic.

Cheers,

						- Ted
