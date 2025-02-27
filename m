Return-Path: <linux-ext4+bounces-6579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DFA47BFC
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F323A84F5
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95174226D06;
	Thu, 27 Feb 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAJOc2uf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7F215F45;
	Thu, 27 Feb 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655237; cv=none; b=u53h+hCobAnRhOQVe9WwtVUNgp9uPOq80UDXRZY4oU4i97Sg1i8/0bo0weRu9K1j5vilVsHgz1+QmTcDTo70XVOI5J3va3a3vjpLCgt8a2xcHnwpG9SJ4ZWOlWYKNzJKEUQA82hSxnKYgBNEqMHFV+s32py1HwfXYWg4m4fQo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655237; c=relaxed/simple;
	bh=YTbKKgx2qtEsp6s2dyw+w3HJD/wJnlXlVpGlV/Aqt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKTUQA5jpJfvYyFKGH0jFYe8u8rDYpNEwx+5oHKLW5m1mLX5B6SAGV2a+E7M2jSXeujny97Jqk+RvTPs4c7F9fJPw8SxyLi4ZCr+Q5mlKPuky7CsaSipwnrYR/pFeZeKyS5zcIiNIDEhqCluy2SP1SR1Pw3OgR0/7ZkLkcw4TzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAJOc2uf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAFb4u015605;
	Thu, 27 Feb 2025 11:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VYmZZFz1AkweCu4oC1qu6AXgmc/DD3
	6JP+A3S/z2ZmE=; b=UAJOc2uf6hWVXSPPFkenlBAVbdbnVYK+wc2770N75nUusH
	pfxK7Oa7zi4tz5VNTj/YkaQxi30M14/oK2WpwI0UC07v5mC09ybJANiwHXMxhm6+
	T5bTRYQbymzEeyqjBjN+9HPaOBg+tOrvpVc0ingUHDUFyqaYrfes1k5R2aRFbC2A
	qgve7ZhAxg2HX0jT2p2MdVTy9oZxWZbfpQaaVxiPpbO/1yJwhhilXYlFrcjAl7w0
	LM3wuwJRt7IAlj93AYtyYyoyPyk+BXxQUe//IjqD2bRJQAJbIoRTB8NvAUmgn1d4
	F0GD7xXb1/J3EaZBVIoRWBpznknxgrC/PE0JEYJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a2y7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:20:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RBKTbH003925;
	Thu, 27 Feb 2025 11:20:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a2y76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:20:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAoZUU027344;
	Thu, 27 Feb 2025 11:20:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum27v34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:20:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RBKRuK56361424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:20:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 028432004D;
	Thu, 27 Feb 2025 11:20:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A386A20040;
	Thu, 27 Feb 2025 11:20:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Feb 2025 11:20:25 +0000 (GMT)
Date: Thu, 27 Feb 2025 16:50:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <Z8BKdo5IAHJRdMkp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sCpyCIhjzkf57j3f7pol1wfVgW4_Xt4B
X-Proofpoint-ORIG-GUID: OMgXp0qPUO22zlL9zfiI_lsjfBW7311q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270083

