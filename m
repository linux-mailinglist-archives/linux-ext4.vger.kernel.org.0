Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9088D54000D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiFGNbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiFGNbB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 09:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C844DDFD30
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654608659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YOK5j4zHCz7ri6E8WBWsq9PqLTA9RObvziPndYoLk0=;
        b=XL9feH7cedT5s0AvRsBJ/6sp2Dvss9W7qfo4mvhwKT9EOZh47xpv+Ujh3ioYWUOUKqHbDn
        akSVH1vBHLL3Ghu+EZ9+ooyOpmzT8rleNOI2kJrt1MjSgPw6mO6mykLDNAskbDMqQHoD1k
        MO9KCKcHFHsYF4eFvqxtt3zskVCTjYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-TD5BgHeoP0mQ4qDG5p61xQ-1; Tue, 07 Jun 2022 09:30:56 -0400
X-MC-Unique: TD5BgHeoP0mQ4qDG5p61xQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FAC918E5380;
        Tue,  7 Jun 2022 13:30:56 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DB27C27E8F;
        Tue,  7 Jun 2022 13:30:55 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:30:52 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 2/7] e2fsck: fix potential out-of-bounds read in
 inc_ea_inode_refs()
Message-ID: <20220607133052.vyao56ajey57a2ih@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-3-tytso@mit.edu>
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

On Tue, Jun 07, 2022 at 12:24:39AM -0400, Theodore Ts'o wrote:
> If there isn't enough space for a full extended attribute entry,
> inc_ea_inode_refs() might end up reading beyond the allocated memory
> buffer.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/pass1.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index dde862a8..2a17bb8a 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -389,13 +389,13 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
>  static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
>  			      struct ext2_ext_attr_entry *first, void *end)
>  {
> -	struct ext2_ext_attr_entry *entry;
> +	struct ext2_ext_attr_entry *entry = first;
> +	struct ext2_ext_attr_entry *np = EXT2_EXT_ATTR_NEXT(entry);
>  
> -	for (entry = first;
> -	     (void *)entry < end && !EXT2_EXT_IS_LAST_ENTRY(entry);
> -	     entry = EXT2_EXT_ATTR_NEXT(entry)) {
> +	while ((void *) entry < end && (void *) np < end &&
> +	       !EXT2_EXT_IS_LAST_ENTRY(entry)) {
>  		if (!entry->e_value_inum)
> -			continue;
> +			goto next;
>  		if (!ctx->ea_inode_refs) {
>  			pctx->errcode = ea_refcount_create(0,
>  							   &ctx->ea_inode_refs);
> @@ -408,6 +408,9 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
>  		}
>  		ea_refcount_increment(ctx->ea_inode_refs, entry->e_value_inum,
>  				      0);
> +	next:
> +		entry = np;
> +		np = EXT2_EXT_ATTR_NEXT(entry);
>  	}
>  }
>  
> -- 
> 2.31.0
> 

