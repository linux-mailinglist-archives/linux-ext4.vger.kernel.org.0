Return-Path: <linux-ext4+bounces-6565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB98A43EDA
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 13:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE13A9094
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C38267F57;
	Tue, 25 Feb 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ioC2Ggv9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F7267B1A;
	Tue, 25 Feb 2025 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485227; cv=none; b=bAhtYNiPZLfh1YJpILC/s+14kj6boLBD3egI8quygvtfa1vQtyYFhEgTz4SBeulntsj/xHiZtBwXc+cw8jWpivFqj+uVAhslaQuWvapp9A9xUrIIBLAzVCaPu+vYJxVs46X8WuYcTVFE2WRZtibiLkPQM9dms32ppxAA+OMAhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485227; c=relaxed/simple;
	bh=R0YZwPa/j81Upn6H8+MQGjK/pv9flKnpttvi/0LYwVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCdmu2sfqzIA3czJQU7g6eWWX+8gCT71VBC27ARdM7MvKQP7Q51Fw+17amyBP19BxMVdSOODifV8QbvzZEQId1jY+F3tsE/tKUs/I03t2m2XJ2cDyErJAYWEBpCvY4B1iP8pqIRPN6kxISCEfLlMYKRd/ANtMEovvknmZUHXHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ioC2Ggv9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5Novm004885;
	Tue, 25 Feb 2025 12:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=stcecdV4WR1w+pgTJ4RS+UPRZOfLI1
	L48wPKI0ZpCDE=; b=ioC2Ggv9SkRIJcJGaQj5hhu/PmbmcDZpLmW8gEqwNzoP2t
	1Qklnhan/VIZ5m1dNG+8M/SS6LtShBz0XH3XTT/DyhdhNN1USj2+hxeXTekikEZB
	QmmlO5adSTzuSpa9O9syVhccZgsAXQ8+RgKpwRk+lZaTSRKyzye4djlFtkcW8WhD
	shDDzgV7hlfmxAPmLgHIaExguT/faYEz1YTxxFZgXZosHKtoZPSNZE+Zk5x9u8qW
	EBXHB/pwoNvOjLF2w2V+o/hgdz+CVYSL9BrESWreknKuoBswB8Gd/hWCh1G4PYxO
	AcOW7PB+ewDxn6vFTiCvDhstB1H6Zq8N3cGydmfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4517p8hua5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 12:06:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51PC1am0009865;
	Tue, 25 Feb 2025 12:06:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4517p8hua1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 12:06:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9wwXK012470;
	Tue, 25 Feb 2025 12:06:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsn0r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 12:06:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PC6l3230999286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 12:06:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEE820040;
	Tue, 25 Feb 2025 12:06:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A3E2004B;
	Tue, 25 Feb 2025 12:06:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Feb 2025 12:06:45 +0000 (GMT)
Date: Tue, 25 Feb 2025 17:36:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <Z72yUqGWHdRyCE25@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sp-LYtRSr40l-UtyIL0GwCBAnZ7jOTQB
X-Proofpoint-ORIG-GUID: DIEIlSmlvfnTVSdl5ijDVoylXAEfgk_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250081

On Tue, Feb 25, 2025 at 09:53:10AM +0800, Baokun Li wrote:
> On 2025/2/22 16:40, Ojaswin Mujoo wrote:
> > Presently we always BUG_ON if trying to start a transaction on a journal
> > marked with JBD2_UNMOUNT, since this should never happen. However while
> > running stress tests it was observed that in case of some error handling
> > paths, it is possible for update_super_work to start a transaction after
> > the journal is destroyed eg:
> > 
> > (umount)
> > ext4_kill_sb
> >    kill_block_super
> >      generic_shutdown_super
> >        sync_filesystem /* commits all txns */
> >        evict_inodes
> >          /* might start a new txn */
> >        ext4_put_super
> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> >          jbd2_journal_destroy
> >            journal_kill_thread
> >              journal->j_flags |= JBD2_UNMOUNT;
> >            jbd2_journal_commit_transaction
> >              jbd2_journal_get_descriptor_buffer
> >                jbd2_journal_bmap
> >                  ext4_journal_bmap
> >                    ext4_map_blocks
> >                      ...
> >                      ext4_inode_error
> Just curious, since jbd2_journal_bmap() only queries the map and does not
> create it, how does it fail here? Is there more information in dmesg?
> Is s_journal_inum normal after file system corruption?

