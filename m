Return-Path: <linux-ext4+bounces-3444-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00D93BE29
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11176284516
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A7196438;
	Thu, 25 Jul 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h54EiO/+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DB17C203;
	Thu, 25 Jul 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897337; cv=none; b=SnP6NZkwBJ22aePV1quUCFwtMBtPjobJgpRYPVqoXwCeGgPoQCXyuftv2R7wXxy5yHUiAclih5A+IRR6NdBx4T2Yxe5tOv3MSrhI7kZa8ASjXyKofUbzAUuc5dLDYKWPjozefEFV3QKIVqkMO2EktLVhddFMkqyDeGwMQYtpeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897337; c=relaxed/simple;
	bh=qsFA+cU5P98sdj9RVrkewUegqRBzGVkycpJZ6sBq+qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhU+KCnrxMLUzmULbMtxB6ZsAndijif7RcqHZ24QEy9DGBmkhxIyLvzgcPuzx/i5kZoRoLW6Sext0exrP/UuH2D8eekiAXEWKKv5zN3Ir6Fcgog1CvzxHO7cMe5jGXDHHSbdrke3j9dVlBHOWIS02fccBEtNOkOLHG7cHGXb3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h54EiO/+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8TAeU008633;
	Thu, 25 Jul 2024 08:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=r
	VDLOlXxb2rBhwEK5FY7L6rN/5WkiMbPccj2WY3xA9E=; b=h54EiO/+XdWV09RyE
	Wo3KQiUj0ewiuvR58LzZhyQNlq+t4DoSNMEuFXyZh7sd9XE8QNcSXrNTd/o7EtIn
	lqRAVzAwh3UpbLi61YtG3JhD+SdKgPQ1cbleEJqpWFOHCmfd5UQKbME30HmxgCCr
	OFQNysSTON6Oi5y39Tkli71uo8omkk3hpabqoi2P0E4bPpDNSlvkZi3lRK4DB+Ec
	mRn5pAMsNdzIzB3t6isnZT/g7YcHE0eIsyuedhHk4DROhrcZ56AvNhoEwJP/d8vE
	aCrXFPwqF5qYwXjWvr93wGT31uD8/6RR8dI83ngTXb1rvY2fWXJX22g9lSTzGfCZ
	Z/Rew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kgk8rdn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 08:48:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46P8mWcI010021;
	Thu, 25 Jul 2024 08:48:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kgk8rdn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 08:48:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P6Qhdm009115;
	Thu, 25 Jul 2024 08:48:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93ns1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 08:48:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P8mRBZ56623472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 08:48:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5AA32004B;
	Thu, 25 Jul 2024 08:48:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C70C820040;
	Thu, 25 Jul 2024 08:48:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 08:48:25 +0000 (GMT)
Date: Thu, 25 Jul 2024 14:18:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <ZqIRVzXireJ8fiU1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
 <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
 <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fcb1d52-520f-425f-8b83-debeda423483@huaweicloud.com>
 <ZqCd0fjFzZt00h6N@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <6df79e24-df1a-43da-8d1d-6bd0f8dd2edf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6df79e24-df1a-43da-8d1d-6bd0f8dd2edf@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 94HkO9mayGdlhi1tTE90w950JPGumnrg
X-Proofpoint-ORIG-GUID: FaYBell6NQ_VoIVfEoXGKOEpsu0iPGwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_08,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250054

