Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08454278FDD
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgIYRr6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:47:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgIYRr6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 13:47:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08PHjsiI023839;
        Fri, 25 Sep 2020 10:47:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DnFy8uj7Tw6g+S0XkByhMwj3z2lwQXAbspqNU1Froc4=;
 b=HxYkFGCcPiu6zLDK+icpQGFLcfvk3Dtq4stJBPy5l0IBsYs2YUKPoeR8XFvK5lLBZW1i
 cd9JjhaSJKeSN9kQcOl9BB00tGnoP3cRHiC7vxALdqa2EIwlNxjm6b2ACmjosk8u/HUK
 PMRxs+2Qjk1SrPODQjihbLWtLDFFIIx012w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp88py4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 10:47:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 25 Sep 2020 10:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5cUmJAiG9zzCioJ1guv0FVU0jH6B0Amu9D0xr0YMNyMkEfuMQOLOR5x6CC3hf/HJD4DfdzrmaBEDTbCSRKLZVqhWCs5J42h+UYb5qdURdzv3Swf1q96FM1PwH2709d21liaJ8KWFfgamLHC13Q1qDDHBPjnoyEFkTsk5+B90Dj/asvFDQT4nlxA88nm3OR6zgXcC8yatnIOYZ2/ioweSaNtY9/xCz4D+zG8AZPO+PSSqIvNBrg2k0l69zaT7qgPkoL2gbkRo8R1VtX6t9g2p7wMy5SPL7KXtU51dDaSlGzH3h6m8PjUkFG4pwUbZVaA6PSsorXP0iLZexKr1LyluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnFy8uj7Tw6g+S0XkByhMwj3z2lwQXAbspqNU1Froc4=;
 b=MRaMVbacijgfxSJk+G/axkjjFo7pUcz9bKBkPtwzOslCh/TAs6rPLbC5Mm670kEpOMhzpFt9jKUrKfcDk/aGwbvS5O0Hy2UQT5y1lLj1MWUN5XwHGlD5LQ+keFnvs/ihl5tl6P1x0Cv27+OpJXx5YhD7n1dhplYV8IcM9S60N6J4+lIHtyBxxgh3RDZidHZ3CKDBFTZbIhd24o+uxe+KvJ5LOjXXlPGQCp7UYlKLq0HJwiNtCV/oLfP2Zf1bMr9SzTsu+eoHs5Kgt52diLg38JWbMcVoZmwnMBKGr7Ll0HLqhSd5z6aCIUtrkM6IZXLcwCmNfddz3Ei+cKv5AsEfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnFy8uj7Tw6g+S0XkByhMwj3z2lwQXAbspqNU1Froc4=;
 b=W01ET913s2dQq+1yU7CvMhMGVDpBW21AfxxKK0nkTgFFougFC6pVJtw3UKbRM6M/+QI6AmkasCYoluse5xqh/3OAcGwVsJG6CO5wxQpcEcI9Q+RIUHtajdoLUAAQA0JqL1XwJVm/zkhAPaWlHwWGzYZuhg1O+lGQ4uIVPKQGZwA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 17:47:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 17:47:45 +0000
Date:   Fri, 25 Sep 2020 10:47:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925174740.GA2211131@carbon.dhcp.thefacebook.com>
References: <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu>
 <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590>
 <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
 <CALvZod4+ucJfr4gR60mM1gRoc7NKWydPY-JQ757q+n8hOdmrvA@mail.gmail.com>
 <CALvZod4Wc23o09KXb+s=VJGs6X+8juuDXWfyfJuMH5DCksLtAQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Wc23o09KXb+s=VJGs6X+8juuDXWfyfJuMH5DCksLtAQ@mail.gmail.com>
