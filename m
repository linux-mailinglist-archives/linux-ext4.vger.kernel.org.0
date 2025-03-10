Return-Path: <linux-ext4+bounces-6741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E11A58D75
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 09:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E9188DA37
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01F222588;
	Mon, 10 Mar 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="npYs6iPD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323791D432D;
	Mon, 10 Mar 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593576; cv=none; b=e7FFW68xGql+Y4y0wmVc69hdmLfOiY8IxJK8WYAg6Ot42jC9hs3zzhphDYPZ7HzkvvJhumJ2vx3C3FcY9cPoh24V+HIPIFiCReKglClXAXNTGZCBmZUtjUE4EGV4ddUbFd5xX2LdMXQ5yrUN85ZfntSM9Gy+lye1CS2+u2JDmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593576; c=relaxed/simple;
	bh=hrfyWyfU7hL4/yB2MI0jgRRNnZpqC4KUKiKVex1CDug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfOJRbAoMQ67jXoKHClhHzVLXJJoXHf5tiptIyADi3xLWs0iB/Z0CNy9XZU3vJKz0GyJ+xyvDFthcrGjbRC8SebkbEonx+RNcucVmo2902EftRKEUie7C8oOyXWMjPe3mLThMhMtxktSVczvAq2Tck+8MYLzwROCVIUcdG82FI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=npYs6iPD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A3jlcL016934;
	Mon, 10 Mar 2025 07:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQG59l
	QOGr0uco6SMi/hMmUMG2NERHmXLi2EltnlBSs=; b=npYs6iPDztAey/KRdWD6wc
	SrmZTM/vzHfOs2rGK1zWt2x7fKjuwD1ckW8U8IHDQvI0KrsHmffZF/lHEYF7Xk9/
	SA8v5U188//gV+tolPMgtvHy56N2nkMhuM9DSTnZvjFyLzVcC6ommSpugAfJZ16b
	IfZIPSCLx7XUp43UWku49qurnER4NCiY+hLrWAke1IB75guvhRZ+J4ZdCbaqWiCK
	aG0zBpBhCLOALwibSxAef398vsWDKI1JqsJUNjvb6ZIgNprvJEV31/pZ9VMyTkz1
	ylmYl9F4iCVApuN3jdzPRFOfsm54AUvMU7FL6qY9e6YkHaVtncH0X8t3SJRypWdg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf910rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:59:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A4BBhP014024;
	Mon, 10 Mar 2025 07:59:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1n3x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:59:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52A7xIml34865824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 07:59:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79C892004F;
	Mon, 10 Mar 2025 07:59:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B87200DF;
	Mon, 10 Mar 2025 07:59:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.219.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Mar 2025 07:59:16 +0000 (GMT)
Date: Mon, 10 Mar 2025 13:29:13 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v2 0/3] Fix a BUG_ON crashing the kernel in
 start_this_handle
Message-ID: <Z86b0c_qTURBBkOW@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <692ab4aa-ff90-4b6f-980d-bfd6c1ca7619@huawei.com>
 <Z8xBHVU1vChK2rMO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z8xgY07XJuIi49Q9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <098bbcba-c7ba-4527-9486-1d89c902c594@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <098bbcba-c7ba-4527-9486-1d89c902c594@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uUFhjE8z7PY8vVszdXe3jaB7juXOjd58
X-Proofpoint-GUID: uUFhjE8z7PY8vVszdXe3jaB7juXOjd58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100062

On Mon, Mar 10, 2025 at 11:10:26AM +0800, Baokun Li wrote:
> On 2025/3/8 23:21, Ojaswin Mujoo wrote:
> > On Sat, Mar 08, 2025 at 06:37:41PM +0530, Ojaswin Mujoo wrote:
> > > On Sat, Mar 08, 2025 at 09:09:28AM +0800, Baokun Li wrote:
> > > > On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> > > > > ** Changes since v1 [1] **
> > > > > 
> > > > >    * Picked up RVBs from Jan and Ritesh
> > > > >    * In patch 2/3, we now use a flag in sbi instead of SB_ACITVE
> > > > >      to determine when to journal sb vs when to commit directly.
> > > > >    * Added a prep patch 1/3
> > > > > 
> > > > > [1] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#m5e659425b8c8fe2ac01e7242b77fed315ff89db4
> > > > > 
> > > > > @Baokun, I didn't get a chance to look into the journal_inode
> > > > > modifications we were discussing in [2]. I'll try to spend some time and
> > > > > send that as a separate patch. Hope that's okay
> > > > > 
> > > > > [2] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#mad8feb44d9b6ddadf87830b92caa7b78d902dc05
> > > > That's fine, it's not a priority. And if this patch set makes sure we
> > > > don't crash when things go wrong, I'm okay with leaving it as is.
> > > > 
> > > > It's possible that jbd2_journal_commit_transaction() could call
> > > > ext4_handle_error() in other places as the code evolves. Fixing known
> > > > problems and protecting against potential ones is always a good thing.
> > > Yep thats true, I did spend some time on this since the codepath was a
> > > bit unfamiliar to me. Seems like a straighforward enough change. I'll
> > > add it to the next patch.
> > > 
> > > thanks,
> > > ojaswin
> > Hey Baokun,
> > 
> > So while coding this up, I started looking at some codepaths and it got
> > me wondering when can we actually change the sbi->s_es->s_journal_inum
> > (or sbi->s_sbh) from the time it gets populated to the umount time?
> > 
> > Since the sbi->s_sbh buffer head is always in memory and never reclaimed
> > due the elevated reference, the only way to modify it should be if we
> > modify the memory page somehow. Or is there some codepath/tooling magic
> > I'm missing that can modify this value?
> For the ext4 file system, s_journal_inum is fixed after mkfs and is not
> expected to be modified. However, the sbi->s_sbh buffer head belongs to
> the block device, so direct write operations to the file system's block
> device /dev/xxx may directly modify sbi->s_sbh.

