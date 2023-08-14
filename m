Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F477B969
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHNNIm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHNNIe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 09:08:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66DDF5;
        Mon, 14 Aug 2023 06:08:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 872521F383;
        Mon, 14 Aug 2023 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692018511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHUt2+5qnChENzYz09ciWasPvk8YOCBrdjJWqiYidD0=;
        b=2jtut4HBfKyKs7erOdn2aNV1eiThcq8v5HUJODY3x6qAEUTi74fGzpe0kMreEgmrOy/ohY
        G+I9uupn3j0ROB04VTXZoKgeJ6CYfkQ4JHUFr4L/hkL2v1UZPGNh7mQhowjilltRrWUeka
        uQyLhIi39oWjIsaiPe3HJTCjtVTRHsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692018511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHUt2+5qnChENzYz09ciWasPvk8YOCBrdjJWqiYidD0=;
        b=KHOrhSa88Zb75tcaavPD5Z+PAWEP514bFEJEgRqt3a82d/TFbTtDQV6I77n/8vPS3IDxqh
        pio1D1xdgM0bOyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76D37138E2;
        Mon, 14 Aug 2023 13:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GzYAHU8n2mQ5UwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 13:08:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03C89A0769; Mon, 14 Aug 2023 15:08:30 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:08:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2: dump current reservation window info before BUG
Message-ID: <20230814130830.kizeni4hk5vjtqkm@quack3>
References: <20230811033857.1800578-1-yebin10@huawei.com>
 <20230811033857.1800578-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811033857.1800578-3-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 11-08-23 11:38:57, Ye Bin wrote:
> There's report BUG in 'ext2_try_to_allocate_with_rsv()', although there's
> now dump of all reservation windows information. But there's unknown which
> window is being processed.So this is not helpful for locating the issue.
> To better analyze the problem, dump the information about reservation window
> that is being processed.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext2/balloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 039f655febfd..0132b8af546e 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1131,6 +1131,11 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
>  
>  		if ((my_rsv->rsv_start > group_last_block) ||
>  				(my_rsv->rsv_end < group_first_block)) {
> +			ext2_error(sb, __func__,
> +				   "Out of group %u range goal %d fsb[%lu,%lu] rsv[%lu, %lu]",
                                   ^^^ "Reservation out of group ...."

> +				   group, grp_goal, group_first_block,
> +				   group_last_block, my_rsv->rsv_start,
> +				   my_rsv->rsv_end);
>  			rsv_window_dump(&EXT2_SB(sb)->s_rsv_window_root, 1);
>  			BUG();
>  		}

And we could just bail with error instead of BUG here when we are already
changing the code...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
