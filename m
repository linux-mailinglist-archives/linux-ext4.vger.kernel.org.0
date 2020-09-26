Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858827974E
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Sep 2020 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgIZGnA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Sep 2020 02:43:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42896 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgIZGnA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 26 Sep 2020 02:43:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08Q6e4XY024040;
        Fri, 25 Sep 2020 23:42:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=T07AiwSeMicilDuHvo5Jjfy9JtGRm4j7/LJIDqQcri0=;
 b=i7eLVfT2aU+UsImiE9QfnxC5RIrKJUnY5xGCtVKZBP3M/ik3T2Bo/OlJub2s3+tQTuGu
 7oRYxe+FixVvd8wF57u92yixjN+BovMxlEFJkFfFXasDeMqz63bjorLIN6aug0z94yLg
 blIz19GWiSxdphFJeGrtps88hcfKgbwuhxY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33s8su5x8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 23:42:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 25 Sep 2020 23:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0ESo5UiBnF9fhUyQaVAP/KJqdBgDlw80y7u5mTGQH4A3971MZZPv7a3BWamrm7EqWa5dRU5L/4a29DqyUHeB1qSbKsPQWILHlRGiRkujsYvcf2kG7B+It+BL5a5Vr/c2JkM8Oq1kqTjVMbqO6Z9b/JSRCfwdBo8okMPjAhlFc8YtS8XpI8w22kdOoxHJkwP3PsgiXoiiGB/dWo50UiI8VXFT3ds+8lbH8GwPXECBTQ8PEROg8Az2N9YqaQDLNUlJhbkv07rEBthbfZKnFzfoHDauC2onSnhhc0irKbd5UfLvCZW+LEnJpzjyqGT7UFfe4S/r1J3k2cjlCju/hPqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07AiwSeMicilDuHvo5Jjfy9JtGRm4j7/LJIDqQcri0=;
 b=DS1bI72IGiMV0q0x/ntT/+7GLiAy7cUylYdj90kM27/pKfQNz7OzvTNPWIp+VHjY2IOSecOPTeYz0DW/hfIkRDS3+aO/cJjwPClVNUdNHKP5/eXxzwHn2xsm0HKfXNkjq4mZyqgOHZkrX/9J7W2BZW3IWFzD5GAZuWhQ2IX5JBuyOqv8k9xdBje0p2YxFaqcyn2ekrJeBcWiBJfcOR55TtSPdYz07xfTjp9oLqRH9MpAJl1IKcGIqfQMbs5F879/wHK5Og0+5x7Yn7OwWiWqgoHMTCXkn4g+JEtFG6TupEzV9lZf65crNNUGmG9CDgHM2qibyLf/THwYF8p50QX8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07AiwSeMicilDuHvo5Jjfy9JtGRm4j7/LJIDqQcri0=;
 b=IXfAF99GnVbOyI/iXFmst2NyELHfjEtYpx86irI0vVAx0cFv5gOOLZL3rSkYuTo9DPMqENzkPJKL7dMs+kIlQdZeZI5uuDsuQwrNxs+x53LvaaLszrVvuJbAT2o6YqeOp0cGp6KIJxywVkc6I30JWNgY+6EqIsUzmEbQlkiN144=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sat, 26 Sep
 2020 06:42:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Sat, 26 Sep 2020
 06:42:37 +0000
Date:   Fri, 25 Sep 2020 23:42:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <20200926064232.GA2240876@carbon.dhcp.thefacebook.com>
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
 <20200925191902.543953-1-shakeelb@google.com>
 <20200926014325.GA2516054@T590>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926014325.GA2516054@T590>
