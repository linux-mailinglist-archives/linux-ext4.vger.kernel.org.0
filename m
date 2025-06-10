Return-Path: <linux-ext4+bounces-8345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85130AD3598
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A16E1898110
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E028E569;
	Tue, 10 Jun 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jlLDQDez"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F228CF7F;
	Tue, 10 Jun 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557260; cv=none; b=tymfhVk/hALvztb6D0tLrD9fe1bIU5DEa7ad334aEwLS4MoTLJdK6S784ll41vn/3dlOGYrAr6JutTdokEEgX7Ag6XmnLaJPR2pJIVnYJh9GQJvxVsmTCvUXMYxVVONXfmQIYMResAeKwqILMgIsIiooFhcSmS8NXsSI0QOx4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557260; c=relaxed/simple;
	bh=aA4A8xLS+ECd1w0wWi+hwJEtG5/NUV8SdihKO6ly2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj2k6k4usGcyC7XqvIziO/4CW6koKVHk3dPhs4VnmPb8B0XO9VWWMzfgNa/USPTJDs7UZUwFymMvAyhC6iieauC01++vL74BkQqiZcmrFDI5CTPbhZ4ZCUtcr4c+3DeFNnWBQTR3rj46scZq8DNAB41WJl1HVA+nvByahdnT14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jlLDQDez; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8uje8029692;
	Tue, 10 Jun 2025 12:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jey4AS
	himmOWh5g7EgTau/abqMZNEL12r+V2Fqr7Y0s=; b=jlLDQDezZ3HaJIzu0IJmqU
	7aIJIUwkzoHWzAUBljnEpzIhKh00pM9/l4lCHgwywpn5vw9J49iZ6Cz7QvXCl0JF
	BUWXIhodqX7Dlcz80iTYEuIoKoEOwpuFO27TZTpoN4oG36wiZES6WFdWDHvHl/sI
	vkRyZwkWgHc/SXRzam11gZXbAm3vk/zCZuXPgrqiFvGX7qDddus0Z8wev59Xaa4h
	l8pBp1HtezfXNwNupcOWQOHPDP6kibiUIoKoK0Y4ik+qon5tUrt7lKkDany1/XZg
	4SlQURIWbjh2Ot86gN5KNoMEEkBEI+dD0usTl+UY5RrUMyLDGIcE4BVquPiIURPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxj658p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 12:07:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AAkSA8019565;
	Tue, 10 Jun 2025 12:07:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f29x0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 12:07:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55AC7Dwa48431594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 12:07:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53FA020063;
	Tue, 10 Jun 2025 12:07:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 337182004E;
	Tue, 10 Jun 2025 12:07:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Jun 2025 12:07:10 +0000 (GMT)
Date: Tue, 10 Jun 2025 17:37:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 1/4] ext4: add ext4_try_lock_group() to skip busy groups
Message-ID: <aEgf7Jf9x5BXSwbz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-2-libaokun@huaweicloud.com>
 <aDcmRdOrWatcBJWc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <d5d840c5-d030-48de-84df-3891f498cfc7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5d840c5-d030-48de-84df-3891f498cfc7@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nLrjnl_Wf3tJfZMdtDpCI1TXoyggHrsL
X-Proofpoint-GUID: nLrjnl_Wf3tJfZMdtDpCI1TXoyggHrsL
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=68481ff4 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=KFyfeOmcnQpl-OtaCRAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5MiBTYWx0ZWRfX81NE7Oyjjko1 1FcuAWHKHT9B8TelW2x6D13O1dVdwZXecyKnjrv03KYDNnEr1KUCni+/qskW+yjBPX8aUjNiCFi MRX4mrSW6MLpRTydHDmigPJ4nAg+Q5SSTmjD3KqxcUoAI40/ZNrD2z0WrKGUFdhbEPL1fmsDqtg
 UDObHkJPDAiymmy/JgscqBaOb6rue1aT1kG+39mrItXjv57Dl7US6i8237LDqHLkz2rVxwtNLl1 kfe8DgaQUbBM3zP12RocLxfyQ/u+ESifbZ6KRIuJOz6LG5SaykLL5mmkp2Bi0zkqhU8SlxD0VFT raAzr0k0cSBWWIOZrQ5ANyX6V2cMlQBXh5RJHYxGtN1sWGeEYvZ7T9nnGQ6Z1J3QV3rJnlrQHtX
 +Z851btd8INh/ZFzPmxmTTJNEBn4sjcktNFyNpKCok+1uYBtOrzlCfDatJg7XyhIQ9CCS8/0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100092

