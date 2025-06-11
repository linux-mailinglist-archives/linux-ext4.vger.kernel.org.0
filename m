Return-Path: <linux-ext4+bounces-8353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E1AD4E2F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA103A58F0
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357E238C21;
	Wed, 11 Jun 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="of2E4Pry"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E162D541D;
	Wed, 11 Jun 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630171; cv=none; b=QF6/Sj0AlYA8a7RnOnIl0IxUKrzGsPfu9uI8w0XSx0coBc21KW0hnlEIDIFX9XmLfjKAWUMxRMdEHJu7YmqS6gQ2+ZmNjFme5AwzHbS2uFIorFdfCtIjNqCgH06kuXzDIy8x0bYU4Ttezkg5ketAApjQcDi0A+IL7Qe4IcyqFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630171; c=relaxed/simple;
	bh=Eo3gGOsaeogOSd/B6wfv4eqHEcclQbrt5eDMWhBHswU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6t06zlZcMXKBnU8QELAlMm11ZNUswuZ8N02Q62K1H0IiZ+G29cfj4hlT4whEhMaTgn4ZojDb0yjVZDxhmPEFrkNp56V5Zcfpmdn6FfpWqGSrt3Zj5ME2Gv/BtqogLnSJDr6v+12L0u62GPHjS0v7wvoiSk9fcxHvBvOjg8aok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=of2E4Pry; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B2UifU031658;
	Wed, 11 Jun 2025 08:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TMLSkA
	JYZHdO/aYQ3gEehXA8/ELikz3XVMG52xpfMPE=; b=of2E4PryhsOvxq/vBi3wO0
	spZS8CVvDqD/3tjhNiG/UfrWVOgf2O40EzsYiL3p/G1WK/tb/Yg/djUukCwuKm95
	m3aI8KqtvvZH22PfGUNxnBQZAOJJwcS0Q8SCIBCH9gJi09U3ToWcaev4qILtjTU/
	X4NIYnzvCyw9HqlqW/oFZ0CGkcBk3SuTXzG4CdC/rxHvOy8GoKotoD13gWgivaG2
	A1cZEfijN5BokrHBTHIpiApfH1V+JtsdrjsYnHz0lMlOsCjXeWkaHN3tdNW19C5C
	NguxLEZhRIUPQ2NLoQ21FVGSS4hcwHeOFME3p18f+e5j05zhiizmsVWYo8LlVThg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8ce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 08:22:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B4toTm015006;
	Wed, 11 Jun 2025 08:22:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp6rc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 08:22:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B8MY0846858616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 08:22:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC5022004E;
	Wed, 11 Jun 2025 08:22:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C819720040;
	Wed, 11 Jun 2025 08:22:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Jun 2025 08:22:31 +0000 (GMT)
Date: Wed, 11 Jun 2025 13:52:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH 0/4] ext4: better scalability for ext4 block allocation
Message-ID: <aEk8xcy9Zykrx3m3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <aDchmYDc_OOAu2yC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <f21507f9-ebc6-43ce-97c4-cd055c53747e@huawei.com>
 <aEgfwKvcJzt9gkGq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <bff134da-e056-4eaf-b5ac-cace99208e40@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bff134da-e056-4eaf-b5ac-cace99208e40@huawei.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68493ccc cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=AiHppB-aAAAA:8 a=bUqMBbjT_IMJPAd7GqYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=pguttIyuptPycXpC454v:22
X-Proofpoint-GUID: ChutF85oazqB0v7BXrsN-eH07Gd4TOo9
X-Proofpoint-ORIG-GUID: ChutF85oazqB0v7BXrsN-eH07Gd4TOo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3MiBTYWx0ZWRfX46KwahOGIW8r WBajov8OVPeJhkldfEc7LLP6kuiVW1J2ZEHVV15M4zqFK/VCse4ApgxOMpMveZWAyNajx6FFo5K az24xtMeaXiZBOjc4WCnDd57GuiKlGBpMtw3pnoXG/qdvMfb3zQfW4tbcOeZlmGirrMy+TXMZqT
 l/0EPMHRvIeIQy3xmDAN+Z7JSheXXn0NQna8d6stDp44QtjI61H/S6XX2tlT1ofDtwRchPVt1Mr wce7wcB1hCy6LIapAHSbR3inNL1ElyZwnSJmgEXdzcVSS+9gq17zPj6WoQcBQZmH63O2uAF6b4W /Ivki3P00bC/OkomjywDDEEWP/2Mb5To9uZ4IqJmUig+mOX1tDsliR+UMI7oMBs9mHF5uprLs8s
 iIrGJz8FNHyb3zpkswPncLLLuDvj8P4W5VX0oJaEmYI8c3eVANsbBpjRbwzwpZ39N1Lh1nkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=822 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110072