X-ClientProxiedBy: MWHPR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:301:15::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:d27c) by MWHPR2001CA0008.namprd20.prod.outlook.com (2603:10b6:301:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 17:47:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:d27c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7243b41c-ac66-4293-4027-08d8617b1c16
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3144001594CAE348B5C49EC7BE360@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Xd/rw414oyUnoT56ADM22cAvnNZctaytVSyTjnidKFXPro998+nyFHYYWEUTzpP/Atu9VT5cda9rsNBmnucLs8Hv7r4UArlMvlM9DtXTeM4v0eDCxj82p0DH1N0hjZ6hCndMNaXFiq+bpJ9ACIdte6eAZMcZKdkCvJDD8zq4UzvgoxOBgfJqeQxTXRYqWwK4H5uGC4R7EV8rw+xldWg+FGnOWs+Knh4he+hEWInGntHk9l0gFJdjwV36M9iK+dsnFlpCWDsIM9VfiZJiQzNUwdzNoh+BSo2swksH3I8sLAdzXSp23wDbKbLnXj0D94gG3MjnPbJ8P0+xb/bkUGsYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(86362001)(83380400001)(4326008)(478600001)(6916009)(8676002)(5660300002)(2906002)(8936002)(9686003)(6506007)(186003)(16526019)(53546011)(6666004)(1076003)(33656002)(316002)(54906003)(7416002)(66556008)(7696005)(66946007)(52116002)(66476007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oqT+1CQ3glpNCa3wDmdWzM81U/WO2gBHViuIZktIFT9t9TKA36aZvqhELDLn3Tp4+mqsvCvDSfZgzKAvdmcOK9aHkvuYCjfmXPQL8sAmUs4FJax6y9acEgVEowtB7tF2rDBCGVRik9LmPqc0dhK5rd0Ixum/0suTBMC+BOOzhVRiX2Mkw5vHoE6owk8+RE+LIgg0eod240L1xqEL2Fd+1fZwqMZYbpoBd6hKehELmB7JIswGutJ8eZJe+9TgYXpA/Jkcn2OSvmd4I/X5BuYatthq5mBJIVFtDY5pmYgLWTKDcZJruxx+R0D37wqte6cDZFvrVL/HLeqdD/JCZl4kdXttV+riKvjDilMeUd7/sLPVZXYnzlWhF4SkMShZzYPhmWip5RAcASV108I1KdSIvcguRWjqXqGgAHgsnUQA/bVej7BdmJhHef/N/46utaS3OgKdW+9uLxaGVga3RYBJ6CvVxBUvwX15medG8g2KqR5DA1vzznFQrGX3IdJc9pEv++TbL1EUngIHhupu19xEm72YaX4dxXpdZH24fP+jB4uGVZRn8abGKeJtcqbIkx9yGsP1JlN5atglqW2f+NBtDeZ6wSbgfPLpoW/LYrWXvsWKW+r+JZxKtIw0Qg3pn6ERkyKH59DNkfEGUKOHnfRe8II7CFO8Vrrpe6U3uyOwtNM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7243b41c-ac66-4293-4027-08d8617b1c16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 17:47:45.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YMyzcb5LhZDiLI3xLR05YDhTn1bDFGTIX5NviA93jJjwf44+6476UpjL0Sr1xoX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_15:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=5
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009250124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 10:35:03AM -0700, Shakeel Butt wrote:
> On Fri, Sep 25, 2020 at 10:22 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Sep 25, 2020 at 10:17 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > git bisect shows the first bad commit:
> > > >
> > > >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> > > >                 kmem_caches for all allocations
> > > >
> > > > And I have double checked that the above commit is really the first bad
> > > > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > > > is LIST_POISON1 (dead000000000100)',
> > >
> > > Thet commit doesn't revert cleanly, but I think that's purely because
> > > we'd also need to revert
> > >
> > >   849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
> > >   74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
> > > (un)account_slab_page()")
> > >
> > > too.
> > >
> > > Can you verify that a
> > >
> > >     git revert 74d555bed5d0 849504809f86 10befea91b61
> > >
> > > on top of current -git makes things work for you again?
> > >
> > > I'm going to do an rc8 this release simply because we have another VM
> > > issue that I hope to get fixed - but there we know what the problem
> > > and the fix _is_, it just needs some care.
> > >
> > > So if Roman (or somebody else) can see what's wrong and we can fix
> > > this quickly, we don't need to go down the revert path, but ..
> > >
> >
> > I think I have a theory. The issue is happening due to the potential
> > infinite recursion:
> >
> > [ 5060.124412]  ___cache_free+0x488/0x6b0
> > *****Second recursion
> > [ 5060.128666]  kfree+0xc9/0x1d0
> > [ 5060.131947]  kmem_freepages+0xa0/0xf0
> > [ 5060.135746]  slab_destroy+0x19/0x50
> > [ 5060.139577]  slabs_destroy+0x6d/0x90
> > [ 5060.143379]  ___cache_free+0x4a3/0x6b0
> > *****First recursion
> > [ 5060.147896]  kfree+0xc9/0x1d0
> > [ 5060.151082]  kmem_freepages+0xa0/0xf0
> > [ 5060.155121]  slab_destroy+0x19/0x50
> > [ 5060.159028]  slabs_destroy+0x6d/0x90
> > [ 5060.162920]  ___cache_free+0x4a3/0x6b0
> > [ 5060.167097]  kfree+0xc9/0x1d0
> >
> > ___cache_free() is calling cache_flusharray() to flush the local cpu
> > array_cache if the cache has more elements than the limit (ac->avail
> > >= ac->limit).
> >
> > cache_flusharray() is removing batchcount number of element from local
> > cpu array_cache and pass it slabs_destroy (if the node shared cache is
> > also full).
> >
> > Note that we have not updated local cpu array_cache size yet and
> > called slabs_destroy() which can call kfree() through
> > unaccount_slab_page().
> >
> > We are on the same CPU and this recursive kfree again check the
> > (ac->avail >= ac->limit) and call cache_flusharray() again and recurse
> > indefinitely.

It's a coll theory! And it explains why we haven't seen it with SLUB.

> 
> I can see two possible fixes. We can either do async kfree of
> page_obj_cgroups(page) or we can update the local cpu array_cache's
> size before slabs_destroy().

I wonder if something like this can fix the problem?
(completely untested).

--

diff --git a/mm/slab.c b/mm/slab.c
index 684ebe5b0c7a..c94b9ccfb803 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -186,6 +186,7 @@ struct array_cache {
        unsigned int limit;
        unsigned int batchcount;
        unsigned int touched;
+       bool flushing;
        void *entry[];  /*
                         * Must have this definition in here for the proper
                         * alignment of array_cache. Also simplifies accessing
@@ -526,6 +527,7 @@ static void init_arraycache(struct array_cache *ac, int limit, int batch)
                ac->limit = limit;
                ac->batchcount = batch;
                ac->touched = 0;
+               ac->flushing = false;
        }
 }
 
@@ -3368,6 +3370,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
        int node = numa_mem_id();
        LIST_HEAD(list);
 
+       if (ac->flushing)
+               return;
+
+       ac->flushing = true;
+
        batchcount = ac->batchcount;
 
        check_irq_off();
@@ -3404,6 +3411,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
        spin_unlock(&n->list_lock);
        slabs_destroy(cachep, &list);
        ac->avail -= batchcount;
+       ac->flushing = false;
        memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
 }
 
