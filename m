Return-Path: <linux-ext4+bounces-6659-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A1A4DE72
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694277ABBBA
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9181202F89;
	Tue,  4 Mar 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kavBwSo8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034B202F7B;
	Tue,  4 Mar 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092882; cv=none; b=oPnCLrc9VrLMmNKFJ3XId1dfE/tzub0Rqk/MhI8yYbcCpYfuz8wgAIAQC7p6aptH5VgVFqYHA0q/1qe/cq8w0J3CvmXPDrF4xyJpFeqP3QKQD8P1TnFjaYlZ5nOb4yrgU18t4p2b/zLzlIbL3AQWW5/dXegwzEmkU6c+luU3vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092882; c=relaxed/simple;
	bh=V8nC5TryvlmZdJIb16g+wi8piYOWu1md+jxGO7yNJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+oCH/YrGCYDBAN1KTz2nYjZuFOmgLNMHplXMUuHx/iqU+uAASyz7bELqELWRbIZr8Fz+gP0GNAQfK8B3Hiaf6qFn6eIQZAbkzwX0rJ35Xpo2b7GCv/+zR2AxsJrOWuKYW7dpQD7b4Lr799gmycuYKwcwr5pEWP18O2/LNmba2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kavBwSo8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5247oDli022672;
	Tue, 4 Mar 2025 12:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9GIQtTQ3n52e0xvtZx3D+1FsMOE5DE
	3K42Qjqn7zKAU=; b=kavBwSo8YQ9Ex6GfrjA3gmAKdk/vKr3Np8yhrVj6VKe2VJ
	df/oD6cjNn62bTHi7ENO+EtSrm29Ug9bn89e9WC/RLzs7oX6GMkKS0Chrp+oKCGJ
	F7fOkdshdqoOpDNFw3FH10tWgUY8+9JXKZ1rE4J5bYmgUNE0lQfWsjeDawJ47YRq
	YLkjlIqeNTCJk+rYBt5VLVo5nt8F8RWM1PnvkNnvp0QkpJFX116GOeRS5M4xLXz9
	IbPluLTAmBzn0lt9cQtVS6CLjhIjFcSqN5DKOOMxe4CJqnKgY4H5jCp8COLMwcDe
	ytxL/rSb7b4o3WPL83TJhnupgdGLyHV0ivhxLejA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunxqjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:54:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524CJKPB018920;
	Tue, 4 Mar 2025 12:54:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunxqjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:54:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524CVaSI013720;
	Tue, 4 Mar 2025 12:54:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2knavf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:54:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524CsWXU32899820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 12:54:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54BE720043;
	Tue,  4 Mar 2025 12:54:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC15420040;
	Tue,  4 Mar 2025 12:54:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 12:54:30 +0000 (GMT)
Date: Tue, 4 Mar 2025 18:24:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <Z8b4Aze43cnDrsBF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl>
 <Z8BKdo5IAHJRdMkp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <mpm3x7uonxoc73lgva72vaiydc76cmr5niapm45ipk6ts5voab@e7zundhoui6i>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mpm3x7uonxoc73lgva72vaiydc76cmr5niapm45ipk6ts5voab@e7zundhoui6i>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rn3lgViAMgDn6Q695MgojrDoKdmzt_SQ
X-Proofpoint-GUID: 3KlF1a48yKyrmOK7jF7-2o1XsL0-zMcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040102

