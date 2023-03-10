Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B26B36BB
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJGlG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJGlF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:41:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469BCF0EB;
        Thu,  9 Mar 2023 22:41:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8321A60D57;
        Fri, 10 Mar 2023 06:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A726FC4339B;
        Fri, 10 Mar 2023 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678430463;
        bh=plBP9xtYXP2I+FupQ173CX+ZuDUo4RXoMY/5XknZJQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVN06iiidwL5e+tS5lMUOzHoPflOolCexueJbeifBRqTxOVAc1ikk+e5WEEAVddse
         NWlgogJWIHUkh4t873sb53GbQPAvUTOrZaqCH3mHyhdnQXGd+SIzqpK/z1+Z7McwzY
         uQ9y5eOp3aEOyaYM2rEVE56M1NT/xbofRJab7XHJNqTvnaiSjLgcOKzdiZAVCcxWNr
         zTqEKotS4Tm68F0k88zAxe5Xy9mmd+OR7rQYbHOrwOTwIPcItGAVY8YlM0XC4ypdNU
         nYvzdHvcSlPawucx8YqH6otrWQaz2DlDV0H7stE8XOhMaNc/9L3BCLdK/73wSOvpxy
         OfPPWTFYBm+CA==
Date:   Thu, 9 Mar 2023 22:41:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        hsiangkao@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZArQ/WaBrw0LR56v@sol.localdomain>
References: <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310062738.69663-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310062738.69663-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 02:27:38PM +0800, Yangtao Li wrote:
> > Please don't do this.  This makes the code compile down to a division, which is
> > far less efficient.  I've verified this by checking the assembly generated.
> 
> How much is the performance impact? So should the following be modified as shift operations as well?
> 
> fs/erofs/namei.c:92:    int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> fs/erofs/zmap.c:252:    const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> fs/erofs/decompressor.c:14:#define LZ4_MAX_DISTANCE_PAGES       (DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
> fs/erofs/decompressor.c:56:                                     DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> fs/erofs/decompressor.c:70:     unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> fs/erofs/data.c:84:     nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> 

No, compilers can handle division by a power-of-2 constant just fine.  It's just
division by a non-constant that is inefficient.

- Eric
