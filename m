Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D43CB145
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhGPEBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 00:01:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39829 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229507AbhGPEBs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 00:01:48 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3wjI1028804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:58:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 505204202F5; Thu, 15 Jul 2021 23:58:45 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:58:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 11/12] misc/lsattr: check whether path is NULL in
 lsattr_dir_proc()
Message-ID: <YPED9XnrrHFaC11p@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-12-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-12-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:23PM +0800, wuguanghao wrote:
> 
> diff --git a/misc/lsattr.c b/misc/lsattr.c
> index 0d954376..f3212069 100644
> --- a/misc/lsattr.c
> +++ b/misc/lsattr.c
> @@ -144,6 +144,12 @@ static int lsattr_dir_proc (const char * dir_name, struct dirent * de,
>  	int dir_len = strlen(dir_name);
>  
>  	path = malloc(dir_len + strlen (de->d_name) + 2);
> +	if (!path) {
> +		fprintf(stderr, "%s",
> +			_("Couldn't allocate path variable "
> +			  "in lsattr_dir_proc"));
> +		return -1;
> +	}

The string is missing a closing newline.  Also, why not?

		fputs(_("Couldn't allocate path variable in lsattr_dir_proc"),
		      stderr);

					- Ted
