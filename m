Return-Path: <linux-ext4+bounces-9165-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97632B0F498
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4667AA41F8
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1B2ED845;
	Wed, 23 Jul 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jS+gQDnv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77792288503;
	Wed, 23 Jul 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278879; cv=none; b=sjVrX5MA10/83zoifAcMIxf9sEK+f11a/60ITG2WiTjseZJA+oFN6eBlGzKRmFszaYQmzQsaKKc5Qx91WMNzCj16P9g+fSVnC6KsvEBee9uNWAXCS4Fshls2awAfzd/VvzlHXEW0emsatrutSAf1VAWQ4lmuPNrEP4yY9Rl4vTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278879; c=relaxed/simple;
	bh=RMuYBp0A6vyzQ766WOPRpQROGETcbc/JOZdzOJjILX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eInZSfST6tCk0Fc/SChmlFAPtF06v1YQA1nnw6OfSEfqJy4qj5f98LdzW73jreAbtYjmvJ40b+9+10GUZfhXntibICAeNQE44TKw6DbXXq9zk0CHQpRXlT99wgRQOVWO71x2GtPHCuNHD8WDUKaDacicIIVLxsFz9ZuuJBQbXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jS+gQDnv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8Poq9029669;
	Wed, 23 Jul 2025 13:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0YWJBrxGaCoqQ3YrHFW0WvtlSgQQ3Z
	qrq2kfmLR+Icw=; b=jS+gQDnvdCG2Ssa0l/lB95EmUmOXHCxRLDNCxgBFUo6aFV
	SvsW/Ym0J4QF3kA8TiC3fYd9NDZDJbbqioDMHBvCDedAMaZvBwd76R67DiNvpuSD
	yKQbiH3I3LxqyfiDSo9prfB5WjbD0ixS6ffr28uEXUCuBKWNF/qCfduZbyymf/s1
	FvCZuRW6BHjnQMwmLXWO7FOhwyW9z57OYd+ZLk1nHCck6DHCWD3QLTRxy4/Op/yO
	Npdm6xA/pzPud8luAx+rCAGyvzizObdlUKrg+/HviI/JHN8jvtNJhlnNpsh2x8H2
	HXvm/5SgMggYUdiUunyopF9+CVZr1Wn9rqgjjBaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdykv8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:54:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56NDmflY009745;
	Wed, 23 Jul 2025 13:54:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdykv86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:54:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9hdf0024744;
	Wed, 23 Jul 2025 13:54:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2fsxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:54:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NDsCL520775184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 13:54:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4911A20043;
	Wed, 23 Jul 2025 13:54:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BB420040;
	Wed, 23 Jul 2025 13:54:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 13:54:09 +0000 (GMT)
Date: Wed, 23 Jul 2025 19:23:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 07/13] generic/1228: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <aIDpdg_SibBYFAPy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>
 <20250717163510.GJ2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717163510.GJ2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wrwQ8mGAXZHX7I1lKsC4Q6DSqTqQiQBG
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6880e987 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=vSSht2dO2PesWFsvtsoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: F1TixKmTGwGx9V2IRWYqtOckXbGe6GaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX0z51h7rs0F3g
 Aj8xxKSfQVzwP4K09yqLUm8FQMCFk/4NzT7qtxZfJtQ+TdvUFzZ0tWbqwJGZ9I8kqpNXyKQKYTX
 6KW8HLYty+2hEwSDUCwB34iSLsemFTDiHGE5eobqNL51e+7kKpbYOg8PP6/nrUeFwY2PzVw3PgD
 tbJ3uoUp5ReIwvQYB2v6m1Jah/wNXI3e1atstarFQF64O/eogn34jsaTYSqeZtCI777N1v4Q1TW
 K5dOtKKvi17lKMd+oUe8H3q1r0ChqQHsZejjchBN/lRVxq/oJqPwby3InX4SFQUzovS0jJ6bnuJ
 gSj0iaahInTITWjHh+KxOR2c29s+2KrfawMaVGmPNomUDH0+FVPp77CUDdor1FuXswxsRNBDqau
 0tm09jpkFL77itakMHxKEewHN5TIHvUKxSaFY9vqJ/MoXhGAevoVozHi9g0+JwN0J413vAif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=768 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230117

On Thu, Jul 17, 2025 at 09:35:10AM -0700, Darrick J. Wong wrote:

<snip>

> > +verify_atomic_write() {
> > +	if [[ "$1" == "shutdown" ]]
> > +	then
> > +		local do_shutdown=1
> > +	fi
> > +
> > +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> > +
> > +	if [[ $do_shutdown -eq "1" ]]
> > +	then
> > +		echo "Shutting down filesystem" >> $seqres.full
> > +		_scratch_shutdown >> $seqres.full
> > +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> > +	fi
> > +
> > +	check_data_integrity
> > +}
> > +
> > +mixed_mapping_test() {
> > +	prep_mixed_mapping
> > +
> > +	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > +		        grep wrote | awk -F'[/ ]' '{print $2}')
> > +
> > +	verify_atomic_write $1
> 
> The shutdown happens after the synchronous write completes?  If so, then
> what part of recovery is this testing?
> 
> --D

Right, it is mostly inspired by [1] where sometimes isize update could
be lost after dio completion. Although this might not exactly be
affected by atomic writes, we added it here out of caution.

[1] https://lore.kernel.org/fstests/434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com/
> 
> > +}
> > +

