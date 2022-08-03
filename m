Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CB5887A2
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiHCHAO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiHCHAK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 03:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3A092E688
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659510008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NxGTTQQ2iBxQY08ALTbVtdri71RwhzNW5j1WwpD7bnw=;
        b=R7+ucBk7vO99ywn3zSRPhBFh1fQPglLOGw0ZtgX3mXfI7wK1zf3vpLDNeKqsQrDqBKS3iB
        zLVVe0A9RH213ZNpyiObFQ8I4JQHbd7zmBSBDfobBZHg9Khu93u2M/1OSx3sqK45O+3xFE
        qcQwiwDxTMzGIcK6vRKHTYQm+P5nkRk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-qxDbqRMTOZSzwtp-RY6A1w-1; Wed, 03 Aug 2022 03:00:04 -0400
X-MC-Unique: qxDbqRMTOZSzwtp-RY6A1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CF2E380670A;
        Wed,  3 Aug 2022 07:00:04 +0000 (UTC)
Received: from fedora (unknown [10.40.192.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AE1E1121315;
        Wed,  3 Aug 2022 07:00:03 +0000 (UTC)
Date:   Wed, 3 Aug 2022 09:00:01 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't run ext4lazyinit for read-only filesystems
Message-ID: <20220803070001.iygdreewgveotfwx@fedora>
References: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 31, 2022 at 08:24:53PM -0700, Josh Triplett wrote:
> On a read-only filesystem, we won't invoke the block allocator, so we
> don't need to prefetch the block bitmaps.
> 
> This avoids starting and running the ext4lazyinit thread at all on a
> system with no read-write ext4 filesystems (for instance, a container VM
> with read-only filesystems underneath an overlayfs).
> 
> Fixes: 21175ca434c5 ("ext4: make prefetch_block_bitmaps default")
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---

Looks good to me.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Tested in a VM, with a read-only ext4 root filesystem. Confirmed that
> ext4lazyinit starts without this patch, and does not start with this
> patch.
> 
> (For a future merge window, not the current one. Please let me know if I
> need to re-send this at a later, more convenient time.)
> 
>  fs/ext4/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..20437acc8865 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3973,9 +3973,9 @@ int ext4_register_li_request(struct super_block *sb,
>  		goto out;
>  	}
>  
> -	if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
> -	    (first_not_zeroed == ngroups || sb_rdonly(sb) ||
> -	     !test_opt(sb, INIT_INODE_TABLE)))
> +	if (sb_rdonly(sb) ||
> +	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
> +	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
>  		goto out;
>  
>  	elr = ext4_li_request_new(sb, first_not_zeroed);
> -- 
> 2.36.1
> 

