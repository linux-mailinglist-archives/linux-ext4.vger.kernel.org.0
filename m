Return-Path: <linux-ext4+bounces-7008-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF4A74EDD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A154D1653A3
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCE1DB55D;
	Fri, 28 Mar 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eq+hi93A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48463C0C;
	Fri, 28 Mar 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181853; cv=none; b=Ab9u3IkJUpOa/TY9Vk7BNbhISuRXXN1TUr9/kLRDqBvj4R4ksmh3azVcvluR6kEk4NhzaHkZytRyNDx/iipFze5MphivGbFnPUVUYx0d4ktYWBAhyulggi5EXMpC2b98DkOV2/WxPvl1WQUmh1fQsuj8kES7VwXkv+Rb3lV31zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181853; c=relaxed/simple;
	bh=ZCS/dxVchT7RjC/7c75KorG7EBsoBigVswbLraXEFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=casxJLoZiK0rjTSQ1mv1ArBr2hXaDPLnvQ9wyf9bkF5bHtczKfEg5oT3sWlFyRHYrMOjBPrrp0oAeEbd2JbDdziS0PkYlqUSPmi6JDpPYIEgNKQkVaFD+yed+AL3qaz4nC8n2uKvykG3KL0aYGrzFFVGc7Ytumu31M3A/5vPWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eq+hi93A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S8U4Zw028482;
	Fri, 28 Mar 2025 17:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dP6vDY0mqd0WAksGh2hpTgMVyiyQIO
	A63f5WdOoqu60=; b=Eq+hi93A/SvXwtYNBxeJ6DpaYYv0sU9g1XsQhq+xD0Lhbv
	EL+7JjK0Ka82Sh5bVvLYuivYRBcidEezhNqMaIc2zoOv4KSwUXyq+5xR5QCTDS7N
	6f7Aonzloq4SyoHNI2fsqpt0UiPE1c9hJjIcy0O3KGDonHYVmmimGxV2UudWuznC
	AeOcvVydKqxv1HlBJ2o8yaSxMj4DKautaleJ+ykg1KmOGJwdoadcrTK6B2AqIPgh
	3Ff29dBJBiz08pTtHp+v9Dy+7LvlCLp1yUBhbjY6ALOGb/2Psd4ck6mjCYDBUYVM
	E10s394Q0lau2U5FqZewv7HhkYQWaUEehw+znqfA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndupw79t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 17:10:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52SH61jo014248;
	Fri, 28 Mar 2025 17:10:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndupw79q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 17:10:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52SDSCdp012352;
	Fri, 28 Mar 2025 17:10:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mk8xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 17:10:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52SHAcXe41877794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 17:10:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCFCD20043;
	Fri, 28 Mar 2025 17:10:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17AC020040;
	Fri, 28 Mar 2025 17:10:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 17:10:36 +0000 (GMT)
Date: Fri, 28 Mar 2025 22:40:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent
 (4)
Message-ID: <Z-bYCp7CJqxVAdF9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <6772fd43.050a0220.2f3838.04cd.GAE@google.com>
 <67e5e2c3.050a0220.2f068f.0050.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e5e2c3.050a0220.2f068f.0050.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nuoN3PdPw7ClnNdoxMHgaIa4MA1Suc_L
X-Proofpoint-ORIG-GUID: -VtAZp3y_CT4zQ_DyfEyyU6kFm0H6kEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280117

On Thu, Mar 27, 2025 at 04:44:03PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 93cdf49f6eca5e23f6546b8f28457b2e6a6961d9
> Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Date:   Sat Mar 25 08:13:39 2023 +0000
> 
>     ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1566b43f980000
> start commit:   1e1ba8d23dae Merge tag 'timers-clocksource-2025-03-26' of ..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1766b43f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1366b43f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2edddb53537e0320
> dashboard link: https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623343f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123343f980000
> 
> Reported-by: syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Okay, so I'm able to replicate this with the patch whereas it does not
hit without it, so the bisect seems right. 

In my environment, at the time UAF hits, I also see the following logs:

[  139.893083][    T9] EXT4-fs error (device loop0): ext4_ext_split:1078: inode #15: comm kworker/u8:0: !
[  139.894260][    T9] EXT4-fs (loop0): Delayed block allocation failed for inode 15 at logical offset 17
[  139.894278][    T9] EXT4-fs (loop0): This should not happen!! Data will be lost
[  139.894278][    T9]

[  139.897505][ T1098] EXT4-fs error (device loop4): ext4_map_blocks:730: inode #15: block 131075: comm )
[  139.897607][ T1098] EXT4-fs (loop4): Delayed block allocation failed for inode 15 at logical offset 17
[  139.897624][ T1098] EXT4-fs (loop4): This should not happen!! Data will be lost

ext4_ext4_split:1078 is 	
  
	   if (unlikely(path[depth].p_ext > EXT_MAX_EXTENT(path[depth].p_hdr))) {

and ext4_map_blocks:730 is check_block_validity failure in map blocks.
I'm still trying to make sense of the logs and the UAF and will update
when I have more information.

Regards,
ojaswin



