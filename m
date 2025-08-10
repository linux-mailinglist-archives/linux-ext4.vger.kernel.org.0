Return-Path: <linux-ext4+bounces-9307-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19CB1F982
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 11:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369063A50EB
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306A242D78;
	Sun, 10 Aug 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CoWHlNtN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC948BEE;
	Sun, 10 Aug 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754818918; cv=none; b=PjYk5PafGF7bX456Thvid9ROUhIY3YZGw9OT5RrB97CtMVKS2L/bvDGD9vGDZQQfIhJbwHcU5gxfv9b7keOiBccsysiVdeTLANyTagMwJHHAlYmH68A7rNwIjR4uhIj6R8QSoQpW9C9bVh9Zk/pknXpaly+F0z6JT/zowa+diXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754818918; c=relaxed/simple;
	bh=HxXKid4gzZk4f/k8yE6zqulz1MKpGqJC7x8XQetKVoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llGajP773Hva7wf2ArwFUzn6AjuRSEjx7fUKEe9tDObjlu6yzAdjiHStRpovRD/JoXH53tDCV8r9J8+ZChuOcNSi6DioV3hZ+WsHFBtm+pJRhP6VjWl8jt0SRUsZk7Xui7xuxmPGLD8YWJwIJ53jhltsv0rvdtH+g592bOWtjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CoWHlNtN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A9UafY032244;
	Sun, 10 Aug 2025 09:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eUIR9POZpK7ETPFvmtBrWE7qW4mYsu
	7xez1pExehzP4=; b=CoWHlNtNMMgM5y6tSJwAKdnDkuiAO1MUkmkZErW9DvM5+M
	xKYVsUAK4e01ObzL6O1vyYWQ/xpXeIOSwH2Y4MYeRdDHv5MQjCcbhcIfTEfCnry9
	01kXXcCMxfJrdPwwbYO/MXLAhNnzWkFEJMak8w07WNA/p2q8wepCKoklugb+C7Ue
	y6b0UOKiNlRlJoYbtF8eq41wQnMoJNvsubOitJ9j5+eFuGs3mUwu5qtlnFuI3QgH
	53bIGSgAyDTcPJ90Vx2beSFf2sprUaCBWRh9V8VBnzAaQgAHoxIP1d/XsDHT/eHC
	x3PJM9L3R6Xfs7sDnEyPfBggy0YOJXs4vJ7irG4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucvss0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 09:41:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57A9fmao020659;
	Sun, 10 Aug 2025 09:41:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucvsrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 09:41:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A6F3df010622;
	Sun, 10 Aug 2025 09:41:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnu9hmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 09:41:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57A9fkRQ16122242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 09:41:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E5F20043;
	Sun, 10 Aug 2025 09:41:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B276520040;
	Sun, 10 Aug 2025 09:41:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Aug 2025 09:41:43 +0000 (GMT)
Date: Sun, 10 Aug 2025 15:11:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 07/13] generic/1228: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <aJhpVROJPYlz2gNB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>
 <20250717163510.GJ2672039@frogsfrogsfrogs>
 <aIDpdg_SibBYFAPy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250723145423.GN2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723145423.GN2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA2NyBTYWx0ZWRfXz39s8cURrgEA
 hMLMtVU+/ycloGFupQZzV1rY3fMQ8uHkr6h9JQMmJmk1h+tPeso25SlRGwVZ8LLcXHn5iDuUJkJ
 gTeuHpkRJSAMqCpfu8PhPbX0OnQ+wLKnXHMlWI05KphMT0GlwbPam/o7f/mSV+a7kgQLjIwO/Hb
 IDTf5nqD3ddVzWxdgYP5dnxrluZYQoQQwlQTdv888Y0Cy20+rqHLomBXc3FpeOX84jSBsGEx2Sm
 LmbixJQ/Ty6ksoDzQ1aX5awokMa9wsc2hrCFVuc6PJDhBDpiDi2u0iuDxhjtcdckX4sy/XgjDTf
 Lx5DXFZwVepLDWTBhc5x8Aza8qBHYNBAm7g/bbm+ZReHtsM3lyhqiTQmlkDaZp44GUd82Elq02H
 2vjr6xJ24SjrxoaiWFQ0esZ2R5XOAlclv3ZsWk228R3czc2ivrZKdGbJfGIV/V+Q9eOJrfS1
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=6898695d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=duHtkgBDHVnZg8uZmhQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ZbLsdEtLJCQDBvxTd_-8e38Bz4S3Gc4d
X-Proofpoint-ORIG-GUID: alXEItiCxgwqTKVMwi_sBksvfkFIGd28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=980 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100067

On Wed, Jul 23, 2025 at 07:54:23AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 23, 2025 at 07:23:58PM +0530, Ojaswin Mujoo wrote:
> > On Thu, Jul 17, 2025 at 09:35:10AM -0700, Darrick J. Wong wrote:
> > 
> > <snip>
> > 
> > > > +verify_atomic_write() {
> > > > +	if [[ "$1" == "shutdown" ]]
> > > > +	then
> > > > +		local do_shutdown=1
> > > > +	fi
> > > > +
> > > > +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> > > > +
> > > > +	if [[ $do_shutdown -eq "1" ]]
> > > > +	then
> > > > +		echo "Shutting down filesystem" >> $seqres.full
> > > > +		_scratch_shutdown >> $seqres.full
> > > > +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> > > > +	fi
> > > > +
> > > > +	check_data_integrity
> > > > +}
> > > > +
> > > > +mixed_mapping_test() {
> > > > +	prep_mixed_mapping
> > > > +
> > > > +	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> > > > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > > > +		        grep wrote | awk -F'[/ ]' '{print $2}')
> > > > +
> > > > +	verify_atomic_write $1
> > > 
> > > The shutdown happens after the synchronous write completes?  If so, then
> > > what part of recovery is this testing?
> > > 
> > > --D
> > 
> > Right, it is mostly inspired by [1] where sometimes isize update could
> > be lost after dio completion. Although this might not exactly be
> > affected by atomic writes, we added it here out of caution.
> > 
> > [1] https://lore.kernel.org/fstests/434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com/
> 
> Ah, so we're racing with background log flush then.  Would it improve
> the potential failure detection rate to call shutdown right after the
> pwrite, e.g.
> 
> $XFS_IO_PROG -dxc "pwrite -DA..." -c 'shutdown' $testfile
> 
> It can take a few milliseconds to walk down the bash functions and
> fork/exec another child process.

Sounds good, I can make that change.

Thanks!
> 
> --D
> 
> > > > +}
> > > > +
> > 

