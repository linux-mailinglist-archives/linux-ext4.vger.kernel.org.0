Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC06EA747
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Apr 2023 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDUJkV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Apr 2023 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDUJjx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Apr 2023 05:39:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415CFA26F;
        Fri, 21 Apr 2023 02:39:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA7A01FDDB;
        Fri, 21 Apr 2023 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682069980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0oBb1WNVgVgeV0jfAXu74YAFlW458tbcChtpKQa26M=;
        b=LWZCQTLRCJx4X1ax9ZfhS6a7i+Pz4rJop3gwvYzXuQEgdw3zZeZWxdqhbC3GD7htJ3vpbz
        0eOwqNC6kaD38FdbOAmqZph5OWpzOCn4MlZDqXiG6wOwuVN1X8tZD5vOrySFxXvsKYLUrm
        a8bT9JSZFBWaeFl4+wi42Hqv9nR2gks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682069980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0oBb1WNVgVgeV0jfAXu74YAFlW458tbcChtpKQa26M=;
        b=Hcv2e7x44qtUBNerqbUy5jqGRASuIibWTV1k7O7Wyx5GRo6nozPIG9EXBHbLpecYPcAv2E
        qT83uBu7qX8GsJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C695D13456;
        Fri, 21 Apr 2023 09:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DeB6MNxZQmRuVAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 09:39:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DB21A0729; Fri, 21 Apr 2023 11:39:40 +0200 (CEST)
Date:   Fri, 21 Apr 2023 11:39:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <chao@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix to report fstrim.minlen back to userspace
Message-ID: <20230421093940.k2crghkblpx2fqlv@quack3>
References: <20230406150410.3853001-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406150410.3853001-1-chao@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-04-23 23:04:10, Chao Yu wrote:
> Quoted from manual of fstrim(8):
> 
> "-m, --minimum minimum-size
> 	..., if it's smaller than the device's minimum, and report that
> (fstrim_range.minlen) back to userspace."
> 
> So this patch tries to report adjusted fstrim_range.minlen back to
> userspace via FITRIM interface, if the value is smaller than device's
> minimum discard granularity.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
> - fix the wrong calculation of range->minlen.
>  fs/ext4/mballoc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d8b9d6a83d1e..4af51a16fc64 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6491,6 +6491,10 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  				discard_granularity >> sb->s_blocksize_bits);
>  		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
>  			goto out;
> +
> +		/* Report adjusted minlen back to userspace */
> +		range->minlen = EXT4_C2B(EXT4_SB(sb), minlen) <<
> +						sb->s_blocksize_bits;
>  	}
>  	if (end >= max_blks - 1) {
>  		end = max_blks - 1;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
