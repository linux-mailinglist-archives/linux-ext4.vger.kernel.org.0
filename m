Return-Path: <linux-ext4+bounces-3297-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07319933665
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 07:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA801C212BE
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E5101C8;
	Wed, 17 Jul 2024 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jBmoe2K4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488D803;
	Wed, 17 Jul 2024 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194242; cv=none; b=nY2J7EitCeAfhjLfTRa86eW6yU5eeiNM4TfbWJjo7MQd0T5Miuq1AybnikPvtvRK0C+tS6zdZD7R6tV4b189LXw2uidoly4b/fkuKJy5C9KQgK7CjIiYupbEL2rA7NhtyYKSDfj6RGTrAbsAhgL+Upm/giJuuOCh2VoBq9+HM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194242; c=relaxed/simple;
	bh=1cD91AiF+ofn2qy+LURerTe+cUZh3kPu9C/4LdVxYso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0FUGhXwZZxUV+PAqMVyyWTP1YIXTDqYzIZxGGrwOyPI39ojnDBxiUZFz0TmBwyWmDthx8HcmBt6GHrGe6uCSb5zqWIpWAuQu50FSJFbGdkH7/AnKA4wTRlgSH49pD5JOz5Gox+k7TuznmrfyyHa29On21vDOdVn1UXd/2i7I24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jBmoe2K4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H5RhXP001713;
	Wed, 17 Jul 2024 05:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=w
	9v1uqSc7I6EDoQLYfTVG+EkjaoRO64Tk2h9wU4fO3k=; b=jBmoe2K4oBwAIEak7
	jYG8d2YddF859QvszM1XG7vRZ+ON42Fpa2ziGB3Ebg/tINzhfSJkoqh5uFhwXmDR
	SMszQDjgrOVF6OXgXLt4c5sCslWJcF6cMIPeZFA5LTtPoqWHjCnY/IoOY/rB0Bls
	aJ4ahspMnLrwt2+RwkP6aIlUkwMmJXvgU1dM8DT3re5eKzz8m+UryuOjoIdyVHcM
	adob+WJh+lwGbVGzz71c6pRKj89vR2hzLjeF5fGrYUlUVZ2M5bl5xIPTLiymTkq5
	QjXecrlTKDI2I7lYGlNNoPj+RER6ZxcTsUFo9LY5MdzF12vE63VkmGmHt+/YYlrb
	fP9fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnd9cx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:30:07 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46H5U6pk004680;
	Wed, 17 Jul 2024 05:30:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnd9cx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:30:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H12ikj009586;
	Wed, 17 Jul 2024 05:30:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmjmr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:30:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46H5U1Ko54460850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 05:30:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51052004E;
	Wed, 17 Jul 2024 05:30:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FB220040;
	Wed, 17 Jul 2024 05:29:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.47.122])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jul 2024 05:29:59 +0000 (GMT)
Date: Wed, 17 Jul 2024 10:59:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
 <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JiCbRVXGX1A1s-AVfFQDc6iao96CCMUa
X-Proofpoint-ORIG-GUID: MEAS-Y7ghFlj_ThbARp2C9rpbpOQ_9Bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=598 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170038

On Tue, Jul 16, 2024 at 07:54:43PM +0800, Baokun Li wrote:
> Hi Ojaswin,
> 
> On 2024/7/16 17:54, Ojaswin Mujoo wrote:
> > > > But the journal will ensure the consistency of the extents path after
> > > > this patch.
> > > > 
> > > > When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
> > > > ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
> > > > the extents tree to be inconsistent. But the inconsistency just
> > > > exists in memory and doesn't land on disk.
> > > > 
> > > > For ext4_ext_get_access(), the handle must have been aborted
> > > > when it returned an error, as follows:
> > > ext4_ext_get_access
> > >   ext4_journal_get_write_access
> > >    __ext4_journal_get_write_access
> > >     err = jbd2_journal_get_write_access
> > >     if (err)
> > >       ext4_journal_abort_handle
> > > > For ext4_ext_dirty(), since path->p_bh must not be null and handle
> > > > must be valid, handle is aborted anyway when an error is returned:
> > > ext4_ext_dirty
> > >   __ext4_ext_dirty
> > >    if (path->p_bh)
> > >      __ext4_handle_dirty_metadata
> > >       if (ext4_handle_valid(handle))
> > >         err = jbd2_journal_dirty_metadata
> > >          if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
> > >            ext4_journal_abort_handle
> > > > Thus the extents tree will only be inconsistent in memory, so only
> > > > the verified bit of the modified buffer needs to be cleared to avoid
> > > > these inconsistent data being used in memory.
> > > > 
> > > Regards,
> > > Baokun
> > Thanks for the explanation Baokun, so basically we only have the
> > inconsitency in the memory.
> > 
> > I do have a followup questions:
> > 
> > So in the above example, after we have the error, we'll have the buffer
> > for depth=0 marked as valid but pointing to the wrong ei_block.
> It looks wrong here. When there is an error, the ei_block of the
> unmodified buffer with depth=0 is the correct one, it is indeed
> 'valid' and it is consistent with the disk. Only buffers that were

Hey Baokun,

Ahh I see now, I was looking at it the wrong way. So basically since
depth 1 to 4 is inconsistent to the disk we mark then non verified so
then subsequent lookups can act accordingly.

Thanks for the explanation! I am in the middle of testing this patchset
with xfstests on a POWERPC system with 64k page size. I'll let you know
how that goes!

Regards,
Ojaswin
> modified during the error process need to be checked.
> 
> Regards,
> Baokun

> > 
> > In this case, can we have something like below:
> > 
> > -----------------
> > ext4_ext_remove_space
> >    err = ext4_ext_rm_idx (error, path[0].p_bh inconsistent but verified)
> >    /*
> >     * we release buffers of the path but path[0].p_bh is not cleaned up
> >     * due to other references to it (possible?)
> >     */
> > 
> > ... at a later point...:
> > 
> > ext4_find_extent
> >    bh = read_extent_tree_block()
> >      /*
> >       * we get the bh that was left inconsistent previously
> >       * since its verified, we dont check it again corrupting
> >       * the lookup
> >       */
> > 
> > -----------------
> > 
> > Is the above scenario possible? Or would the path[0].p_bh that was
> > corrupted previously always be reread during the subsequent
> > ext4_find_extent() lookup?
> > 
> > Thanks again,
> > Ojaswin
> 

