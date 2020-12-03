Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4779D2CD310
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 10:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgLCJ6p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 3 Dec 2020 04:58:45 -0500
Received: from smtp.h3c.com ([60.191.123.50]:59635 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388483AbgLCJ6o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Dec 2020 04:58:44 -0500
X-Greylist: delayed 6058 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 04:58:42 EST
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 0B38Hgsh099569
        for <linux-ext4@vger.kernel.org>; Thu, 3 Dec 2020 16:17:42 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
        by h3cspam02-ex.h3c.com with ESMTP id 0B38FxA0095873;
        Thu, 3 Dec 2020 16:15:59 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 16:16:02 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Thu, 3 Dec 2020 16:16:02 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Jan Kara <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ext4: remove the null check of bio_vec page
Thread-Topic: [PATCH] ext4: remove the null check of bio_vec page
Thread-Index: AQHWpruDhYzwIts0bkGkoCqDPV0JCqmhVUyAgAQSuiD//39fAIBAY6/Q
Date:   Thu, 3 Dec 2020 08:16:01 +0000
Message-ID: <6859d08c4dd44de9b7a040c160046359@h3c.com>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
 <20201021102503.GC19726@quack2.suse.cz>
 <113ad7d2cbfd43a9972ad37df66e5542@h3c.com>
 <20201023165644.GG9119@quack2.suse.cz>
In-Reply-To: <20201023165644.GG9119@quack2.suse.cz>
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
X-MAIL: h3cspam02-ex.h3c.com 0B38FxA0095873
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan
Hi Ted Tso, Could I get your opinion of this patch?  thanks

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Saturday, October 24, 2020 12:57 AM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: Jan Kara <jack@suse.cz>; tytso@mit.edu; adilger.kernel@dilger.ca; linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page

On Fri 23-10-20 16:38:16, Tianxianting wrote:
> Thanks Jan
> Can be the patch applied?

Ted Tso is the ext4 maintainer so he should eventually pick up and apply the patch. But since there's merge window currently open, I guess he's busy shuffling patches to send to Linus. I'd expect he'll get to your patch in a week or two.

								Honza

> 
> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz]
> Sent: Wednesday, October 21, 2020 6:25 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: tytso@mit.edu; adilger.kernel@dilger.ca; jack@suse.cz; 
> linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ext4: remove the null check of bio_vec page
> 
> On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> > bv_page can't be NULL in a valid bio_vec, so we can remove the NULL 
> > check, as we did in other places when calling
> > bio_for_each_segment_all() to go through all bio_vec of a bio.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> 
> Thanks for the patch. It looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/ext4/page-io.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c index
> > defd2e10d..cb135a944 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -111,9 +111,6 @@ static void ext4_finish_bio(struct bio *bio)
> >  		unsigned under_io = 0;
> >  		unsigned long flags;
> >  
> > -		if (!page)
> > -			continue;
> > -
> >  		if (fscrypt_is_bounce_page(page)) {
> >  			bounce_page = page;
> >  			page = fscrypt_pagecache_page(bounce_page);
> > --
> > 2.17.1
> > 
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
