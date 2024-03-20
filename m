Return-Path: <linux-ext4+bounces-1702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A5880A95
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 06:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E080B22294
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1214A96;
	Wed, 20 Mar 2024 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kSLwH3Vp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0E12E40;
	Wed, 20 Mar 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912014; cv=none; b=OFebf996OwnaL5OMUw2I+S5neQ9+wznGBYmYSkt7f3lOuqoTr/60HXVppGC6vR2G18MBK6QIqRVcsw4HaOxXgjYr7l/tnaAW2EBVQ4YK49b81t7/cIik2kgEP414Flk8cjHIiG4pNMDgQTxWsbsBx5p2Eg2L7BCegzlKku5mOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912014; c=relaxed/simple;
	bh=9r0ksp3q7+QEWSYdR3N++UiGCzkrkjgIP2YI1PqXznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8hV7ZJxQch4NP5r2v/HRhEm/nnB7ZiCWAFX71lXyYVXGaFv9uqAO5bsbiUVoNjYMnTXiNWud7hgtJlb9BPvZvofAkqSuEGXkLT9V2rnhXpUCI2fUPJ4o7J5jWkyYPUD1P1rLttAj20DIr0Fvvkzo9Zos+ZpB0GKChkifE8dhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kSLwH3Vp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K3RvAU008352;
	Wed, 20 Mar 2024 05:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=+V7jZmMeVZisCRlxP948QB+T8M0EKOj0gLGkvfjICuo=;
 b=kSLwH3Vp3Upz1DXxL08GRJigMfgFk94v5nSRBMaDdwSeqiN/igYj3qF+w5C/NJVKC1zU
 jkSwyfuu4+952HHZKw7YQab9FDBC8yFLWf/ht0gfJqCp5Vl44PPriGNjnoFi3dK4CtJv
 3XrSK9V3ctIOCegvhX+2jC0xHki2U+wcSqFUgip1wuqqMY7U3hjyTNjHo5lrQoZyaw35
 /BC23ksZozZlPiIublEkI8lSoZSS42jsiE21DVa29tRjt71P3GA5vKV+b9SdF+Nl4HGI
 Er0t9t0UnDubohQ7/OZ+7t+02RiHAXrt4FaRQ6YX8JZ+OMNku642hlLwK4R3gyQNTu+M CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyqwh8567-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:19:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K5Jr64025981;
	Wed, 20 Mar 2024 05:19:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyqwh8566-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:19:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K3IXvo002799;
	Wed, 20 Mar 2024 05:19:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2kttx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:19:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K5JmrL41746906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 05:19:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFFCD2004E;
	Wed, 20 Mar 2024 05:19:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40D3920040;
	Wed, 20 Mar 2024 05:19:45 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.43.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 05:19:44 +0000 (GMT)
Date: Wed, 20 Mar 2024 10:49:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <Zfpx7TWG5z3HXtnZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <469c58c5-1095-cb9d-bd1d-514476e262e0@huawei.com>
 <ZfnYmzPIQfbtITPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <340be7bb-c5e6-7140-5e19-cb63d44e6149@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340be7bb-c5e6-7140-5e19-cb63d44e6149@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o6v9U6XlfJFe8p3LOPf2ALjQnRjX19A9
X-Proofpoint-GUID: 8z3-s8xRRGE6BgQC695ofDNC6JF3_7aW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200039

