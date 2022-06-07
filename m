Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B526540134
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiFGOXD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiFGOXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 10:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 370875A091
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654611776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSh728YDbuNUTuFkh2C7CYWOGQbjnMx31K0uaAlgZTA=;
        b=Wk6Uv41QKyCa1Nh+EUfxnDKxd0So6MlJQ46TuU9y+3DAPjDEuNBvyFX4TSc0cziuIA3JHw
        p6wkm+tBC8yL5KOKwrwe/VKXBN/z61UnLjGSfjKfCVp+UG7ZNO0tC6Jbj8U1ICQbomG8K8
        YhGQ2zDoQdHCY4SsS0GPAe02uYxeKak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-H1sjooPQMg-ZV6jm-WVIAg-1; Tue, 07 Jun 2022 10:22:52 -0400
X-MC-Unique: H1sjooPQMg-ZV6jm-WVIAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F1A9801756;
        Tue,  7 Jun 2022 14:22:52 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 060FC1415100;
        Tue,  7 Jun 2022 14:22:50 +0000 (UTC)
Date:   Tue, 7 Jun 2022 16:22:48 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 7/7] libext2fs: check for invalid blocks in
 ext2fs_punch_blocks()
Message-ID: <20220607142248.3zp564uieel5zjrb@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-8-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-8-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


Thanks!
-Lukas

On Tue, Jun 07, 2022 at 12:24:44AM -0400, Theodore Ts'o wrote:
> If the extent tree has out-of-range physical block numbers, don't try
> to release them.
> 
> Also add a similar check in ext2fs_block_alloc_stats2() to avoid a
> NULL pointer dereference.
> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  lib/ext2fs/alloc_stats.c | 3 ++-
>  lib/ext2fs/punch.c       | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
> index 3949f618..6f98bcc7 100644
> --- a/lib/ext2fs/alloc_stats.c
> +++ b/lib/ext2fs/alloc_stats.c
> @@ -62,7 +62,8 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
>  {
>  	int	group = ext2fs_group_of_blk2(fs, blk);
>  
> -	if (blk >= ext2fs_blocks_count(fs->super)) {
> +	if (blk < fs->super->s_first_data_block ||
> +	    blk >= ext2fs_blocks_count(fs->super)) {
>  #ifndef OMIT_COM_ERR
>  		com_err("ext2fs_block_alloc_stats", 0,
>  			"Illegal block number: %lu", (unsigned long) blk);
> diff --git a/lib/ext2fs/punch.c b/lib/ext2fs/punch.c
> index effa1e2d..e2543e1e 100644
> --- a/lib/ext2fs/punch.c
> +++ b/lib/ext2fs/punch.c
> @@ -200,6 +200,10 @@ static errcode_t punch_extent_blocks(ext2_filsys fs, ext2_ino_t ino,
>  	__u32		cluster_freed;
>  	errcode_t	retval = 0;
>  
> +	if (free_start < fs->super->s_first_data_block ||
> +	    (free_start + free_count) >= ext2fs_blocks_count(fs->super))
> +		return EXT2_ET_BAD_BLOCK_NUM;
> +
>  	/* No bigalloc?  Just free each block. */
>  	if (EXT2FS_CLUSTER_RATIO(fs) == 1) {
>  		*freed += free_count;
> -- 
> 2.31.0
> 

