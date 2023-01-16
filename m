Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA166BCA1
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAPLQ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 06:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjAPLQY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 06:16:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83A1E9DC
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 03:16:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34F01372A4;
        Mon, 16 Jan 2023 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673867782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tk47+HobTQ7T97NEESpDxHfealBXwGQATBUSYrMPBQM=;
        b=g4iXteyMrLKcITl2dwazxvssQX/Dc6rugqpD99V7lG2Kr0mk03aAp+x0wY2be9CbZVOanH
        yuoP71r+E3KAqeqFbKjvvuyrM+eYN3xyohvgsjDO4Ugpqs1GPuvmLH03NClO3h5jpvpK2k
        /C2yX0hINKu6Cp76Uy3bfb9GMURdLO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673867782;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tk47+HobTQ7T97NEESpDxHfealBXwGQATBUSYrMPBQM=;
        b=baNvnPjCKKBm8+4CtSWPD+MpWpg6TLGaewAh7pZDGbLGxxVAHpW3lfs2zWE5ueXSljGr97
        FVgN2GZx8yGMEwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 297FC138FA;
        Mon, 16 Jan 2023 11:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CxEZCgYyxWMrbQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 11:16:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F3E3A0746; Mon, 16 Jan 2023 12:16:21 +0100 (CET)
Date:   Mon, 16 Jan 2023 12:16:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: propagate errors from ext2_prepare_chunk
Message-ID: <20230116111621.rffhrhkdggszwlnu@quack3>
References: <20230116085205.2342975-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116085205.2342975-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 16-01-23 09:52:05, Christoph Hellwig wrote:
> Propagate errors from ext2_prepare_chunk to the callers and handle them
> there.  While touching the prototype also turn update_times into a bool
> from the current int used as bool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index c056957221a225..18b3d5af77240b 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -370,7 +370,10 @@ static int ext2_rename (struct user_namespace * mnt_userns,
>  			err = PTR_ERR(new_de);
>  			goto out_dir;
>  		}
> -		ext2_set_link(new_dir, new_de, new_page, page_addr, old_inode, 1);
> +		err = ext2_set_link(new_dir, new_de, new_page, page_addr,
> +				    old_inode, true);
> +		if (err)
> +			goto out_dir;
>  		ext2_put_page(new_page, page_addr);

AFAICT we need to call ext2_put_page(new_page, page_addr) also in case of
error here. I'll fix it up on commit. Thanks for the patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