On Tue, Mar 04, 2025 at 11:25:02AM +0100, Jan Kara wrote:
> On Thu 27-02-25 16:50:22, Ojaswin Mujoo wrote:
> > On Mon, Feb 24, 2025 at 03:52:00PM +0100, Jan Kara wrote:
> > > On Sat 22-02-25 14:10:22, Ojaswin Mujoo wrote:
> > > > Presently we always BUG_ON if trying to start a transaction on a journal
> > > > marked with JBD2_UNMOUNT, since this should never happen. However while
> > > > running stress tests it was observed that in case of some error handling
> > > > paths, it is possible for update_super_work to start a transaction after
> > > > the journal is destroyed eg:
> > > > 
> > > > (umount)
> > > > ext4_kill_sb
> > > >   kill_block_super
> > > >     generic_shutdown_super
> > > >       sync_filesystem /* commits all txns */
> > > >       evict_inodes
> > > >         /* might start a new txn */
> > > >       ext4_put_super
> > > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > > >         jbd2_journal_destroy
> > > >           journal_kill_thread
> > > >             journal->j_flags |= JBD2_UNMOUNT;
> > > >           jbd2_journal_commit_transaction
> > > >             jbd2_journal_get_descriptor_buffer
> > > >               jbd2_journal_bmap
> > > >                 ext4_journal_bmap
> > > >                   ext4_map_blocks
> > > >                     ...
> > > >                     ext4_inode_error
> > > >                       ext4_handle_error
> > > >                         schedule_work(&sbi->s_sb_upd_work)
> > > > 
> > > >                                                /* work queue kicks in */
> > > >                                                update_super_work
> > > >                                                  jbd2_journal_start
> > > >                                                    start_this_handle
> > > >                                                      BUG_ON(journal->j_flags &
> > > >                                                             JBD2_UNMOUNT)
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
> > > >  ext4_put_super
> > > >   flush_work(&sbi->s_sb_upd_work)
> > > > 
> > > >                            **kjournald2**
> > > >                            jbd2_journal_commit_transaction
> > > >                            ...
> > > >                            ext4_inode_error
> > > >                              /* JBD2_UNMOUNT not set */
> > > >                              schedule_work(s_sb_upd_work)
> > > > 
> > > >    jbd2_journal_destroy
> > > >     journal->j_flags |= JBD2_UNMOUNT;
> > > > 
> > > >                                       **workqueue**
> > > >                                       update_super_work
> > > >                                        jbd2_journal_start
> > > >                                         start_this_handle
> > > >                                           BUG_ON(JBD2_UNMOUNT)
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
> > > 
> > > Good catch! But I think the solution will have to be slightly different.
> > > Basing the check on SB_ACTIVE has the problem that you can have racing
> > > updates of the sb in the still running transaction and in your direct
> > > update leading to inconsistencies after a crash (that was the reason why
> > > we've created the s_sb_upd_work in the first place).
> > > 
> > > I would solve this by implementing something like
> > > ext4_update_sb_destroy_journal() which will set a flag in sbi, flush the
> > > workqueue, and then destroy the journal. And ext4_handle_error() will check
> > > for the sbi flag.
> > > 
> > > 								Honza
> > 
> > Hey Jan,
> > 
> > Thanks for the review. So earlier I did go through different code paths to see
> > if we will have a direct sb write clash with a journalled one it wouldn't but,
> > relooking at it, seems like we might have a scenario as follows:
> > 
> > generic_super_shutdown
> >  sync_filesytems
> >   /* running txns committed. executing ext4_journal_commit_callback */
> >   ext4_maybe_update_superblock
> >    /* schedules work */
> >    schedule_work(&sbi->s_sb_upd_work)
> >                                           update_super_work
> >                                           /* start a txn and add sb to it */
> >  sb->s_flags &= ~SB_ACTIVE;
> >  evict_inode
> >    ext4_evict_inode
> >     ext4_std_error
> >      ext4_handle_error
> >       /* direct commit of sb (Not good!) */
> > 
> > 
> > Now with the 'setting the flag in sbi' approach, I'm not sure if that will be
> > enough to handle this as well. For example, if we add a flag like
> > sbi->s_journal_destroying, then:
> > 
> > ext4_put_super
> >  sbi->s_journal_destroying = true
> >  flush_workqueue()
> >   /* sb is now journalled */
> >  jbd2_journal_destory
> >   jbd2_journal_commit_transaction
> >    /* add tag for sb in descriptor and add buffer to wbufs[] */
> >    /* Later from some other buffer in the txn: */
> >    jbd2_journal_next_log_block
> >     /* hits error in ext4_journal_bmap */
> >     ext4_handle_error
> >       sbi->s_journal_destroying == true
> >       /* update and commit sb directly causing a checksum mismatch b/w entry in descriptor */
> >    jbd2_journal_abort
> >    /* after abort everything in wbufs[] is written to journal */
> > 
> > In the above we will have a checksum mismatch but then maybe its not really
> > an issue. Maybe since we never commit the txn it is understood that the contents
> > can't be trusted and it should be fine to have a mismatch b/w the decriptor tag
> > and the actual super block contents? In which case the sbi flag approach should
> > be fine.
> > 
> > Does my understanding sound correct?
> 
> Yes. Since the transaction does not get committed, its contents will be
> (and must be) ignored. So although you are correct that the superblock
> content in the transaction need to match the content we write directly, it
> does not matter because whatever is in the uncommitted transaction must
> never be written to the final position on disk.
> 
> 								Honza

Got it, thanks for the review. I'll address this in v2

Regards,
ojaswin
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

