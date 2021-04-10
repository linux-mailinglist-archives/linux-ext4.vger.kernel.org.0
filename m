Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947CB35AA84
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 05:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJDcX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 23:32:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32873 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229665AbhDJDbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 23:31:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A3UCti013647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 23:30:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E0D1615C3B12; Fri,  9 Apr 2021 23:30:11 -0400 (EDT)
Date:   Fri, 9 Apr 2021 23:30:11 -0400
From:   tytso@mit.edu
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Yi Li <yili@winhong.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        changfengnan <fengnanchang@foxmail.com>,
        Shijie Luo <luoshijie1@huawei.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix debug format string warning
Message-ID: <YHEbw84HHzViYQfj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409201211.1866633-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 09, 2021 at 10:12:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using no_printk() for jbd_debug() revealed two warnings:
> 
> fs/jbd2/recovery.c: In function 'fc_do_one_pass':
> fs/jbd2/recovery.c:256:30: error: format '%d' expects a matching 'int' argument [-Werror=format=]
>   256 |                 jbd_debug(3, "Processing fast commit blk with seq %d");
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ext4/fast_commit.c: In function 'ext4_fc_replay_add_range':
> fs/ext4/fast_commit.c:1732:30: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
>  1732 |                 jbd_debug(1, "Converting from %d to %d %lld",
> 
> The first one was added incorrectly, and was also missing a few newlines
> in debug output, and the second one happened when the type of an
> argument changed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: d556435156b7 ("jbd2: avoid -Wempty-body warnings")
> Fixes: 6db074618969 ("ext4: use BIT() macro for BH_** state bits")
> Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied, with one change.

> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 69f18fe20923..60601c5779f1 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -245,15 +245,15 @@ static int fc_do_one_pass(journal_t *journal,
>     ....
>  
>  		if (err) {
> -			jbd_debug(3, "Fast commit replay: read error");
> +			jbd_debug(3, "Fast commit replay: read error\n");
>  			break;
>  		}
>  
> -		jbd_debug(3, "Processing fast commit blk with seq %d");
> +		jbd_debug(3, "Processing fast commit blk with seq\n");

This debug statement isn't adding any real value, so I just removed
it.

				- Ted
