Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E76F1B08
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjD1O6l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjD1O6f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 10:58:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35A55BD;
        Fri, 28 Apr 2023 07:58:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6C6200C3;
        Fri, 28 Apr 2023 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682693913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWc+/LnHmEKaQXdNj0kSzuKffYCIpGDlsQo52XW1EBk=;
        b=P7yoor0eSo0jk1UW1MQxaLwwZlEn/L6vsijjKZTdjLIb+9c3ST045lVjxJpKyOFv56t1Y4
        wNju2SXGyCNXJOl9Sy/awhh0psFTVZQB6F2qgq7Ti4owOWKadNgIwbbzCXTZ8EXAwAVnMp
        Zfumc36iJGX/eXu8fu3/fEYPw+6pNQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682693913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWc+/LnHmEKaQXdNj0kSzuKffYCIpGDlsQo52XW1EBk=;
        b=KGSTxwZmnI12QJeK73ov38wGWehnyZuWzYvoifPtTqqdeLn9jMLoPPDy05kiPFkqPC6/2+
        cXTdTCmiXirwnwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0735E1390E;
        Fri, 28 Apr 2023 14:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yuO3ARnfS2TTTgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 14:58:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4259BA0729; Fri, 28 Apr 2023 16:58:32 +0200 (CEST)
Date:   Fri, 28 Apr 2023 16:58:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wu Bo <wubo@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        qiuchangqi.qiu@huawei.com, wubo40@huawei.com
Subject: Re: [PATCH] ext4: Remove unnecessary variable assignments
Message-ID: <20230428145832.azuluj4rnqurphyg@quack3>
References: <1681731135-18768-1-git-send-email-wubo@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681731135-18768-1-git-send-email-wubo@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 17-04-23 19:32:15, Wu Bo wrote:
> Just remove unnecessary variable assignments.
> 
> Signed-off-by: Wu Bo <wubo@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37..f0b790d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5842,7 +5842,6 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
>  	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
>  		pr_warn("Failed to read block bitmap\n");
>  		return;
>  	}
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
