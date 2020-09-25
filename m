Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814F82792C7
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIYU41 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 16:56:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26554 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIYU41 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 16:56:27 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08PKtHlr027390;
        Fri, 25 Sep 2020 13:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XZRdlq6/5cPtTledetOwhGLEy+w9+vwNOQDR+1mt0T0=;
 b=KA8e0K+Nbt1VnMdd5DiszLECA6tZAm/BtDKM0FfhpciOflDf5gDHNGdmaNadxQL7WapR
 LkzozAFt0mWcDRgNmnNPzxv5NSyBdBCknwEnxPUmN0S7Xr8mihXdErGCTTJHh57uQH/L
 soZKXKnS5+d8/kaVnrRczqG2DEvZNQ6SW8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33s5ygcukh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 13:56:14 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 25 Sep 2020 13:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkIHkWp7pWnMxK0OLdTrvVstuJ/tKi790hqOwwPBrIPxjYpsBPvktClcgUFgDmkdDIJ+QS6G8EoJbmv732N1GtgeNnXWeyXkCDYnBV1Y/GrLKXqxiNSGeckL6k/ockGsS2ieswOI/9/bpTGPttnEAql9sAAe+a0fuEeFCZjM7Q/dRX/eBiu75zidpNUHIGMIiL8HNkqdvUlVkiES84la3nRmh06OYD3IgZN8dzHfGXqFBgWfPuRJeoB7Y04pgo/y0jrraNbRj2mYy+m5Kj6C4MFrVo3I+n1mYD5TmeTYu16r72OO6EnBUh2yzW37lMehwxpjGVA/jOBQm5Uz2Xuj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZRdlq6/5cPtTledetOwhGLEy+w9+vwNOQDR+1mt0T0=;
 b=YSknrLrt9gWhs5ECV+0csmGQpFOUvtuTF3AhxN0CmSdtAtX9gN0mvfGT7jvXaTLO2VFfV/0wGjCgDLPD5PsjqT2El206Qr+0NM0Bl9AT9g/3N+wH1cV6pd+vQFbMJhcV055t8N2ylic0qT3rB/FWhZx5a+T5nciYQI2y/zSQWvcsysrW2dbls7EFf08Jo65v3zBnUf1ygzbBTBuYhnLzCT6QUgQMJQBeXYr9rW5h0382hPcPAWz3pZwV+afNSoU+/Auuir5gQoMkGDbpWN98G7DhZNpgTZ9Swhz2PzbnMIW+jK7hI3Jbo8Ie9LoGbAelSqbv1oVr4ZZvu4uS5ykoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZRdlq6/5cPtTledetOwhGLEy+w9+vwNOQDR+1mt0T0=;
 b=Zyalew/Kpf+jiRIqTwdzn1A4i94H3S3PTm8PmZszy0rdjg1Wn2a7/FEN7Ki0ybW/QuyhWaHq7BzNMsqDlLwwUKNmZw7hyiS17XFJkkQRtD4E1+f/guM+utqjRwxaY5yLYNWZXEZxae8wICCjzad7RFaDzInGao82uYIcKt+HoMQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3029.namprd15.prod.outlook.com (2603:10b6:a03:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 20:56:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 20:56:10 +0000
Date:   Fri, 25 Sep 2020 13:56:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925205604.GA2228989@carbon.dhcp.thefacebook.com>
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
 <20200925191902.543953-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925191902.543953-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:d27c) by MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 20:56:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:d27c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c67c9ee-c922-4bfb-aad1-08d861956dff
