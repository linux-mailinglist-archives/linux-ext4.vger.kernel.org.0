Return-Path: <linux-ext4+bounces-6653-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B52A4CA0D
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8094A188124C
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C48250C00;
	Mon,  3 Mar 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVfk1qaR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43679250BEB;
	Mon,  3 Mar 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023075; cv=none; b=GaNgefKbHjPwnP2RF5mdP1V6ITVPri5cL1SZvQTcu3T/TiqyyvlKBpjj7Qhe1lFUkReNTUZYAS2rV5smr8r/92jL/YtSaSOBJEk7Qdj1nby7EqOAJXHiO8emb7nDPwqPe2cs+yADMDTdMvKI6xPM8BcIiOGSbzpze4TM71b5h9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023075; c=relaxed/simple;
	bh=w6uOTSX/VPzJEMePulP99FzCwhpsVIcs+/wyKHhDP3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWHVRrQjivDOxB1uoZdgad4ng84f1UCPjpVwXT22CFM/xNQSoojP/dTZyB9tIFL+FzVXdX/722V4yOFfoxKIeZLRjZxVLBWtwBkcT4De9TE7TVTlQrdD+t3TfennUwpNJy3Po2pC6SCY0U/6cenzQg02dguDw28ZYdXTEqPI0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVfk1qaR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523E361D022672;
	Mon, 3 Mar 2025 17:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LCr6pU
	IsgsVXQTAZXfqxcc+mF9zf7Zl8i5wrr90EN08=; b=GVfk1qaRArbJF2/TC/zrmI
	Z+kwZJFuU0y2OiTdd0BhdLN2g8OU600u+1qD0rfs7twaEEnPyKHuIOhEIEGSyzh7
	5Kdm7i9s8rg5U9VEIZSk0w2jnPrVdwXIscGyBsg3uArmpv24Gp1sgHG1UWMBB3yc
	Wii3G9YE5zVnPtwdFvgvaJ1xhg1taj82PvgZdgBAcwJL1neROFQUDkBk8LzYb3VK
	KwNy9Igf8z7ja2WJIUP05wzkcstUGao7kGA+AKRI+FCflThzC99uBtWfO2I9vw3z
	xr+jmAIghAbjY0egQHY0V4ztTM22EAexYGmSXui9gjqR/gLb08GCEOTpukxPfiJw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunsuv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 17:30:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523H77q7029492;
	Mon, 3 Mar 2025 17:30:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunsuuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 17:30:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523HA61o020928;
	Mon, 3 Mar 2025 17:30:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjrv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 17:30:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 523HUtH559441516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 17:30:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 185A72004B;
	Mon,  3 Mar 2025 17:30:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D00520043;
	Mon,  3 Mar 2025 17:30:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.79])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Mar 2025 17:30:53 +0000 (GMT)
Date: Mon, 3 Mar 2025 23:00:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <Z8XnMOT1LNzgjwaN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
 <Z72yUqGWHdRyCE25@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <1a1ff87b-6f75-4d43-ad7b-54883bea13f8@huawei.com>
 <Z8BP4luSfyvz-V4T@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <84ebed94-d4ab-4b8c-962c-f10ebaca5a75@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84ebed94-d4ab-4b8c-962c-f10ebaca5a75@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oXwgmBByK124_ABNKnXygQNMWV_MpwZ9
X-Proofpoint-GUID: eh3u1pGDNo_2LwPiT_df1YunPZ9pV067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030133

