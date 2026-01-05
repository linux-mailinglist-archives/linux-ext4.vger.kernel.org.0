Return-Path: <linux-ext4+bounces-12568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B6CF2142
	for <lists+linux-ext4@lfdr.de>; Mon, 05 Jan 2026 07:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D7D3011419
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jan 2026 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5EE5478D;
	Mon,  5 Jan 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4l3HhzX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BC184;
	Mon,  5 Jan 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594897; cv=none; b=oR2DFiGxOxLhNcgWhizIxkxAntTmeSW30v7XiF+X0W6EjSEsczWJMwIaiKQI826YarGqrXt84t14SBsKiAM0fMdDdGkCiJ4CfwElVET+DAepmuG2J/p3umQUKu59Akidf9spf3sdQIsXnxe0pC8Q2uk8DfOLCTGN2clPGjSMt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594897; c=relaxed/simple;
	bh=GzTMMIwkqRezQlSnoIZtID8YrFaF3ivdsqUl+79XAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXiGTcWImo8H5bOYHkGN9BMZn5X4mS3qLSjDTM5ut/B9+HqZgwUL27k9RZopWpL17CsDO6mNeU/WHO+6K6Ev6XnVvdyQ1JOcffqLBFtx/GaBBbQavrGomCF6565cvF/zYAEyY14EBCi8G6rKnUpT2DRB6I2NONMs0O/o8RfIYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4l3HhzX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604Hgw8T022493;
	Mon, 5 Jan 2026 06:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KTeTcfCbVyWmnG4R+qkSqJeSpUMlNg
	3ebi6tx1KW9JU=; b=W4l3HhzXxWjmKHYUNHseDKmEKqX17tHK56n76QlJUnGeb4
	AG4YhsngcCdK0P1+k1axh9mrv6uFYVWUl1KjNR8+iUaZepf2OZlHMF4u73cqhxjm
	dCs+FX7vql1L0Xy6QKapHQx9D0FghAiQidUrrDmU/YCfTVP61tcVV5dirVs8GDH+
	4c9+ePN94uuAbYby4vsowu2/v/oQ6ULueX+OosOKR4D67vDAyJw2YgN3P/B63iPy
	rwuvkL/3OhT3BbLxrFAlWAyze3KEmlz2JCY9y4sTzCjWQs/0E7gWunrwYfA2p3YM
	msGAkgMnVnDDwnJTVgmkXAuPU8WGLx5G/f4hXTbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspwuvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 06:34:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6056XRFw011793;
	Mon, 5 Jan 2026 06:34:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspwuvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 06:34:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6053cGCu012560;
	Mon, 5 Jan 2026 06:34:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj43ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 06:34:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6056Ya2s60424668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 06:34:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 110A320043;
	Mon,  5 Jan 2026 06:34:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 416FD20040;
	Mon,  5 Jan 2026 06:34:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Jan 2026 06:34:34 +0000 (GMT)
Date: Mon, 5 Jan 2026 12:04:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ext4 extent split/convert refactor and kunit tests
Message-ID: <aVtbS3Ybg49qTpIw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767528171.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AGMWQUhgsMtBn_X51J3PaIbdF0NUBXdL
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695b5b7f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=JoMeTywGKBwSziRazvcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MZwoHs34CryZKo3ew2fsaWep9kHrdFYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA1NiBTYWx0ZWRfX7csyJIreYFk8
 4klqIpZWpDwjyjufL63YsJsT21vX4bQioUSQs2tbPLgbDOnn60vgrJR9OLFsZ8ZQzSLPOOiVkKI
 5JhOnzugJ9yYZWUoXuqyM0B/QpQH4EBYr204a4mjI5pQ4w95Y8Zl94tTUI97bzbr1W3kpZ9y+K4
 N30A/7z1CuFseahTvIAN4gUZTFdKmQLDUBlpvg6SvC0F7gs8WhAtDWNPkWxVEbN6grf0UAuV9fA
 TdipKnLO1kNMXHEVHDu2oH4+6WuX1tNJK1v3k/Su9iICSlYxxut3kc9HrHr9yU2xSIrOSWZJURa
 35QsWmfUo/xxoPpA+q3O48OqCKzJr9p3C/cI1l8YPE2gfLV6ihWcPvPBxKRPaNHm9OFhRPeTPyX
 QFm8/q3Ulq2UCJP2QgtInZY9W9+sOpW4A+JnHd3TcTUBfqZ+U/yciprnI5yYMwwNLOykWcFPwnG
 k48nsXaO/1jSlfJKt2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601050056

On Sun, Jan 04, 2026 at 05:49:13PM +0530, Ojaswin Mujoo wrote:
> Offlate we've have seen multiple issues and inconsistencies in the
> our extent splitting and conversion logic causing subtle bugs. Recent
> patches by Yhang Zi [1] helped address some of the issues however
> the messy use of EXT4_EXT_DATA_VALID* and EXT4_EXT_MARK_UNWRIT* flags
> made the implementation confusing and error prone.
> 
> This patchset aims to refactor the explent split and convert code paths
> to make the code simpler and the behavior consistent and easy to
> understand. It also adds several Kunit tests to stress various
> permutations of extent splitting and conversion.
> 
> I've rebased this over [2] since it seems like it'll go in first. 
> 
> Another idea I want to try out after this is proactively zeroout
> before even trying to split, as Jan suggested here [3], but before
> trying to do that I wanted to refactor and add some tests hence sending
> these patches out first.
> 
> [1] https://lore.kernel.org/linux-ext4/20251129103247.686136-1-yi.zhang@huaweicloud.com/
> [2] https://lore.kernel.org/linux-ext4/20251223011802.31238-1-yi.zhang@huaweicloud.com/T/#t
> [3] https://lore.kernel.org/linux-ext4/yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq/
> 
> Rest of the details can be found in the commit messages.
> 
> Patch 1-2: new kunit tests
> Patch 3-4: minor fixes
> Patch 5: refactoring zeroout and making sure zeroout handles all
>         permutations correctly
> Patch 6: Refactoring ext4_split_* functions.
> Patch 7: Enable zeroout for writ to unwrit case
> 
> Testing:
> - I've run kvm-xfstests for 4k, 1k and bigalloc_4k with -g quick and I
>   see no failures.
> - Some new kunit tests that were failing due to inconsistencies are not
>   passing

Are *now* passing with the patches* :)

> - Due to dev servers being down for eoy maintanence I couldn't run more
>   rigourous tests. In the coming week I'll run stress and auto group as
>   well.
> 
> Thoughts and comments are welcome.
> 
> Ojaswin Mujoo (7):
>   ext4: kunit tests for extent splitting and conversion
>   ext4: kunit tests for higher level extent manipulation functions
>   ext4: propagate flags to convert_initialized_extent()
>   ext4: propagate flags to ext4_convert_unwritten_extents_endio()
>   ext4: Refactor zeroout path and handle all cases
>   ext4: Refactor split and convert extents
>   ext4: Allow zeroout when doing written to unwritten split
> 
>  fs/ext4/extents-test.c   | 871 +++++++++++++++++++++++++++++++++++++++
>  fs/ext4/extents.c        | 591 +++++++++++++++-----------
>  fs/ext4/extents_status.c |   3 +
>  fs/ext4/inode.c          |   4 +
>  4 files changed, 1226 insertions(+), 243 deletions(-)
>  create mode 100644 fs/ext4/extents-test.c
> 
> -- 
> 2.51.0
> 

