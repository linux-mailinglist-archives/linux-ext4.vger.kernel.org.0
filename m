Return-Path: <linux-ext4+bounces-1686-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E787FBE7
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81A2283891
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144837E111;
	Tue, 19 Mar 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GyegJSBd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A655C3C;
	Tue, 19 Mar 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844620; cv=none; b=XEN3ekU2rGhaG7TPMk8WOVJoTClwECksDtnDFyzymoXhTywN1aoGETjsrikOpjcfZPqfJNAXFZshgBMtGMgHKDgyTsA1jmIhMfTn4weSK8nYFEAk1lboQDJsB10cMHswHKLkgm98iN3nA0D/rMWZdruunwsvEMpqgHdkgMq3vzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844620; c=relaxed/simple;
	bh=mGctuonGgrj/mW/NYRMJLbhJEWslrS7zVEwK8aHOuCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhxTwSEEq+FG1qgJNXY+qBaUBqI7jSykGGibTUWSVjqB2xmc+Yg7K6cXKXMFjnn4EuOHcH6MRxItcCRrBEQWqPsKPzAL2KglQTIHl+mEwaJgkiDftGmaPgyLw3mdbS7ssCnFd03bm9jRmBAKmlmIq0RBkdYIsqZWBkDZssX+wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GyegJSBd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J92QTk004438;
	Tue, 19 Mar 2024 10:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=B8+KhgXOB0lAYx60bbFxRx9Im3wx7n/N2fAX73+k61o=;
 b=GyegJSBdFJs20ZnrIN+wJ04TrbEyXcpYBuE8bAgvQl0e/KqU+MY/RnCeNSQlggU9YoyN
 iRI6JvbBfitbMAFjASdYLHjkpnYdwco13oYHBiFONJHZ0HzKrObhZFf869RFigxmZJPt
 MK6snIT92xQ5h7V5INx9DwRf+d2PWeBBV76ivgRDFgYhdCx9tx1UdyEby34o1TEToO5/
 +quZrGWhgLPiVZvaFzLS300QpnJF1CA56nLqAeO6A61/ndgknoP5dQ1kmp8Mr/DHB+ai
 Wj9VWJmBtQJqkMKrYdcng2NTRG3/aI/8f/qgswTDr6ejrncnCQZ4Vnw2ODuyq53vPsFd yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy7qmrghx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:36:46 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JAYU8u019894;
	Tue, 19 Mar 2024 10:36:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy7qmrghu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:36:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J9oMJJ017194;
	Tue, 19 Mar 2024 10:36:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt71m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:36:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JAafcM41550198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 10:36:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F81720040;
	Tue, 19 Mar 2024 10:36:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F47B2004F;
	Tue, 19 Mar 2024 10:36:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 10:36:38 +0000 (GMT)
Date: Tue, 19 Mar 2024 16:06:35 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <Zflqs3riUr6dGWLn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20240318152509.5tdmkojnhd3gqxqu@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318152509.5tdmkojnhd3gqxqu@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P_CCjEgNLiVYFwOyN9fvGEpt6O4f7w8q
X-Proofpoint-ORIG-GUID: oh2ivtND1E1sShnlKIonyFatVwNS8jpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190081