On Thu, Jul 25, 2024 at 01:35:10PM +0800, Baokun Li wrote:
> On 2024/7/24 14:23, Ojaswin Mujoo wrote:
> > On Wed, Jul 17, 2024 at 02:11:27PM +0800, Baokun Li wrote:
> > > On 2024/7/17 13:29, Ojaswin Mujoo wrote:
> > > > On Tue, Jul 16, 2024 at 07:54:43PM +0800, Baokun Li wrote:
> > > > > Hi Ojaswin,
> > > > > 
> > > > > On 2024/7/16 17:54, Ojaswin Mujoo wrote:
> > > > > > > > But the journal will ensure the consistency of the extents path after
> > > > > > > > this patch.
> > > > > > > > 
> > > > > > > > When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
> > > > > > > > ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
> > > > > > > > the extents tree to be inconsistent. But the inconsistency just
> > > > > > > > exists in memory and doesn't land on disk.
> > > > > > > > 
> > > > > > > > For ext4_ext_get_access(), the handle must have been aborted
> > > > > > > > when it returned an error, as follows:
> > > > > > > ext4_ext_get_access
> > > > > > >     ext4_journal_get_write_access
> > > > > > >      __ext4_journal_get_write_access
> > > > > > >       err = jbd2_journal_get_write_access
> > > > > > >       if (err)
> > > > > > >         ext4_journal_abort_handle
> > > > > > > > For ext4_ext_dirty(), since path->p_bh must not be null and handle
> > > > > > > > must be valid, handle is aborted anyway when an error is returned:
> > > > > > > ext4_ext_dirty
> > > > > > >     __ext4_ext_dirty
> > > > > > >      if (path->p_bh)
> > > > > > >        __ext4_handle_dirty_metadata
> > > > > > >         if (ext4_handle_valid(handle))
> > > > > > >           err = jbd2_journal_dirty_metadata
> > > > > > >            if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
> > > > > > >              ext4_journal_abort_handle
> > > > > > > > Thus the extents tree will only be inconsistent in memory, so only
> > > > > > > > the verified bit of the modified buffer needs to be cleared to avoid
> > > > > > > > these inconsistent data being used in memory.
> > > > > > > > 
> > > > > > > Regards,
> > > > > > > Baokun
> > > > > > Thanks for the explanation Baokun, so basically we only have the
> > > > > > inconsitency in the memory.
> > > > > > 
> > > > > > I do have a followup questions:
> > > > > > 
> > > > > > So in the above example, after we have the error, we'll have the buffer
> > > > > > for depth=0 marked as valid but pointing to the wrong ei_block.
> > > > > It looks wrong here. When there is an error, the ei_block of the
> > > > > unmodified buffer with depth=0 is the correct one, it is indeed
> > > > > 'valid' and it is consistent with the disk. Only buffers that were
> > > > Hey Baokun,
> > > > 
> > > > Ahh I see now, I was looking at it the wrong way. So basically since
> > > > depth 1 to 4 is inconsistent to the disk we mark then non verified so
> > > > then subsequent lookups can act accordingly.
> > > > 
> > > > Thanks for the explanation! I am in the middle of testing this patchset
> > > > with xfstests on a POWERPC system with 64k page size. I'll let you know
> > > > how that goes!
> > > > 
> > > > Regards,
> > > > Ojaswin
> > > Hi Ojaswin,
> > > 
> > > Thank you for the test and feedback!
> > > 
> > > Cheers,
> > > Baokun
> > Hey Baokun,
> 
> Hi Ojaswin,
> 
> Sorry for the slow reply, I'm currently on a business trip.
> 
> > The xfstests pass for sub page size as well as bs = page size for
> > POWERPC with no new regressions.
> Thank you very much for your test!
> > 
> > Although for this particular patch I doubt if we would be able to
> > exersice the error path using xfstests. We might need to artifically
> > inject error in ext4_ext_get_access or ext4_ext_dirty.  Do you have any
> > other way of testing this?
> The issues in this patch set can all be triggered by injecting EIO or
> ENOMEM into ext4_find_extent(). So not only did I test kvm-xftests
> several times on x86 to make sure there weren't any regressions,
> but I also tested that running kvm-xfstests while randomly injecting
> faults into ext4_find_extent() didn't crash the system.

Ahh got it, thanks. I think I understand the changes well enough now and 
it makes sense to me to mark them non verified in case of errors.
Furthermore, the tests also look fine. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> > 
> > Also, just curious whether you came across this bug during code reading
> > or were you actually hitting it?
> The initial issue was that e2fsck was always reporting some sort of
> extents tree exception after testing, so the processes in question
> were troubleshooting and hardening, i.e. the first two patches.
> The other issues were discovered during fault injection testing of
> the processes in question.
> 
> 
> Regards,
> Baokun
> 

