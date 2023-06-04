Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBA721482
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jun 2023 05:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjFDDqK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDDqJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 23:46:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E3DD
        for <linux-ext4@vger.kernel.org>; Sat,  3 Jun 2023 20:46:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3543jx9R019796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jun 2023 23:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685850361; bh=Z/rHLP4+79kfrR13EgPbRbEkF/C/fR6AnjLcoB1SGPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LoBinesi/D4fCZfz/Amqk23kgVxR+uVWLkoseH+JyFdtNKIhC1cz7a4CED1b9jiSG
         kfht74AQgrIxj3EEdsUKH2J+GuKSEM8jjIgnP/ek1xBbmOsVxvNEVeXa1Hx1OI5+7u
         rRLQsLTPlwBBL290OcyL/g+42YNI6+JTbJ+RXX8dpIqloeBMET5tv5ErIR9hBO/ndE
         63yGJ3i0i2iyBUv5tBEWjvqnsiNDscRBW4v937LQPtI4UdiGul6pMOSnc6DUPc/cXI
         fOSs1SkgMsU2R5jqS4J2NN1HuTNW/IwEDt3xmvps86TSo8NnGLeSjUYL85pV0Teszn
         Kzj9Bnup1QG2A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6602315C02EE; Sat,  3 Jun 2023 23:45:59 -0400 (EDT)
Date:   Sat, 3 Jun 2023 23:45:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Message-ID: <20230604034559.GG1128744@mit.edu>
References: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 5504f72bbbbe..5df357763975 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -224,11 +223,14 @@ int ext4_setup_system_zone(struct super_block *sb)
>  
>  	for (i=0; i < ngroups; i++) {
>  		cond_resched();
> -		if (ext4_bg_has_super(sb, i) &&
> -		    ((i < 5) || ((i % flex_size) == 0))) {
> +		unsigned int sb_num = ext4_bg_has_super(sb, i);
> +		unsigned long gdb_num = ext4_bg_num_gdb(sb, i);
> +		unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
> +
> +		if (sb_num != 0 || gdb_num != 0) {
>  			ret = add_system_zone(system_blks,
>  					ext4_group_first_block_no(sb, i),
> -					ext4_bg_num_gdb(sb, i) + 1, 0);
> +					sb_num + gdb_num + rsvd_gdt, 0);
>  			if (ret)
>  				goto err;
>  		}


How the reserved GDT blocks should be added to the system zone are not
handled correctly in this patch.   It can't be unconditionally added to
all block groups.

See the logic in ext4_num_base_meta_clusters() in fs/ext4/balloc.c ---
without the EXT4_NUM_B2C() at the end of the function, since the
system zone tracking is done at the block level, not the cluster
level.

					- Ted
