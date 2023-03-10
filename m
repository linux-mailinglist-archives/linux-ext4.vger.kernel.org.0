Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746A66B3678
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCJGR2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCJGRY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:17:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81EBCBBB;
        Thu,  9 Mar 2023 22:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6418CB82150;
        Fri, 10 Mar 2023 06:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C0FC433D2;
        Fri, 10 Mar 2023 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678429038;
        bh=3KQoEB5xsbUba6lDC22OBK8J/6CcI/caBunnFrPzGqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzAeZrjeLE9bYoqbwv3FGQ3UoDO/5Q01Wg/FT2OuEBoQtuSSiy8Rx7rR4XjfQiNVh
         vFOlQD0BqlskUJgQPksOwJ0pMMH4INIP+tFSgWqaYoRXjuvKy2ZzwFDkwdYzW4Nt3r
         NXRWffhKhfJfMxtxZ0NpW5QjA1h0jz49z1pOy1kyriRUlKCBQJRq+sKPUG3RLbUs0S
         B4cPH82ZJw0ZAoJgmwbhN6vDh6tnLPcMj4Wok9ETs3C7w1O6vHDQ+cLphGmXbogpjk
         Y/t4bpPApCeg7TMFksHFwm+9Vh4U1XKmWFD7VHeG1ezxfZYjqVTyPxpPsC6KVSPFpq
         L2c1W0xX17gwA==
Date:   Thu, 9 Mar 2023 22:17:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZArLbO1ckmcXwQf0@sol.localdomain>
References: <20230310060734.8780-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310060734.8780-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> Just for better readability, no code logic change.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d251d705c276..d121cde74522 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
>  {
>  	struct inode *inode = mpd->inode;
>  	int err;
> -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> -							>> inode->i_blkbits;
> +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
>  

Please don't do this.  This makes the code compile down to a division, which is
far less efficient.  I've verified this by checking the assembly generated.

- Eric
