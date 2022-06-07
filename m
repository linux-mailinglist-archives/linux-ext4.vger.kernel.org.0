Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E154007B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiFGNxu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiFGNxs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 09:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDA25522C2
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654610027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQT7KGwAU25Ad9v8Kqv5iuM8NDkxHOXTSGURLpCbcqc=;
        b=jNflrky5bk1I5JX9tIkKgs1I1vPiB6TT4zt7rVk5BUGGDbZO2++H+t9z9BoVLrzd3YCpiX
        prmMqxrxjuusjIkipGeTeisXvrYTSx3TtQjtyWjLWGzEOaPN3uLfXnP/a7deMhd8UY7TgA
        x91MR35SYyo5SsgvAnuXO6ZagLhV37k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-heREq18nP8CpVPYzu1JahA-1; Tue, 07 Jun 2022 09:53:43 -0400
X-MC-Unique: heREq18nP8CpVPYzu1JahA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75A3329ABA04;
        Tue,  7 Jun 2022 13:53:43 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8330DC28101;
        Tue,  7 Jun 2022 13:53:42 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:53:40 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 5/7] e2fsck: avoid out-of-bounds write for very deep
 extent trees
Message-ID: <20220607135340.lv2k26ggillb2ixi@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-6-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-6-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 07, 2022 at 12:24:42AM -0400, Theodore Ts'o wrote:
> The kernel doesn't support extent trees deeper than 5
> (EXT4_MAX_EXTENT_DEPTH).  For this reason we only maintain the extent
> tree statistics for 5 levels.  Avoid out-of-bounds writes and reads if
> the extent tree is deeper than this.
> 
> We keep these statistics to determine whether we should rebuild the
> extent tree.  If the extent tree is too deep, we don't need the
> statistics because we should always rebuild the it.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/extents.c | 10 +++++++++-
>  e2fsck/pass1.c   |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/e2fsck/extents.c b/e2fsck/extents.c
> index 01879f56..86fe00e7 100644
> --- a/e2fsck/extents.c
> +++ b/e2fsck/extents.c
> @@ -526,7 +526,8 @@ errcode_t e2fsck_check_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino,
>  		 */
>  		if (info.curr_entry == 1 &&
>  		    !(extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT) &&
> -		    !eti.force_rebuild) {
> +		    !eti.force_rebuild &&
> +		    info.curr_level < MAX_EXTENT_DEPTH_COUNT) {
>  			struct extent_tree_level *etl;
>  
>  			etl = eti.ext_info + info.curr_level;
> @@ -580,6 +581,13 @@ errcode_t e2fsck_should_rebuild_extents(e2fsck_t ctx,
>  	extents_per_block = (ctx->fs->blocksize -
>  			     sizeof(struct ext3_extent_header)) /
>  			    sizeof(struct ext3_extent);
> +
> +	/* If the extent tree is too deep, then rebuild it. */
> +	if (info->max_depth > MAX_EXTENT_DEPTH_COUNT) {
> +		pctx->blk = info->max_depth;
> +		op = PR_1E_CAN_COLLAPSE_EXTENT_TREE;
> +		goto rebuild;
> +	}
>  	/*
>  	 * If we can consolidate a level or shorten the tree, schedule the
>  	 * extent tree to be rebuilt.
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 11d7ce93..43972e7c 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -2842,7 +2842,8 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
>  	if (pctx->errcode)
>  		return;
>  	if (!(ctx->options & E2F_OPT_FIXES_ONLY) &&
> -	    !pb->eti.force_rebuild) {
> +	    !pb->eti.force_rebuild &&
> +	    info.curr_level < MAX_EXTENT_DEPTH_COUNT) {
>  		struct extent_tree_level *etl;
>  
>  		etl = pb->eti.ext_info + info.curr_level;
> -- 
> 2.31.0
> 