On Mon, Feb 24, 2025 at 03:52:00PM +0100, Jan Kara wrote:
> On Sat 22-02-25 14:10:22, Ojaswin Mujoo wrote:
> > Presently we always BUG_ON if trying to start a transaction on a journal
> > marked with JBD2_UNMOUNT, since this should never happen. However while
> > running stress tests it was observed that in case of some error handling
> > paths, it is possible for update_super_work to start a transaction after
> > the journal is destroyed eg:
> > 
> > (umount)
> > ext4_kill_sb
> >   kill_block_super
> >     generic_shutdown_super
> >       sync_filesystem /* commits all txns */
> >       evict_inodes
> >         /* might start a new txn */
> >       ext4_put_super
> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> >         jbd2_journal_destroy
> >           journal_kill_thread
> >             journal->j_flags |= JBD2_UNMOUNT;
> >           jbd2_journal_commit_transaction
> >             jbd2_journal_get_descriptor_buffer
> >               jbd2_journal_bmap
> >                 ext4_journal_bmap
> >                   ext4_map_blocks
> >                     ...
> >                     ext4_inode_error
> >                       ext4_handle_error
> >                         schedule_work(&sbi->s_sb_upd_work)
> > 
> >                                                /* work queue kicks in */
> >                                                update_super_work
> >                                                  jbd2_journal_start
> >                                                    start_this_handle
> >                                                      BUG_ON(journal->j_flags &
> >                                                             JBD2_UNMOUNT)
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
> >  ext4_put_super
> >   flush_work(&sbi->s_sb_upd_work)
> > 
> >                            **kjournald2**
> >                            jbd2_journal_commit_transaction
> >                            ...
> >                            ext4_inode_error
> >                              /* JBD2_UNMOUNT not set */
> >                              schedule_work(s_sb_upd_work)
> > 
> >    jbd2_journal_destroy
> >     journal->j_flags |= JBD2_UNMOUNT;
> > 
> >                                       **workqueue**
> >                                       update_super_work
> >                                        jbd2_journal_start
> >                                         start_this_handle
> >                                           BUG_ON(JBD2_UNMOUNT)
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
> 
> Good catch! But I think the solution will have to be slightly different.
> Basing the check on SB_ACTIVE has the problem that you can have racing
> updates of the sb in the still running transaction and in your direct
> update leading to inconsistencies after a crash (that was the reason why
> we've created the s_sb_upd_work in the first place).
> 
> I would solve this by implementing something like
> ext4_update_sb_destroy_journal() which will set a flag in sbi, flush the
> workqueue, and then destroy the journal. And ext4_handle_error() will check
> for the sbi flag.
> 
> 								Honza

Hey Jan,

Thanks for the review. So earlier I did go through different code paths to see
if we will have a direct sb write clash with a journalled one it wouldn't but,
relooking at it, seems like we might have a scenario as follows:

generic_super_shutdown
 sync_filesytems
  /* running txns committed. executing ext4_journal_commit_callback */
  ext4_maybe_update_superblock
   /* schedules work */
   schedule_work(&sbi->s_sb_upd_work)
                                          update_super_work
                                          /* start a txn and add sb to it */
 sb->s_flags &= ~SB_ACTIVE;
 evict_inode
   ext4_evict_inode
    ext4_std_error
     ext4_handle_error
      /* direct commit of sb (Not good!) */


Now with the 'setting the flag in sbi' approach, I'm not sure if that will be
enough to handle this as well. For example, if we add a flag like
sbi->s_journal_destroying, then:

ext4_put_super
 sbi->s_journal_destroying = true
 flush_workqueue()
  /* sb is now journalled */
 jbd2_journal_destory
  jbd2_journal_commit_transaction
   /* add tag for sb in descriptor and add buffer to wbufs[] */
   /* Later from some other buffer in the txn: */
   jbd2_journal_next_log_block
    /* hits error in ext4_journal_bmap */
    ext4_handle_error
      sbi->s_journal_destroying == true
      /* update and commit sb directly causing a checksum mismatch b/w entry in descriptor */
   jbd2_journal_abort
   /* after abort everything in wbufs[] is written to journal */

In the above we will have a checksum mismatch but then maybe its not really
an issue. Maybe since we never commit the txn it is understood that the contents
can't be trusted and it should be fine to have a mismatch b/w the decriptor tag
and the actual super block contents? In which case the sbi flag approach should
be fine.

Does my understanding sound correct?


Regards,
ojaswin
> 
> > ---
> >  fs/ext4/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index a963ffda692a..b7341e9acf62 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> >  		 * constraints, it may not be safe to do it right here so we
> >  		 * defer superblock flushing to a workqueue.
> >  		 */
> > -		if (continue_fs && journal)
> > +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> >  		else
> >  			ext4_commit_super(sb);
> > -- 
> > 2.48.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

