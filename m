Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2252CD9DC
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgLCPJb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 10:09:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39421 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727037AbgLCPJb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 10:09:31 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3F8frj015037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 10:08:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3596D420136; Thu,  3 Dec 2020 10:08:41 -0500 (EST)
Date:   Thu, 3 Dec 2020 10:08:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
Message-ID: <20201203150841.GM441757@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764698-4269-4-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 07, 2020 at 11:58:14PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In order to avoid poor search efficiency of system_zone, the
> system only adds metadata of some sparse group to system_zone.
> In the meta_bg scenario, the non-sparse group may contain gdt
> blocks. Perhaps we should add these blocks to system_zone to
> improve fault tolerance without significantly reducing system
> performance.

> @@ -226,13 +227,16 @@ int ext4_setup_system_zone(struct super_block *sb)
>  
>  	for (i=0; i < ngroups; i++) {
>  		cond_resched();
> -		if (ext4_bg_has_super(sb, i) &&
> -		    ((i < 5) || ((i % flex_size) == 0))) {
> -			ret = add_system_zone(system_blks,
> -					ext4_group_first_block_no(sb, i),
> -					ext4_bg_num_gdb(sb, i) + 1, 0);
> -			if (ret)
> -				goto err;
> +		if ((i < 5) || ((i % flex_size) == 0)) {

If we're going to do this, why not just drop the above conditional,
and just always do this logic for all block groups?

> +			gd_blks = ext4_bg_has_super(sb, i) +
> +				ext4_bg_num_gdb(sb, i);
> +			if (gd_blks) {
> +				ret = add_system_zone(system_blks,
> +						ext4_group_first_block_no(sb, i),
> +						gd_blks, 0);
> +				if (ret)
> +					goto err;
> +			}

						- Ted
