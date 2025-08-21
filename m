Return-Path: <linux-ext4+bounces-9496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11666B2F7B6
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 14:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BA4189453B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347A30DEDB;
	Thu, 21 Aug 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZzgZOHD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27727F16C;
	Thu, 21 Aug 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778754; cv=none; b=PcJEe3ttXCW7aL6xjF6MohxUxDDMrwxDUarpjQF06vaYL7zgtZCDt48rnKtTkSyOfakZL0mWFATO8seQj10GEl0bnMRZv4PSt5fHSSzhzEqIAIx6yZKeIyOw+bL0g3mYEQiQ0Gicd9XYZBHJH5/dviQtQVlQ7Y6hDNah9pNpsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778754; c=relaxed/simple;
	bh=GJXV9IwdbHELpPd1iqWlbQOye/lVA2wHMGvLjKuCdn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2in2C4KHVLfYMguoR7y9Gxywm37qLWvBry2gTIEFBB5qdoZh1WZKMbHDrwDWI84XWQXLVTgg2oj4RWvu8mJHbGEASHUTjI3AsxvK76/1hIqYkJuoSCVkpL9EaOQLAPSetQjdPZD6V5UgH2jKhXBxGItTyC+QPK/IJy/vGSZb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZzgZOHD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAvUWC009423;
	Thu, 21 Aug 2025 12:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7RTv4cHvCYuthGaYXQWkCkqFkgugsY
	NJ/YEXJhNu4Ec=; b=rZzgZOHD4SNL/QNJvM25Wd9aYOh676R/VYZk90yYtQ2wel
	TZb3FOyumi27l0Uzzw+1wBo5PeiJflMe2BtcVN2uGeoAsURwIZdeXRAG1hhSjuSb
	dAijuOMIc8AZ7mUXW0WGjb2STMKpHOr1jJac3XzkjgMXsaV8qXgDYeO9EsOObg6j
	BoznDyXU/h1efXyRYEnbh2mEsWcVcoKeCd06JYGRxwxf0+B9iKnNEmSQK3OUXfy7
	F/YWT1OnCp9XpQveJ/bV69ZM6wxUR0Mg+yuJegkgCH1TPc7dUCSuEnBmwq7YfKz2
	YKKWke0oRqfuRLgOg0RikoCl4E9JJOEEShx8UKgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w0d7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:18:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LCIwgt021533;
	Thu, 21 Aug 2025 12:18:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w0d7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:18:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAhceS015619;
	Thu, 21 Aug 2025 12:18:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my4286sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:18:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LCIusc44237306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:18:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D2D2004B;
	Thu, 21 Aug 2025 12:18:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B43F20040;
	Thu, 21 Aug 2025 12:18:54 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 12:18:53 +0000 (GMT)
Date: Thu, 21 Aug 2025 17:48:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 04/11] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <aKcOou4LLl3aQqLq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
 <f9ae3870-f6c5-4ab0-924e-261f4ec3b5cc@oracle.com>
 <aKbb2XhcsMMhBlgb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4572fcd8-6364-4827-af9b-d11728c39c78@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4572fcd8-6364-4827-af9b-d11728c39c78@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dDD9tmTdv6twEE1s6hstAlszRkAck6wC
X-Proofpoint-GUID: RWw4PfjNydTSolXyYX07QT-9Siyzbb6f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX0ZStzglO+bbm
 VNnLLaJa0T0quiL2Gis+kgryHHI9qdBGasqX3hnZ56LE1X3M+p0uYXpPkWdEULd2z/HMBGX1HRg
 2xZw1oqA0Fc6Z0gwzCXYt7Q7Fa9K38wmfsVsySizIH5oGfdAGSX7eb+66TZOmuE/Ujhd8eOrsYI
 jAvQRfI6dpuJdlRcukIc4as27fK9hRNusoEiWbr3jnaDU/g6+vYVYC3j6ey8TWTnu6g1tIre96R
 Gflg+UZVgS44cDpzS3gWSgQnKxCvLAYXOnRMU5SfD9pY4DhC/a01CKtf/H0W95T92E1wJd9XM6X
 6KcA9REc6PVk4xIUi9QqIZiTuWwQ8BJfrfeq+9tNhnojB0YXkLUqId1BEEV+ZeaQx/DuLrGJGV3
 TNcC0Hi2QN7aSGC8foqs5f1Y39CGag==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a70eb3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Popbfe6uXnL6BILChUUA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On Thu, Aug 21, 2025 at 10:24:58AM +0100, John Garry wrote:
> On 21/08/2025 09:42, Ojaswin Mujoo wrote:
> > On Wed, Aug 13, 2025 at 02:39:40PM +0100, John Garry wrote:
> > > On 10/08/2025 14:41, Ojaswin Mujoo wrote:
> > > > This adds atomic write test using fio based on it's crc check verifier.
> > > > fio adds a crc for each data block. If the underlying device supports
> > > > atomic write then it is guaranteed that we will never have a mix data from
> > > > two threads writing on the same physical block.
> > > > 
> > > > Avoid doing overlapping parallel atomic writes because it might give
> > > > unexpected results. Use offset_increment=, size= fio options to achieve
> > > > this behavior.
> > > > 
> > > You are not really describing what the test does.
> > > 
> > > In the first paragraph, you state what fio verify function does and then
> > > describe what RWF_ATOMIC means when we only use HW support, i.e. serialises.
> > > In the second you mention that we guarantee no inter-thread overlapping
> > > writes.
> > Got it John, I will add better commit messages for the fio tests.
> > >  From a glance at the code below, in this test each thread writes to a
> > > separate part of the file and then verifies no crc corruption. But even with
> > > atomic=0, I would expect no corruption here.
> > Right, this is mostly a stress test that is ensuring that all the new
> > atomic write code paths are not causing anything to break or
> > introducing any regressions. This should pass with both atomic or non
> > atomic writes but by using RWF_ATOMIC we excercise the atomic specific
> > code paths, improving the code coverage.
> 
> I am not sure really how much value this has. At least it should be
> documented what we are doing here and what value there is in this test.

Got it John, I'll add it with information about what we are doing and
what we are trying to stress.

Regards,
ojaswin

> 
> Thanks,
> John

