Return-Path: <linux-ext4+bounces-9831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6DB45E60
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EE23A9E69
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C58309F09;
	Fri,  5 Sep 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="McIAE7M6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294430216A;
	Fri,  5 Sep 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090389; cv=none; b=CtK/WKYTVrBmViUWrh7SqKTNu8fafqJrkuPMhTPwWNebxMdAT8WSavjIOi4uy8a+M5hPFttSMmojfedgpW19lLe1VyPOEHFKb1LfyNT6lXyPgU2B+jrKDPdThRX6CSNazFHwZSPVhYt6D8cyTdwOBJAThCbc58smV0HReG0vDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090389; c=relaxed/simple;
	bh=S0TwjZpUPyv01fJLvHyQ+O8SblkWMRWqoSrkeCWqs/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5sofRxflzDsfVY3H/dpklPd/BviPhE3CzSD6jFgRtITLs95SOHOgvCZwGEM6eD6Aa9hqXw7rwYgdOGH8lWhwxSvbULzkyJAM2CA7wgaIQvbWmyVZRrUxPitRVqmpukgRI0RnOvJTEyfXqxutvC/yaafsaabaImptmKniOoSJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=McIAE7M6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GDilK019646;
	Fri, 5 Sep 2025 16:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AISZC/brx2LaVbcv17cxmRo25iGJLU
	Cvwihm8JffejI=; b=McIAE7M6iCJHtQC4SQdWS9kZwWrG6C+rBqQUhuvjlktL/G
	2GBBG8b8BkOZyaBlCe8Io4wHXxdlBEMa3XBR+N1QBwQRdgiQG+lKrl8yKLIMk//w
	mjJzDa2k7/7Kq5GhttK4jzZWEU1bg4c+X9PE8vDYj3nTjE6gOEpBkqcjDsUoR2nh
	FbN0j3BjWA2mwxy0nRrol7/KfP+eOD64M0OewHek7Ywy1AQd9JslWAScdXvkLbxF
	NUZFNN0wHrkd0eNSeEZfYG2O7NQhsNi8KVLqun5DTCj35YpUwst5J0zTWgF5l2WR
	Rvp9BEgAO6K3F3BP7D2fV6EG9DJWam6K+2CAIpmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3hudr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:39:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585GZR0O021153;
	Fri, 5 Sep 2025 16:39:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3hudp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:39:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585EFS14013941;
	Fri, 5 Sep 2025 16:39:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3t2px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:39:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585GdbeG23003600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 16:39:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61CF02004B;
	Fri,  5 Sep 2025 16:39:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2908320040;
	Fri,  5 Sep 2025 16:39:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 16:39:34 +0000 (GMT)
Date: Fri, 5 Sep 2025 22:09:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aLsSRFPvye9jDmdd@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <aLsG7Y3jPk0DcVOU@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <76ab5bdd-1d8b-4024-8eac-73ee247e9410@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ab5bdd-1d8b-4024-8eac-73ee247e9410@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RpvZoskRh_q3AV3QAvEP8EzcVFsEGh6h
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68bb124c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=6rh7t8xvsbNBSUqDWIEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Ogm_C8MiqKF0FtVS8LZrS8ewwvkSkxtY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX5rpkCExXRONW
 4zi37xxer/T3dQvrEX8yfgBdH+XqSDZK56NNJk8i1neDxpek0r6jI+MpG9nfn8C937e8YV25OJT
 6m7CtIX4wYGXuNxFInLc8c/kYmgrXdULHFEaDXC+T8F7HSiQt5L6TmjXwpU5TW2gShGAjz1U2ob
 HZxM2ENVqpYL8cT8okDH3AjAkyAyQBuyjLku10qpYz/dktGMnPVqWMsQ+UO2gEqkXBfIAmlYkB7
 5bc4n95h6iN0h+Nf7nP3oeikRlhRk/rJyZdcM9ug6JRSb15Gs4Z6TUuVIox/HcLBcIHJq3A05lB
 RGdbKAuNNU4oXZcSm/fCQWtoEixnKorKIr2vBNFt2g+ELLckGgtWBiQT0FtNo3kNFmIwGQEr5Nu
 f7iO1gdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

On Fri, Sep 05, 2025 at 05:14:47PM +0100, John Garry wrote:
> On 05/09/2025 16:51, Ojaswin Mujoo wrote:
> > > This requires the user to know the version which corresponds to the feature.
> > > Is that how things are done for other such utilities and their versions vs
> > > features?
> > Hi John,
> > 
> > So there are not many such helpers but the 2 I could see were used this
> > way:
> > 
> > tests/btrfs/284:
> >     _require_btrfs_send_version 2
> > 
> > tests/nfs/001:
> >     _require_test_nfs_version 4
> > 
> > So I though of keeping it this way.
> 
> What about the example of _require_xfs_io_command param, which checks if
> $param is supported?
> 
> We could have _require_fio_option atomics, which checks if a specific
> version is available which supports atomic? Or a more straightforward would
> be _require_fio_with_atomics.

Hey John,

Sure Im okay with having a high level helper. I liked the name you
previously suggested:

  _require_fio_atomic_writes() {
    _require_fio_version 3.38+
  }

And the tests could use it as:

  _require_fio_atomic_writes()
  fio_config="abc.fio"
  _require_fio $fio_config

------------------------

OR would you prefer:

  _require_fio_atomic_writes() {
    _require_fio_version 3.38+
    _require_fio $fio_config
  }

And the tests could use it as:

  fio_config="abc.fio"
  _require_fio_atomic_writes $fio_config

------------------------

Let me know which one would you prefer.

Regards,
ojaswin

> 
> Cheers
> 

