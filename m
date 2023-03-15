Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B6BAB02
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCOIoV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjCOIoS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 04:44:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB601A979;
        Wed, 15 Mar 2023 01:44:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 311C2218B8;
        Wed, 15 Mar 2023 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678869844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvOZugXUhrUQOcXbZmWvapNYH6jrQd97PlKDCXDdhKM=;
        b=CbThbT6ZmTLiJdKQbADYt32S94ZoKTT7Gl4pCQpo+JrFfBpmxRQffRsU0GDszKoJxLrzDI
        meQgDWknV19Jw56UN+/KXDA0tHw3UUQWs6C7ncHXZaL9uEl7HNF90NQGbNIStyALZ8vnKi
        le4lWR2tYm6Uwk6RXOx7/ZdPkc5XGxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678869844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvOZugXUhrUQOcXbZmWvapNYH6jrQd97PlKDCXDdhKM=;
        b=1O27JqUXHicFonY1abz6gBBHY91f2mKgovxpfgqkRIaM8BCyoMYqrA3MEkU+41Aj/KTdfd
        2iA66xNx10fxXwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2503413A00;
        Wed, 15 Mar 2023 08:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dfUFCVSFEWR0EgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 15 Mar 2023 08:44:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B90EDA06FD; Wed, 15 Mar 2023 09:44:03 +0100 (CET)
Date:   Wed, 15 Mar 2023 09:44:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        tudor.ambarus@linaro.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3 2/6] ext4: ext4_put_super: Remove redundant checking
 for 'sbi->s_journal_bdev'
Message-ID: <20230315084403.krguix7veo4lsvgk@quack3>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
 <20230315013128.3911115-3-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315013128.3911115-3-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-03-23 09:31:24, Zhihao Cheng wrote:
> As discussed in [1], 'sbi->s_journal_bdev != sb->s_bdev' will always
> become true if sbi->s_journal_bdev exists. Filesystem block device and
> journal block device are both opened with 'FMODE_EXCL' mode, so these
> two devices can't be same one. Then we can remove the redundant checking
> 'sbi->s_journal_bdev != sb->s_bdev' if 'sbi->s_journal_bdev' exists.
> 
> [1] https://lore.kernel.org/lkml/f86584f6-3877-ff18-47a1-2efaa12d18b2@huawei.com/
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 61511b7ba017..a22417d113ca 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1277,7 +1277,7 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	sync_blockdev(sb->s_bdev);
>  	invalidate_bdev(sb->s_bdev);
> -	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
> +	if (sbi->s_journal_bdev) {
>  		sync_blockdev(sbi->s_journal_bdev);
>  		ext4_blkdev_remove(sbi);
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
