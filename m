Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E05E5E12
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Sep 2022 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiIVJAv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIVJAt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 05:00:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEC90C79;
        Thu, 22 Sep 2022 02:00:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 807521F37F;
        Thu, 22 Sep 2022 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663837245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOc07hI/fXyP1LUQlxgxxUDV+HgejEBOXvhqSCkzves=;
        b=Ta3ASpkhxk5y0XEhr2ctyQY9Wz8L3VdF1sFkYW0cOFF/HmLlD5r4/eODCHWUsVONbLeeIu
        FrZpTMp47UGIG50UND4f+rvB9kaLgAaN5pPEYZQA1ZPuIiq0YJzg1A0PA+1KbnkN6Z+G9r
        zk3R3K1yatgFWFPFdyzoP8WbGoDfJG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663837245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOc07hI/fXyP1LUQlxgxxUDV+HgejEBOXvhqSCkzves=;
        b=8JbX2hGfZF3eogC7UiTq6BddSiX+USLQxadE40PtiAEscE2bkFWnFzjdm1i1LoZsRmdgEo
        rvBVnTT6SCu/p9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64EAC1346B;
        Thu, 22 Sep 2022 09:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UR2YGD0kLGNkcgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Sep 2022 09:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB985A0684; Thu, 22 Sep 2022 11:00:44 +0200 (CEST)
Date:   Thu, 22 Sep 2022 11:00:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix use-after-free in ext4_ext_shift_extents
Message-ID: <20220922090044.stl32ssbzpebcx7d@quack3>
References: <20220921134218.3577001-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921134218.3577001-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-09-22 21:42:18, Baokun Li wrote:
> If the starting position of our insert range happens to be in the hole
> between the two ext4_extent_idx, because the lblk of the ext4_extent in
> the previous ext4_extent_idx is always less than the start, which leads
> to the "extent" variable access across the boundary, the following UAF is
> triggered:
> ==================================================================
> BUG: KASAN: use-after-free in ext4_ext_shift_extents+0x257/0x790
> Read of size 4 at addr ffff88819807a008 by task fallocate/8010
> CPU: 3 PID: 8010 Comm: fallocate Tainted: G            E     5.10.0+ #492
> Call Trace:
>  dump_stack+0x7d/0xa3
>  print_address_description.constprop.0+0x1e/0x220
>  kasan_report.cold+0x67/0x7f
>  ext4_ext_shift_extents+0x257/0x790
>  ext4_insert_range+0x5b6/0x700
>  ext4_fallocate+0x39e/0x3d0
>  vfs_fallocate+0x26f/0x470
>  ksys_fallocate+0x3a/0x70
>  __x64_sys_fallocate+0x4f/0x60
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ==================================================================
> 
> To solve this issue, when the ee_block of the last extent is less than
> the start, exit the loop in advance to avoid UAF.
> 
> Fixes: 331573febb6a ("ext4: Add support FALLOC_FL_INSERT_RANGE for fallocate")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Nice catch. The fix looks mostly good, just one small thing noted below.

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..25fc1f4b35a5 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5216,11 +5216,18 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  		}
>  
>  		tmp = *iterator;
> +		extent = EXT_LAST_EXTENT(path[depth].p_hdr);
>  		if (SHIFT == SHIFT_LEFT) {
> -			extent = EXT_LAST_EXTENT(path[depth].p_hdr);
>  			*iterator = le32_to_cpu(extent->ee_block) +
>  					ext4_ext_get_actual_len(extent);
>  		} else {
> +			/*
> +			 * start happens to be in the hole between
> +			 * the two ext4_extent_idx.
> +			 */
> +			if (le32_to_cpu(extent->ee_block) < start)
> +				break;

I think you need to initialize 'ret' somewhere (probably just after the
again: label would make most sense) so that we don't accidentally return
-EAGAIN here.

> +
>  			extent = EXT_FIRST_EXTENT(path[depth].p_hdr);
>  			if (le32_to_cpu(extent->ee_block) > 0)
>  				*iterator = le32_to_cpu(extent->ee_block) - 1;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