On Thu, Feb 27, 2025 at 08:51:11PM +0800, Baokun Li wrote:
> On 2025/2/27 19:43, Ojaswin Mujoo wrote:
> > On Wed, Feb 26, 2025 at 09:55:52AM +0800, Baokun Li wrote:
> > > On 2025/2/25 20:06, Ojaswin Mujoo wrote:
> > > > On Tue, Feb 25, 2025 at 09:53:10AM +0800, Baokun Li wrote:
> > > > > On 2025/2/22 16:40, Ojaswin Mujoo wrote:
> > > > > > Presently we always BUG_ON if trying to start a transaction on a journal
> > > > > > marked with JBD2_UNMOUNT, since this should never happen. However while
> > > > > > running stress tests it was observed that in case of some error handling
> > > > > > paths, it is possible for update_super_work to start a transaction after
> > > > > > the journal is destroyed eg:
> > > > > > 
> > > > > > (umount)
> > > > > > ext4_kill_sb
> > > > > >      kill_block_super
> > > > > >        generic_shutdown_super
> > > > > >          sync_filesystem /* commits all txns */
> > > > > >          evict_inodes
> > > > > >            /* might start a new txn */
> > > > > >          ext4_put_super
> > > > > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > > > > >            jbd2_journal_destroy
> > > > > >              journal_kill_thread
> > > > > >                journal->j_flags |= JBD2_UNMOUNT;
> > > > > >              jbd2_journal_commit_transaction
> > > > > >                jbd2_journal_get_descriptor_buffer
> > > > > >                  jbd2_journal_bmap
> > > > > >                    ext4_journal_bmap
> > > > > >                      ext4_map_blocks
> > > > > >                        ...
> > > > > >                        ext4_inode_error
> > > > > Just curious, since jbd2_journal_bmap() only queries the map and does not
> > > > > create it, how does it fail here? Is there more information in dmesg?
> > > > > Is s_journal_inum normal after file system corruption?
> > > > Hey Baokun,
> > > Hello Ojaswin,
> > > 
> > > Thanks for your detailed explanation!
> > > > So I dug a bit more into the vmcore. The error information in sbi looks
> > > > like this:
> > > > 
> > > >     s_add_error_count = 1,
> > > >     s_first_error_code = 117,
> > > >     s_first_error_line = 475,
> > > >     s_first_error_ino = 0,
> > > >     s_first_error_block = 0,
> > > >     s_first_error_func = 0xc0080000055300d0 <__func__.6> "ext4_read_block_bitmap_nowait",
> > > >     s_first_error_time = 1737023235,
> > > > 
> > > >     s_last_error_code = 117,
> > > >     s_last_error_line = 609,
> > > >     s_last_error_ino = 8,
> > > >     s_last_error_block = 783,
> > > >     s_last_error_func = 0xc008000005531b10 <__func__.41> "ext4_map_blocks",
> > > >     s_last_error_time = 1737023236,
> > > > 
> > > >     The first error is here:
> > > > 
> > > >         if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> > > >        474               (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
> > > >     *  475                   ext4_error(sb, "Invalid block bitmap block %llu in "
> > > >        476                              "block_group %u", bitmap_blk, block_group);
> > > >        477                   ext4_mark_group_bitmap_corrupted(sb, block_group,
> > > >        478                                           EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> > > >        479                   return ERR_PTR(-EFSCORRUPTED);
> > > >        480           }
> > > > 
> > > > and the last error is here:
> > > > 
> > > >       608           if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> > > >    *  609                   ret = check_block_validity(inode, map);
> > > >       610                   if (ret != 0)
> > > >       611                           return ret;
> > > >       612           }
> > > > 
> > > > 
> > > > And indeed we have the traces of the first error in dmesg:
> > > > 
> > > > [75284.713463] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > > > [75284.713470] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > > > [75284.713476] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > > > 
> > > > However, the last error seems strange. It seems like check_block_validity
> > > > should ideally never fail for a journal inode.Unfortunately, sbi->s_es page is
> > > > not recorded in the crash dump for some reason so idk the exact value at the
> > > > time of the check, but looking in journal->j_inode->i_ino, the inode num is 8,
> > > > which seems fine to me. So yeah, I'm a bit unsure what caused the corruption.
> > > > I'll look a bit more into the proc01 ltp to see if we can recreate the failure
> > > > to get more info.
> > > Right, check_block_validity() skips the journal inode check. If
> > > the journal inode check fails, that shows s_es->s_journal_inum and
> > > journal->j_inode->i_ino are different. The file system doesn't modify
> > > s_journal_inum, so it should be modified by some other writer bypassing
> > > the file system (i.e. writing to bare disk).
> > > 
> > > If that's how it is, we could avoid this issue by using EXT4_JOURNAL_INO
> > > directly or saving s_journal_inum to ext4_sb_info (which offers better
> > > compatibility).
> > Hey Baokun,
> > 
> > So I'm wondering if modifying the check in __check_block_validity the
> > right thing to do. The fact that something has changed the on disk
> > journal inode number is itself concerning and maybe stopping IO here is
> > the right thing to do instead of using a cached journal inode number and
> > silently ignoring the issue.
> Because the cached journal inode is fine (it was checked when mounting),
> and the data we're committing is good too, I think it's okay to keep
> committing.  The actual problem is someone modified the superblock
> directly, bypassing the file system, and the file system can't protect
> against that.
> > 
> > Anyways now that the journal inode is corrupted on disk, will the
> > recovery tooling even be able to read the journal anymore?
> Actually, the journal inode on disk could still be okay. This just tells us
> s_es->s_journal_inum is abnormal, meaning part of the superblock on disk
> got changed. If only the superblock was modified, we can use the backup
> superblock or grab the latest superblock copy from the journal.

Ahh right thats true idk why I missed that. Although it's very unlikely 
someone would have modified/corrupted the journal inode num in sb in the
tests we are running (mostly syscall tests in ltp), but yes your
suggestion does make sense. I'll try to look into it and add it in the
next revision.

Regards,
ojaswin

> 
> 
> Cheers,
> Baokun

