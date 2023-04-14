Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0446E28C4
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Apr 2023 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNQzn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Apr 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNQzm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Apr 2023 12:55:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F630FD;
        Fri, 14 Apr 2023 09:55:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95CF121A29;
        Fri, 14 Apr 2023 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681491340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xo+bpFCx2G3gOAg5wWwNoprAZYT4JBt333daVcklgSI=;
        b=u/6h/wvx33GGsyIOMI83gtW19ULP/1S+y4U4VXvujUn8DC0eA8nK/+wwsiI8IgHqRvMS6l
        om0jjlaGpzFlCsT8fj5s72UgZ0lq7r5x+fd0OLrUGOFlfBpkc2ZMpVJ3q8RMDsSCoZI7g3
        mq9QYmLshGd8SsF/K3ExGCm2P1FTNmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681491340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xo+bpFCx2G3gOAg5wWwNoprAZYT4JBt333daVcklgSI=;
        b=EjNRSy4ZQWm3iGEuXtaQdzwmeP+B6+UdUvuVkMbsCkq8oBf4Qn8fUpsFiZiHTXKUFVgpXr
        RLFj/KbI8fSzXLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5092F13498;
        Fri, 14 Apr 2023 16:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +MiiE4yFOWTYbAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 16:55:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 28056A0732; Fri, 14 Apr 2023 18:55:38 +0200 (CEST)
Date:   Fri, 14 Apr 2023 18:55:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove useless conditional branch code
Message-ID: <20230414165538.arfcfqriwbo2fgzq@quack3>
References: <20230401075303.45206-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401075303.45206-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 01-04-23 15:53:03, wuchi wrote:
> It's ok because the code will be optimized by the compiler, just
> try to simple the code.
> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> 
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index 87c1c8ae9298..cd725bebe69e 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -74,10 +74,7 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb,
>  	} else
>  		calculated &= 0xFFFF;
>  
> -	if (provided == calculated)
> -		return 1;
> -
> -	return 0;
> +	return provided == calculated;
>  }
>  
>  void ext4_block_bitmap_csum_set(struct super_block *sb,
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
