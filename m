Return-Path: <linux-ext4+bounces-6707-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A104A56532
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 11:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6DB177896
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD620E00D;
	Fri,  7 Mar 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LCLTTGvS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25420AF69;
	Fri,  7 Mar 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343261; cv=none; b=Skr1zW9EiMwj3cpGX/IAUKz2y6iWfYWlPksuiIDySehcMqC4Lgb8COik/raqXDA6uSeLtWuofeTLGcDSpitnMqDcPiX7aPrKyzI7MiS3NFGB5BBfLr5O1EvfPTvi4q7hfdfOZ4OwoC2usaWtLcxWlXjvBeKecmgBNOmLi7V+Syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343261; c=relaxed/simple;
	bh=3GwKPvhhCjAeHcsF75339jmzhYAfN+guTWs95f5YAH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf6tUwdxbUiKZjbLjtmbIVUEFAJZbpMsuPDfM2NWuJCkUXlXSKHrx4cAQADd3OpD2so0aA7ikhD7jTFE735LZn3g8scPNdfptCIgYi5nGmSglK4K1IwkoYfXM+c5DIM33JM1dvbcV7neStrYcdEuOZWnhjM64JQubnmQvRsagls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LCLTTGvS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5278UCxt006414;
	Fri, 7 Mar 2025 10:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6eiXidlmZ5oqs3DIhLztO1wxHxcHJB
	P6f0srNmPxXxI=; b=LCLTTGvS6HGTCUQmd5I+Qw5K2UevYmLMqOuVGdDInECK69
	mTQcwQ2UE+XTPRPS5cexTqOXF5BTJ+Q6qxi9wAzc+lvTkD4JQOb6y5MzgxV8kxxd
	N7v01KhHxwvJFCVSMcKHIpa3YvjRconuJoZZLOZ0nX6LOZ9O9Ft+RPytrzPSJHpm
	zqUQ7vFXgym0qTOGkn6NNJXwLBbcrxzoT0MhSitA+mrHpzg8vqsbUfvbwAx79Mom
	QgrbB5sHkDubYa5wTYaJM/KsL+Enxl1n3ePnFx7Gs3JWUs+Li5e0+71hAmFM//Ug
	KlUfqBfBPJ0NyMYX2mLqnn+RssKhpia75AEQ6WwQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457br2wxct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:27:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 527AHIIq002586;
	Fri, 7 Mar 2025 10:27:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457br2wxcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:27:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5279HOLj020871;
	Fri, 7 Mar 2025 10:27:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnx7e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:27:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527ARItr11731282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 10:27:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB7FD20043;
	Fri,  7 Mar 2025 10:27:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25E020040;
	Fri,  7 Mar 2025 10:27:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 10:27:16 +0000 (GMT)
Date: Fri, 7 Mar 2025 15:57:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z8rKAsmIuBlOo4T1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <5b3864c3-bcfd-4f45-b427-224d32aca478@huaweicloud.com>
 <Z8qTciy49b7LSHqr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z8qqna0BEDT5ZD82@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e9e92601-53bc-42a2-b428-e61bff6153c5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e92601-53bc-42a2-b428-e61bff6153c5@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B9YQy0U0-6O5x_R2EDuc49lr8YsbGpI9
X-Proofpoint-ORIG-GUID: SWHxaz6uVzlJK2ERNZQzInkrWUVfcSuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070075

