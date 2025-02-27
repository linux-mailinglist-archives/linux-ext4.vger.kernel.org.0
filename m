Return-Path: <linux-ext4+bounces-6580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241FA47C70
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 12:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4816AC96
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F722B5B5;
	Thu, 27 Feb 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WS/FbXyK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B522AE7B;
	Thu, 27 Feb 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656632; cv=none; b=scLsJoY8WBK26o/e4GxmgSSBHY+amEYhZGITfK3TFIroapM5qz3te3akooqO/RqUaioLaAGdNxsrBW141ACjRd5wWwoeBvdvJ29wsEYaPdEYwOODW03ztTtR64NuDVuBSeQW3VqdU56z8IIY33u1noIvoUswMdOsBMF57pTNdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656632; c=relaxed/simple;
	bh=iQ/OqGHJ35k9TIxBNeqT9G7Q4A3QH4YlI71JKSkZfIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqdDslT2vT5qzBtgBZWr6gEFCaK6mVy3zxUbrudFV7lEN+rBHo5HeAHNJISyOO0JScPgbIOmhLkjUwYafIDegudO6M1zKRsH+w89U25pGo+NdtRnysfbIoVHouRHZmLc40uogIOpkggwCcPmebrQObDY495tn4ebbmZyA8rYkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WS/FbXyK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R215SV004844;
	Thu, 27 Feb 2025 11:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aQpk0k++tIJ6UIPRwLXAyk3Ii/5/Mc
	w23xjtYmTiCEY=; b=WS/FbXyKEQ5jMoRy8ZkzKTLI1fO63vIjA/hLcpXstiHT3z
	K99O7r+WM9L13aGnIP/HJ3BkY57Mxg/2jfPH4B4e+WzBM1aAIFZ9XIXXQcq+JDJy
	UmUq5q5810OhPUmJ4K/UfO0o4DgrFZ/u2GhVS9gNjvST6iaoGGGaKkfMLWkRf1M6
	H5kGtgPv1EkrJj2TZ82BLuqAkyXy4GlGN/QKy9nDMQioNdOWwx0JKcG55cX1CS5Q
	Wah+bUo4ClE4pSL5VCXli1Bk/DJ9EYu+ZDdxyjB+5mAAUs4lEhYH7rpk82FUmVrx
	jweHEN/fElEUp/Ay6kLd2kc1msXQAK8od00Ufo3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0japw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:43:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RBgagG004707;
	Thu, 27 Feb 2025 11:43:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0japs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:43:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8G5uc012462;
	Thu, 27 Feb 2025 11:43:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt0kr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:43:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RBhYfd33423814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:43:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE8A20043;
	Thu, 27 Feb 2025 11:43:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EECE20040;
	Thu, 27 Feb 2025 11:43:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Feb 2025 11:43:32 +0000 (GMT)
Date: Thu, 27 Feb 2025 17:13:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <Z8BP4luSfyvz-V4T@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
 <Z72yUqGWHdRyCE25@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <1a1ff87b-6f75-4d43-ad7b-54883bea13f8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1ff87b-6f75-4d43-ad7b-54883bea13f8@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 820b_PEWq4a0ggNc6MSBPxphEM-nY3Gq
X-Proofpoint-ORIG-GUID: yCog7RJcCUfTn12LGkFsPepExV3fM-o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270087

