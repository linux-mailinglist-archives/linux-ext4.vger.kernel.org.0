Return-Path: <linux-ext4+bounces-11108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7303C13DD0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3481A27FD7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA12E8E1F;
	Tue, 28 Oct 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JItKFsnB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE42277C96;
	Tue, 28 Oct 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644369; cv=none; b=bVfjCB1ueuDjKQ/aM9tGbZSCqpXi9KU+GgfT8TkaFUAXbPTbWl9yQiBuIlrOifcvVeXZquy/v5PeIAW2+Z7YQ10UXtsn7Wb9cmJMWj9eKZVACDmwkEIJjS+sx6XzSwpQH8j+jsdOvfdrrp8UGhezB2sfnFaQeEXVHHD+s35zFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644369; c=relaxed/simple;
	bh=tUy110vddkdJnqWl2sEa90K4A/yomIhmT3LeLdZCDSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqwlcGX14lJ8Q78GbTNYwYqr1rLvzqjwM8LJaoVG7rNiv3cwlyEmYoQx/GzecLr3KGNKD7MzKJ/x76NUDX6lob4JDwWACc5nUkf6b8zJoTgfNF9vS/fRVlwUxniPyAi/7ZrLaHxopiCPDzHRnYNpIAy9kGD9N3XnV5RAdpCTj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JItKFsnB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RIINPu027900;
	Tue, 28 Oct 2025 09:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rqoINq
	pbR7qCzVzeW2poXgF/+kZjpzlEHSgEZTYbPAQ=; b=JItKFsnB2s6BpN2sa7DA3k
	Va5p5qXrTRCLhZiIg9MvYO3bqkKoqMrOKcy9Q4O9HJuc6Dd+Yghe2k/RLuuD58G0
	hsRf6s74ZbsRbcNdU8AjRGZ16rzigTcrL3mzoSoGctPPz/n2MqiQIl20KI2KpoI+
	rJzEvgKqd20H3rBEFeuZv0YKa1MeXqhy8mtxJP/an7zBs3QLUw7A1ZGfLKKu/rQy
	j4L/0b/vMQgf5zwHAWSAqNcNLiZMR0YWORDc+57GPbzZ94SSsuVCVTf7ocvs7bzP
	wBQU7ilj6/qFFCzg8/cbWONKxfZXAM8IXGAEblCVN9hXo5GkhuWrFJinV8iUUT7w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81u3db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:39:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S9d8DJ031862;
	Tue, 28 Oct 2025 09:39:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81u3d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:39:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S7Lxm3021598;
	Tue, 28 Oct 2025 09:39:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs24r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:39:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S9dJeq58327336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:39:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D9D220043;
	Tue, 28 Oct 2025 09:39:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6534420040;
	Tue, 28 Oct 2025 09:39:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 09:39:18 +0000 (GMT)
Date: Tue, 28 Oct 2025 15:09:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Leah Rumancik <lrumancik@google.com>, linux-ext4@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4/048: Fix hangup due to no free inodes
Message-ID: <aQCPQ1V8DuAMpmVc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251028071743.1507168-1-ojaswin@linux.ibm.com>
 <89dbd368-4e76-45b5-8c82-9102db9f302e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89dbd368-4e76-45b5-8c82-9102db9f302e@huawei.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=69008f4a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=xabxmebrqzwiKRJRnR4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1Ts5JcP6EDzIgwUouQb9zUt_ouQfoYMM
X-Proofpoint-GUID: jMH9foRuNxPSBAodUrb3mUREqPYZvLPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX0Kdz7jiiw/oK
 uccLRCWWRtfJStOkoSNBzqRCHhiQDjruJv0yJVoLmJLZo1m4w8cEFbN9kIIt5K3sjRd+lVRAA+I
 pQVjLgK0UysdrkTQbM/Cahu8Ff0zz7XMv70WbNH5vRnyHi5UHcOGK0aS7JvBUs5sWgzyOjj3iMd
 a7YHfa4Yvjf8KoLZxU5/XvBsRsqxL90IoyDjyaptYv18PbDPXrvi4Gn1Iz25G1P3KUVXA8f8dNq
 In/Y2ZMWxLebkaa8N7HgJzlbPqOrg1e5FWmcAfkmFZYai2i7wcHlYgScb7ogDrFvbCnkABRX5T5
 Ci+T/iQpaVkdJw8L144OceRyJTNSU39kAtKhtVAFGc8luQMoeZBoq3xkuAuzJAGwq3xO//nVkYS
 8qB4ubq3pwtTSGZ/deWb2EF+qqdNXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On Tue, Oct 28, 2025 at 03:57:00PM +0800, Baokun Li wrote:
> On 2025-10-28 15:17, Ojaswin Mujoo wrote:
> > We currently mkfs a 128MB filesystem, which gives use ~2048 free inodes
> > on 64k blocksize. The test then keeps adding new files to a directory to
> > trigger an htree split. For 64k this takes more than the total free
> > inodes, which causes touch to return -ENOSPC. This leads to the while
> > loop in induce_node_split() to never finish.
> >
> > To fix this:
> > 1. Format a 1G FS which gives us atleast 16K inodes to work with.
> > 2. _fail if there's any error while trying to induce node split, so we
> >    dont get stuck in loop
> >
> > Fixes: 466ddbfd1151 ("ext4: add test for ext4_dir_entry2 wipe")
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> 
> Yeah, I also hit this issue when testing LBS — file creation kept failing
> without breaking out of the loop, which resulted in the test case spinning
> endlessly.
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Baokun Li <libaokun1@huawei.com>

Hi Baokun, I was planning to CC you since I thought you might've hit it,
but missed it while sending the mail.

Thanks for the review :)

Regards,
ojaswin

> 
> >  tests/ext4/048 | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/ext4/048 b/tests/ext4/048
> > index 2031c8c8..6343ff3a 100755
> > --- a/tests/ext4/048
> > +++ b/tests/ext4/048
> > @@ -69,6 +69,11 @@ induce_node_split() {
> >  	while [[ "$(stat --printf="%s" $testdir)" == "$dir_size" ]]; do
> >  		file_num=$(($file_num + 1))
> >  		touch $testdir/test"$(printf "%04d" $file_num)"
> > +		local ret=$?
> > +		if [[ $ret -ne 0 ]]
> > +		then
> > +			_fail "ERROR induce_node_split(): $ret"
> > +		fi
> >  	done
> >  	_scratch_unmount >> $seqres.full 2>&1
> >  }
> > @@ -81,7 +86,7 @@ test_file1="test0001"
> >  test_file2="test0002"
> >  test_file3="test0003"
> >  
> > -_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((1 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> >  
> >  # create scratch dir for testing
> >  # create some files with no name a substr of another name so we can grep later
> 
> 

