Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6B647D8C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 07:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLIGFY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 01:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLIGFX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 01:05:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591D4C251
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 22:05:22 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B964uKq001168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 01:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670565898; bh=eB3l1ZPS+3z8Gov8819OEgKyJzNPoD2Z+tSNfsm5SEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WazQQWWuAwZXsPrJBbhxRuabsvOTxvfTPzzCsp5BWLyumSnMKMQkpMRgAA8CLFrHB
         MwJiArrx49RCnwh0dk+qR7Bc8FAr3SKL4ceVGGSB1diGV2n2F2nwvl3c0J5acRlb3B
         T4Xw9GCpgIfUONS6Ca9hs7334R4VxKF4WYE27ZcYOngvZpIJhrXvGhVFyMBprkegr9
         sJlXHf1tZkJE4gbMsoM0OxEr65bDxljCxIQ23yTkiNVQtooC2tDFrsjiMgrUyMvfwd
         XAexs/Mr8y7UO5U4/RLDVPPic7a9q7OqbBYVC7TcS18Vwu15WsFJ0+kTQRMB6TNDwG
         /+563E+yqO98Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 63F8E15C3AE9; Fri,  9 Dec 2022 01:04:56 -0500 (EST)
Date:   Fri, 9 Dec 2022 01:04:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/3] ext4: add check pending tree when evict inode
Message-ID: <Y5LQCPyJyg/pY2PJ@mit.edu>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
 <20221208033426.1832460-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208033426.1832460-4-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 11:34:26AM +0800, Ye Bin wrote:
> 
> Above issue fixed by
> commit 1b8f787ef547 ("ext4: fix warning in 'ext4_da_release_space'")
> in this scene. To make things better add check pending tree when evict
> inode.
> According to Eric Whitney's suggestion, bigalloc + inline is still in
> development so we just add test for this situation, there isn't need to
> add code to free pending tree entry.

The i_pending_tree is an in-memory data structure, and so it's not
appropriate to call ext4_error(), because there will be nothing for
fsck to fix.

If you really want to a bug to be noticed, you could use a ext4_msg
plus a WARN_ON(); but an ext4_error() is really not appropriate.

Cheers,

					- Ted