On Wed, Feb 26, 2025 at 09:55:52AM +0800, Baokun Li wrote:
> On 2025/2/25 20:06, Ojaswin Mujoo wrote:
> > On Tue, Feb 25, 2025 at 09:53:10AM +0800, Baokun Li wrote:
> > > On 2025/2/22 16:40, Ojaswin Mujoo wrote:
> > > > Presently we always BUG_ON if trying to start a transaction on a journal
> > > > marked with JBD2_UNMOUNT, since this should never happen. However while
> > > > running stress tests it was observed that in case of some error handling
> > > > paths, it is possible for update_super_work to start a transaction after
> > > > the journal is destroyed eg:
> > > > 
> > > > (umount)
> > > > ext4_kill_sb
> > > >     kill_block_super
> > > >       generic_shutdown_super
> > > >         sync_filesystem /* commits all txns */
> > > >         evict_inodes
> > > >           /* might start a new txn */
> > > >         ext4_put_super
> > > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > > >           jbd2_journal_destroy
> > > >             journal_kill_thread
> > > >               journal->j_flags |= JBD2_UNMOUNT;
> > > >             jbd2_journal_commit_transaction
> > > >               jbd2_journal_get_descriptor_buffer
> > > >                 jbd2_journal_bmap
> > > >                   ext4_journal_bmap
> > > >                     ext4_map_blocks
> > > >                       ...
> > > >                       ext4_inode_error
> > > Just curious, since jbd2_journal_bmap() only queries the map and does not
> > > create it, how does it fail here? Is there more information in dmesg?
> > > Is s_journal_inum normal after file system corruption?
> > Hey Baokun,
> Hello Ojaswin,
> 
> Thanks for your detailed explanation!
> > 
> > So I dug a bit more into the vmcore. The error information in sbi looks
> > like this:
> > 
> >    s_add_error_count = 1,
> >    s_first_error_code = 117,
> >    s_first_error_line = 475,
> >    s_first_error_ino = 0,
> >    s_first_error_block = 0,
> >    s_first_error_func = 0xc0080000055300d0 <__func__.6> "ext4_read_block_bitmap_nowait",
> >    s_first_error_time = 1737023235,
> > 
> >    s_last_error_code = 117,
> >    s_last_error_line = 609,
> >    s_last_error_ino = 8,
> >    s_last_error_block = 783,
> >    s_last_error_func = 0xc008000005531b10 <__func__.41> "ext4_map_blocks",
> >    s_last_error_time = 1737023236,
> > 
> >    The first error is here:
> > 
> >        if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> >       474               (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
> >    *  475                   ext4_error(sb, "Invalid block bitmap block %llu in "
> >       476                              "block_group %u", bitmap_blk, block_group);
> >       477                   ext4_mark_group_bitmap_corrupted(sb, block_group,
> >       478                                           EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> >       479                   return ERR_PTR(-EFSCORRUPTED);
> >       480           }
> > 
> > and the last error is here:
> > 
> >      608           if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> >   *  609                   ret = check_block_validity(inode, map);
> >      610                   if (ret != 0)
> >      611                           return ret;
> >      612           }
> > 
> > 
> > And indeed we have the traces of the first error in dmesg:
> > 
> > [75284.713463] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > [75284.713470] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > [75284.713476] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> > 
> > However, the last error seems strange. It seems like check_block_validity
> > should ideally never fail for a journal inode.Unfortunately, sbi->s_es page is
> > not recorded in the crash dump for some reason so idk the exact value at the
> > time of the check, but looking in journal->j_inode->i_ino, the inode num is 8,
> > which seems fine to me. So yeah, I'm a bit unsure what caused the corruption.
> > I'll look a bit more into the proc01 ltp to see if we can recreate the failure
> > to get more info.
> Right, check_block_validity() skips the journal inode check. If
> the journal inode check fails, that shows s_es->s_journal_inum and
> journal->j_inode->i_ino are different. The file system doesn't modify
> s_journal_inum, so it should be modified by some other writer bypassing
> the file system (i.e. writing to bare disk).
> 
> If that's how it is, we could avoid this issue by using EXT4_JOURNAL_INO
> directly or saving s_journal_inum to ext4_sb_info (which offers better
> compatibility).

Hey Baokun,

So I'm wondering if modifying the check in __check_block_validity the
right thing to do. The fact that something has changed the on disk
journal inode number is itself concerning and maybe stopping IO here is
the right thing to do instead of using a cached journal inode number and
silently ignoring the issue.

Anyways now that the journal inode is corrupted on disk, will the
recovery tooling even be able to read the journal anymore? 

Regards,
ojaswin

> 
> 
> Cheers,
> Baokun

> > > Thanks,
> > > Baokun
> > > >                         ext4_handle_error
> > > >                           schedule_work(&sbi->s_sb_upd_work)
> > > > 
> > > >                                                  /* work queue kicks in */
> > > >                                                  update_super_work
> > > >                                                    jbd2_journal_start
> > > >                                                      start_this_handle
> > > >                                                        BUG_ON(journal->j_flags &
> > > >                                                               JBD2_UNMOUNT)
> > > > 
> > > > Hence, make sure we only defer the update of ext4 sb if the sb is still
> > > > active.  Otherwise, just fallback to an un-journaled commit.
> > > > 
> > > > The important thing to note here is that we must only defer sb update if
> > > > we have not yet flushed the s_sb_update_work queue in umount path else
> > > > this race can be hit (point 1 below). Since we don't have a direct way
> > > > to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
> > > > subtle so adding some notes below for future reference:
> > > > 
> > > > 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
> > > > == 0) however this is not correct since we could end up scheduling work
> > > > after it has been flushed:
> > > > 
> > > >    ext4_put_super
> > > >     flush_work(&sbi->s_sb_upd_work)
> > > > 
> > > >                              **kjournald2**
> > > >                              jbd2_journal_commit_transaction
> > > >                              ...
> > > >                              ext4_inode_error
> > > >                                /* JBD2_UNMOUNT not set */
> > > >                                schedule_work(s_sb_upd_work)
> > > > 
> > > >      jbd2_journal_destroy
> > > >       journal->j_flags |= JBD2_UNMOUNT;
> > > > 
> > > >                                         **workqueue**
> > > >                                         update_super_work
> > > >                                          jbd2_journal_start
> > > >                                           start_this_handle
> > > >                                             BUG_ON(JBD2_UNMOUNT)
> > > > 
> > > > Something like the above doesn't happen with SB_ACTIVE check because we
> > > > are sure that the workqueue would be flushed at a later point if we are
> > > > in the umount path.
> > > > 
> > > > 2. We don't need a similar check in ext4_grp_locked_error since it is
> > > > only called from mballoc and AFAICT it would be always valid to schedule
> > > > work here.
> > > > 
> > > > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > > > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > > > Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >    fs/ext4/super.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index a963ffda692a..b7341e9acf62 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> > > >    		 * constraints, it may not be safe to do it right here so we
> > > >    		 * defer superblock flushing to a workqueue.
> > > >    		 */
> > > > -		if (continue_fs && journal)
> > > > +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
> > > >    			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> > > >    		else
> > > >    			ext4_commit_super(sb);
> > > 
> 

