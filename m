Return-Path: <linux-ext4+bounces-6973-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA24A7089E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Mar 2025 18:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6813C176324
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Mar 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477D2641F0;
	Tue, 25 Mar 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKcz7p7r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2B263F28;
	Tue, 25 Mar 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925490; cv=none; b=EM7YI80iRDx2hef4S6bieO5cpR4tgRLLEHpjGT2tRRJT1oAa3Koy6kBqFIjIx7hGF6Gw9Nk1xEjQ5VQpA5p6cMXQSBnAn6vGpK1C7fLGDql5EVpj3Sr3e81WGP8IbvIYGnOZkASKZlcvueKlKCDXHSe5+vTbPwDJ/3rOuxzMBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925490; c=relaxed/simple;
	bh=5HdLC1rHg9J4X7tyalzd6IcNZV6O6wiOCoBst61C28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I79xZ9FvBlhgwKYKpYcwZGuOEOCLej8GcooKN9LOikue13m3YlJ7u4HuIBRnmgPaKr6OvaZkuKgFtJmvKtrMGB28vQxwE1TJBR8WS+T29izxZ8C/b5w9H+ZQGvOJQYrBFS3i5x95oRGjkYGstKokRTmQijkUhSF7iDmweTsh+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKcz7p7r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PHHvst011926;
	Tue, 25 Mar 2025 17:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8vcQ8AubDxfyCdEsQwqdCwbEDoKiwC
	MRRguYk7riU08=; b=hKcz7p7rs4tWIwMpa3XZiKBOSYDdUan50RFTN1fXRoTsSA
	0FkwDaisTMer+7eZqfIJEfAViTli7a3PFBKlSuYUsgij0OpYKJKfv5NpG+MjlYsJ
	HjxkQvbx2XQbZe6pnG1tnF4BFd/YwE36Sd9iNIcBW2xELNAC5V0sTq9zQgErPaT1
	4b50v6VU6sCTQabppu5Ec1nHaHGCfpgUsbLbxHumBrxORO1y3jgnpDC7pecIzilF
	WAUok1ggYe3E6dBYTe531UtrNcmTHUWSoFniUvLsdo/SZYMMGqgu5bkVVN7H4AIy
	yKbDHuKiT3slNMblip5GJ+VlEBRywJ53KafIhxCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpwahg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:57:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PHswSj024773;
	Tue, 25 Mar 2025 17:57:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpwahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:57:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PHJ0n4009709;
	Tue, 25 Mar 2025 17:57:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkmd1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:57:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PHvsmd40304976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 17:57:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D16A20043;
	Tue, 25 Mar 2025 17:57:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCFE320040;
	Tue, 25 Mar 2025 17:57:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 17:57:52 +0000 (GMT)
Date: Tue, 25 Mar 2025 23:27:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Message-ID: <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319023129.GF787758@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ov2922JpmuaCPDHh_lHntdBbsCt5gQWw
X-Proofpoint-GUID: B5aLWMCwwtG6I8WlOVbtPkkNuMo7lkt5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=516 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250119

On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
> On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
> > > So this is something we need to do if the journal is actived, and if
> > > it's active, then sbi->s_journal will be non-NULL, and so we can just
> > > check to see if inode == sbi->s_journal instead.  This will simplify
> > 
> > I believe you mean inode == sbi->s_journal->j_inode here right?
> 
> Yes, that's what I meant; sorry for the not catching this before I
> sent my reply.
> 
> Cheers,
> 
> 					- Ted

Hi Ted, Baokun,

I got some time to revisit this. Seems like checking against
s_journal->j_inode is not enough. This is because both
ext4_check_blockref() and check_block_validity() can be called even
before journal->j_inode is set:

ext4_open_inode_journal
  ext4_get_journal_inode
	  __ext4_iget
		  ext4_ind_check_inode
			  ext4_check_blockref  /* j_inode not set */

  journal = jbd2_journal_init_inode
	  bmap
		  ext4_bmap
			 iomap_bmap
			   ext4_iomap_begin
				   ext4_map_blocks
					   check_block_validity

  journal->j_inode = inode


Now, I think in this case the best solution might be to use the extra
field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
sufficiently early.

Thoughts?

