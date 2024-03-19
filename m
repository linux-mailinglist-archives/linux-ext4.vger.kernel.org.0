Return-Path: <linux-ext4+bounces-1699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF08804C0
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8A928526C
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F52DF9C;
	Tue, 19 Mar 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojiQWj/D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0592D051;
	Tue, 19 Mar 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872758; cv=none; b=BtAH1PWswQ798gXD9W5DRHTWbC+65q8WNIYHIGfwOgPnjUb0ukASFkemzK9+fUwignYzLiOuThR9LRJlqJrm/z+GI8ao5eG07gKdQG6HRdKQJb7R3/sHmH07rCwDcTY3uBmo4RiIbaTrL7rdQvKo7EymDR89PHGLMIG+6TWm6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872758; c=relaxed/simple;
	bh=647I8SQbS+NpPyRU98HxnDo7TahF6K5IOCsVS1iYicU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQJkQCf6AKQFaoDY865yqgZTiQJHMJXejGhVineAl1FkjHoacKJmsFGm6MEnVoIClxgiALa3y1MEdGKy0suF8YSQcihSrEdQ52zP6PYMogOW8o2DngdmwLFzTlu59kvjyD0m1VjEOAJEJg3/XM72ZzGNQeJOTRNj3YdnTSV6/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ojiQWj/D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIBdsJ032331;
	Tue, 19 Mar 2024 18:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=3mMufUjeP7xzgoywj6yUqTGzVkNXCgFRrFQvDtSyAcA=;
 b=ojiQWj/DGY2OGtxP3d0yUVGGkEyet7AsbwA30YWQ1Sgf5hg5Levryjk1g0pg34UlIaq6
 lhHlalfa9gNyWu6mDY0wXmvoUa8ntWEWvNrAuke6CynlC54HUpWbTST6elQvdUcSAgpY
 GtXH9cAfYHeKKfK0L+iF6gqHJwNxataDz3aZshVYzP4UQAhqzy27BEqcjuV38V+HSQmJ
 mfokt4UWUqmbPKW5VTvTSr2ubwMsKd6s6Ovh2yIgxQg586W5QfeedQ8ktF8ISMbseW91
 Hn8eUj+mCA1AG4UpnKohOlUMhxYgrkVfXuT+dpW6HXhbXzbZBlDR00H5p2IEQhCzxehM ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wybdhh7br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:25:42 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JIPfiB021935;
	Tue, 19 Mar 2024 18:25:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wybdhh7bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:25:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIFTbw015781;
	Tue, 19 Mar 2024 18:25:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp501jcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:25:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JIPb7k17826258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 18:25:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E398C2004E;
	Tue, 19 Mar 2024 18:25:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF7D2004D;
	Tue, 19 Mar 2024 18:25:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.13.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 18:25:34 +0000 (GMT)
Date: Tue, 19 Mar 2024 23:55:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <ZfnYmzPIQfbtITPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <469c58c5-1095-cb9d-bd1d-514476e262e0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <469c58c5-1095-cb9d-bd1d-514476e262e0@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2dn_Mivuy7ko4rDbYdnrMlMjgm2DeDga
X-Proofpoint-ORIG-GUID: tsPsXmIYX9GQ-12XzJOLss63-ak1S1vI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_07,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190138

On Tue, Mar 19, 2024 at 06:05:53PM +0800, Baokun Li wrote:
> On 2024/3/18 20:39, Ojaswin Mujoo wrote:
> > On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> > >      return 0;
> > >    if (order == MB_NUM_ORDERS(sb))
> > >      order--;
> > > + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > > +   order = MB_NUM_ORDERS(sb) - 1;
> > Hey Baokun,
> Hi Ojaswin,
> > 
> > Thanks for fixing this. This patch looks good to me, feel free to add:
> > 
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Thanks for the review!
> > my comments after this are less about the patch and more about some
> > thoughts on the working of average fragment lists.
> > 
> > So going through the v2 and this patch got me thinking about what really
> > is going to happen when a user tries to allocate 32768 blocks which is also
> > the maximum value we could have in say ac->ac_g_ex.fe_len.
> > 
> > When this happens, ext4_mb_regular_allocator() will directly set the
> > criteria as CR_GOAL_LEN_FAST. Now, we'll follow:
> > 
> > ext4_mb_choose_next_group_goal_fast()
> >    for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
> > 
> > Here, mb_avg_fragment_siz_order() will do something like:
> > 
> >    order = fls(32768) - 2 = 14
> >    ...
> >    if (order == MB_NUM_ORDERS(sb))
> >      order--;
> > 
> >    return order;
> > 
> > And we'll look in the fragment list[13] and since none of the groups
> > there would have 32768 blocks free (since we dont track it here) we'll
> > unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
> > (this will become a noop due to the way order and min_order
> > are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
> > something or end up splitting.
> That's not quite right, in ext4_mb_choose_next_group_goal_fast() even
> though we're looking for the group with order 13, the group with 32768
> free blocks is also in there. So after passing ext4_mb_good_group() in
> ext4_mb_find_good_group_avg_frag_lists(), we get a group with 32768
> free blocks. And in ext4_mb_choose_next_group_best_avail() we were

Hey Baokun,

So IIUC, a BG with 32768 blocks free will have bb_fragments = 0 and in
mb_update_avg_fragment_size() we exit early if a BG has bb_fragments = 0
hence it won't show up in the order 13 list.

> supposed to allocate blocks quickly by trim order, so it's necessary
> here too. So there are no unnecessary loops here.
> 
> But this will trigger the freshly added WARN_ON_ONCE, so in the
> new iteration I need to change it to:
> 
> if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) + 1))
>         order = MB_NUM_ORDERS(ac->ac_sb) - 1;
> 
> In addition, when the block size is 4k, there are these limitations:
> 
> 1) Limit the maximum size of the data allocation estimate to 8M in
>     ext4_mb_normalize_request().
> 2) #define MAX_WRITEPAGES_EXTENT_LEN 2048
> 3) #define DIO_MAX_BLOCKS 4096
> 4) Metadata is generally not allocated in many blocks at a time
> 
> So it seems that only group_prealloc will allocate more than 2048
> blocks at a time.
> 
> And I've tried removing those 8M/2048/4096 limits before, but the
> performance of DIO write barely changed, and it doesn't look like
> the performance bottleneck is here in the number of blocks allocated
> at a time at the moment.

Ohh that's interesting, on paper I think it does seem like it should
improve the performance. I think if CR_GOAL_LEN_FAST can start including
blocks which are completely empty, and lift those restrictions then we
might see better performance. I'll try to play around a bit with this as
well.

Regards,
ojaswin

> 
> Thanks,
> Baokun
> > I think something more optimal would be to:
> > 
> > 1. Add another entry to average fragment lists for completely empty
> > groups. (As a sidenote i think we should use something like MB_NUM_FRAG_ORDER
> > instead of MB_NUM_ORDERS in calculating limits related to average
> > fragment lists since the NUM_ORDERS seems to be the buddy max order ie
> > 8192 blocks only valid for CR_POWER2 and shouldn't really limit the
> > fragment size lists)
> > 
> > 2. If we don't want to go with 1 (maybe there's some history for that),
> > then probably should exit early from CR_GOAL_LEN_FAST so that we don't
> > iterate there.
> > 
> > Would like to hear your thoughts on it Baokun, Jan.
> > 
> > Regards,
> > ojaswin
> > 

