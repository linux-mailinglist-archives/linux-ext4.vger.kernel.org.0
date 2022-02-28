Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875E4C655F
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Feb 2022 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiB1JFa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 04:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiB1JFV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 04:05:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9C419AC
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 01:04:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 03E591F3A2;
        Mon, 28 Feb 2022 09:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646039043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtRnU0foWoN2rM3Xp2ByyjTu26o9/VRblCeANRjwRPQ=;
        b=w+LPVvjIMOgEvAok78lIirhEcujZm1UL48u9cxRWg903UONHVBFUiZPUbqhr4Fn+9q+6Hg
        5PyeR6qJay29/c2YUd6e8rqzd4mNfiCY8CEUcF96B4Pcel9cUgLFEeXEHr2sbL+/3n1jCC
        deMBVRXji2WcseM4i+MQ1Q9q53Zpf38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646039043;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtRnU0foWoN2rM3Xp2ByyjTu26o9/VRblCeANRjwRPQ=;
        b=f3KVzNw2UZs9lzFlEsJGIOP1Ia3lHbOozBzDlW4cDmc9oI5c3xO/MW/uanByDsx5xHT/ck
        4tFAI5qMwfPS1CBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E73A2A3B84;
        Mon, 28 Feb 2022 09:04:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7B93EA060A; Mon, 28 Feb 2022 10:03:59 +0100 (CET)
Date:   Mon, 28 Feb 2022 10:03:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: fix underflow in ext4_max_bitmap_size()
Message-ID: <20220228090359.dcqajobuol3ripur@quack3.lan>
References: <20220225102837.3048196-1-yi.zhang@huawei.com>
 <20220225123851.flahv2nlvpqq3d33@quack3.lan>
 <3335eb5d-76c0-0b01-3dca-b2e2ccdf91c0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3335eb5d-76c0-0b01-3dca-b2e2ccdf91c0@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 26-02-22 10:30:31, Zhang Yi wrote:
> On 2022/2/25 20:38, Jan Kara wrote:
> > On Fri 25-02-22 18:28:37, Zhang Yi wrote:
> >> +	/* Compute how many metadata blocks are needed */
> >> +	meta_blocks = 1;
> >> +	meta_blocks += 1 + ppb;
> >> +	meta_blocks += 1 + ppb + ppb * ppb;
> >> +	/* Does block tree limit file size? */
> >> +	if (res + meta_blocks <= upper_limit)
> >> +		goto check_lfs;
> >> +
> >> +	res = upper_limit;
> >> +	/* How many metadata blocks are needed for addressing upper_limit? */
> >> +	upper_limit -= EXT4_NDIR_BLOCKS;
> >> +	/* indirect blocks */
> >> +	meta_blocks = 1;
> >> +	upper_limit -= ppb;
> >> +	/* double indirect blocks */
> >> +	if (upper_limit < ppb * ppb) {
> >> +		meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb);
> >> +		res -= meta_blocks;
> >> +		goto check_lfs;
> >> +	}
> >> +	meta_blocks += 1 + ppb;
> >> +	upper_limit -= ppb * ppb;
> >> +	/* tripple indirect blocks for the rest */
> >> +	meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb) +
> >> +		DIV_ROUND_UP_ULL(upper_limit, ppb*ppb);
> >> +	res -= meta_blocks;
> >> +check_lfs:
> >>  	res <<= bits;
> > 
> > Cannot this overflow loff_t again? I mean if upper_limit == (1 << 48) - 1
> > and we have 64k blocksize, 'res' will be larger than (1 << 47) and thus 
> > res << 16 will be greater than 1 << 63 => negative... Am I missing
> > something?
> > 
> 
> If upper_limit==(1 << 48) - 1, we could address the whole data blocks, the 'res'
> is equal to EXT4_NDIR_BLOCKS + ppb + ppb*ppb + ((long long)ppb)*ppb*ppb, it's
> smaller than (1 << 43) - 1, so res << 16 is still smaller 1 << 59, so it cannot
> overflow loff_t again.

Indeed, sorry for confusion. Not sure where I did mistake in my math
previously.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
