Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05725540017
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiFGNd3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 09:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiFGNd3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 09:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB4845AFB
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654608806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkHnNtwXN+00SIB6Y0BYCGvF3PQB+a0R4/bXHuNW+w8=;
        b=ARWWGyw2YkLlDHJCKeQ0SJgRqTTvT+iIwH5fbHbxhSGtcMOLJwPtVudIGMf6if0ftq1coo
        RDzq56cXzX7hfKJHcabO2sSRy1qpQhCqFLppvpBQ0tt32M3CVXqnle2S9dNiMX+kNSnt0E
        PzCAkcYEzls9GE1rRDYCCau79a9tv/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-joeMJ0cSOtmaCWnv_20b5g-1; Tue, 07 Jun 2022 09:33:23 -0400
X-MC-Unique: joeMJ0cSOtmaCWnv_20b5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5F3D101E982;
        Tue,  7 Jun 2022 13:33:22 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C76C27E8F;
        Tue,  7 Jun 2022 13:33:21 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:33:19 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 4/7] e2fsck: check for xattr value size integer wraparound
Message-ID: <20220607133319.5s4b4l43lronawnr@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-5-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-5-tytso@mit.edu>
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

On Tue, Jun 07, 2022 at 12:24:41AM -0400, Theodore Ts'o wrote:
> When checking an extended attrbiute block for correctness, we check if
> the starting offset plus the value size exceeds the end of the block.
> However, we weren't checking if the size was too large, and if it is
> so large that it triggers a wraparound when we added the starting
> offset, we won't notice the problem.  Add the missing check.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/pass1.c             |  5 +++--
>  lib/ext2fs/ext2_ext_attr.h | 11 +++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 2a17bb8a..11d7ce93 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -2556,8 +2556,9 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
>  			break;
>  		}
>  		if (entry->e_value_inum == 0) {
> -			if (entry->e_value_offs + entry->e_value_size >
> -			    fs->blocksize) {
> +			if (entry->e_value_size > EXT2_XATTR_SIZE_MAX ||
> +			    (entry->e_value_offs + entry->e_value_size >
> +			     fs->blocksize)) {
>  				if (fix_problem(ctx, PR_1_EA_BAD_VALUE, pctx))
>  					goto clear_extattr;
>  				break;
> diff --git a/lib/ext2fs/ext2_ext_attr.h b/lib/ext2fs/ext2_ext_attr.h
> index f2042ed5..c6068c48 100644
> --- a/lib/ext2fs/ext2_ext_attr.h
> +++ b/lib/ext2fs/ext2_ext_attr.h
> @@ -57,6 +57,17 @@ struct ext2_ext_attr_entry {
>  #define EXT2_XATTR_SIZE(size) \
>  	(((size) + EXT2_EXT_ATTR_ROUND) & ~EXT2_EXT_ATTR_ROUND)
>  
> +/*
> + * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
> + * for file system consistency errors, we use a somewhat bigger value.
> + * This allows XATTR_SIZE_MAX to grow in the future, but by using this
> + * instead of INT_MAX for certain consistency checks, we don't need to
> + * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
> + * defined in include/uapi/linux/limits.h, so changing it is going
> + * not going to be trivial....)
> + */
> +#define EXT2_XATTR_SIZE_MAX (1 << 24)
> +
>  #ifdef __KERNEL__
>  # ifdef CONFIG_EXT2_FS_EXT_ATTR
>  extern int ext2_get_ext_attr(struct inode *, const char *, char *, size_t, int);
> -- 
> 2.31.0
> 

