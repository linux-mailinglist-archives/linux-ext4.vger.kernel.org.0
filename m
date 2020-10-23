Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29572974B5
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbgJWQi4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 23 Oct 2020 12:38:56 -0400
Received: from smtp.h3c.com ([60.191.123.56]:14920 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbgJWQi4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Oct 2020 12:38:56 -0400
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam01-ex.h3c.com with ESMTPS id 09NGcBMd034586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Oct 2020 00:38:11 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 24 Oct 2020 00:38:16 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Sat, 24 Oct 2020 00:38:16 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Jan Kara <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ext4: remove the null check of bio_vec page
Thread-Topic: [PATCH] ext4: remove the null check of bio_vec page
Thread-Index: AQHWpruDhYzwIts0bkGkoCqDPV0JCqmhVUyAgAQSuiA=
Date:   Fri, 23 Oct 2020 16:38:16 +0000
Message-ID: <113ad7d2cbfd43a9972ad37df66e5542@h3c.com>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
 <20201021102503.GC19726@quack2.suse.cz>
In-Reply-To: <20201021102503.GC19726@quack2.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 09NGcBMd034586
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan
Can be the patch applied?

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Wednesday, October 21, 2020 6:25 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: tytso@mit.edu; adilger.kernel@dilger.ca; jack@suse.cz; linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page

On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> bv_page can't be NULL in a valid bio_vec, so we can remove the NULL 
> check, as we did in other places when calling 
> bio_for_each_segment_all() to go through all bio_vec of a bio.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/page-io.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c index 
> defd2e10d..cb135a944 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -111,9 +111,6 @@ static void ext4_finish_bio(struct bio *bio)
>  		unsigned under_io = 0;
>  		unsigned long flags;
>  
> -		if (!page)
> -			continue;
> -
>  		if (fscrypt_is_bounce_page(page)) {
>  			bounce_page = page;
>  			page = fscrypt_pagecache_page(bounce_page);
> --
> 2.17.1
> 
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
