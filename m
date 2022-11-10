Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC436239F5
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKJCrl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiKJCrk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:47:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1318383
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:47:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E7F0B82053
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 02:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE06C433D6;
        Thu, 10 Nov 2022 02:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668048456;
        bh=L+Uqwg2wLhfKrfuCf6FbvGQZAKxTgEfUj9wJB4PzXXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBM5IOLE2ZPXniO8G7k/hUvYrz57P8WS7q1GO3oQBos1hZ7aWH/iMJ1b1w03KqgH1
         L2XYaOHSTFNQ2RqbNhoXqZ1l5du6dyvu5rYG5AJIFzaOaNRSYbIyvpLCmihB+feq9z
         J0GMbDQCvQZaFEge9ZxeSAEmFOWIF7VsdWrlxVqV9LpudXq0Zczx254BYjsfbtedqk
         wbqS36St1lueJxtpMF6Npf4iRUWC7J1wuGLqJlS/gNMhmc+y9edvBGYYztPRCUfhGR
         a0Q+ehTpSyyEgZLHRgQoGXLhrJ786II8bCkkh9XxAYTmE9Np666jgwvImgPJtAFQh6
         CMYPgI9VXt2bg==
Date:   Wed, 9 Nov 2022 18:47:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: replace kmem_cache_create with KMEM_CACHE
Message-ID: <Y2xmRmGY7lfg/sbt@sol.localdomain>
References: <20221109153822.80250-1-sunjunchao2870@gmail.com>
 <Y2vqs7/Djy22B6XE@sol.localdomain>
 <CAHB1NaidN+FquNh2z-UXW8cycM-X5h+6T=XX=fEFyt2VkwXGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NaidN+FquNh2z-UXW8cycM-X5h+6T=XX=fEFyt2VkwXGvw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 10, 2022 at 08:53:26AM +0800, JunChao Sun wrote:
> Yeah, maybe we should remove the SLAB_RECLAIM_ACCOUNT flag for static
> slab, and 16828088f9e51815 ("ext4: use KMEM_CACHE instead of
> kmem_cache_create") have done so. But should we remove
> SLAB_RECLAIM_ACCOUNT in this patch or belong to a separate patch?

I'd just keep the slab flags the same in this patch.  If any flags do need to be
changed, that should be a separate patch.

I think SLAB_RECLAIM_ACCOUNT is meant for for things that are directly
reclaimable, such as struct ext4_inode_info.  Inodes are evictable, and when
that happens, the corresponding struct ext4_inode_info gets freed.

bio_post_read_ctx_cache probably should use SLAB_TEMPORARY instead, since it is
only used for temporary structures during I/O.

That being said, SLAB_TEMPORARY is currently #define'd to SLAB_RECLAIM_ACCOUNT,
so currently it makes no difference in practice...

- Eric
