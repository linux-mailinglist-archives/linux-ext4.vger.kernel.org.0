Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622F6B36E6
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCJGyp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJGyo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:54:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381160A8F;
        Thu,  9 Mar 2023 22:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D731EB82150;
        Fri, 10 Mar 2023 06:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797B8C433EF;
        Fri, 10 Mar 2023 06:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678431280;
        bh=Bu5tDIHBLFUCQZoY3qbp4UXGwqPmi3R7ym2zrBVXXbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjnshkUpe2MV75sBlOBTNzfXrxp/ypYEMNgmZ7GprVSPMl80ACwrzoC+qeoYDpLc+
         3jTd+wa+8lO0YYSzMlMEJjUrOd0Q/LdOVXI4BASxQNfhYjGMpP6Z0huAXR55w0xBpR
         m+uPFbm0a5yseE/ETDI38WklhmGE/3A99XSWQsWdcY7MWJPLRdVtCUlpBtG/t7IOB5
         JRvXEVGvKh4vkLHNIkkLlVU9OIVjjFnT3qcWQcRJouhZmi8ansWz5uNuxmkZvLP+Pw
         fo5h4LVUfIsFuNI7DThFiabp+ZVsnRdMxciQBwjU2UGmwqoC4cXz1qJr60Zog5n8FS
         TFYerntfqyGmQ==
Date:   Thu, 9 Mar 2023 22:54:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZArULrNVaxl7e42r@sol.localdomain>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
 <ZArRq/25a5Gt+YMB@sol.localdomain>
 <20230310064612.GQ3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310064612.GQ3390869@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 06:46:12AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 10:43:55PM -0800, Eric Biggers wrote:
> > On Fri, Mar 10, 2023 at 06:37:29AM +0000, Al Viro wrote:
> > > On Thu, Mar 09, 2023 at 10:17:16PM -0800, Eric Biggers wrote:
> > > > On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> > > > > Just for better readability, no code logic change.
> > > > > 
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > ---
> > > > >  fs/ext4/inode.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > index d251d705c276..d121cde74522 100644
> > > > > --- a/fs/ext4/inode.c
> > > > > +++ b/fs/ext4/inode.c
> > > > > @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> > > > >  {
> > > > >  	struct inode *inode = mpd->inode;
> > > > >  	int err;
> > > > > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > > > > -							>> inode->i_blkbits;
> > > > > +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
> > > > >  
> > > > 
> > > > Please don't do this.  This makes the code compile down to a division, which is
> > > > far less efficient.  I've verified this by checking the assembly generated.
> > > 
> > > Which compiler is doing that?
> > 
> > $ gcc --version
> > gcc (GCC) 12.2.1 20230201
> > 
> > i_blocksize(inode) is not a constant, so this should not be particularly
> > surprising.  One might hope that a / (1 << b) would be optimized into a >> b,
> > but that doesn't seem to happen.
> 
> It really ought to be a / (1u << b), though...

Sure, that does better:

uint64_t f(uint64_t a, int b)
{
        return a / (1U << b);
}

gcc:
	0000000000000000 <f>:
	   0:	48 89 f8             	mov    %rdi,%rax
	   3:	89 f1                	mov    %esi,%ecx
	   5:	48 d3 e8             	shr    %cl,%rax
	   8:	c3                   	ret

clang:
	0000000000000000 <f>:
	   0:	89 f1                	mov    %esi,%ecx
	   2:	48 89 f8             	mov    %rdi,%rax
	   5:	48 d3 e8             	shr    %cl,%rax
	   8:	c3                   	ret

But with a signed dividend (which is the case here) it gets messed up:

int64_t f(int64_t a, int b)
{
        return a / (1U << b);
}

gcc:
	0000000000000000 <f>:
	   0:	48 89 f8             	mov    %rdi,%rax
	   3:	89 f1                	mov    %esi,%ecx
	   5:	bf 01 00 00 00       	mov    $0x1,%edi
	   a:	d3 e7                	shl    %cl,%edi
	   c:	48 99                	cqto
	   e:	48 f7 ff             	idiv   %rdi
	  11:	c3                   	ret

clang:
	0000000000000000 <f>:
	   0:	89 f1                	mov    %esi,%ecx
	   2:	be 01 00 00 00       	mov    $0x1,%esi
	   7:	d3 e6                	shl    %cl,%esi
	   9:	48 89 f8             	mov    %rdi,%rax
	   c:	48 89 f9             	mov    %rdi,%rcx
	   f:	48 c1 e9 20          	shr    $0x20,%rcx
	  13:	74 06                	je     1b <f+0x1b>
	  15:	48 99                	cqto
	  17:	48 f7 fe             	idiv   %rsi
	  1a:	c3                   	ret
	  1b:	31 d2                	xor    %edx,%edx
	  1d:	f7 f6                	div    %esi
	  1f:	c3                   	ret
