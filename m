Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C64337BC
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJSNwG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 09:52:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSNwG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 09:52:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 863DE1FD68;
        Tue, 19 Oct 2021 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634651392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYIRvsPTFonp092ZZWcjL7XIkMyhcUTpPaWgkCq3hG4=;
        b=CN3sDR44nW5r3YTqnNkf15WMSBM28SkO1ntJS6ZwWGtrzFhCWaJvOE0szKpwCxPAdGCNeB
        +mGnILAWGU2+lvBUubCTfkqARfOxApNAbC1sLRwb2K+6pU9pi8b7hyxt5YqOQgM0/UfrPc
        zJV1WD9Yws1x2gh/leRYIrBGiJbKFT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634651392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYIRvsPTFonp092ZZWcjL7XIkMyhcUTpPaWgkCq3hG4=;
        b=0lGS5MZ/MB7mchE2pqVYfQkDuNKjwJeNgTvbj9nPcN0iDfrhwvgUKX3+uU3DOWI8W1QJBy
        II/RmkErCP0d0VAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 79C5FA3B87;
        Tue, 19 Oct 2021 13:49:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 24A7C1E0983; Tue, 19 Oct 2021 15:49:52 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:49:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v4 3/3] ext4: simplify read_mmp_block fucntion
Message-ID: <20211019134952.GJ3255@quack2.suse.cz>
References: <20211019123931.1545295-1-yebin10@huawei.com>
 <20211019123931.1545295-4-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019123931.1545295-4-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-10-21 20:39:31, Ye Bin wrote:
> This patch is according to Jan Kara's suggestion:
> I guess I would just get rid of sb_getblk() in read_mmp_block() and always
> expect valid bh passed. The only place that passes NULL bh after this
> patch is one case in ext4_multi_mount_protect() and that can call
> sb_getblk() on its own. That way we can also simplify read_mmp_block()
> prototype to:
> 
> static int read_mmp_block(struct super_block *sb, struct buffer_head *bh);
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

...

> @@ -289,7 +279,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
>  		goto failed;
>  	}
>  
> -	retval = read_mmp_block(sb, &bh, mmp_block);
> +	bh = sb_getblk(sb, mmp_block);
> +	if (bh)
	^^^^^^

!bh here, please.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
