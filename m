Return-Path: <linux-ext4+bounces-3289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736B93236E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E31F23ABE
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD7197A7D;
	Tue, 16 Jul 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ex4hdFk8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AA15EA6;
	Tue, 16 Jul 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123707; cv=none; b=kJyi6RgkAhHPbwKSKgAQWvJWQIskljzM4hFs1+tfSqLDu3KoQ9L0o2IpsxTP8PnnTD00ehXZ85GB7aEnKDpUkx51qHMhGeeckIMPp6mS6l92p+D+K1n31IsObtUirm27qgl36yFESlYpldz8LDbHaFJ/Q2tHuicXc5dVwTeAV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123707; c=relaxed/simple;
	bh=jfxSFmmn0FuBrzgetWN57RpGUWLVf3aBc+89qRwLppw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9o2LlUDx00kPMTIUr1Dg+dQA1/bN1+ItIeASmXWaK3RtI/NG/rOKKG9/BXGKbqn6w6z62RnUF45vH9ek/fXtfpgPSR4ISdFcFZBZWjSEe8O2Dwk/4rSjNt5kzNHufJgBYvXbE7kg2/fA6L6HLxrjSShPwI9hxzDxf4LqUop9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ex4hdFk8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G8xJlJ007518;
	Tue, 16 Jul 2024 09:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=V
	G50molFEjmHBUz5s7o7renexBIBxRWMR8t/rWyUk4M=; b=Ex4hdFk80TScBM6B2
	/pah8yYlzV5ikYDulpwgpg9Ww81pZra5vn0TZGqJBTjP1LHXxLyBhLPPg8f+AqYa
	7iLnuqOoasrYu8FyExf5Znkg9OJmKA+y71VvvrkMF7MeghztUMZ+716/SNyQuRHy
	7NTbbH8HvHi2Cgar4+gxkr759kUyVPEit150SypVljR/e0tFSzd7eC56JxYERJ2a
	s9N2a5lCdTilhFZFk/kfCLw5LcLppWAfiTRtrjNUY1CO+XzbD/dgiqI/ShIjb0im
	5Rep4ev2E+P/nrM+eoEU+MA7s8tBPecgIy7mp6zqo/3QyUFXYCgsyFECF9DXH+BP
	isyvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dnu2g491-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:54:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46G9sfOQ024302;
	Tue, 16 Jul 2024 09:54:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dnu2g48s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:54:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46G613WB015025;
	Tue, 16 Jul 2024 09:54:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4wpbdt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:54:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46G9sajf53870950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 09:54:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D84D20040;
	Tue, 16 Jul 2024 09:54:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758FB2004B;
	Tue, 16 Jul 2024 09:54:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jul 2024 09:54:34 +0000 (GMT)
Date: Tue, 16 Jul 2024 15:24:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EstWM539K01k2nwSki2KgzRRMJCGebUs
X-Proofpoint-ORIG-GUID: TMh6XINqQD9UhX26lLpgAbill4c3gpl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=316 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160071


> > But the journal will ensure the consistency of the extents path after
> > this patch.
> > 
> > When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
> > ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
> > the extents tree to be inconsistent. But the inconsistency just
> > exists in memory and doesn't land on disk.
> > 
> > For ext4_ext_get_access(), the handle must have been aborted
> > when it returned an error, as follows:
> ext4_ext_get_access
>  ext4_journal_get_write_access
>   __ext4_journal_get_write_access
>    err = jbd2_journal_get_write_access
>    if (err)
>      ext4_journal_abort_handle
> > For ext4_ext_dirty(), since path->p_bh must not be null and handle
> > must be valid, handle is aborted anyway when an error is returned:
> ext4_ext_dirty
>  __ext4_ext_dirty
>   if (path->p_bh)
>     __ext4_handle_dirty_metadata
>      if (ext4_handle_valid(handle))
>        err = jbd2_journal_dirty_metadata
>         if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
>           ext4_journal_abort_handle
> > Thus the extents tree will only be inconsistent in memory, so only
> > the verified bit of the modified buffer needs to be cleared to avoid
> > these inconsistent data being used in memory.
> > 
> Regards,
> Baokun

Thanks for the explanation Baokun, so basically we only have the
inconsitency in the memory.

I do have a followup questions:

So in the above example, after we have the error, we'll have the buffer
for depth=0 marked as valid but pointing to the wrong ei_block.

In this case, can we have something like below:

-----------------
ext4_ext_remove_space
  err = ext4_ext_rm_idx (error, path[0].p_bh inconsistent but verified)
  /* 
   * we release buffers of the path but path[0].p_bh is not cleaned up
   * due to other references to it (possible?)
   */

... at a later point...:

ext4_find_extent
  bh = read_extent_tree_block() 
    /* 
     * we get the bh that was left inconsistent previously
     * since its verified, we dont check it again corrupting
     * the lookup
     */

-----------------

Is the above scenario possible? Or would the path[0].p_bh that was
corrupted previously always be reread during the subsequent
ext4_find_extent() lookup?

Thanks again,
Ojaswin

