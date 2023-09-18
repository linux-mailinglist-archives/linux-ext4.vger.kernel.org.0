Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E77A4C6A
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjIRPcm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjIRPc1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 11:32:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961FE12B;
        Mon, 18 Sep 2023 08:30:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA1B621D71;
        Mon, 18 Sep 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695048428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MiFl31+UGD6aDpGF4GuaYmsTJ9E5cBA01T0ksKE6gMU=;
        b=Qv9SqzI2u9WyQTkioGDIoLEQSLqFz0sgXgQGSKuMEBM4EpRxCMf2++yAVW7M7cPPnf+W5S
        Grc2gagVJWyoBP9K+xeartPuTBcTkN3JJSzXmBDvDNJ33Lz/rt0/Cn6zzSg/x79gP+kkBU
        vMzA1BP2IDRHC4eG7fUWPJ2kgXaMDBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695048428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MiFl31+UGD6aDpGF4GuaYmsTJ9E5cBA01T0ksKE6gMU=;
        b=zd8dFmLW3XkCnWrSNjEnxsaYmCa/VRQNnIWI8JjLnIOwA1cnCtvI3l8t74h9Y/ZXmHE7AC
        gd7+ulV0Qr9dX5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB24E1358A;
        Mon, 18 Sep 2023 14:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WDh2NexiCGUkQwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 14:47:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66CBDA0759; Mon, 18 Sep 2023 16:47:08 +0200 (CEST)
Date:   Mon, 18 Sep 2023 16:47:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chunhui He <hchunhui@mail.ustc.edu.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: trivial: add semicolon after label attributes
Message-ID: <20230918144708.cntjdjjomj7oy5f5@quack3>
References: <20230826085658.69769-1-hchunhui@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826085658.69769-1-hchunhui@mail.ustc.edu.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 26-08-23 08:56:58, Chunhui He wrote:
> The gcc document says label attributes are ambiguous if they are
> not immediately followed by a semicolon. Although the ambiguity
> does not arise in C90/99, it would be better to add it.
> 
> Link: https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Label-Attributes-2
> Signed-off-by: Chunhui He <hchunhui@mail.ustc.edu.cn>

Fair enough. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..f5fa9815a86e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5609,7 +5609,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  failed_mount10:
>  	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
> -failed_mount9: __maybe_unused
> +failed_mount9: __maybe_unused;
>  	ext4_release_orphan_info(sb);
>  failed_mount8:
>  	ext4_unregister_sysfs(sb);
> -- 
> 2.39.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
