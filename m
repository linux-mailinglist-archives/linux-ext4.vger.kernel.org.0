Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9F654C27
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Dec 2022 06:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLWFIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Dec 2022 00:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLWFIi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Dec 2022 00:08:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737812AF2
        for <linux-ext4@vger.kernel.org>; Thu, 22 Dec 2022 21:08:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BN58Nt5028962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 00:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671772109; bh=Hxq17Aov0v/KEYVnWVgtHO8L2e6gITsXnqdXSO6e9Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AIZ/pxKeWK7zNWoPx661pcQl/feqj9NaMwe4olcs6TRUTkfTCtaEGNTPEgHY3ACft
         XHoSq85MAtEvHThQjXqKLvZE0yO2j4mUre1EHBxZajTidCDepZdaXx7Gfego2hMQKu
         J+ib/Igmd956kAD9AGoWLkpappJRKim5NcKK/n6jOROl1QvC9syCiZRu67osICsZUZ
         djYcMIcfb+ijnRGN7YEXfj+h+glvvlJO25NI5CfCDqkRuZRBrosPSr+OMpQ12PEXU6
         0/4u1jLXliMChxKvqgYWk/P3cXe67cB8uzmQ0RLFXkmAzKE2uywIYFkVBM5xFpDvz9
         YX8EeAiJ/MByA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BD14F15C39F2; Fri, 23 Dec 2022 00:08:23 -0500 (EST)
Date:   Fri, 23 Dec 2022 00:08:23 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix underflow in group bitmap calculation
Message-ID: <Y6U3x3Cs8Mzaakkx@mit.edu>
References: <20221222020244.1821308-1-jun.nie@linaro.org>
 <Y6SW5s/jFY1oWFe2@mit.edu>
 <Y6SdOzSr5CW5nQl/@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6SdOzSr5CW5nQl/@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 22, 2022 at 10:08:59AM -0800, Darrick J. Wong wrote:
> 
> Question -- on a 1k-block filesystem, are the first 1024 bytes of the
> device *reserved* by ext4 for whatever bootloader crud goes in there?
> Or is that space undefined in the filesystem specification?
> 
> I never did figure that out when I was writing the ondisk specification
> that's in the kernel, but maybe you remember?

That's an interesting (and philosophical) question.  The ext2 file
system never had a formal specification, and this part of the file
system format was devised by Remy Card before I had gotten involved
with ext2.  (I first got started writing e2fsprogs; which replaced the
previous file system utilities, which were forked from minix's tools,
and which were quite inefficient.)

In favor of it being undefined, the first 1024 bytes are not part of
any block group in an ext2 file system with a 1k block size.  (The
first block group is composed of physical blocks 1 through 8192
inclusive when the block size is 1k.  Whereas if the blocksize is 4k,
the first block group is composed of physical blocks 0 through 32767.)
In addition, the status of the first 1024 bytes is not controlled by
an ext2 block allocation bitmap.

One could also argue that to the extent that ext2 was derived the ext
file system, which in turn was derived from Minix --- and Minix File
System (which does have a specification, explicitly states that "block
0" is reserved for the Bootloader, with "Block 1" being the location
of the superblock.  But Minix only supports a 1k blocksize, and
doesn't have the concept of FFS-style block (cylinder) groups.

So I'd come down on the side which states that the first 1024 bytes
are "undefined" on a 1k block file system.

(One could also aruge that they are "undefined" on a 2k and 4k block
file system, but the first 1024 bytes are part of "block 0", and on 2k
and 4k block file systems, "block 0" is part of a block group.)

> If those first 1024 bytes are defined to be reserved in the ondisk
> format, then you could return a mapping for those bytes with the owner
> code set to EXT4_FMR_OWN_UNKNOWN.
> 
> If, however, the space is undefined, then going off this statement in
> the manpage:
> 
> "For example, if the low key (fsmap_head.fmh_keys[0]) is set to (8:0,
> 36864, 0, 0, 0), the filesystem  will  only  return  records for extents
> starting at or above 36 KiB on disk."
> 
> I think the 'at or above' clause means that ext4 should not pass back
> any mapping for the byte range 0-1023 on a 1k-block filesystem.

Sure, sounds good to me.

						- Ted
