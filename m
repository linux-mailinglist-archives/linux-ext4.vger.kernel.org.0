Return-Path: <linux-ext4+bounces-10568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99386BB4B8D
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06DBD4E27D4
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C87274B39;
	Thu,  2 Oct 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3I0W44v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264D2749E0;
	Thu,  2 Oct 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427006; cv=none; b=p0gNxS6AKiaIvWdpEEhcQcNCc0O2c0DZr5W+UMJ9EPpQQ4oj7jLbbV+eFa1jBgTV3Rlu3NSRTws3DbXnhsYzvm9HZFCEpMxpHMeq1xrKjI9wuUW09yIfS2b9r2f301672V4aRxpoFa9O1TOVxEjfdPpFG4mxB/tAhHRFm+dZv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427006; c=relaxed/simple;
	bh=NIT5wDqV8woLQiSPOPYTXbuCcenXuPaJCJos0Up77UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHhdhuQO8j0rPI2LAVCKJU8cb/Zf5dE/WaZxH3GB1nW0SzNQnNwU7C2nWGLtveTOw8K85Ue0dRTmzcghIB2OogxnEMBW8RlkF6yYIKh5jTMNrWXTEorJcmIhzX9vkaNzuKAnJ9guTE6YHUZOsJLX0wnE4o33lBxK5pvC/u8K+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3I0W44v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592AHxAN011590;
	Thu, 2 Oct 2025 17:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nssoqpINitCeMvSG/7exWcv5JhvRmA
	H+O1b4zrZmRUU=; b=H3I0W44vgQOoBQAVnr5v114A2rYnOfg58Lfo2uJ8WjbGP6
	CPwu0Foewlx7hghKLzxlRb4oh1j4fsnQ8PhAzHPhESiHo4whV0BitX3z4k6AcKXx
	MmeWQwd6yz+Rj9X80ZGsMtMjyRa4sgsnGmh//fqBKIsSjeHXT2rynJxht+1XXo7n
	mfy2A+UclMMIcf1FTpIZEpgRuWsHPB0LdRcosVHCG9rduvYOLuiweyFrvqDptqkn
	fLD471JijfzhIjUndoGRuXWHkqX3eRno+2MJkPod7iRSjYnzouatG3//bcKfFC/J
	nMxscuuTCGzTsirDczSNg2WArRpRSB4dMGoHc34Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwwn7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:43:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 592HgKYj021924;
	Thu, 2 Oct 2025 17:43:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwwn7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:43:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592GG7EW020064;
	Thu, 2 Oct 2025 17:43:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8sf9xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:43:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592Hgw8I52560326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 17:42:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB25B20043;
	Thu,  2 Oct 2025 17:42:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 202C320040;
	Thu,  2 Oct 2025 17:42:57 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 17:42:56 +0000 (GMT)
Date: Thu, 2 Oct 2025 23:12:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 2/2] fsmap: use blocksize units instead of cluster units
Message-ID: <aN65nsxrpMoK33h5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1757058211.git.ojaswin@linux.ibm.com>
 <d332ed2f90a0c8533139741d25e7fc1935773e14.1757058211.git.ojaswin@linux.ibm.com>
 <20250926123536.GA12175@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926123536.GA12175@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXxy4BW5fwSuZF
 PUJhOvA3WZTPQ8C5WHk4p7OWuowoC7BnaIhXVd795czHMNJG4lcmzbWXQr5gJszQ+86yACfa+ci
 yz66vVWzQEuDNrmDnjstQjz6n5pyEL1N7R85YaGGfUAXD2U6pdaMa6fE3y0WLCbIWtPIuwrHUoH
 uRkaiisXBHP+MKWJLUMtKIka0gOpCdfXRsqcX1o3bQ7K1yEod/Wt2dy0smd8VrNvfSQcn1tBgXM
 tCwrAsbv1tC+kxVCGqsaMQlkxOXeK4+doszMTac/qAOCgrpNsdsTGn8xxblaVVpyPTju09X7Q4I
 c7FiXTySZ8jzE1aFMffJ3BxXfRLXa1EqycpTYOu44X6S5ssHAc5ezbZl/u8YhUF6Q0PS4D4Pt8H
 BFGMV49bXNlHXWjl9A/2pA+/cW3eVQ==
X-Proofpoint-ORIG-GUID: qc5L8To2Q2bZg9qHRNojDkm6SopP61Oz
X-Proofpoint-GUID: AVllfxe1H5COGzXBlri5ltQf5xbdQrU4
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68deb9a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=eOGLbINAkHJCJ0LyVhEA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Fri, Sep 26, 2025 at 08:35:36AM -0400, Theodore Ts'o wrote:
> On Fri, Sep 05, 2025 at 01:44:47PM +0530, Ojaswin Mujoo wrote:
> > Currently, ext4's implementation of fsmap converts the ranges to cluster
> > units if bigalloc is enabled and then converts to block units whenever
> > needed. However, this back and forth conversion has known to cause
> > several edge case issues since even with bigalloc the metadata is still
> > in block size unit....
> 
> This commit causes ext4/028 to fail with a 1k blocksize.  The failure
> happens after just under 45 minutes; before this commit, ext4/028
> would complete after a second.
> 
> Do you have a preference regarding whether I just drop this commit, or
> drop the whole series?  The previous patch looks fine to me and fixes
> a real problem, so my plan is to keep the 1/2 commit and drop this
> one.

Hey Ted,

Thanks for pointing this out, I'll look into the failure. Sorry for the
late reply I've been on vacation this week. 

I'll get to it as soon as possible.

Regards,
ojaswin

> 
> Cheers,
> 
> 						- Ted

