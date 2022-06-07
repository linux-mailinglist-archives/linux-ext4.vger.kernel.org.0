Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9A53FFC2
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiFGNMp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbiFGNMm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 09:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B561711830
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654607557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x88zFmIa0xQRcWNFtK8nPZB7r2+a6k7O1vQyJb2OTg8=;
        b=Fer249CrcrIeFznduJ9acojr9sBkyqz/oh4gR0UNH7cozqmwDHp3EZPTJnkTKT8iw2M4Ak
        LsRV6DjlgQjco4PP06aKaO16hpMhYf0TtoU3sfTG5xjZ62FhP8kNNd+FKpw5DWOJWdO5rq
        /boF6wsFTzjCDCup9NuInszBDHBx1NI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-HcR4Jug8ML-d27rW5pm-ug-1; Tue, 07 Jun 2022 09:12:34 -0400
X-MC-Unique: HcR4Jug8ML-d27rW5pm-ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F07185A7B2;
        Tue,  7 Jun 2022 13:12:34 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB8192026D64;
        Tue,  7 Jun 2022 13:12:32 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:12:30 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 1/7] e2fsck: sanity check the journal inode number
Message-ID: <20220607131230.vwlqysdihghwwpyx@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-2-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 07, 2022 at 12:24:38AM -0400, Theodore Ts'o wrote:
> E2fsck replays the journal before sanity checking the full superblock.
> So it's possible that the journal inode number is not valid relative
> to the number of block groups.  So to avoid potentially an array
> bounds overrun, sanity check this before trying to find the journal
> inode.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/journal.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 2e867234..12487e3d 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -989,7 +989,14 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
>  	journal->j_blocksize = ctx->fs->blocksize;
>  
>  	if (uuid_is_null(sb->s_journal_uuid)) {
> -		if (!sb->s_journal_inum) {
> +		/*
> +		 * The full set of superblock sanity checks haven't
> +		 * been performed yet, so we need to do some basic
> +		 * checks here to avoid potential array overruns.
> +		 */
> +		if (!sb->s_journal_inum ||
> +		    (sb->s_journal_inum >
> +		     (ctx->fs->group_desc_count * sb->s_inodes_per_group))) {
>  			retval = EXT2_ET_BAD_INODE_NUM;
>  			goto errout;
>  		}
> -- 
> 2.31.0
> 