X-MS-TrafficTypeDiagnostic: BYAPR15MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3029AF618C205F02CCAB9177BE360@BYAPR15MB3029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oT2LBpuiEkM48zUOTWW5uDWTAo5QKDI+GPe0928fgQ139s6MhRBlSyEEFXyg9HoDsf+TURS8wR+OeCKMfaq0wD4eFKJkDw94pfCEDvUfW7airmlB3m+0aCZowLj6IPxGjl+Tt9DJ8+hDQ5kZYPn4IvC4CilwXjyB0sIce8bQbSqosLv1VgKS9Jplts1l/PHlxo3iS4VA1w/JnDwnAQUG5svk+nE4KEOI+Qo3t/SmXwmRMltHb/zWSvjplsuJvwZrzkeU8XrDb7FHz89820Ki8K9jSuElt6tCVzzimYS4cUhdfkYV8F+MezWWrPF+GFYQ8H8tcjb9ZDTAbKGurzoFDRX+ECr8nRn8YnRQVTvYsoPYilvasM0QtUcW5WkhxZFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(53546011)(6506007)(6916009)(186003)(52116002)(33656002)(7696005)(316002)(54906003)(83380400001)(9686003)(4326008)(478600001)(16526019)(55016002)(86362001)(8936002)(5660300002)(1076003)(6666004)(2906002)(66476007)(66556008)(7416002)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3mYkak78m9wbDw84Y1xHz6DktrFO4YoeJTetXgYrtX7Eg4OsSjxP2bYdDi+03IfbSwHH7BIo7kAnot0SNlGQ/ZqKxOAj/1rA0LGI2NXji8Hj0gOY50sTC1akhvEp2VDgcPavvwM9Nti6oNxZ92eoqSCr34sRWROJ646ftWc1y8slVX5d6whN8Y+dmBasRDSUSwVtFVYArNQ/rwhzxlPDu1SDPz8L8rC5Xpj9VDZ+HMBxyTlC4FuZLHEg/ORnVwqoiq1hjDjvNCE659smcBAsunnPCde7+NXsytdGuZlsuo/VkNurkxCWDr9czM7fJXz2MaZypFKzNjBUZGazfkSEjrw7bh/Wjf2Jeo91lGKGCbbadyRO7yvo3scUzJiDUx+51ON+GgUvv8/1lCZzMI15nISDe8I+xvalGJIQ3I6iMYTMlDHvxySyZvo6WQ3lGxjgqMSlkoZWYxwXJ969i5TWSrOxqPb1WzFLP4ift23UyIR8djgLmR+n9mv2jsSGn/PSkfdV8xn8exbeMXlUalzxN+uDXu3W5tIrxCVyoUHf/5wrllKzyBtFR0LHXYcZd/B76+MXzwAdD7m2Ubp9mO+gFAND9aZ8UCGfHBuElVw1MetdmrMK2cZ8KcgKVKsJV2AurxHZ5U9wegDxKcC3Chj7T60s/SUAPO09Z+bagN5Oqlc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c67c9ee-c922-4bfb-aad1-08d861956dff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 20:56:09.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUqnNaQEG+9N4CFaFaljvvIkgtywUzl9PGlQ7ZiHT5TRxX1aKVnnMShnLvC3jVBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_19:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=5
 spamscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009250151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 12:19:02PM -0700, Shakeel Butt wrote:
> On Fri, Sep 25, 2020 at 10:58 AM Shakeel Butt <shakeelb@google.com>
> wrote:
> >
> [snip]
> >
> > I don't think you can ignore the flushing. The __free_once() in
> > ___cache_free() assumes there is a space available.
> >
> > BTW do_drain() also have the same issue.
> >
> > Why not move slabs_destroy() after we update ac->avail and memmove()?
> 
> Ming, can you please try the following patch?
> 
> 
> From: Shakeel Butt <shakeelb@google.com>
> 
> [PATCH] mm: slab: fix potential infinite recursion in ___cache_free
> 
> With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations"), it becomes possible to call kfree()
> from the slabs_destroy(). However if slabs_destroy() is being called for
> the array_cache of the local CPU then this opens the potential scenario
> of infinite recursion because kfree() called from slabs_destroy() can
> call slabs_destroy() with the same array_cache of the local CPU. Since
> the array_cache of the local CPU is not updated before calling
> slabs_destroy(), it will try to free the same pages.
> 
> To fix the issue, simply update the cache before calling
> slabs_destroy().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

I like the patch and I think it should fix the problem.

However the description above should be likely asjusted a bit.
It seems that the problem is not necessary caused by an infinite recursion,
it can be even simpler.

In cache_flusharray() we rely on the state of ac, which is described
by ac->avail. In particular we rely on batchcount < ac->avail,
as we shift the batchcount number of pointers by memmove.
But if slabs_destroy() is called before and leaded to a change of the
ac state, it can lead to a memory corruption.

Also, unconditionally resetting ac->avail to 0 in do_drain() after calling
to slab_destroy() seems to be wrong.
It explains double free BUGs we've seen in stacktraces.

Thanks!

> ---
>  mm/slab.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 3160dff6fd76..f658e86ec8ce 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1632,6 +1632,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct page *page)
>  		kmem_cache_free(cachep->freelist_cache, freelist);
>  }
>  
> +/*
> + * Update the size of the caches before calling slabs_destroy as it may
> + * recursively call kfree.
> + */
>  static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
>  {
>  	struct page *page, *n;
> @@ -2153,8 +2157,8 @@ static void do_drain(void *arg)
>  	spin_lock(&n->list_lock);
>  	free_block(cachep, ac->entry, ac->avail, node, &list);
>  	spin_unlock(&n->list_lock);
> -	slabs_destroy(cachep, &list);
>  	ac->avail = 0;
> +	slabs_destroy(cachep, &list);
>  }
>  
>  static void drain_cpu_caches(struct kmem_cache *cachep)
> @@ -3402,9 +3406,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  	}
>  #endif
>  	spin_unlock(&n->list_lock);
> -	slabs_destroy(cachep, &list);
>  	ac->avail -= batchcount;
>  	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
> +	slabs_destroy(cachep, &list);
>  }
>  
>  /*
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