On Tue, Jun 10, 2025 at 09:48:30PM +0800, Baokun Li wrote:
> On 2025/6/10 20:06, Ojaswin Mujoo wrote:
> > On Thu, May 29, 2025 at 08:24:14PM +0800, Baokun Li wrote:
> > > On 2025/5/28 22:53, Ojaswin Mujoo wrote:
> > > > On Fri, May 23, 2025 at 04:58:17PM +0800, libaokun@huaweicloud.com wrote:
> > > 
> > > ----------------------------------------------------------
> > >                       |       base      |      patched    |
> > > ---------------------|--------|--------|--------|--------|
> > > mb_optimize_scan     | linear |opt_scan| linear |opt_scan|
> > > ---------------------|--------|--------|--------|--------|
> > > bw(MiB/s)            | 217    | 219    | 5685   | 5670   |
> > > Avg. free extent size| 1943732| 1943728| 1439608| 1368328|
> > > Avg. extents per file| 261879 | 262039 | 744    | 2084   |
> > > Avg. size per extent | 4      | 4      | 1408   | 503    |
> > > Fragmentation score  | 100    | 100    | 2      | 6      |
> > > ----------------------------------------------------------
> > Hi Baokun,
> > 
> > Thanks for the info and data and apologies for being late, I caught a
> > viral last week :/
> Hi Ojaswin,
> 
> Being sick really takes a toll.
> Please get some good rest and take care of yourself.

Thanks Baokun!

<snip>

> > 
> > > Another reason is that opt_scan tends to allocate from groups that have
> > > just received freed blocks, causing it to constantly "jump around"
> > > between certain groups.
> > > 
> > > This leads to intense contention between allocation and release, and even
> > > between release events. In contrast, linear traversal always moves forward
> > > without revisiting groups, resulting in less contention between allocation
> > > and release.
> > By just received free blocks, you mean the blocks got freed in the group
> > right?
> Yes.
> > I was under the impression that when we free blocks and the group's
> > largest order/ avg fragment changes, the group is added to the end of
> > the free fragment list/order list so it should be the last to be picked.
> > Is that not the case?
> Yes, we are indeed adding the group to the list tail. However, because
> we traverse all ordered lists from low to high, a group might end up
> "bouncing" repeatedly between order_0 and order_1 here.
> 
> For instance, if order_1 only contains group 1, linear traversal would
> rarely revisit it after the initial pass. However, after a non-linear
> allocation, this group is moved from the order_1 list to the order_0 list.
> When blocks are freed, it's moved back to the order_1 list, and then
> non-linear traversal prioritizes allocation in this same group again...

Right, I get what you mean now. Thanks.

> > 
> > > However, because linear involves more groups in allocation, journal
> > > becomes a bottleneck. If opt_scan first attempts to traverse block groups
> > > to the right from the target group in all lists, and then from index 0 to
> > > the left in all lists, competition between block groups would be
> > > significantly reduced.
> > > 
> > > To enable ordered traversal, we attempted to convert list_head to an
> > > ordered xarray. This ordering prevents "bouncing" during retries.
> > > Additionally, traversing all right-side groups before left-side groups
> > > significantly reduced contention. Performance improved from 10430 to 17730.
> > Do you maybe have some code you can share of this?
> Yes, V2 will include those changes.

Okay sure

<snip

> > > In a single container, create a file, then repeatedly append 8KB using
> > > fallocate until the file reaches 1MB. After that, truncate the file to
> > > 0 and continue appending 8KB with fallocate. The 64 containers will
> > > occupy a maximum of 64MB of disk space in total, so they won't fill the
> > > entire file system.
> > Also, as per your theory, if we do similar experiments in a fragmented
> > FS we should see opt_scan perform better right? I'd like to test this as
> > well. I'll try to play with the scripts you have shared.
> > 
> Yes, mb_optimize_scan performs well when free space fragmentation is
> severe. We have a 600TB disk array where the write bandwidth is
> approximately 5 GB/s when empty. When space utilization reaches 95%,
> linear traversal drops bandwidth to 1 GB/s, whereas enabling
> mb_optimize_scan restores it to 4.2 GB/s.

Got it, thanks for confirming. Seems like in mostly empty FS linear
traversal seems to do better. Makes me wonder if we should use some
heurestic to switch between linear and opt_scan based allocation, for
example opt_scan can be used if FS is 60% full or has a fragmentation 
score of X. (or something like that..)

But Im also curious about your improved optimize scan implementation
with ordered traversal, so lets see how that goes first.

> 
> 
> Cheers,
> Baokun
> 

