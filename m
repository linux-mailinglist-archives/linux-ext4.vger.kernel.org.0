Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45DB485FEB
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiAFEhs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:37:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39074 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbiAFEhs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:37:48 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064bg1f002504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:37:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 22C6815C00E1; Wed,  5 Jan 2022 23:37:42 -0500 (EST)
Date:   Wed, 5 Jan 2022 23:37:42 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] ext4: Simplify !page_bufs logic with simple BUG_ON()
Message-ID: <YdZyFnRH90FfeJLw@mit.edu>
References: <20211228073252.580296-1-xu.xin16@zte.com.cn>
 <4088b190f4367763c447f22e39ecb35de324f19e.1641371169.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4088b190f4367763c447f22e39ecb35de324f19e.1641371169.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 05, 2022 at 02:06:56PM +0530, Ritesh Harjani wrote:
> Simplify !page_bufs logic with simple BUG_ON().
> 
> @@ -1879,10 +1879,7 @@ static int __ext4_journalled_writepage(struct page *page,
>  			goto out;
>  	} else {
>  		page_bufs = page_buffers(page);
> -		if (!page_bufs) {
> -			BUG();
> -			goto out;
> -		}
> +		BUG_ON(!page_bufs);
>  		ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
>  				       NULL, bget_one);
>  	}

This code was removed by:

    https://lore.kernel.org/r/20211225090937.712867-1-yi.zhang@huawei.com

... so this patch is no longer needed.

						- Ted
