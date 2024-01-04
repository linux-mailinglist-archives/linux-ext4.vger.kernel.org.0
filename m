Return-Path: <linux-ext4+bounces-668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDD823C16
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 07:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DAE287EF3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DE1A28F;
	Thu,  4 Jan 2024 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Es6hIFGf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00B18ECC;
	Thu,  4 Jan 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4043pA6m011662;
	Thu, 4 Jan 2024 06:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Z4im9IN4pjqffl+xzHuW0Sg2rY6SbrkdQOjLJ8jg2zk=;
 b=Es6hIFGfQB6LkGHFLpIS1HtlAUK1fQ4Xh0A5B9u9aNM3MRYOxBezQk4avLZUWMYidZ0D
 Ki5zmag5fZ49NmPnswN8ZRad/EAfyPQEpMAGLLr/ZYSVtDdtnuY2GUeGniq61TTxj/dX
 JSzSDXFCGx4mZg2nJLsBLPbDE57M8jpQD5tlwsxbO3Cs/icuEcLpBYgrsIKLOTYG8bZR
 44yc725k4HG97g0B/5T3Zz0xkvVnToYmTDov98wUu0ied8yfI8OceuFs8WPHFxj2edp5
 ePyzq1X37z53zw1DTNbF2BqEtN3vxRs2HD5niFU9apnaTIBZEQCLRgBq/FrVCnPR7W1w /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdgctufgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 06:11:19 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4044PA9h003200;
	Thu, 4 Jan 2024 06:11:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdgctufe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 06:11:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4045EA8m024498;
	Thu, 4 Jan 2024 06:11:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082f2re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 06:11:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4046BCFu30736830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 06:11:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD18620043;
	Thu,  4 Jan 2024 06:11:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B436B20040;
	Thu,  4 Jan 2024 06:11:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jan 2024 06:11:11 +0000 (GMT)
Date: Thu, 4 Jan 2024 11:41:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Daniel Dawson <danielcdawson@gmail.com>
Cc: Carlos Carvalho <carlos@fisica.ufpr.br>, linux-ext4@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: parity raid and ext4 get stuck in writes
Message-ID: <ZZZL/b58ROm+uflo@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
 <ed52f171-646f-47ff-ad3b-be8bef48d813@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed52f171-646f-47ff-ad3b-be8bef48d813@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YuOVUYBPPcxXmPoc-Qr2yZ7HL4K7LlBE
X-Proofpoint-ORIG-GUID: qZyJq0T0rUEkIkB2WKY1m-9fesrA0q7b
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=775 suspectscore=0 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040043

On Sun, Dec 24, 2023 at 11:39:05PM -0800, Daniel Dawson wrote:
> On 12/22/23 12:48 PM, Carlos Carvalho wrote:
> > This is finally a summary of a long standing problem. When lots of writes to
> > many files are sent in a short time the kernel gets stuck and stops sending
> > write requests to the disks. Sometimes it recovers and finally sends the
> > modified pages to permanent storage, sometimes not and eventually other
> > functions degrade and the machine crashes.
> > 
> > A simple way to reproduce: expand a kernel source tree, like
> > xzcat linux-6.5.tar.xz | tar x -f -
> This sounds almost exactly like a problem I was having, right down to
> triggering it by writing the files of a kernel tree, though the details in
> my case are slightly different. I wanted to report it, but wanted to get a
> better handle on it and never managed it, and now I've changed my setup such
> that it doesn't happen anymore.
> > - it happens only with ext4 on a parity raid array
> 
> This is where it differs for me. I experienced it only with btrfs. But I had

Hi Daniel,

So I think there are some other people noticing something similar on
btrfs as well [1]. Maybe this is related to the issue you are noticing
although they have not mentioned anything about raid in btrfs.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2242391

Regards,
ojaswin
> two arrays with it, one on SSDs and one on HDDs. The HDD array exhibited the
> problem almost exclusively (the SSDs, I think, exhibited it once in several
> months, while the HDDs did pretty much every time I tried to compile a new
> kernel (until I started working around it), and even from some other things,
> which was a couple of times a week). I imagine because HDDs much slower and
> therefore allow more data to get cached.
> 
> Now that I've switched the HDD array to ext4, I haven't experienced the
> issue even once. But the setup has better performance, so maybe it's just
> because it flushes its writes faster.
> 
> -- 
> PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A
> 

