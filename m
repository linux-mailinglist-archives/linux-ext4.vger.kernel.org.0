Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3153CB11D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhGPDat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 23:30:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37210 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231230AbhGPDas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 23:30:48 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3RjJx020669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:27:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F2A554202F5; Thu, 15 Jul 2021 23:27:44 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:27:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 04/12] ss_add_info_dir: fix memory leak and check
 whether
Message-ID: <YPD8sGirl9D/3CyL@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-5-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-5-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:16PM +0800, wuguanghao wrote:
> In ss_add_info_dir(), need free info->info_dirs before return,
> otherwise it will cause memory leak. At the same time, it is necessary
> to check whether dirs[n_dirs] is a null pointer, otherwise a segmentation
> fault will occur.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>
> ---
>  lib/ss/help.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/ss/help.c b/lib/ss/help.c
> index 5204401b..6768b9b1 100644
> --- a/lib/ss/help.c
> +++ b/lib/ss/help.c
> @@ -148,6 +148,7 @@ void ss_add_info_dir(int sci_idx, char *info_dir, int *code_ptr)
>      dirs = (char **)realloc((char *)dirs,
>  			    (unsigned)(n_dirs + 2)*sizeof(char *));
>      if (dirs == (char **)NULL) {
> +	free(info->info_dirs);
>  	info->info_dirs = (char **)NULL;
>  	*code_ptr = errno;
>  	return;

Adding the free() isn't right fix.  The real problem is that this line
should be removed:

  	info->info_dirs = (char **)NULL;

The function is trying to add a string (a directory name) to list, and
the realloc() is trying to extend the list.  If the realloc fils, we
shouldn't be zapping the original list.  We should just be returning,
and leaving the original list of directories unchanged and untouched.

    	    		      	 	     - Ted
