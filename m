Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206ED6C6AA3
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCWOTq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjCWOTP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:19:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5135EE7
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:19:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEInaa001556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679581131; bh=cGD8jvsfa9IIYRW5RRrX3cUET8CNS99iIvfOWiCAkM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a8gn2XBSn61rTvA9THZMLq1sHhazldZ6opzjvVDg7Pr1ea4gSPtgwMQxuAplyBxJ/
         SH8HJFsUOGpi/y/JZcBUKZj6WOpOvHagaQQyMgzy7cuDCuEfXKSVAWhKIfFhji6Uvg
         h1YnLBt5rqGsYdSVM3uxzZ+b/cvgVNSFB0P7m/epKz1tK/edoAZQey7wZcl/1FzdiD
         v9JvxxmxULL2NIthhGI9ZVACQLVtz2N7/Co9GgWLt0105/CJz7K7UBScaT+E3gE43N
         1lONi5UFR9RdwM2+zkGm06kA+P9iVJ5rW392yI877lUhWrY/zHdiKZv43CDVqHlcto
         ijOvmkONLn+1w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 424E815C4279; Thu, 23 Mar 2023 10:18:49 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:18:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com, jack@suse.cz
Subject: Re: [PATCH] ext4: avoid to access uninitialized block_cluster
Message-ID: <20230323141849.GA136146@mit.edu>
References: <20230320212106.4164212-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320212106.4164212-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 21, 2023 at 05:21:06AM +0800, Kemeng Shi wrote:
> If inode bitmap block and block bitmap block are in different group,
> there is a risk to access uninitialized block_cluster in
> ext4_num_overhead_clusters. Initialize block_cluster to -1 to fix this.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303171446.eLEhZzAu-lkp@intel.com/
> Fixes: e3c70113e2cb ("ext4: improve inode table blocks counting in ext4_num_overhead_clusters")

Thanks for the fix-up and to Dan and the zero-day test bot for noting
the problem.  Since I've needed to rebase the ext4 dev tree to pick up
an urgent fixup as well as deal with some other problematic commits,
I've merged this fix into the base commit "ext4: improve inode table
blocks counting in ext4_num_overhead_clusters".

Cheers,

					- Ted