On Mon, Mar 18, 2024 at 04:25:09PM +0100, Jan Kara wrote:
> On Mon 18-03-24 18:09:18, Ojaswin Mujoo wrote:
> > On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
> > > We can trigger a slab-out-of-bounds with the following commands:
> > > 
> > >     mkfs.ext4 -F /dev/$disk 10G
> > >     mount /dev/$disk /tmp/test
> > >     echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
> > >     echo test > /tmp/test/file && sync
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> > > Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
> > > CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
> > > Call Trace:
> > >  dump_stack_lvl+0x2c/0x50
> > >  kasan_report+0xb6/0xf0
> > >  ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> > >  ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
> > >  ext4_mb_new_blocks+0x88a/0x1370 [ext4]
> > >  ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
> > >  ext4_map_blocks+0x569/0xea0 [ext4]
> > >  ext4_do_writepages+0x10f6/0x1bc0 [ext4]
> > > [...]
> > > ==================================================================
> > > 
> > > The flow of issue triggering is as follows:
> > > 
> > > // Set s_mb_group_prealloc to 2147483647 via sysfs
> > > ext4_mb_new_blocks
> > >   ext4_mb_normalize_request
> > >     ext4_mb_normalize_group_request
> > >       ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
> > >   ext4_mb_regular_allocator
> > >     ext4_mb_choose_next_group
> > >       ext4_mb_choose_next_group_best_avail
> > >         mb_avg_fragment_size_order
> > >           order = fls(len) - 2 = 29
> > >         ext4_mb_find_good_group_avg_frag_lists
> > >           frag_list = &sbi->s_mb_avg_fragment_size[order]
> > >           if (list_empty(frag_list)) // Trigger SOOB!
> > > 
> > > At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> > > but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> > > to be triggered by an attempt to access an element at index 29.
> > > 
> > > Add a new attr_id attr_clusters_in_group with values in the range
> > > [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> > > that type to fix the issue. In addition avoid returning an order
> > > from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> > > and reduce some useless loops.
> > > 
> > > Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/mballoc.c |  4 ++++
> > >  fs/ext4/sysfs.c   | 13 ++++++++++++-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 12b3f196010b..48afe5aa228c 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> > >     return 0;
> > >   if (order == MB_NUM_ORDERS(sb))
> > >     order--;
> > > + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > > +   order = MB_NUM_ORDERS(sb) - 1;
> > 
> > Hey Baokun,
> > 
> > Thanks for fixing this. This patch looks good to me, feel free to add:
> > 
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
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
> >   for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
> > 
> > Here, mb_avg_fragment_siz_order() will do something like:
> > 
> >   order = fls(32768) - 2 = 14
> >   ...
> >   if (order == MB_NUM_ORDERS(sb))
> >     order--;
> > 
> >   return order;
> > 
> > And we'll look in the fragment list[13] and since none of the groups
> > there would have 32768 blocks free (since we dont track it here) we'll
> > unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
> > (this will become a noop due to the way order and min_order
> > are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
> > something or end up splitting.
> 
> Yeah, agreed this looks a bit suboptimal. I'm just not 100% sure whether
> we'll ever generate a request to allocate 32768 blocks - that would need
> verification with tracing - because I have some vague recollection I once
> arrived at conclusion this is not possible.

Ahh, right! I see the following line in mpage_add_bh_to_extent():

	/* Don't go larger than mballoc is willing to allocate */
	if (map->m_len >= MAX_WRITEPAGES_EXTENT_LEN)
		return false;

Where MAX_WRITEPAGES_EXTENT_LEN is 2048 ie 8MB on 4k filesystem. As pointed out
by your comment there, it seems to come from the fact that we have some restrictions 
in ext4_mb_normalize_range() which don't allow us to go beyond 8MB length. I think
I was also looking at that code sometime back and it really needs some rework, I'll 
try to test a few things out.

So yep, in the usual paths we shouldn't be sending a request as big as 32768 blocks
but it's still possible with group prealloc with s_mb_group_prealloc set to 32768.

Anyways, thanks for pointing this out, I'll try to look into the code path more to see
how we can optimize it better and maybe if we can lift the 2048 block restriction.

Regards,
ojaswin

> 
> > I think something more optimal would be to:
> > 
> > 1. Add another entry to average fragment lists for completely empty
> > groups. (As a sidenote i think we should use something like MB_NUM_FRAG_ORDER
> > instead of MB_NUM_ORDERS in calculating limits related to average
> > fragment lists since the NUM_ORDERS seems to be the buddy max order ie
> > 8192 blocks only valid for CR_POWER2 and shouldn't really limit the
> > fragment size lists)
> 
> I guess the thinking was that you can never get larger than
> 1<<(MB_NUM_ORDERS-1) chunk from mballoc so there's no point to keep
> fragment lists of such chunks?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

