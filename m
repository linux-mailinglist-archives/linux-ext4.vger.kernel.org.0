Return-Path: <linux-ext4+bounces-3591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1F944484
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888821C223FF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 06:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503E15854D;
	Thu,  1 Aug 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FPPLQfcf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DED158534;
	Thu,  1 Aug 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493918; cv=none; b=SLduTQ5I3IyrVTOJ2RZhI8L1EbgFovgDBU97VcXyMrPqO9Bl6XFXfVB2J+mz1r0VbzbYKx3kSIRaa8EyqIV0Ijf6Arzgy7TXaDpvAEq/1PzktffMcGXeVBhPt79mwMSyZLWQg3EeFB0cAC0NCmMfu6rsLE04j+dIos/PaajEvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493918; c=relaxed/simple;
	bh=dlaZQXwlgCuRvMLHXO6Q5mUOphL7QTLBwat9U1z8Mt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTA4Xi21kMtz2Xj5H/ir6Kx5O7CzcFhLgTgBKku690pc5c7cLs7R9qe3hfw0t4l0QxRMNrErcBGCnpfMtksEE/DXQ58CeMoPpvXP7JM/OcY3n9hYWMec1vg2W+xXUyjRtYHOQ00GcHrK+K8IlE+H9rMc8sPb7Q3o3ANaKuYdw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FPPLQfcf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4712l7lZ006223;
	Thu, 1 Aug 2024 06:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=c
	GCcsoQpvk1hY1Y1fok3ylEXbYOA+YxUbZ1OnekV30k=; b=FPPLQfcfW8VkHpjvX
	qMCtfIWfK9qzPyL3YLO4cA64lSY+auUytRW2COLUSiek56WH533yDmR7QR6XJgtf
	JywKD4jvZlY3XMxCfFV3Ll8nGsnqXOuXORBvlNR4KGWRHd1HOjV3rwl0w1NcI88i
	AiyCEPCXa2EAr5BZwBJp2xM7eaZh+CrmWDc78nO45WCRSM52v4t65ttWuyLZ319+
	1SeYDplOcj2k89tpaUXHmn1bA0Jnfy7WSNVZVol0RsOGl2laKCg38URFcnFiIEIy
	2m9lM/iDBVVvnb5ivCRJi3lTfbz8tC0vCFKGHA53rD6Lg3oov8F5JJDxhIES/HHo
	kokwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8q56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:26:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4716NdHb012280;
	Thu, 1 Aug 2024 06:26:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8q53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:26:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4713eESV029103;
	Thu, 1 Aug 2024 06:26:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm10c9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:26:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4716QLtI55116252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 06:26:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3D7520043;
	Thu,  1 Aug 2024 06:26:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A55F20040;
	Thu,  1 Aug 2024 06:26:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.43.15])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Aug 2024 06:26:12 +0000 (GMT)
Date: Thu, 1 Aug 2024 11:56:07 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 03/20] ext4: fix double brelse() the buffer of the
 extents path
Message-ID: <ZqsqZP2Hgx8xTa2i@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-4-libaokun@huaweicloud.com>
 <ZqOMQ6cIHd0hZqhY@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <4147a862-df2c-457c-8ebd-4c04f121b93e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4147a862-df2c-457c-8ebd-4c04f121b93e@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vowL40WOO5G9DSBaPl2myDG3_C-n8NPe
X-Proofpoint-ORIG-GUID: r7yw8rdL_IrweGnCeE8xNRnCbfC6LE9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_03,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=634 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010035

On Tue, Jul 30, 2024 at 04:47:56PM +0800, Baokun Li wrote:
> On 2024/7/26 19:45, Ojaswin Mujoo wrote:
> > On Wed, Jul 10, 2024 at 12:06:37PM +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > >  snip
> > Hi Baokun,
> > 
> > If i'm not wrong, in this trace, we'll enter ext4_ext_insert_extent() with
> > gb_flags having EXT4_GET_BLOCKS_PRE_IO so we won't actually go for a
> > merge_up.
> > 
> > That being said, there seems to be a few places where we follow the
> > split-insert pattern and it might be possible that one of those call
> > sites might not be passing EXT4_GET_BLOCKS_PRE_IO and we'll the double
> > free issue you mentioned. I'll check and update if I see anything.
> Hi Ojaswin,
> 
> You're right. I am very sorry for the confusion.
> 
> The trace here is wrong, this patch should actually be placed after the two
> UAF patches. Here ext4_ext_try_to_merge() is called when trying zeroout in
> ext4_split_extent_at(). It is called when trying zeroout with or without
> EXT4_GET_BLOCKS_PRE_IO.The correct trace is as follows:
> 
>   split2    map    split1
> |--------|-------|--------|
> 
> ext4_ext_map_blocks
>  ext4_ext_handle_unwritten_extents
>   ext4_split_convert_extents
>    // path->p_depth == 0
>    ext4_split_extent
>      // 1. do split1
>      ext4_split_extent_at
>        |ext4_ext_insert_extent
>        |  ext4_ext_create_new_leaf
>        |    ext4_ext_grow_indepth
>        |      le16_add_cpu(&neh->eh_depth, 1)
>        |    ext4_find_extent
>        |      // return -ENOMEM
>        |// get error and try zeroout
>        |path = ext4_find_extent
>        |  path->p_depth = 1
>        |ext4_ext_try_to_merge
>        |  ext4_ext_try_to_merge_up
>        |    path->p_depth = 0
>        |    brelse(path[1].p_bh)  ---> not set to NULL here
>        |// zeroout success
>      // 2. update path
>      ext4_find_extent
>      // 3. do split2
>      ext4_split_extent_at
>        ext4_ext_insert_extent
>          ext4_ext_create_new_leaf
>            ext4_ext_grow_indepth
>              le16_add_cpu(&neh->eh_depth, 1)
>            ext4_find_extent
>              path[0].p_bh = NULL;
>              path->p_depth = 1
>              read_extent_tree_block  ---> return err
>              // path[1].p_bh is still the old value
>  ext4_free_ext_path
>   ext4_ext_drop_refs
>    // path->p_depth == 1
>    brelse(path[1].p_bh)  ---> brelse a buffer twice
> 
> I'll adjust the order of the patches and correct the trace in the next
> version.

Hey Baokun,

The corrected trace looks good, thanks.

Regards,
Ojaswin

