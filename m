Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3D69AFA7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBQPjz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 10:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQPjy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 10:39:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5116FF0D;
        Fri, 17 Feb 2023 07:39:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65EDF205AC;
        Fri, 17 Feb 2023 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676648382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wxI2fnQI0J8e7xSOYfqIUBNqAP5lh3gjEjH9f2TlJM=;
        b=dviz929Yaol/nXcSaB5aWmlBZH8bQe2k3TNS8nVxhz7ZGHFWcI6JncgRyOTcMocn7ocjMQ
        ttP3tpcX4vWU0Pmn7aIOB/aE/p1Cc5TZQS2bYXz2Zjuw/KWYOMlnETzNOLzTX3t576DgJi
        W1vjVoE0jG+Q16y+jAKz6x28prB/hXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676648382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wxI2fnQI0J8e7xSOYfqIUBNqAP5lh3gjEjH9f2TlJM=;
        b=5wH3wb6IOH7SObSuXO5IjPns/NxnH7DAQcQqlTdoyymthGCnvzSHmdL9NoCX4rPBtn+f26
        1JF9MZvuOB+7Z5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5987A138E3;
        Fri, 17 Feb 2023 15:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UtXRFb6f72PxPAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 15:39:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8AE1A06E1; Fri, 17 Feb 2023 16:39:41 +0100 (CET)
Date:   Fri, 17 Feb 2023 16:39:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: make kobj_type structures constant
Message-ID: <20230217153941.ehxoa55lerv5ofve@quack3>
References: <20230209-kobj_type-ext4-v1-1-6865fb05c1f8@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209-kobj_type-ext4-v1-1-6865fb05c1f8@weissschuh.net>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 09-02-23 03:18:35, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index d233c24ea342..364e3da49b03 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -496,13 +496,13 @@ static const struct sysfs_ops ext4_attr_ops = {
>  	.store	= ext4_attr_store,
>  };
>  
> -static struct kobj_type ext4_sb_ktype = {
> +static const struct kobj_type ext4_sb_ktype = {
>  	.default_groups = ext4_groups,
>  	.sysfs_ops	= &ext4_attr_ops,
>  	.release	= ext4_sb_release,
>  };
>  
> -static struct kobj_type ext4_feat_ktype = {
> +static const struct kobj_type ext4_feat_ktype = {
>  	.default_groups = ext4_feat_groups,
>  	.sysfs_ops	= &ext4_attr_ops,
>  	.release	= (void (*)(struct kobject *))kfree,
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-ext4-962d5425769a
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
