Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA80589615
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiHDCUt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 22:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiHDCU1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 22:20:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7B60516;
        Wed,  3 Aug 2022 19:19:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2742J3na016498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Aug 2022 22:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659579547; bh=lVmWkYXsXLaJeU5oCXp8D4hgHPnxPp08OOK5NVVA8BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XWN5m8tYkC2nA1UxzytQihlUVBwjvBDEpIcooOKO6VwrvS9cl4n2TU/AR/nWUzNpe
         JooaQoMf7OSGFBQmocmaHh8SwLDb4ztft/yUJCBNPwtWTo6HL1/h/WWQhE/WR+Nk48
         ZeW5mOAsk22NstEWaLBGTfDtBBM+3a+b4Bqfk37aPx6FjmkpaX8MMhsPS8AhaqhVQ8
         oPivaVmdPD/bAe0YCFdgVUvgy8ei7TTBVFtA4P/SFNnMOGdxCpLXwJ/InG82QbyvMU
         tygBMvOySSphBY0uNe6n86xWmeXozgCREpsLITwSoH+nLlXTGD35g+gQcVKIoK1fpI
         Vl7KeIhe3QX+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A12F515C00E4; Wed,  3 Aug 2022 22:19:03 -0400 (EDT)
Date:   Wed, 3 Aug 2022 22:19:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Michael Wu <michael@allwinnertech.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: Re: [PATCH] ext4: fix error when itable blocks is greater than
 s_itb_per_group
Message-ID: <Yussl4uRWAAO3TtT@mit.edu>
References: <20220802021029.16046-1-michael@allwinnertech.com>
 <20220803071859.elywnni2yfol4bea@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803071859.elywnni2yfol4bea@fedora>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 03, 2022 at 09:18:59AM +0200, Lukas Czerner wrote:
> 
> Hi Michael,
> 
> mke2fs is making sure that we completely fill the inote table blocks.
> This is a corrupted image and so AFAICT ext4 is doing the right thing
> here. There does not seem to be a problem to fix, unless you can somehow
> trick mke2fs to make a file system like this.

Several years ago, android was shipping a bogus/busted
reimeplementation of mke2fs, reportedly because a certain founder of
Android (cough, Andy Rubin, cough) was alergic to the GPL.  ("The
problem with GPL in embedded systems [such as smartphones and tablets]
is that it's viral...")  This bogus reimplementation would create file
systems where the number of inodes per block group was a multiple of 4
instead of 8.  But, it was under the BSD license, so it was all good!   :-/

This bogus reimplementation of mkfs would, 50% of the time, create
busted file systems which couldn't be fixed, if they got corrupted, by
e2fsck.  This is because e2fsprogs' allocation bitmap code assumes
that you can back the bitarray into a single contiguous memory block
--- and this doesn't work if the number of inodes per block group is
not a multiple of 8.  If the file system got corrupted, the only
recourse was to wipe the user partition and the user would lose any
data that wasn't backed up to the cloud.

This has since been fixed for quite some time, but if there is some
low-end Android manufacturer is using an ancient version of AOSP, this
could be happening even in 2022 --- but that doesn't mean we need to
support such broken file systems.  As far as I'm concerned the only
way to make valid Android ext4 system images is the combination of
mke2fs and e2fsdroid, which is what modern versions of AOSP do.

    	       	     	     	    	     	- Ted
