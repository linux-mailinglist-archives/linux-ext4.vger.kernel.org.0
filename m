Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18419534050
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiEYPZI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbiEYPZC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 11:25:02 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 08:24:59 PDT
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF336AFB12
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 08:24:59 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 566E6121361;
        Wed, 25 May 2022 15:18:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 16C9360009;
        Wed, 25 May 2022 15:18:22 +0000 (UTC)
Message-ID: <fa2a3a8041b9d814654f0dae4607e1a2f20d333d.camel@perches.com>
Subject: Re: [PATCH] ext4: add KERN_<LEVEL> for printk()
From:   Joe Perches <joe@perches.com>
To:     Yu Zhe <yuzhe@nfschina.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
Date:   Wed, 25 May 2022 08:18:22 -0700
In-Reply-To: <20220525124816.86915-1-yuzhe@nfschina.com>
References: <20220525124816.86915-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: ffimii8t86ekppstzgu1g7s9g4zcecuu
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 16C9360009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/TmTIrRKHyXtZxBIwCQr8v2pNMTsaHpqI=
X-HE-Tag: 1653491902-998717
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2022-05-25 at 05:48 -0700, Yu Zhe wrote:
> printk() should include KERN_<LEVEL> facility level, add them.

NACK.

checkpatch is just a guide.

You have to inspect the code to determine if what checkpatch emits
should be followed or ignored.

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
[]
> @@ -628,7 +628,7 @@ static struct stats dx_show_leaf(struct inode *dir,
>  	char *base = (char *) de;
>  	struct dx_hash_info h = *hinfo;
>  
> -	printk("names: ");
> +	printk(KERN_WARNING "names: ");
>  	while ((char *) de < base + size)
>  	{
>  		if (de->inode)
> @@ -648,7 +648,7 @@ static struct stats dx_show_leaf(struct inode *dir,
>  					/* Directory is not encrypted */
>  					ext4fs_dirhash(dir, de->name,
>  						de->name_len, &h);
> -					printk("%*.s:(U)%x.%u ", len,
> +					printk(KERN_WARNING "%*.s:(U)%x.%u ", len,

_might_ use KERN_CONT, 

>  					       name, h.hash,
>  					       (unsigned) ((char *) de
>  							   - base));
> @@ -683,7 +683,7 @@ static struct stats dx_show_leaf(struct inode *dir,
>  					else
>  						ext4fs_dirhash(dir, de->name,
>  						       de->name_len, &h);
> -					printk("%*.s:(E)%x.%u ", len, name,
> +					printk(KERN_WARNING "%*.s:(E)%x.%u ", len, name,

and here, etc...

[]

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
[]
> @@ -941,9 +941,9 @@ void __ext4_msg(struct super_block *sb,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	if (sb)
> -		printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
> +		printk(KERN_WARNING "%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);

You broke the logging here.

Did you check what prefix is and how it is used in ext4_msg ?

>  	else
> -		printk("%sEXT4-fs: %pV\n", prefix, &vaf);
> +		printk(KERN_WARNING "%sEXT4-fs: %pV\n", prefix, &vaf);
>  	va_end(args);
>  }
>  


