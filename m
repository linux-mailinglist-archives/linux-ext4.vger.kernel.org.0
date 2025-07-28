Return-Path: <linux-ext4+bounces-9202-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DAB13780
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF56A168407
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE4238C10;
	Mon, 28 Jul 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JAdjIL5i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F782327A3;
	Mon, 28 Jul 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694887; cv=none; b=XAU99Mozz3WPTrPcBXuuf7Weq3pVk85YHb801MAryupdI5jFxNs3OKlv1TywqKMCxK61FCRWgoeb8n1V3CU5O/rpsgHVmQ74kIE17syfRSNUhTXc3yA52jw+i623mjG6NIzXv1GQzFxK9vVcWAzVJ2sYyLHbUpuVwuWXlb83QkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694887; c=relaxed/simple;
	bh=CZztvEBOuWTUFsVJ+SgZuF1TKLAMvk8pdthyCh8jm7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBHQRfY0IS2K6ANWGIHv2m0PaGSmzISAOGvwHlxVim4d3pLw81gSajDNmp8a1LZ7q3JPYrTpHHAxrXCuxaq5GQwRa5avgvO1Y1/93MFVT0NLYVUzFQVKzYWt9I5cITmHSevTWxWYxRGnqvbC+glvzS+R59n2vYolXHBm6f/RkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JAdjIL5i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RKEgMd018791;
	Mon, 28 Jul 2025 09:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HDCX7nDeRDVxcRMYL3E+nIsT0huRc0
	lyhrUsIeB8CdM=; b=JAdjIL5isd85TpbCWTKx1t2DKSR0hFZP3rp/8bn4Viw68u
	4ZYEpnlDYJYVQOLFKBoTEYZHQRT+7PjzKTRtEJ5S+6pDpyA/U577eBOTZa5P1zQ6
	O3lD2cNKax7++TG9UcqQ04l9RDsYZ6LdYmD8Pd91+k4tqSfkBYiooEuubUl1nv8q
	OXHDPfLgpAhTUNS6TrSEfCVdCiQ7gIhXQE1OWhi50EI4Teslq+XwnMibtDcrfVeY
	44EVlnba90LkeJo8qBB3ABcG3V6EzqgoS4yNQyMj/VMJwZjX4knei3Brl59Jezo+
	DqqrqcwfUN2uqe9eZf52FvApUedntu+hvrxq6Lig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd585cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:27:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S9N57R025085;
	Mon, 28 Jul 2025 09:27:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd585cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:27:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S79Mod028782;
	Mon, 28 Jul 2025 09:27:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c22cv20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:27:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S9RsFc18874648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 09:27:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C3D2004B;
	Mon, 28 Jul 2025 09:27:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CECB620040;
	Mon, 28 Jul 2025 09:27:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Jul 2025 09:27:52 +0000 (GMT)
Date: Mon, 28 Jul 2025 14:57:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 06/13] generic/1227: Add atomic write test using fio
 verify on file mixed mappings
Message-ID: <aIdClh24QRu6mzcm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <f2d4a366f32ca56e1d47897dc5cf6cc8d85328b4.1752329098.git.ojaswin@linux.ibm.com>
 <20250728085851.i3rqef5zssralmvl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728085851.i3rqef5zssralmvl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2OCBTYWx0ZWRfXxSAZMkZOJobD
 eOZTtY2Yq5HeY2wRnUdnZ4IO4t//F6RtiHgymJEgL+7G8GXkT9lgEtaw38vFdO+McxM/U34AIL1
 vEzwib2ICP05FLc9scJyRWk92fus1ae5uwFYmuAXb1xB6M/rl0soqKFXDKGagz1mMD98xI3hyCV
 4LMXp9VBmJ1q8HwCqmCOqyrECOGTNTHUIM9vgm+7RZzYxPvHyGsxO6vbV560x8FlD6glnBsVhSQ
 7qRvB97EzzVvmVeudeutIGEVnZQ/JrJwUyW4aGiHuYWPTjUg/Qsom7zc/Avdg0x2crJNHNZ2qO1
 UA74sEOaVr+lyEURxeXLesczy8Cme7Cx9+kC0sxK4WbMMWhUk4JQ25bHrM5nCQqtnWZfDY1FLUZ
 sCRf/kv7EMqhqX2hSHyqnMhvwFGAN3DeczJ4pyKDi/0RW4UANUR4AaI9E5DRS9tWJ6Ehpx9/
X-Proofpoint-ORIG-GUID: lrK2P6grwbxr7KbrfJhsZW8ameibfw9B
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=6887429d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=o97Vj5sRf2UnNAzqRT0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nXy_P4_aX6Bqiym-X9oeU0Ivt_VwgxHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280068

On Mon, Jul 28, 2025 at 04:58:51PM +0800, Zorro Lang wrote:
> On Sat, Jul 12, 2025 at 07:42:48PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > This tests uses fio to first create a file with mixed mappings. Then it
> > does atomic writes using aio dio with parallel jobs to the same file
> > with mixed mappings. This forces the filesystem allocator to allocate
> > extents over mixed mapping regions to stress FS block allocators.
> > 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> 
> This patch looks good to me, just the subject:
>  "generic/1227: Add atomic write test using fio verify on file mixed mappings"
> 
> generally if we write a new test case, we don't use a temporary case number
> in commit subject, you can just write as "generic: add atomic write test using ..."
> 
> Other patches (with new test cases) refer to this.
> 
> With this change,
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Hi Zorro, thanks for pointing it out. I'll make the change in next
revision.

Regards,
Ojaswin