On Fri, May 30, 2025 at 04:20:44PM +0800, Baokun Li wrote:
> On 2025/5/28 23:05, Ojaswin Mujoo wrote:
> > On Fri, May 23, 2025 at 04:58:18PM +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > When ext4 allocates blocks, we used to just go through the block groups
> > > one by one to find a good one. But when there are tons of block groups
> > > (like hundreds of thousands or even millions) and not many have free space
> > > (meaning they're mostly full), it takes a really long time to check them
> > > all, and performance gets bad. So, we added the "mb_optimize_scan" mount
> > > option (which is on by default now). It keeps track of some group lists,
> > > so when we need a free block, we can just grab a likely group from the
> > > right list. This saves time and makes block allocation much faster.
> > > 
> > > But when multiple processes or containers are doing similar things, like
> > > constantly allocating 8k blocks, they all try to use the same block group
> > > in the same list. Even just two processes doing this can cut the IOPS in
> > > half. For example, one container might do 300,000 IOPS, but if you run two
> > > at the same time, the total is only 150,000.
> > > 
> > > Since we can already look at block groups in a non-linear way, the first
> > > and last groups in the same list are basically the same for finding a block
> > > right now. Therefore, add an ext4_try_lock_group() helper function to skip
> > > the current group when it is locked by another process, thereby avoiding
> > > contention with other processes. This helps ext4 make better use of having
> > > multiple block groups.
> > > 
> > > Also, to make sure we don't skip all the groups that have free space
> > > when allocating blocks, we won't try to skip busy groups anymore when
> > > ac_criteria is CR_ANY_FREE.
> > > 
> > > Performance test data follows:
> > > 
> > > CPU: HUAWEI Kunpeng 920
> > > Memory: 480GB
> > > Disk: 480GB SSD SATA 3.2
> > > Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
> > > Observation: Average fallocate operations per container per second.
> > > 
> > >                        base    patched
> > > mb_optimize_scan=0    3588    6755 (+88.2%)
> > > mb_optimize_scan=1    3588    4302 (+19.8%)
> > The patch looks mostly good. Same observations about mb_optimize_scan=1
> > improving less. We can continue this discussion in my reply to the cover
> > letter. That being said, I have some minor suggestions:
> Thanks for the review!
> > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/ext4/ext4.h    | 23 ++++++++++++++---------
> > >   fs/ext4/mballoc.c | 14 +++++++++++---
> > >   2 files changed, 25 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 5a20e9cd7184..9c665a620a46 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -3494,23 +3494,28 @@ static inline int ext4_fs_is_busy(struct ext4_sb_info *sbi)
> > >   	return (atomic_read(&sbi->s_lock_busy) > EXT4_CONTENTION_THRESHOLD);
> > >   }
> > > +static inline bool ext4_try_lock_group(struct super_block *sb, ext4_group_t group)
> > > +{
> > > +	if (!spin_trylock(ext4_group_lock_ptr(sb, group)))
> > > +		return false;
> > > +	/*
> > > +	 * We're able to grab the lock right away, so drop the lock
> > > +	 * contention counter.
> > > +	 */
> > > +	atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
> > > +	return true;
> > > +}
> > > +
> > >   static inline void ext4_lock_group(struct super_block *sb, ext4_group_t group)
> > >   {
> > > -	spinlock_t *lock = ext4_group_lock_ptr(sb, group);
> > > -	if (spin_trylock(lock))
> > > -		/*
> > > -		 * We're able to grab the lock right away, so drop the
> > > -		 * lock contention counter.
> > > -		 */
> > > -		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
> > > -	else {
> > > +	if (!ext4_try_lock_group(sb, group)) {
> > >   		/*
> > >   		 * The lock is busy, so bump the contention counter,
> > >   		 * and then wait on the spin lock.
> > >   		 */
> > >   		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, 1,
> > >   				  EXT4_MAX_CONTENTION);
> > > -		spin_lock(lock);
> > > +		spin_lock(ext4_group_lock_ptr(sb, group));
> > >   	}
> > >   }
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 1e98c5be4e0a..5c13d9f8a1cc 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -896,7 +896,8 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
> > >   				    bb_largest_free_order_node) {
> > >   			if (sbi->s_mb_stats)
> > >   				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
> > > -			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
> > > +			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED)) &&
> > > +			    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
> > Maybe reversing the && order to be (!spin_is_locked() && ext4_mb_good_group()) would be better?
> Yeah.
> > >   				*group = iter->bb_group;
> > >   				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
> > >   				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> > > @@ -932,7 +933,8 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
> > >   	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
> > >   		if (sbi->s_mb_stats)
> > >   			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
> > > -		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
> > > +		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr)) &&
> > > +		    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
> > same as above
> Okay.
> > >   			grp = iter;
> > >   			break;
> > >   		}
> > > @@ -2911,7 +2913,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> > >   			if (err)
> > >   				goto out;
> > > -			ext4_lock_group(sb, group);
> > > +			/* skip busy group */
> > > +			if (cr >= CR_ANY_FREE) {
> > > +				ext4_lock_group(sb, group);
> > > +			} else if (!ext4_try_lock_group(sb, group)) {
> > > +				ext4_mb_unload_buddy(&e4b);
> > > +				continue;
> > > +			}
> > This in itself looks good. I am just thinking that now that we are
> > deciding to skip locked groups, in the code above this one, shall we do
> > something like:
> > 
> >        if (spin_is_locked(group_lock))
> >          continue;
> >        err = ext4_mb_load_buddy(sb, group, &e4b);
> >        if (err)
> >          goto out;
> > 
> >        /* skip busy group */
> >        if (cr >= CR_ANY_FREE) {
> >          ext4_lock_group(sb, group);
> >        } else if (!ext4_try_lock_group(sb, group)) {
> >          ext4_mb_unload_buddy(&e4b);
> >          continue;
> >        }
> > 
> > With this we can even avoid loading the folio as well.
> I previously assumed that for busy groups, the buddy was already loaded,
> so reloading it would incur minimal overhead. However, I was mistaken.
> 
> After implementing a change, the proportion of time spent in
> ext4_mb_load_buddy() decreased from 3.6% to 1.7%, resulting in
> approximately a 2% performance improvement.

Nice :) 

> 
> Thank you for your suggestion！
> I will prevent unnecessary buddy loading in the next version.
> 
> Cheers,
> Baokun
> 

