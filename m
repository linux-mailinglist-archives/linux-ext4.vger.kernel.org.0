Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8336D531D62
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiEWVIL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiEWVIK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 17:08:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5677980B;
        Mon, 23 May 2022 14:08:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A002721A7C;
        Mon, 23 May 2022 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653340087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rM9f/yMLkuaW40DJL7kDDLDuwZqvNK3W9bqRERKYeU=;
        b=jxjHwbshYzVKwX4qe8E7lB7lA0sJvBbrXNHKXrkKnkkrLjp7TTPs3ew0FayxxYpNFLzxG0
        MUOfPVqaDn92SOZV//00TWhgrpozT2R1uyDhXiUsH9s6KAfxsp1SZUPyX/m1xYUP1TwrR8
        /SgWG+Gy2pNMQIajDjCwSlbT3RanZZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653340087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rM9f/yMLkuaW40DJL7kDDLDuwZqvNK3W9bqRERKYeU=;
        b=FwTn37IqgobJz1XyuiTa4ggrkOt/Vhe00BkKD6rX11hf58mjmoRZQG6onGqWF/+pVAhJBQ
        itFiPaR/aO5Vl4AA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59D122C141;
        Mon, 23 May 2022 21:08:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03D0DA0632; Mon, 23 May 2022 23:08:06 +0200 (CEST)
Date:   Mon, 23 May 2022 23:08:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220523210806.yeapg54ctleocwdn@quack3.lan>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 24-05-22 01:38:44, Ritesh Harjani wrote:
> On 22/05/21 09:42PM, Baokun Li wrote:
> > When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> > "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> > that the fe_logical is not in the allocated range.
> 
> Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
> We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
> within the preallocated range. So if our start or start + size doesn't include
> fe_logical then it is a bug in the ext4_mb_normalize_request() logic.

I agree ac->ac_o_ex.fe_logical is a goal block. But AFAIK it never was a
hard guarantee that we would allocate extent that includes that block. It
was always treated as a hint only. In particular if you look at the logic
in ext4_mb_normalize_request() it does shift the start of the allocation to
avoid preallocated ranges etc. so I don't see how we are guaranteed that
ext4_mb_normalize_request() will result in an allocation request that
includes ac->ac_o_ex.fe_logical.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
