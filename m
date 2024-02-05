Return-Path: <linux-ext4+bounces-1097-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A452884975D
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 11:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99FF1C21B95
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261614AB3;
	Mon,  5 Feb 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASKQUGmp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31C13AED;
	Mon,  5 Feb 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127752; cv=none; b=QIFtT+BZz+d5Q6hQr4X+r7HjXR4mwSsyFX7nifkTCBlzToDKfzYKUwy4WE/nkxP5xHy6pWFJKRL74SA7GcVkQWhGx2uKnnz9pwzkK5aiLeUR12+52XtYs1vgv/N1XbNF3J9r6n8VncP6GWbzstIeZAs8Ogt8VRVWKp89diS4n5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127752; c=relaxed/simple;
	bh=Zq7miwxbrFgr1QcCYOSeeksVLGohHwTXhO8tvxX9HyU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HB3yvm9zUTNNK5R3vV+vxMcG5EINFAFX4FW08RBaCjl5lJBJ4GUwv2MnQbLFsPdcoE/K2cMozJbAGQYLqeak2o5VRcompAJYSg2cQzy/+L2AIxYYoXnfqN3q0dYwsGme54PVBm36k/O4OXfP79YEh10/o5fIw/w7bH6ynOabKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASKQUGmp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159RNK6008177;
	Mon, 5 Feb 2024 10:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=JcsoH4hXZcWxZ1RfuRdTg/y9BbNd2oLKGK/54T9lzzQ=;
 b=ASKQUGmpsPufyS1CSEksrmLgjgm8TIlT8FaDb9/cSiFRahkaXzFtnndy7ekQQ8Y+6KYO
 1IIWj23gQCdpBvtPgj6L8LiZhfJEOK6oVqicL+CadBz4HnL3u1z73zX53S1PnVuNVaBE
 JzgTW2O+pFmpBdn0kU9LFX79BVMs2+yGoCBFoc7yYN9i62owz97gN5QD4vTPT9VQDUiZ
 NoqL+BDFp3IEEu/T7s91d8dS1+QKJ9Tk5PY2Tnmp080MGbsIfuIp38PEeTvbOzBJ/3iB
 gIeWIVsl19ftE5M2KDSuqmyJt4vJ7AvxmFnT9u8y4RveCkzIrNal2IIyhm6tP4kvyz16 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2w240xyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:09:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4159ksgG007148;
	Mon, 5 Feb 2024 10:09:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2w240xy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:09:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4159Yqf2016148;
	Mon, 5 Feb 2024 10:09:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1q808-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:09:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415A8wKE15205002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 10:08:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5EF620067;
	Mon,  5 Feb 2024 10:08:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C7222004F;
	Mon,  5 Feb 2024 10:08:57 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 10:08:56 +0000 (GMT)
Date: Mon, 5 Feb 2024 15:38:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz,
        ritesh.list@gmail.com, john.g.garry@oracle.com, djwong@kernel.org
Subject: Running out of inode flags in ext4
Message-ID: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LRKy6uw2ycFonp9HiHTMQga5tMeeKhDh
X-Proofpoint-GUID: 5vIVyb_WSIEbxEQn8QTo4T5SRouBM8zk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1031
 priorityscore=1501 malwarescore=0 mlxlogscore=581 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402050076

Hi folks,

I'm trying to rework the ext4 atomic write patchset so we have similar
semantics as discussed here [1], which would look something like:

1. we call FS_IOC_FSSETXATTR to enable atomic write on inode

2. In the setxattr path, we need to mark the inode with
atomic_write_enabled. XFS does it via an on disk inode flag which is
straightforward enough 

However, on ext4 we are almost out of 32 bits of inode flags and I don't
think it's possible to add any flags2 field or something (iiuc, ondisk
indoe doesn't have scope for expansion).

Some ideas that I have:

- I see that 0x00400000 (formerly EXT4_EOFBLOCKS_FL) is free to use but
	as per my understanding, this is interpreted in some way by older fsck
	versions. However, marking atomic writes as RO_COMPAT might help aavoid
	confusion in fsck.

- If we can't use inode flags, should we maybe use xattr to store
	atomic_write details?
	
Should I go with either of above or is there a better way to mark
ext4 inodes which I might be missing. Also, now that we are out of inode
flags, what's the recommended way to handle such use cases in the
future?

Would appreciate some suggestions on this.

Thanks,
ojaswin

[1]
https://lore.kernel.org/all/20240124142645.9334-4-john.g.garry@oracle.com/

