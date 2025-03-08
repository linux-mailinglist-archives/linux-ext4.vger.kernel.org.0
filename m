Return-Path: <linux-ext4+bounces-6729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFEA57A51
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEC416B8BD
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA601B6D01;
	Sat,  8 Mar 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sOjDZuPM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A797AD4B;
	Sat,  8 Mar 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439153; cv=none; b=EHDisdT1LbN3ABxdc5p27Yb/DPdsnt5cdTVhKwWKlYqFYc6YA9X5IkGV0Yd8x2sKoxGvahOJCBXucTYfZlledjMtqlBo/b24iYoR4J+qfc+V50NgRMXKF5vc7abKo+rLjllEE7gtSCST5gtp5oVDD1AbWM4O2I4+Gw1/nLAnvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439153; c=relaxed/simple;
	bh=pHy1EkO+M9LdtOP1esqudLujE78opiuZtzFTKSvhiGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW6fOWMzuEcQRV88H7qp+oQnaVGDHHWfB2AH81h4w26bV0CMI5fVYSDtW7yCRyN4DWio20zw2meMH1iaY8rj/Jyn4XXvFdpdMK+HqPGmqBhyyUiOfLSgky2BkhNNUo9Oi16azoBMBcm+5Ly8nYzRf9Aql0BwHvtb/QHx1oje9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sOjDZuPM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528CU66H006788;
	Sat, 8 Mar 2025 13:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GUiZRjFoPnlXOjKzFtFZbQXlgW+Hh4
	f/IQjfun5cLfk=; b=sOjDZuPM3/6nQoDTl1/Yf0hAVl43kk5dHbszei4npS/IlX
	LyBNchA+iVgjkstcZnam67oRiQBA8TjkfaJSlSBIQmZHY8pJAEJEit+ZvMfHCu28
	gNahDri1WOi/I54J6jKS9pQ1CCp8iOYNt0sQNzQRngdvXaOHZrFkFkmW+yJOq85/
	Vx+SULl4xjkbpBNfBgU0qPuAxYoBdqaU1HNhkCInCvLAXj8E3T1Ec6EZsuv+Euja
	JujSVXrMt9EQe2PDk7VTDdQUMBw3TFNClLVo+iAfqYWRQY46DU6sqCi2HLZVi02L
	sb8y+Nnmo0l07/IE7A8EpPjOT6mS8wO4vbKH0+/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458nx183d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 13:05:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528D5dcd016360;
	Sat, 8 Mar 2025 13:05:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458nx183d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 13:05:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528CmLQi013720;
	Sat, 8 Mar 2025 13:05:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2mc6ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 13:05:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 528D5aAU28836276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 13:05:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23C3B20043;
	Sat,  8 Mar 2025 13:05:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4930B20040;
	Sat,  8 Mar 2025 13:05:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.97])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Mar 2025 13:05:34 +0000 (GMT)
Date: Sat, 8 Mar 2025 18:35:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldtfhmo7.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dtRnfqA9L9PihIkWDRgT-n67QlJ8akeJ
X-Proofpoint-ORIG-GUID: a30kPrR1ews13oXFkVob4funuR7eRvV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080092

On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > Presently we always BUG_ON if trying to start a transaction on a journal marked
> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> > stress tests, it was observed that in case of some error handling paths, it is
> > possible for update_super_work to start a transaction after the journal is
> > destroyed eg:
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
> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> > destroying only do a journaled (and deferred) update of sb if this flag is not
> > set. Otherwise, just fallback to an un-journaled commit.
> >
> > We set sbi->s_journal_destroying = true only after all the FS updates are done
> > during ext4_put_super() (except a running transaction that will get commited
> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> > outside the journal as it won't race with a journaled update (refer
> > 2d01ddc86606).
> >
> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> > called from mballoc and AFAICT it would be always valid to schedule work here.
> >
> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/ext4.h      | 2 ++
> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
> >  fs/ext4/super.c     | 4 +++-
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 2b7d781bfcad..d48e93bd5690 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> >  	 */
> >  	struct work_struct s_sb_upd_work;
> >  
> > +	bool s_journal_destorying;
> > +
> >  	/* Atomic write unit values in bytes */
> >  	unsigned int s_awu_min;
> >  	unsigned int s_awu_max;
> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > index 9b3c9df02a39..6bd3ca84410d 100644
> > --- a/fs/ext4/ext4_jbd2.h
> > +++ b/fs/ext4/ext4_jbd2.h
> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> >  {
> >  	int err = 0;
> >  
> > +	/*
> > +	 * At this point all pending FS updates should be done except a possible
> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> > +	 * is now safe for any new errors to directly commit superblock rather
> > +	 * than going via journal.
> > +	 */
> > +	sbi->s_journal_destorying = true;
> 
> This is not correct right. I think what we decided to set this flag
> before we flush the workqueue. So that we don't schedule any new
> work after this flag has been set. At least that is what I understood.
> 
> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
> 
> -ritesh

Hey Ritesh,

Yes that is not correct, I missed that in my patch however we realised
that adding it before flush_work() also has issues [1]. More
specifically:

                     **kjournald2**
                     jbd2_journal_commit_transaction()
                     ...
                     ext4_handle_error()
                        /* s_journal_destorying is not set */
                        if (journal && !s_journal_destorying)
  ext4_put_super()
    sbi->s_journal_destorying = true;
    flush_work(&sbi->s_sb_upd_work)
                                      schedule_work()
    jbd2_journal_destroy()
     journal->j_flags |= JBD2_UNMOUNT;

                                        jbd2_journal_start()
                                         start_this_handle()
                                           BUG_ON(JBD2_UNMOUNT)

So the right thing to do seems to be that we need to force a journal
commit before the final flush as well. [1] Has more info on this and
some followup discussion as well.

[1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e

Regards,
ojaswin
> 
> 
> > +
> >  	err = jbd2_journal_destroy(journal);
> >  	sbi->s_journal = NULL;
> >  
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 8ad664d47806..31552cf0519a 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> >  		 * constraints, it may not be safe to do it right here so we
> >  		 * defer superblock flushing to a workqueue.
> >  		 */
> > -		if (continue_fs && journal)
> > +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> >  		else
> >  			ext4_commit_super(sb);
> > @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	spin_lock_init(&sbi->s_error_lock);
> >  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
> >  
> > +	sbi->s_journal_destorying = false;
> > +
> >  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> >  	if (err)
> >  		goto failed_mount3;
> > -- 
> > 2.48.1