X-ClientProxiedBy: MWHPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:300:117::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:30da) by MWHPR03CA0008.namprd03.prod.outlook.com (2603:10b6:300:117::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Sat, 26 Sep 2020 06:42:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:30da]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e579ce10-c52a-477c-b1e3-08d861e75b86
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2710B257F49BE51392CF76CFBE370@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1IXlhGCAiRnMBDzhmWAeOqpwOOQ0ExDr9mAjZQeVwMbjzfqRSFFg0YwhuVbMvMblTdsiO1mFoKaPfu8SV3rA8/5YJbwZrdoPrVPhx7YjieHHdg0ZlgYt/CK+/axGRh12xR/hd3RUxYrp5+h0rUZWnrg0D2v8jKnm8R4HoOgc17BZ9b3iAwb/U1gMFxYduxfrrM13JbDjcpk6SYUvo7ctLA+TQdHHgP2D6BmZ16EhsL7N6LlgGfy4Nv6T9greC/7p1ynMwNcTrxt518zTpvfWlbie74OMfXA6LySZAcjMZbLVxFxv5hTT8gnAIxQB3N31Rm1dLCM9vyjBTalozl9XbYRZJ0+AeIkPxLesIugFnoeTE80hvSc8CQ07KoTjdON
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39860400002)(396003)(66946007)(9686003)(5660300002)(8676002)(8936002)(55016002)(7416002)(16526019)(54906003)(2906002)(53546011)(6506007)(1076003)(4326008)(316002)(66556008)(33656002)(478600001)(66476007)(186003)(86362001)(6916009)(7696005)(52116002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ozxl5aSYRamvm4c1lKMLGkUQ0u3PQ9A4E1Sz6ETGkii6KDvJKcxxuqEXKWCFpm4IV5nLkAxpfeV7d7lKMoT/JPaRYxDuY7H6/aKFBOaXiABYsSNlFqyaAk2uNiUrfQiiEgkWj9fMuZIf1Sthy/bVhAUntyOcBEHZ0VXoO1aMlBfVpDPfgjw0gbYTQgHsvhiTjwu1Vp2n0l35Er2ViDLOIFU9ey+NEctgPfU0DHC9LjulVXHPJwUNLtLdYq9LP6aacL0ofI1iArZMryy2doNWwpucv+uejhRa7sF7kwlAE9ixXgpdH7K1UT3gl6mJPFhGOoNrFE3oJ0+832mG9oNKUqQGoHFCmtyFg/bdyjRTKgj0GGIIdyCWCZtCnOaDvXEdAHYcrwAceCSKt84NWhrEF72SAVgSpzmchICABJDPYnyo2YdIttIjywiKpa5RezBByYfxCcpsZWJS4Np47TLqYEtVnkCjpq0XvlgT2dsy3kajg+TJSwj/oOWNyPkMh6RiKjWU15sx09kSSnMPymuQJi2/gla5K73CTRUU01V5TIRJFO/HbNfIz1kgzwHpf51/7jqeM98O+46nr9Y3CRNUgbJ/BPQwcGd01BIe/jdKiWnUNss5kYFLzzu/6x2sbQ7t0D6EfWKgM3jf7nX4VTxv6cE3RipVB5DHlWFTqPrcS2M=
X-MS-Exchange-CrossTenant-Network-Message-Id: e579ce10-c52a-477c-b1e3-08d861e75b86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 06:42:37.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rlu8+XtNGq2FQxLKcz+/TX/m3uo9JXKTxU3V/JwUvE1lQkKyYDqCSobIu9hHh2EU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-26_05:2020-09-24,2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=5
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260062
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 26, 2020 at 09:43:25AM +0800, Ming Lei wrote:
> On Fri, Sep 25, 2020 at 12:19:02PM -0700, Shakeel Butt wrote:
> > On Fri, Sep 25, 2020 at 10:58 AM Shakeel Butt <shakeelb@google.com>
> > wrote:
> > >
> > [snip]
> > >
> > > I don't think you can ignore the flushing. The __free_once() in
> > > ___cache_free() assumes there is a space available.
> > >
> > > BTW do_drain() also have the same issue.
> > >
> > > Why not move slabs_destroy() after we update ac->avail and memmove()?
> > 
> > Ming, can you please try the following patch?
> > 
> > 
> > From: Shakeel Butt <shakeelb@google.com>
> > 
> > [PATCH] mm: slab: fix potential infinite recursion in ___cache_free
> > 
> > With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
> > kmem_caches for all allocations"), it becomes possible to call kfree()
> > from the slabs_destroy(). However if slabs_destroy() is being called for
> > the array_cache of the local CPU then this opens the potential scenario
> > of infinite recursion because kfree() called from slabs_destroy() can
> > call slabs_destroy() with the same array_cache of the local CPU. Since
> > the array_cache of the local CPU is not updated before calling
> > slabs_destroy(), it will try to free the same pages.
> > 
> > To fix the issue, simply update the cache before calling
> > slabs_destroy().
> > 
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  mm/slab.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 3160dff6fd76..f658e86ec8ce 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -1632,6 +1632,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct page *page)
> >  		kmem_cache_free(cachep->freelist_cache, freelist);
> >  }
> >  
> > +/*
> > + * Update the size of the caches before calling slabs_destroy as it may
> > + * recursively call kfree.
> > + */
> >  static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
> >  {
> >  	struct page *page, *n;
> > @@ -2153,8 +2157,8 @@ static void do_drain(void *arg)
> >  	spin_lock(&n->list_lock);
> >  	free_block(cachep, ac->entry, ac->avail, node, &list);
> >  	spin_unlock(&n->list_lock);
> > -	slabs_destroy(cachep, &list);
> >  	ac->avail = 0;
> > +	slabs_destroy(cachep, &list);
> >  }
> >  
> >  static void drain_cpu_caches(struct kmem_cache *cachep)
> > @@ -3402,9 +3406,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
> >  	}
> >  #endif
> >  	spin_unlock(&n->list_lock);
> > -	slabs_destroy(cachep, &list);
> >  	ac->avail -= batchcount;
> >  	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
> > +	slabs_destroy(cachep, &list);
> >  }
> 
> The issue can't be reproduced after applying this patch:
> 
> Tested-by: Ming Lei <ming.lei@redhat.com>

Perfect, thank you very much for the confirmation!

Shakeel, can you, please, resend the patch with the proper fixes tag
and the updated commit log? Please, feel free to add
Reviewed-by: Roman Gushchin <guro@fb.com> .

Thank you!

Roman
