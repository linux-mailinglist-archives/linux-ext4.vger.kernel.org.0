Return-Path: <linux-ext4+bounces-1133-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7D84ADD7
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 06:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F37728329C
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 05:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E67FBB9;
	Tue,  6 Feb 2024 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q10NdY6h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427A7D3FD;
	Tue,  6 Feb 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196424; cv=none; b=UwbewxC+v8y+LDWt9Twm8CtAKXePDTnCtTuku4g5wYiaK7BnGKXKAxEScdrWKnYltZFkCy+gsn2SUY6dB1f4LrQtw/flG5IKYR4XRv8NMmWlCcjX+bA9tqpMQ28VPqECl4WSZc47EeTDUhtV6UTc7W6qbH1QIbQTACBzX9W0TCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196424; c=relaxed/simple;
	bh=KcejBt6m6WW24dlygJMSgWuNQ4QwpdxGa69ZoW05pVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBS3BF82MwAzcOu+GUUGQfOQW1IuWKCf+n3/mJyUQAiBa2cm+ZYcHBowR0etD+fqOSXxEPa0Du3rrVb3NFDLmIfsSz0BLffuYGHPeMoGhTY2HvGYEpd24E2hwd1DXMWbDalnqQa+197foPe7GotkvF6eauS6rMSIyXLUUnCslVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q10NdY6h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4164mO34000522;
	Tue, 6 Feb 2024 05:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eHOC51YpZavXtHoIhO78ks21jAV+zrX5MTEl3C2U9/g=;
 b=Q10NdY6hC7OgEdSwjyeEFQ8+g366yrB/bTq+QaPK/UKASvpOlgMhgN9bo64vF8D7LLqE
 2klI4sVIiurC4FsPb9e6pyxA/aNPlzwFRcqJNbxULzm7+3l7wUP9/oGUzfyhfMS1SKYW
 lYpewdOYEPbjOQyQf1wHhx2VaXstU8mxvV/DdAwv1c3senE4IizpkinTlPaoY3PrPRKl
 61BPFlKvBdqhPt1prU/MHbsR6+K/MvS5RsR+2qJbupiqiQ7cFTKCKoxbRpn/4IVYDyQ1
 OEB+5nLRVcDYTv1wmLCRDKBF/xWCGgfzhdMhck09JRKsBJGcNRYRaQge3q4Trlk4ikRK RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3e2c8g75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:13:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4165CWaT016606;
	Tue, 6 Feb 2024 05:13:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3e2c8g6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:13:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4161v16C008971;
	Tue, 6 Feb 2024 05:13:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206yd5m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:13:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4165DV5W21037616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 05:13:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F1A2004B;
	Tue,  6 Feb 2024 05:13:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87CAA20040;
	Tue,  6 Feb 2024 05:13:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Feb 2024 05:13:29 +0000 (GMT)
Date: Tue, 6 Feb 2024 10:43:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        g@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz,
        ritesh.list@gmail.com, john.g.garry@oracle.com, djwong@kernel.org
Subject: Re: Running out of inode flags in ext4
Message-ID: <ZcG/96H2zWmtSnyC@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20240205163249.GE119530@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205163249.GE119530@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 42qMiBVFOtOwJR5lR-BXEHEGpMhIHrTw
X-Proofpoint-ORIG-GUID: r_R6959xudH6emLxUp6n4Amda9nwKPeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1031 adultscore=0 mlxlogscore=550
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060034

On Mon, Feb 05, 2024 at 11:32:49AM -0500, Theodore Ts'o wrote:
> On Mon, Feb 05, 2024 at 03:38:54PM +0530, Ojaswin Mujoo wrote:
> > Hi folks,
> > 
> > I'm trying to rework the ext4 atomic write patchset so we have similar
> > semantics as discussed here [1], which would look something like:
> > 
> > 1. we call FS_IOC_FSSETXATTR to enable atomic write on inode
> > 
> > 2. In the setxattr path, we need to mark the inode with
> > atomic_write_enabled. XFS does it via an on disk inode flag which is
> > straightforward enough 
> > 
> > However, on ext4 we are almost out of 32 bits of inode flags and I don't
> > think it's possible to add any flags2 field or something (iiuc, ondisk
> > indoe doesn't have scope for expansion).
> 
> We still have some unused flags.  For example,
> 0x01000000. 0x04000000. and 0x08000000 are still unused.  We are
> starting to get close to full, so we need to be a bit careful since it
> is very much a limited resource.  But we're not yet at the point where
> we need to worry about trying to reuse flags like EXT4_EOFBLOCKS_FL.
Hi Ted,

Thats true, i don't even know how I missed that :) Sorry for the noise.

Regards,
ojaswin
> 
> Cheers,
> 
> 							- Ted

