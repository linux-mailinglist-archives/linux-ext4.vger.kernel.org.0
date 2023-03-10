Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B005C6B536E
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjCJVwX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 16:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjCJVwC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 16:52:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A9FCC07;
        Fri, 10 Mar 2023 13:48:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EC2FCE2B13;
        Fri, 10 Mar 2023 21:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B9AC433A1;
        Fri, 10 Mar 2023 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678484860;
        bh=EsOBHp8t9CzgQxWYIIIPNWkvM51wVXZt/2pw31VcRPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CH6HuHmxIEHANw/hRdbE/AYHue7K/4CBFpJaLAbQVpnhxFxqF2UHOmmhMr41k/Yqs
         fAzEuQaz7JsZKmTQ/eZEV96q4pZg65YZF4MXz//jlLYhcXcceu++df6quM0KDkisZx
         M/V7UCH4A7PGRVvgZkLFGs1LrtsURWnkjVP0/rKCdDmZ1YGnq6FElKUD9ETQUnDJg7
         YLOuDPK6MtjRvftp3VLAzK/U9rLjKb0XGYzYpKIiNW5Ni+XfmzX8U+p+owWiHXp4cP
         RLpNnLpfUmoX13NwoFvRQhn0CWu20pAew40jDwAvuMs3DLacp7W2FB+vad/6nsQseQ
         ERSJTd9fQYcKw==
Date:   Fri, 10 Mar 2023 13:47:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZAulevdpZg/W/JbL@sol.localdomain>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
 <ZArRq/25a5Gt+YMB@sol.localdomain>
 <20230310064612.GQ3390869@ZenIV>
 <ZArULrNVaxl7e42r@sol.localdomain>
 <20230310070527.GS3390869@ZenIV>
 <20230310071231.GU3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310071231.GU3390869@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 07:12:31AM +0000, Al Viro wrote:
> 
> Out of curiosity (and that's already too brittle for practical use) -
> does DIV_ROUND_UP_ULL() do any better on full example?

'DIV_ROUND_UP_ULL(i_size_read(inode), i_blocksize(inode))' works properly with
clang but not gcc.   If i_blocksize() is changed to do '1U << inode->i_blkbits'
instead of '1 << inode->i_blkbits', it works with gcc too.

- Eric
