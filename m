Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB90659186
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Dec 2022 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiL2Ua5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Dec 2022 15:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiL2Uao (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Dec 2022 15:30:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA214096;
        Thu, 29 Dec 2022 12:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CDD5B81915;
        Thu, 29 Dec 2022 20:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502CC433EF;
        Thu, 29 Dec 2022 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672345837;
        bh=0XooJ9mP9l4J/Pq38WJ2Fm3KDYSSG/D++B3s60OVmcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqKTBZPVOV8UWlTk9+gSb7VxZIa9+2CnWxn0kauBH6+Q/AqaPoTocgFGzoAIX+cE0
         S3jWIAE4yg9z6RYCiKzT2ESGWmGthYRNOrZMTXSyiT2nSwtA4e6bq+fMDvmMuadvGw
         ewrnKIRUbtgSSs6lE0H1+6PcO2oHQZLz6KYA9rIquUEW7uZFEFBsyIHsDYjOnHUt/A
         OZbD0otttU1EYogIk27WWczmq+ynIWDbPBTTwDerbwqYop8JvLCDeCTv2xIP7dAnw9
         bV6ciTVTnDm6GjzSqI5ExvrzoNLDUPV3JqQLG1pWtjvo3Jsf6XCjvrBDCELjx4H1V9
         iil1tj388JOlQ==
Date:   Thu, 29 Dec 2022 12:30:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lizhi Xu <lizhi.xu@windriver.com>
Cc:     mail@anirudhrb.com, adilger.kernel@dilger.ca, akpm@osdl.org,
        alex@clusterfs.com, gregkh@linuxfoundation.org,
        linux-ext4@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, shaggy@austin.ibm.com,
        syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com,
        tytso@mit.edu
Subject: Re: How can this fix prevent information from leaking to user space
 and prevent the kernel from crashing?
Message-ID: <Y63464YEo30Ga/US@sol.localdomain>
References: <20210506185655.7118-1-mail@anirudhrb.com>
 <20221226143119.3719096-1-lizhi.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226143119.3719096-1-lizhi.xu@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 26, 2022 at 10:31:19PM +0800, Lizhi Xu wrote:
> Hi, Anirudh Rayabharam
> 
> I verify this patch in the following environment, using reproducer: https://syzkaller.appspot.com/x/repro.c?x=122870ff800000
> 
> 1. kernel version:  kernel version 5.15.72 
> 2. gcc 11.3
> 3. libc 2.35
> 
> Because the kernel version 5.15.72 already contains this patch ce3aba43599f0b50adbebff133df8d08a3d5fffe, 
> So I deleted this patch to make a kernel image to reproduce the problem,
> On the other hand, I reserve this patch to verify that the problem has been fixed,
> The result of the experiment is that no matter whether this patch is applied or not, 
> this problem cannot be reproduced in kernel version 5.15.72.
> 
> In addition, I am also very confused. There are three places to initialize "eh_generation". 
> There is no other reference to the parameter "eh_generation" in all the source code of the kernel,
> At the same time, there is no indirect operation on the parameter "eh_generation" in reproducer,
> How can this fix prevent information from leaking to user space and prevent the kernel from crashing?
> 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 77c84d6f1af6..677d4821bcc1 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -825,6 +825,7 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
> >  	eh->eh_entries = 0;
> >  	eh->eh_magic = EXT4_EXT_MAGIC;
> >  	eh->eh_max = cpu_to_le16(ext4_ext_space_root(inode, 0));
> > +	eh->eh_generation = 0;
> >  	ext4_mark_inode_dirty(handle, inode);
> >  }
> >  
> > @@ -1090,6 +1091,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
> >  	neh->eh_max = cpu_to_le16(ext4_ext_space_block(inode, 0));
> >  	neh->eh_magic = EXT4_EXT_MAGIC;
> >  	neh->eh_depth = 0;
> > +	neh->eh_generation = 0;
> >  
> >  	/* move remainder of path[depth] to the new leaf */
> >  	if (unlikely(path[depth].p_hdr->eh_entries !=
> > @@ -1167,6 +1169,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
> >  		neh->eh_magic = EXT4_EXT_MAGIC;
> >  		neh->eh_max = cpu_to_le16(ext4_ext_space_block_idx(inode, 0));
> >  		neh->eh_depth = cpu_to_le16(depth - i);
> > +		neh->eh_generation = 0;
> >  		fidx = EXT_FIRST_INDEX(neh);
> >  		fidx->ei_block = border;
> >  		ext4_idx_store_pblock(fidx, oldblock);

The information leak was that uninitialized memory was being written to disk.

The way this bug was detected is with KMSAN.  If your kernel does not have KMSAN
enabled, the reproducer will not appear to do anything.  Note that KMSAN
requires Linux v6.1 or later and clang v14.0.6 or later.

- Eric
