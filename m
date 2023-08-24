Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFF7878C2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 21:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbjHXTiK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbjHXThn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 15:37:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51671BEF
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 12:37:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AE3B227E9;
        Thu, 24 Aug 2023 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692905860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/fvniBqjGfIujOFwlI1nSAf7lwHS5+z7Bx9fYrFl0Q=;
        b=iDsKsJBbWnQ0MGmfctEDUXrMmj4tx+Z5kx9ziIEdddcAnErYOj8BaDcFSWP6yzo1lRXT6b
        Lc6a3GvQsB8GdYypM5vruT4Y22S8dLg7veUsuV2CKdc4DWWwdMVRhPZ0CbdXFrzZdomlQ5
        BzL2PuklPuwvvW8SJ7CzzfeiXK6ROPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692905860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/fvniBqjGfIujOFwlI1nSAf7lwHS5+z7Bx9fYrFl0Q=;
        b=Dr4phkn70y21ov8wWywWy9ZP7wq9Ek0Jfsui/SiATWNzSKLLtteNS0uTbeHAxfXCK7wYaR
        pXnDUEd6uDFC3BCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE261336F;
        Thu, 24 Aug 2023 19:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2pTjFoSx52RULQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 19:37:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D517EA0774; Thu, 24 Aug 2023 21:37:39 +0200 (CEST)
Date:   Thu, 24 Aug 2023 21:37:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Message-ID: <20230824193739.4k6kjsohbggoiu4n@quack3>
References: <20230817081828.934259-1-libaokun1@huawei.com>
 <20230823170524.xox66gceoqrigtyo@quack3>
 <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
 <20230824100804.l6dxfdztigdrw7m7@quack3>
 <b922a960-fc17-5595-17b3-06b8348f7fb1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b922a960-fc17-5595-17b3-06b8348f7fb1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 20:56:14, Baokun Li wrote:
> On 2023/8/24 18:08, Jan Kara wrote:
> > On Thu 24-08-23 10:27:46, Baokun Li wrote:
> > > Hello, Jan!
> > > 
> > > On 2023/8/24 1:05, Jan Kara wrote:
> > > > On Thu 17-08-23 16:18:28, Baokun Li wrote:
> > > > > After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
> > > > > inodes"), we load all the quotas before we process the orphaned inodes,
> > > > > and when we load the quotas, we check the checsum of the bbitmap for each
> > > > > group. If one of the bbitmap checksums is wrong, the following error will
> > > > > be reported:
> > > > > 
> > > > > “Error initializing quota context in support library:
> > > > >    Block bitmap checksum does not match bitmap”
> > > > > 
> > > > > But loading quotas comes before checking the current superblock for the
> > > > > EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
> > > > > image that contains orphan inodes and has the wrong bbitmap checksum.
> > > > > So delaying quota loading until after the EXT2_ERROR_FS judgment avoids
> > > > > the above problem.
> > > > > 
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > This certainly looks better but I wonder if there still isn't a problem if
> > > > the bitmap checksums are wrong but EXT2_ERROR_FS is not set. Shouldn't we
> > > > rather move the initialization of the quota files after the call to
> > > > e2fsck_read_bitmaps()?
> > > > 
> > > > 								Honza
> > > When the bitmap checksums are wrong but EXT2_ERROR_FS is not set, we must
> > > have lost some data (error flag or group descriptor or bitmap), so there
> > > is something wrong with the kernel at this time, so I don't think we
> > > should fix the image directly, but rather let the user realize that
> > > something is wrong with the filesystem logic.
> > I agree it means there is a problem somewhere (the storage, the kernel, or
> > similar). But just ignoring bitmap checksums in release_orphan_inodes() is
> > exactly how e2fsck behaves on filesystems without quota feature so I see no
> > reason for quota feature to change that because the inconsistency has
> > nothing to do with quotas...
> > 
> > > Moreover, if we don't care how this happened, but just want to fix the
> > > image, we only need to run "e2fsck -a" twice. After merging in the
> > > current patch, we always empty the orphan list before loading the quotas,
> > > and EXT2_ERROR_FS is set when loading the quotas fails, so this will be
> > > fixed the second time you run e2fsck. It will not happen that every
> > > e2fsck will fail like it did before.
> > I see, you're right so it isn't as bad as I originally thought but still my
> > argument above holds - IMO e2fsck should treat wrong bitmap checksums the
> > same way with and without the quota feature.
> > 
> > 								Honza
> The original flow that went wrong here is as follows：
> e2fsck
>  e2fsck_run_ext3_journal
>  check_super_block
>   release_orphan_inodes
>    e2fsck_read_all_quotas
>     quota_read_all_dquots
>      quota_file_open
>       ext2fs_read_bitmaps
>        ext2fs_rw_bitmaps
>         read_bitmaps_range
>          read_bitmaps_range_start
>           ext2fs_block_bitmap_csum_verify
>            !!! error
>  e2fsck_run
> 
> Yes, the inconsistency has nothing to do with quota, but quota is loaded
> here to keep track of space changes during the normal processing of
> orphan list. If quota was not loaded, we would not have read and check
> bitmaps until Pass5, and we had already done a lot of checking and
> tweaking of inodes, blocks, and dirs before Pass5, and the bitmaps
> inconsistency may have been fixed during that time.

This is not true. release_orphan_inodes() calls e2fsck_read_bitmaps() which
loads all the bitmaps while ignoring checksum failures. This is needed so
that blocks released during orphan cleanup are properly tracked as free.
All I want to do is to move the call to e2fsck_read_all_quotas() a bit
further than you moved it to a place after the e2fsck_read_bitmaps()
call...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
