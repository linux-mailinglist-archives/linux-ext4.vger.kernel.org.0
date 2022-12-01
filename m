Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6AE63E864
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 04:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLADmy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 22:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLADmx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 22:42:53 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953731DEE;
        Wed, 30 Nov 2022 19:42:50 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B13gOfB016075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 22:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669866148; bh=HHMKJiwGtVJMemKzDYVijJgBIM/KPnDraMkJsfeud0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b954UygmgXwiI4MV5uNVOC6afHfu+RrnVqHmjEO0RvX5IgDkpzCNTTn2QB2pE+ZkS
         oDvldj1YmCOYp68224S6pok7vaL2t0GlYHLvYsopnnSVP9hNNIQhNy93nSfO3UtLcU
         L4WpM/Oq6HwonBXMXhGP1zc7B3iORPb0FkJGJt15z6nWmI9xHnoK2+NkRsC0w6IlkA
         ymvfho+iPwcpxYEYZkcpXASDxxHj/1o4dazhOfsnlIE2RpzzchcOHxxrfdXAacfr3E
         PAAfwJR/T3EHdNphh6jgjejhWO0rvKybuM6CCFdBsZv5BlR5wMO6hybQJerxsKgb6l
         AaqtnEn4HykgA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 242F815C46FB; Wed, 30 Nov 2022 22:42:24 -0500 (EST)
Date:   Wed, 30 Nov 2022 22:42:24 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        enwlinux@gmail.com, jack@suse.cz, lczerner@redhat.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, yebin10@huawei.com,
        ritesh.list@gmail.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH 0/2] ext4: fix a infinite loop in do_writepages after
 online resizing
Message-ID: <Y4gioFteBIg2WAEJ@mit.edu>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <166975630697.2135297.7495422853696969304.b4-ty@mit.edu>
 <3cd4e5d1-4837-a569-18b4-72fcaabf103d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd4e5d1-4837-a569-18b4-72fcaabf103d@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 30, 2022 at 10:08:13AM +0800, Baokun Li wrote:
> 
> But I thought this patch set was discarded because there was no
> "Reviewed-by".

No, it had just slipped through the cracks; and when I was going back
through patchwork to see what patches were outstanding, I came across
the patch set which had gotten missed during the last cycle; and I
didn't notice that it had been superceded with a newer patch which
achieved the same goal.

I'll drop it from the ext4 tree and then pick up your newer series.

          	     	      	   	- Ted
