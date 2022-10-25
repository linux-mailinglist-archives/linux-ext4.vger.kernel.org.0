Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E160C7E7
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJYJW6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiJYJW1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 05:22:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB424DA5;
        Tue, 25 Oct 2022 02:18:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88C971FB3E;
        Tue, 25 Oct 2022 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666689493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7waNe3CSSPB1VR39mFd8rV02OAJbyqSaHbIrUnnVO0=;
        b=CVU3wA+rYwqzVG8G5pEA0ZGjbmaAVkYGPNXDE8Z+67W9rmK4PIPV026Py1C3boc7oBKk5E
        WD+BayRGfagInHs12rUb87mjg6A0VFlV9dkifvmoUXOwiLK3dRzPhnPQTo5u9GzIYqo9lj
        p7dk+KpGgamACVs3tWVo7zBMCykFZjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666689493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7waNe3CSSPB1VR39mFd8rV02OAJbyqSaHbIrUnnVO0=;
        b=Fy+Mki2AYPUwHvkfONJaYdshxqmROYtyNPzPqQz22w3WbKyEzqhOSw5T7gN7qsLgohbxcw
        Wn/os/6FbAPkZ/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B12F134CA;
        Tue, 25 Oct 2022 09:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 96kCHtWpV2NeOwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Oct 2022 09:18:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14311A06F5; Tue, 25 Oct 2022 11:18:13 +0200 (CEST)
Date:   Tue, 25 Oct 2022 11:18:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: fix bug_on in __es_tree_search caused by
 wrong boot loader inode
Message-ID: <20221025091813.oo27uhwybvkd7mzc@quack3>
References: <20221021040731.4180649-1-libaokun1@huawei.com>
 <20221021040731.4180649-3-libaokun1@huawei.com>
 <20221024142527.avwgiztqvzmeo4se@quack3>
 <c29e93a7-d4c8-6126-2046-830f43d9adc6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29e93a7-d4c8-6126-2046-830f43d9adc6@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 25-10-22 10:26:14, Baokun Li wrote:
> On 2022/10/24 22:25, Jan Kara wrote:
> > On Fri 21-10-22 12:07:31, Baokun Li wrote:
> > > We got a issue as fllows:
> > > ...
> > > 
> > > In the above issue, ioctl invokes the swap_inode_boot_loader function to
> > > swap inode<5> and inode<12>. However, inode<5> contain incorrect imode and
> > > disordered extents, and i_nlink is set to 1. The extents check for inode in
> > > the ext4_iget function can be bypassed bacause 5 is EXT4_BOOT_LOADER_INO.
> > > While links_count is set to 1, the extents are not initialized in
> > > swap_inode_boot_loader. After the ioctl command is executed successfully,
> > > the extents are swapped to inode<12>, in this case, run the `cat` command
> > > to view inode<12>. And Bug_ON is triggered due to the incorrect extents.
> > > 
> > > When the boot loader inode is not initialized, its imode can be one of the
> > > following:
> > > 1) the imode is a bad type, which is marked as bad_inode in ext4_iget and
> > >     set to S_IFREG.
> > > 2) the imode is good type but not S_IFREG.
> > > 3) the imode is S_IFREG.
> > > 
> > > The BUG_ON may be triggered by bypassing the check in cases 1 and 2.
> > > Therefore, when the boot loader inode is bad_inode or its imode is not
> > > S_IFREG, initialize the inode to avoid triggering the BUG.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > Grepping for calls to ext4_iget() in the ext4 code shows there are many
> > more places that will get unhappy (and crash) when ext4_iget() returns a
> > bad inode. In fact, I didn't find a place when returning bad inode would be
> > useful for anything. So why don't we just return EFSCORRUPTED instead of
> > returning a bad inode?
> > 
> > 								Honza
> 
> Hello Honza,
> 
> In ext4_iget(), the inode is marked as bad and returned only when ino is
> equal to
> EXT4_BOOT_LOADER_INO. In the error branch bad_inode, although the inode is
> marked as bad, the returned value is the corresponding error number.
> The boot loader inode is not initialized during mkfs. Therefore, when
> ext4_iget() is
> entered for the first time, imode of the inode is bad type. However, the
> swap_inode_boot_loader() needs to obtain the inode for initialization and
> swap.
> Therefore, a bad_inode is returned in ext4_iget.
> 
> Generally, ext4_iget() does not get the boot loader inode. Therefore, we
> only need
> to pay attention to the special inodes that can be specified.
> The following figure shows the check result:
> 
> 1) usr_quota_inum/grp_quota_inum/prj_quota_inum
> These inodes may be faulty. In the first patch, this situation is
> intercepted.
> At the beginning, FUZZ found that the quota inode was faulty. Later, we
> found that
> the operation function swap_inode_boot_loader() related to inode 5 was also
> faulty.
> 
> 2) journal_inum
> In ext4_get_journal_inode(), the system checks whether the imode is S_IFREG.
> Then,
> the bmap in jbd2_journal_init_inode() checks whether the inode has
> a_ops->bmap
> operation. The bad inode does not set the bmap operation, so there is no
> problem.
> 
> 3) last_orphan
> In ext4_orphan_get(), it checks if the imode is normal and if the inode is
> bad inode,
> so there is no problem.
> 
> 4) snapshot_inum
> No place to use snapshot_inum was found in the kernel, so there is no kernel
> issue.

Thanks for detailed explanation! Now I agree you have actually covered all
the cases. But since EXT4_BOOT_LOADER_INO has this special behavior maybe
it would be more robust to create a special iget flag for it? Like
EXT4_IGET_BAD? And only with this flag we'd be returning bad inode from
ext4_iget(), otherwise we always return the error code?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