On Fri, Mar 07, 2025 at 04:43:24PM +0800, Zhang Yi wrote:
> 
> 
> On 2025/3/7 16:13, Ojaswin Mujoo wrote:
> > On Fri, Mar 07, 2025 at 12:04:26PM +0530, Ojaswin Mujoo wrote:
> >> On Fri, Mar 07, 2025 at 10:49:28AM +0800, Zhang Yi wrote:
> >>> On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> >>>> Presently we always BUG_ON if trying to start a transaction on a journal marked
> >>>> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> >>>> stress tests, it was observed that in case of some error handling paths, it is
> >>>> possible for update_super_work to start a transaction after the journal is
> >>>> destroyed eg:
> >>>>
> >>>> (umount)
> >>>> ext4_kill_sb
> >>>>   kill_block_super
> >>>>     generic_shutdown_super
> >>>>       sync_filesystem /* commits all txns */
> >>>>       evict_inodes
> >>>>         /* might start a new txn */
> >>>>       ext4_put_super
> >>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> >>>>         jbd2_journal_destroy
> >>>>           journal_kill_thread
> >>>>             journal->j_flags |= JBD2_UNMOUNT;
> >>>>           jbd2_journal_commit_transaction
> >>>>             jbd2_journal_get_descriptor_buffer
> >>>>               jbd2_journal_bmap
> >>>>                 ext4_journal_bmap
> >>>>                   ext4_map_blocks
> >>>>                     ...
> >>>>                     ext4_inode_error
> >>>>                       ext4_handle_error
> >>>>                         schedule_work(&sbi->s_sb_upd_work)
> >>>>
> >>>>                                                /* work queue kicks in */
> >>>>                                                update_super_work
> >>>>                                                  jbd2_journal_start
> >>>>                                                    start_this_handle
> >>>>                                                      BUG_ON(journal->j_flags &
> >>>>                                                             JBD2_UNMOUNT)
> >>>>
> >>>> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> >>>> destroying only do a journaled (and deferred) update of sb if this flag is not
> >>>> set. Otherwise, just fallback to an un-journaled commit.
> >>>>
> >>>> We set sbi->s_journal_destroying = true only after all the FS updates are done
> >>>> during ext4_put_super() (except a running transaction that will get commited
> >>>> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> >>>> outside the journal as it won't race with a journaled update (refer
> >>>> 2d01ddc86606).
> >>>>
> >>>> Also, we don't need a similar check in ext4_grp_locked_error since it is only
> >>>> called from mballoc and AFAICT it would be always valid to schedule work here.
> >>>>
> >>>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> >>>> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> >>>> Suggested-by: Jan Kara <jack@suse.cz>
> >>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >>>> ---
> >>>>  fs/ext4/ext4.h      | 2 ++
> >>>>  fs/ext4/ext4_jbd2.h | 8 ++++++++
> >>>>  fs/ext4/super.c     | 4 +++-
> >>>>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >>>> index 2b7d781bfcad..d48e93bd5690 100644
> >>>> --- a/fs/ext4/ext4.h
> >>>> +++ b/fs/ext4/ext4.h
> >>>> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> >>>>  	 */
> >>>>  	struct work_struct s_sb_upd_work;
> >>>>  
> >>>> +	bool s_journal_destorying;
> >>>> +
> >>>>  	/* Atomic write unit values in bytes */
> >>>>  	unsigned int s_awu_min;
> >>>>  	unsigned int s_awu_max;
> >>>> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> >>>> index 9b3c9df02a39..6bd3ca84410d 100644
> >>>> --- a/fs/ext4/ext4_jbd2.h
> >>>> +++ b/fs/ext4/ext4_jbd2.h
> >>>> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> >>>>  {
> >>>>  	int err = 0;
> >>>>  
> >>>> +	/*
> >>>> +	 * At this point all pending FS updates should be done except a possible
> >>>> +	 * running transaction (which will commit in jbd2_journal_destroy). It
> >>>> +	 * is now safe for any new errors to directly commit superblock rather
> >>>> +	 * than going via journal.
> >>>> +	 */
> >>>> +	sbi->s_journal_destorying = true;
> >>>> +
> >>>
> >>> Hi, Ojaswin!
> >>>
> >>> I'm afraid you still need to flush the superblock update work here,
> >>> otherwise I guess the race condition you mentioned in v1 could still
> >>> occur.
> >>>
> >>>  ext4_put_super()
> >>>   flush_work(&sbi->s_sb_upd_work)
> >>>
> >>>                     **kjournald2**
> >>>                     jbd2_journal_commit_transaction()
> >>>                     ...
> >>>                     ext4_inode_error()
> >>>                       /* JBD2_UNMOUNT not set */
> >>>                       schedule_work(s_sb_upd_work)
> >>>
> >>>                                   **workqueue**
> >>>                                    update_super_work
> >>>                                    /* s_journal_destorying is not set */
> >>>                             	   if (journal && !s_journal_destorying)
> >>>
> >>>   ext4_journal_destroy()
> >>>    /* set s_journal_destorying */
> >>>    sbi->s_journal_destorying = true;
> >>>    jbd2_journal_destroy()
> >>>     journal->j_flags |= JBD2_UNMOUNT;
> >>>
> >>>                                        jbd2_journal_start()
> >>>                                         start_this_handle()
> >>>                                           BUG_ON(JBD2_UNMOUNT)
> >>>
> >>> Thanks,
> >>> Yi.
> >> Hi Yi,
> >>
> >> Yes you are right, somehow missed this edge case :(
> >>
> >> Alright then, we have to move out sbi->s_journal_destroying outside the
> >> helper. Just wondering if I should still let it be in
> >> ext4_journal_destroy and just add an extra s_journal_destroying = false
> >> before schedule_work(s_sb_upd_work), because it makes sense.
> >>
> >> Okay let me give it some thought but thanks for pointing this out!
> >>
> >> Regards,
> >> ojaswin
> > 
> > Okay so thinking about it a bit more, I see you also suggested to flush
> > the work after marking sbi->s_journal_destroying. But will that solve
> > it?
> > 
> >   ext4_put_super()
> >    flush_work(&sbi->s_sb_upd_work)
> >  
> >                      **kjournald2**
> >                      jbd2_journal_commit_transaction()
> >                      ...
> >                      ext4_inode_error()
> >                        /* JBD2_UNMOUNT not set */
> >                        schedule_work(s_sb_upd_work)
> >  
> >                                     **workqueue**
> >                                     update_super_work
> >                                     /* s_journal_destorying is not set */
> >                              	      if (journal && !s_journal_destorying)
> >  
> >    ext4_journal_destroy()
> >     /* set s_journal_destorying */
> >     sbi->s_journal_destorying = true;
> >     flush_work(&sbi->s_sb_upd_work)
> >                                       schedule_work()
>                                         ^^^^^^^^^^^^^^^
>                                         where does this come from?
> 
> After this flush_work, we can guarantee that the running s_sb_upd_work
> finishes before we set JBD2_UNMOUNT. Additionally, the journal will
> not commit transaction or call schedule_work() again because it has
> been aborted due to the previous error. Am I missing something?
> 
> Thanks,
> Yi.

Hmm, so I am thinking of a corner case in ext4_handle_error() where 

 if(journal && !is_journal_destroying) 

is computed but schedule_work() not called yet, which is possible cause
the cmp followed by jump is not atomic in nature. If the schedule_work
is only called after we have done the flush then we end up with this:

                              	      if (journal && !s_journal_destorying)
    ext4_journal_destroy()
     /* set s_journal_destorying */
     sbi->s_journal_destorying = true;
     flush_work(&sbi->s_sb_upd_work)
                                       schedule_work()

Which is possible IMO, although the window is tiny.

Regards,
ojaswin

> 
> >     jbd2_journal_destroy()
> >      journal->j_flags |= JBD2_UNMOUNT;
> >  
> >                                         jbd2_journal_start()
> >                                          start_this_handle()
> >                                            BUG_ON(JBD2_UNMOUNT)
> > 
> > 
> > Seems like these edge cases keep sprouting up :)
> > 
> > As for the fix, how about we do something like this:
> > 
> >   ext4_put_super()
> > 
> >    flush_work(&sbi->s_sb_upd_work)
> >    destroy_workqueue(sbi->rsv_conversion_wq);
> > 
> >    ext4_journal_destroy()
> >     /* set s_journal_destorying */
> >     sbi->s_journal_destorying = true;
> > 
> >    /* trigger a commit and wait for it to complete */
> > 
> >     flush_work(&sbi->s_sb_upd_work)
> > 
> >     jbd2_journal_destroy()
> >      journal->j_flags |= JBD2_UNMOUNT;
> >  
> >                                         jbd2_journal_start()
> >                                          start_this_handle()
> >                                            BUG_ON(JBD2_UNMOUNT)
> > 
> > Still giving this codepath some thought but seems like this might just
> > be enough to fix the race. Thoughts on this?
> > 
> > Regards,
> > ojaswin
> > 
> >>>
> >>>>  	err = jbd2_journal_destroy(journal);
> >>>>  	sbi->s_journal = NULL;
> >>>>  
> >>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> >>>> index 8ad664d47806..31552cf0519a 100644
> >>>> --- a/fs/ext4/super.c
> >>>> +++ b/fs/ext4/super.c
> >>>> @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> >>>>  		 * constraints, it may not be safe to do it right here so we
> >>>>  		 * defer superblock flushing to a workqueue.
> >>>>  		 */
> >>>> -		if (continue_fs && journal)
> >>>> +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
> >>>>  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> >>>>  		else
> >>>>  			ext4_commit_super(sb);
> >>>> @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >>>>  	spin_lock_init(&sbi->s_error_lock);
> >>>>  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
> >>>>  
> >>>> +	sbi->s_journal_destorying = false;
> >>>> +
> >>>>  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> >>>>  	if (err)
> >>>>  		goto failed_mount3;
> >>>
> > 
> 

