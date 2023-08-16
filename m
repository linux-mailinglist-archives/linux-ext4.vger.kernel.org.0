Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5877E5AF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjHPPyC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbjHPPx5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 11:53:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FEDE52;
        Wed, 16 Aug 2023 08:53:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A23FC2189D;
        Wed, 16 Aug 2023 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692201234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cS0o+o2UXMYju9CQYo6U7MKGEYtjqVHUZjdZNl8z6Y8=;
        b=Pi5tCwC/LN8E7q8RbwOtlHWbBKanHKet9PKL6glbDDZQTTwiWugz9n4JGvPt9d3wP3pllG
        t7thtPjzOUF+h3IzB2Nmw0/SuDnDB7iMfhbajd/qaUXC0ZVhhgpwgSIPy+sCrWhEDIG2QK
        cDhZ7Cu1sDA3/8YoW9ZAF+44ZqBURFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692201234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cS0o+o2UXMYju9CQYo6U7MKGEYtjqVHUZjdZNl8z6Y8=;
        b=yFGTJ9XRtnvdvIxx9cZtkmOS4JGFDzvn9I9mqLL58LJXed0MNhzk6SGai59hWLgudFo/GW
        xcKt4TBLh2nV8BCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9345D133F2;
        Wed, 16 Aug 2023 15:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l4y0IxLx3GTTJQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 15:53:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0B444A0769; Wed, 16 Aug 2023 17:53:54 +0200 (CEST)
Date:   Wed, 16 Aug 2023 17:53:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ext2: fix race between setxattr and write back
Message-ID: <20230816155354.5dkicbptvrgcvnhy@quack3>
References: <20230815112612.221145-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815112612.221145-1-yebin10@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-08-23 19:26:08, Ye Bin wrote:
> Diff v2 vs v1:
> 1. Do not use reservation window when allocate block for xattr.
> 2. Remove BUG() in ext2_try_to_allocate_with_rsv().

Thanks! I did't a few smaller spelling fixups on commit but otherwise the
patches look good so I've added them to my tree.

								Honza

> 
> Ye Bin (4):
>   ext2: remove ext2_new_block()
>   ext2: introduce flag argument for ext2_new_blocks()
>   ext2: fix race between setxattr and write back
>   ext2: dump current reservation window info
> 
>  fs/ext2/balloc.c | 32 +++++++++++++++++---------------
>  fs/ext2/ext2.h   |  8 ++++++--
>  fs/ext2/inode.c  |  2 +-
>  fs/ext2/xattr.c  |  4 +++-
>  4 files changed, 27 insertions(+), 19 deletions(-)
> 
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
