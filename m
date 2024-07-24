Return-Path: <linux-ext4+bounces-3407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802693AC8A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4F4B21FCD
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2D4D8BF;
	Wed, 24 Jul 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LGKdxJl9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A94C84;
	Wed, 24 Jul 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802234; cv=none; b=NIUYC99ZzuOaJwTyTK8bX5u71lk6V3/sqqQ/o2TGbyVxibbC+qbYxhiOVHUMSlRsPyXforwgfcmiUOjms+RPK5N+L0WhLqZiQdRW6tOUuOXGIrTIfvztfBZNzoYIB/vPLnJVYbG+4oCEAz3exJvM/iwTIY5ICycl94ac7B2sM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802234; c=relaxed/simple;
	bh=Eb6lxp7TzXWJ8OPyM+IY8UNkUrINmqO8ggWvNrgCoOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9m4kN+Ur0FyfQvh9f7YPmuM8D9Eyb01uRe0jnFKjAM1YIHDikrBq4hJE4Z6GwHgtm2FMzK6vv4lDz9eKGO0jxO+kekBjvGWafvm+5qlPjI6IuL8Fg14SCNhbUoZrvxSrhLYQYLMG81oe90hIml1lOH/fjFyqc2WPJJfLt0Rbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LGKdxJl9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O4uasd008207;
	Wed, 24 Jul 2024 06:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=n
	45njxdt+Fwk6GIVLBkTvX+363dxg4YjF220SXlt21Y=; b=LGKdxJl97HK/rTcDZ
	AP+rkqyXvRGJJi6O/0C64PfyQlRCJtv6BAebdQtw0+/Gb3G9In9e01lsHam+DYoG
	3Mha82xeizJKrllcZekaZywse0UMmXZnHXXovKnqDVMb1ckVnMufUWF4XbJ9guFy
	F2WBAG61VrBRGxS9FRVQahy+cRGMcSjeWgFAQJJR0UmcLnVgUDPLJuWeRrfiUAJI
	GYQZXhx9fA0emzGwAHkgIahI3w2/0O1yp31vTL23XYmP2ZDZeXebYEvyrvdO6Nen
	1/dIKDWM1GITO52rHhQC3mCWfnkLO+8IhVrzM7+USHKk5qKj0MpqUo1hzUJxHgaD
	2vdnQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jrdv0csx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:23:24 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46O6NOgR011287;
	Wed, 24 Jul 2024 06:23:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jrdv0csv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:23:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46O2TKbk006236;
	Wed, 24 Jul 2024 06:23:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjufq86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:23:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46O6NJtd33948278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 06:23:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767DE20040;
	Wed, 24 Jul 2024 06:23:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CB22004E;
	Wed, 24 Jul 2024 06:23:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.222.27])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jul 2024 06:23:16 +0000 (GMT)
Date: Wed, 24 Jul 2024 11:53:13 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <ZqCd0fjFzZt00h6N@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
 <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
 <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fcb1d52-520f-425f-8b83-debeda423483@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fcb1d52-520f-425f-8b83-debeda423483@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nrctnOASPauZe-MUWHd9562IaPzxXm9y
X-Proofpoint-GUID: -AEmKOyvb3SP1VvEPLboFrRL-0g9NSl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_03,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=739 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240042

On Wed, Jul 17, 2024 at 02:11:27PM +0800, Baokun Li wrote:
> On 2024/7/17 13:29, Ojaswin Mujoo wrote:
> > On Tue, Jul 16, 2024 at 07:54:43PM +0800, Baokun Li wrote:
> > > Hi Ojaswin,
> > > 
> > > On 2024/7/16 17:54, Ojaswin Mujoo wrote:
> > > > > > But the journal will ensure the consistency of the extents path after
> > > > > > this patch.
> > > > > > 
> > > > > > When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
> > > > > > ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
> > > > > > the extents tree to be inconsistent. But the inconsistency just
> > > > > > exists in memory and doesn't land on disk.
> > > > > > 
> > > > > > For ext4_ext_get_access(), the handle must have been aborted
> > > > > > when it returned an error, as follows:
> > > > > ext4_ext_get_access
> > > > >    ext4_journal_get_write_access
> > > > >     __ext4_journal_get_write_access
> > > > >      err = jbd2_journal_get_write_access
> > > > >      if (err)
> > > > >        ext4_journal_abort_handle
> > > > > > For ext4_ext_dirty(), since path->p_bh must not be null and handle
> > > > > > must be valid, handle is aborted anyway when an error is returned:
> > > > > ext4_ext_dirty
> > > > >    __ext4_ext_dirty
> > > > >     if (path->p_bh)
> > > > >       __ext4_handle_dirty_metadata
> > > > >        if (ext4_handle_valid(handle))
> > > > >          err = jbd2_journal_dirty_metadata
> > > > >           if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
> > > > >             ext4_journal_abort_handle
> > > > > > Thus the extents tree will only be inconsistent in memory, so only
> > > > > > the verified bit of the modified buffer needs to be cleared to avoid
> > > > > > these inconsistent data being used in memory.
> > > > > > 
> > > > > Regards,
> > > > > Baokun
> > > > Thanks for the explanation Baokun, so basically we only have the
> > > > inconsitency in the memory.
> > > > 
> > > > I do have a followup questions:
> > > > 
> > > > So in the above example, after we have the error, we'll have the buffer
> > > > for depth=0 marked as valid but pointing to the wrong ei_block.
> > > It looks wrong here. When there is an error, the ei_block of the
> > > unmodified buffer with depth=0 is the correct one, it is indeed
> > > 'valid' and it is consistent with the disk. Only buffers that were
> > Hey Baokun,
> > 
> > Ahh I see now, I was looking at it the wrong way. So basically since
> > depth 1 to 4 is inconsistent to the disk we mark then non verified so
> > then subsequent lookups can act accordingly.
> > 
> > Thanks for the explanation! I am in the middle of testing this patchset
> > with xfstests on a POWERPC system with 64k page size. I'll let you know
> > how that goes!
> > 
> > Regards,
> > Ojaswin
> 
> Hi Ojaswin,
> 
> Thank you for the test and feedback!
> 
> Cheers,
> Baokun

Hey Baokun,

The xfstests pass for sub page size as well as bs = page size for
POWERPC with no new regressions.

Although for this particular patch I doubt if we would be able to
exersice the error path using xfstests. We might need to artifically 
inject error in ext4_ext_get_access or ext4_ext_dirty.  Do you have any
other way of testing this? 

Also, just curious whether you came across this bug during code reading
or were you actually hitting it?

Regards,
Ojaswin
> 