Hey Baokun, 

So I dug a bit more into the vmcore. The error information in sbi looks
like this:

  s_add_error_count = 1,
  s_first_error_code = 117,
  s_first_error_line = 475,
  s_first_error_ino = 0,
  s_first_error_block = 0,
  s_first_error_func = 0xc0080000055300d0 <__func__.6> "ext4_read_block_bitmap_nowait",
  s_first_error_time = 1737023235,

  s_last_error_code = 117,
  s_last_error_line = 609,
  s_last_error_ino = 8,
  s_last_error_block = 783,
  s_last_error_func = 0xc008000005531b10 <__func__.41> "ext4_map_blocks",
  s_last_error_time = 1737023236,

  The first error is here:

      if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
     474               (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
  *  475                   ext4_error(sb, "Invalid block bitmap block %llu in "
     476                              "block_group %u", bitmap_blk, block_group);
     477                   ext4_mark_group_bitmap_corrupted(sb, block_group,
     478                                           EXT4_GROUP_INFO_BBITMAP_CORRUPT);
     479                   return ERR_PTR(-EFSCORRUPTED);
     480           }

and the last error is here:

    608           if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 *  609                   ret = check_block_validity(inode, map);
    610                   if (ret != 0)
    611                           return ret;
    612           }


And indeed we have the traces of the first error in dmesg:

[75284.713463] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
[75284.713470] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
[75284.713476] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0

However, the last error seems strange. It seems like check_block_validity
should ideally never fail for a journal inode. Unfortunately, sbi->s_es page is
not recorded in the crash dump for some reason so idk the exact value at the
time of the check, but looking in journal->j_inode->i_ino, the inode num is 8,
which seems fine to me. So yeah, I'm a bit unsure what caused the corruption.
I'll look a bit more into the proc01 ltp to see if we can recreate the failure
to get more info.

> 
> Thanks,
> Baokun
> >                        ext4_handle_error
> >                          schedule_work(&sbi->s_sb_upd_work)
> > 
> >                                                 /* work queue kicks in */
> >                                                 update_super_work
> >                                                   jbd2_journal_start
> >                                                     start_this_handle
> >                                                       BUG_ON(journal->j_flags &
> >                                                              JBD2_UNMOUNT)
> > 
> > Hence, make sure we only defer the update of ext4 sb if the sb is still
> > active.  Otherwise, just fallback to an un-journaled commit.
> > 
> > The important thing to note here is that we must only defer sb update if
> > we have not yet flushed the s_sb_update_work queue in umount path else
> > this race can be hit (point 1 below). Since we don't have a direct way
> > to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
> > subtle so adding some notes below for future reference:
> > 
> > 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
> > == 0) however this is not correct since we could end up scheduling work
> > after it has been flushed:
> > 
> >   ext4_put_super
> >    flush_work(&sbi->s_sb_upd_work)
> > 
> >                             **kjournald2**
> >                             jbd2_journal_commit_transaction
> >                             ...
> >                             ext4_inode_error
> >                               /* JBD2_UNMOUNT not set */
> >                               schedule_work(s_sb_upd_work)
> > 
> >     jbd2_journal_destroy
> >      journal->j_flags |= JBD2_UNMOUNT;
> > 
> >                                        **workqueue**
> >                                        update_super_work
> >                                         jbd2_journal_start
> >                                          start_this_handle
> >                                            BUG_ON(JBD2_UNMOUNT)
> > 
> > Something like the above doesn't happen with SB_ACTIVE check because we
> > are sure that the workqueue would be flushed at a later point if we are
> > in the umount path.
> > 
> > 2. We don't need a similar check in ext4_grp_locked_error since it is
> > only called from mballoc and AFAICT it would be always valid to schedule
> > work here.
> > 
> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   fs/ext4/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index a963ffda692a..b7341e9acf62 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> >   		 * constraints, it may not be safe to do it right here so we
> >   		 * defer superblock flushing to a workqueue.
> >   		 */
> > -		if (continue_fs && journal)
> > +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
> >   			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> >   		else
> >   			ext4_commit_super(sb);
> 
> 