Right got it, now I get the full picture of the change you are
suggesting. Thanks Baokun, I'll do that in next revision.

Regards,
ojaswin

> 
> For example, you can use the following script to trigger a journal bmap
> failure:
> 
> mkfs.ext4 -F /dev/sda
> mount /dev/sda /tmp/test
> dd if=/dev/zero of=/dev/sda bs=4096 count=1
> echo 1 > /tmp/test/file
> umount /tmp/test
> 
> (Adding a delay in put_super and performing the script during the delay
>  can trigger the issue described in the patch.)
> 
> 
> Cheers,
> Baokun
> > 
> > Regards,
> > ojaswin
> > > > 
> > > > Cheers,
> > > > Baokun
> > > > > ** Original Cover **
> > > > > 
> > > > > When running LTP stress tests on ext4, after a multiday run we seemed to
> > > > > have hit the following BUG_ON:
> > > > > 
> > > > >    [NIP  : start_this_handle+268]
> > > > >    #3 [c000001067c27a40] start_this_handle at c008000004d40f74 [jbd2]  (unreliable)
> > > > >    #4 [c000001067c27b60] jbd2__journal_start at c008000004d415cc [jbd2]
> > > > >    #5 [c000001067c27be0] update_super_work at c0080000053f9758 [ext4]
> > > > >    #6 [c000001067c27c70] process_one_work at c000000000188790
> > > > >    #7 [c000001067c27d20] worker_thread at c00000000018973c
> > > > >    #8 [c000001067c27dc0] kthread at c000000000196c84
> > > > >    #9 [c000001067c27e10] ret_from_kernel_thread at c00000000000cd64
> > > > > 
> > > > > Which comes out to
> > > > > 
> > > > >     382   repeat:
> > > > >     383           read_lock(&journal->j_state_lock);
> > > > > * 384           BUG_ON(journal->j_flags & JBD2_UNMOUNT);
> > > > >     385           if (is_journal_aborted(journal) ||
> > > > >     386               (journal->j_errno != 0 && !(journal->j_flags & JBD2_ACK_ERR))) {
> > > > >     387                   read_unlock(&journal->j_state_lock);
> > > > > 
> > > > > 
> > > > > Initially this seemed like it should never happen but upon crash
> > > > > analysis it seems like it could indeed be hit as described in patch 1/2.
> > > > > 
> > > > > I would like to add that through the logs we only knew that:
> > > > > 
> > > > > - ext4_journal_bmap -> ext4_map_blocks is failing with EFSCORRUPTED.
> > > > > - update_super_work had hit the BUG_ON
> > > > > 
> > > > > I was not able to hit this bug again (without modifying the kernel to
> > > > > inject errors) but the above backtrace seems to be one possible paths
> > > > > where this BUG_ON can be hit. Rest of the analysis and fix is in patch
> > > > > 2/3. Patch 3 is just a small tweak that i found helpful while debugging.
> > > > > 
> > > > > That being said, journalling is something I'm not very familiar with and
> > > > > there might be gaps in my understanding so thoughts and suggestions are
> > > > > welcome.
> > > > > 
> > > > > Ojaswin Mujoo (3):
> > > > >     ext4: define ext4_journal_destroy wrapper
> > > > >     ext4: avoid journaling sb update on error if journal is destroying
> > > > >     ext4: Make sb update interval tunable
> > > > > 
> > > > >    fs/ext4/ext4.h      | 11 +++++++++++
> > > > >    fs/ext4/ext4_jbd2.h | 22 ++++++++++++++++++++++
> > > > >    fs/ext4/super.c     | 35 +++++++++++++++++------------------
> > > > >    fs/ext4/sysfs.c     |  4 ++++
> > > > >    4 files changed, 54 insertions(+), 18 deletions(-)
> > > > > 
> 

