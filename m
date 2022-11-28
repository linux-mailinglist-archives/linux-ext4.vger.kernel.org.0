Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4963B39C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiK1Uov (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 15:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiK1Uou (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 15:44:50 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69D2E9F3;
        Mon, 28 Nov 2022 12:44:49 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ASKiJjA009979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 15:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669668263; bh=pnIQNOAY5vhuqXAYNX8YQgNudtCkLfVvMCmZuAp9r0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Rf19edPnUJx8dTG0/rI9l6bTyJ9U7Mp3PrpNwemXd8yEpzei3qiepButayG8JhYqU
         AU8WjRGHZ8FIO8ISAtR2g0ZtmHCrN9aQih43O16mDvEGaEvtPStm3x/1kfco4JWhyT
         K8jGKg2sZ6cntVMV2V87lTon4xuzYR2UZNaXiMtcFGMTkbbkoQ+IW7jDEhNiIEfjjE
         iCTf4ulX59Hg7CbPP5xV3YRjmmGQOPAnNfSPPVvKcoFON71f6X4oMEv7I3shjW+KE4
         dYd+5KxxZJfC3PoJ8fBNx/+N3QIWkokZkqLqppGPHSbBqyrLh+Rizdv061V9U0NfWX
         AYCD60IHa1jCA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1C4DF15C3AA6; Mon, 28 Nov 2022 15:44:19 -0500 (EST)
Date:   Mon, 28 Nov 2022 15:44:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <Y4UdoyF6+oDI6w5P@mit.edu>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
 <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 18, 2022 at 08:13:53PM +0530, Ritesh Harjani (IBM) wrote:
> Folding a small patch to implement the simple bound check. Is this the right
> approach?
> 
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Date: Thu, 18 Aug 2022 07:53:58 -0500
> Subject: [RFC] ext4: Add ext4_sb_getblk() wrapper for block bounds checking
> 
> We might need more bounds checking on the block before calling sb_getblk().
> This helper does that and if it is not valid then returns ERR_PTR(-EFSCORRUPTED)
> Later we will need to carefully convert the callers to use ext4_sb_getblk()
> instead of sb_getblk().

Hey Ritesh,

I was going through some old patches and came across this RFC patch.
Have you had a chance to polish this up?  I don't think I've seen a
newer version of this patch, but maybe I missed it.

Thanks,

					- Ted