On Wed, Mar 20, 2024 at 09:30:57AM +0800, Baokun Li wrote:
> On 2024/3/20 2:25, Ojaswin Mujoo wrote:
> > On Tue, Mar 19, 2024 at 06:05:53PM +0800, Baokun Li wrote:
> > > On 2024/3/18 20:39, Ojaswin Mujoo wrote:
> > > > On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
> > > > > --- a/fs/ext4/mballoc.c
> > > > > +++ b/fs/ext4/mballoc.c
> > > > > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> > > > >       return 0;
> > > > >     if (order == MB_NUM_ORDERS(sb))
> > > > >       order--;
> > > > > + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > > > > +   order = MB_NUM_ORDERS(sb) - 1;
> > > > Hey Baokun,
> > > Hi Ojaswin,
> > > > Thanks for fixing this. This patch looks good to me, feel free to add:
> > > > 
> > > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Thanks for the review!
> > > > my comments after this are less about the patch and more about some
> > > > thoughts on the working of average fragment lists.
> > > > 
> > > > So going through the v2 and this patch got me thinking about what really
> > > > is going to happen when a user tries to allocate 32768 blocks which is also
> > > > the maximum value we could have in say ac->ac_g_ex.fe_len.
> > > > 
> > > > When this happens, ext4_mb_regular_allocator() will directly set the
> > > > criteria as CR_GOAL_LEN_FAST. Now, we'll follow:
> > > > 
> > > > ext4_mb_choose_next_group_goal_fast()
> > > >     for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
> > > > 
> > > > Here, mb_avg_fragment_siz_order() will do something like:
> > > > 
> > > >     order = fls(32768) - 2 = 14
> > > >     ...
> > > >     if (order == MB_NUM_ORDERS(sb))
> > > >       order--;
> > > > 
> > > >     return order;
> > > > 
> > > > And we'll look in the fragment list[13] and since none of the groups
> > > > there would have 32768 blocks free (since we dont track it here) we'll
> > > > unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
> > > > (this will become a noop due to the way order and min_order
> > > > are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
> > > > something or end up splitting.
> > > That's not quite right, in ext4_mb_choose_next_group_goal_fast() even
> > > though we're looking for the group with order 13, the group with 32768
> > > free blocks is also in there. So after passing ext4_mb_good_group() in
> > > ext4_mb_find_good_group_avg_frag_lists(), we get a group with 32768
> > > free blocks. And in ext4_mb_choose_next_group_best_avail() we were
> > Hey Baokun,
> > 
> > So IIUC, a BG with 32768 blocks free will have bb_fragments = 0 and in
> > mb_update_avg_fragment_size() we exit early if a BG has bb_fragments = 0
> > hence it won't show up in the order 13 list.
> Hello Ojaswin,
> 
> This sounded strange, so I added the following debugging information:
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c65fac9b8c72..c6ec423e2971 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1212,6 +1212,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
>                         i = mb_find_next_zero_bit(bitmap, max, i);
>         }
>         grp->bb_fragments = fragments;
> +       pr_err(">>> greoup: %u, bb_free: %d, bb_fragments: %d\n",
> grp->bb_group, grp->bb_free, grp->bb_fragments);
> 
>         if (free != grp->bb_free) {
>                 ext4_grp_locked_error(sb, group, 0, 0,
> 
> 
> Then mount an ext4 image , wait for a moment , and got the
> following printout:
> 
> >>> greoup: 6, bb_free: 32768, bb_fragments: 1
> >>> greoup: 5, bb_free: 31741, bb_fragments: 1
> >>> greoup: 4, bb_free: 32768, bb_fragments: 1
> >>> greoup: 3, bb_free: 31741, bb_fragments: 1
> >>> greoup: 2, bb_free: 32768, bb_fragments: 1
> >>> greoup: 1, bb_free: 31741, bb_fragments: 1
> >>> greoup: 0, bb_free: 23511, bb_fragments: 1

Ahh right, the fragments would be 1 and not zero, my bad! Thanks
for testing this.

> > > supposed to allocate blocks quickly by trim order, so it's necessary
> > > here too. So there are no unnecessary loops here.
> > > 
> > > But this will trigger the freshly added WARN_ON_ONCE, so in the
> > > new iteration I need to change it to:
> > > 
> > > if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) + 1))
> > >          order = MB_NUM_ORDERS(ac->ac_sb) - 1;
> > > 
> > > In addition, when the block size is 4k, there are these limitations:
> > > 
> > > 1) Limit the maximum size of the data allocation estimate to 8M in
> > >      ext4_mb_normalize_request().
> > > 2) #define MAX_WRITEPAGES_EXTENT_LEN 2048
> > > 3) #define DIO_MAX_BLOCKS 4096
> > > 4) Metadata is generally not allocated in many blocks at a time
> > > 
> > > So it seems that only group_prealloc will allocate more than 2048
> > > blocks at a time.
> > > 
> > > And I've tried removing those 8M/2048/4096 limits before, but the
> > > performance of DIO write barely changed, and it doesn't look like
> > > the performance bottleneck is here in the number of blocks allocated
> > > at a time at the moment.
> > Ohh that's interesting, on paper I think it does seem like it should
> > improve the performance. I think if CR_GOAL_LEN_FAST can start including
> > blocks which are completely empty, and lift those restrictions then we
> > might see better performance. I'll try to play around a bit with this as
> > well.
> > 
> > Regards,
> > ojaswin
> > 
> OK, waiting for your good news.

:) 
> 
> -- 
> With Best Regards,
> Baokun Li
> .

