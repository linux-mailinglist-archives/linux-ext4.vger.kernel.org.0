Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E786C91
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjHXKIe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjHXKII (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 06:08:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C61984
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 03:08:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4755420F98;
        Thu, 24 Aug 2023 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692871685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2hFi7a2fvg2qdV/WAYgBSI1VPSewNOy6oxlUzA6V5Q=;
        b=Elg8YPdnNCB+IHDeVJAXID4oSRjsJLT5VTpCOGgY+k9PyTDFFqN9gsfBsSecJOJVAh7SAM
        w3FDMswVEe85/9jIwc5akFCxRZwgOHrQ4z2JXjq8pRFBrgvriVHlvvK3uNfrlv7CC7Y8uo
        LBpwVW0oDQqaGUQ+D8408L8aodD3N2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692871685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2hFi7a2fvg2qdV/WAYgBSI1VPSewNOy6oxlUzA6V5Q=;
        b=NewX7boBwHDgk0KLw1t6V6AW1knAaoO3D++ujAG/OGcDQFB45QntKpwYcwfbejKurTLL7a
        bp49ucKgYbOE4tBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39CB2132F2;
        Thu, 24 Aug 2023 10:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tHQVDgUs52RSLAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 10:08:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC95DA0774; Thu, 24 Aug 2023 12:08:04 +0200 (CEST)
Date:   Thu, 24 Aug 2023 12:08:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Message-ID: <20230824100804.l6dxfdztigdrw7m7@quack3>
References: <20230817081828.934259-1-libaokun1@huawei.com>
 <20230823170524.xox66gceoqrigtyo@quack3>
 <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 10:27:46, Baokun Li wrote:
> Hello, Jan!
> 
> On 2023/8/24 1:05, Jan Kara wrote:
> > On Thu 17-08-23 16:18:28, Baokun Li wrote:
> > > After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
> > > inodes"), we load all the quotas before we process the orphaned inodes,
> > > and when we load the quotas, we check the checsum of the bbitmap for each
> > > group. If one of the bbitmap checksums is wrong, the following error will
> > > be reported:
> > > 
> > > “Error initializing quota context in support library:
> > >   Block bitmap checksum does not match bitmap”
> > > 
> > > But loading quotas comes before checking the current superblock for the
> > > EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
> > > image that contains orphan inodes and has the wrong bbitmap checksum.
> > > So delaying quota loading until after the EXT2_ERROR_FS judgment avoids
> > > the above problem.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > This certainly looks better but I wonder if there still isn't a problem if
> > the bitmap checksums are wrong but EXT2_ERROR_FS is not set. Shouldn't we
> > rather move the initialization of the quota files after the call to
> > e2fsck_read_bitmaps()?
> > 
> > 								Honza
> When the bitmap checksums are wrong but EXT2_ERROR_FS is not set, we must
> have lost some data (error flag or group descriptor or bitmap), so there
> is something wrong with the kernel at this time, so I don't think we
> should fix the image directly, but rather let the user realize that
> something is wrong with the filesystem logic.

I agree it means there is a problem somewhere (the storage, the kernel, or
similar). But just ignoring bitmap checksums in release_orphan_inodes() is
exactly how e2fsck behaves on filesystems without quota feature so I see no
reason for quota feature to change that because the inconsistency has
nothing to do with quotas...

> Moreover, if we don't care how this happened, but just want to fix the
> image, we only need to run "e2fsck -a" twice. After merging in the
> current patch, we always empty the orphan list before loading the quotas,
> and EXT2_ERROR_FS is set when loading the quotas fails, so this will be
> fixed the second time you run e2fsck. It will not happen that every
> e2fsck will fail like it did before.

I see, you're right so it isn't as bad as I originally thought but still my
argument above holds - IMO e2fsck should treat wrong bitmap checksums the
same way with and without the quota feature.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
