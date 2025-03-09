Return-Path: <linux-ext4+bounces-6735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E6A583E4
	for <lists+linux-ext4@lfdr.de>; Sun,  9 Mar 2025 13:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FDE3AE514
	for <lists+linux-ext4@lfdr.de>; Sun,  9 Mar 2025 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B161C4A10;
	Sun,  9 Mar 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="myGVbvCh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19D2B9A4;
	Sun,  9 Mar 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522089; cv=none; b=lAprn/zDKc85QlWD+o2ItmnLB/SLTGqWuH6olZIc9NylRvL54D3nPlsXzwoyjiVAyXXxBkiOIOJ4Z+TnQygSKNxzWBDB+cMRk1oF6bCrZXhRhCHej0kcn7EdshMA5do8tB89P+rOrSAgBCc/o3k2fsbegPGvtZ1p/e4I60HUiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522089; c=relaxed/simple;
	bh=zKt2z94NVsWtRDmvepPz2lTNP+PA15eMsGzaRty+9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKRJQX0w+TYIABYWDzpgEVG8IgXx8w+5YkgReGFtv83Nm3sRTYCVUBOX+5k6TYGEMgF98jXKcEeoMJDDWux1NXZ4P7dmgHery6T8uB9zPjrjvzZYqDyY0cFM0pcZtChqmtqNAkrPpYlCAeZ14C1bi+kupi4VF/PI8e0xiH3JGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=myGVbvCh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529Bcu2X030962;
	Sun, 9 Mar 2025 12:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AcOWU4W7qF6tUNX+Y7UObiFYvriJ4r
	9SzfbNtS/DVPM=; b=myGVbvCh5gZdgbLymDewHcDUSf9ytc8kC/UQF036rJnJhH
	lUJHldnB/LSvG/JNmga2hsbp/vnbgdSc8EZ90QbTbe7A7sGGGdZd758gMCp+tWdX
	cwficX8kD37QpBdgBHRzcPJ/q5wDZodi6TYkECfA6X/fmIMgvjl9vOaGoEscd687
	ErePUHKywfXzUuuD6bqCdanlr1Nv4uZ/dQMVtvwBtL0lcwQb/415bvl9/nhm3++/
	gtlqZfhOHnMck7/7iAmoplhks0FuCzlMp0tbdN+QW0i+8YLO8xy4rvkGZyrDV0Qo
	/60Y1+vc5muard/f4Q/G/Ai7cBr+A75dmeHm06Mg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458w3yj21x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Mar 2025 12:07:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 529C7mD8012937;
	Sun, 9 Mar 2025 12:07:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458w3yj21u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Mar 2025 12:07:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5297U2hc014896;
	Sun, 9 Mar 2025 12:07:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek1nwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Mar 2025 12:07:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 529C7jf818022842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Mar 2025 12:07:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C275420043;
	Sun,  9 Mar 2025 12:07:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA53120040;
	Sun,  9 Mar 2025 12:07:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.162])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 12:07:43 +0000 (GMT)
Date: Sun, 9 Mar 2025 17:37:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
 <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87ecz7hcw0.fsf@gmail.com>
 <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87cyergyb1.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyergyb1.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8dHzsHYK5eE9FPbf-xWtr_zoUUA57npl
X-Proofpoint-GUID: 5h2ePxMUA8oZ45GylbRb6OQzqJlLaa36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503090096

On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> >> 
> >> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> >> >> 
> >> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
> >> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> >> >> > stress tests, it was observed that in case of some error handling paths, it is
> >> >> > possible for update_super_work to start a transaction after the journal is
> >> >> > destroyed eg:
> >> >> >
> >> >> > (umount)
> >> >> > ext4_kill_sb
> >> >> >   kill_block_super
> >> >> >     generic_shutdown_super
> >> >> >       sync_filesystem /* commits all txns */
> >> >> >       evict_inodes
> >> >> >         /* might start a new txn */
> >> >> >       ext4_put_super
> >> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> >> >> >         jbd2_journal_destroy
> >> >> >           journal_kill_thread
> >> >> >             journal->j_flags |= JBD2_UNMOUNT;
> >> >> >           jbd2_journal_commit_transaction
> >> >> >             jbd2_journal_get_descriptor_buffer
> >> >> >               jbd2_journal_bmap
> >> >> >                 ext4_journal_bmap
> >> >> >                   ext4_map_blocks
> >> >> >                     ...
> >> >> >                     ext4_inode_error
> >> >> >                       ext4_handle_error
> >> >> >                         schedule_work(&sbi->s_sb_upd_work)
> >> >> >
> >> >> >                                                /* work queue kicks in */
> >> >> >                                                update_super_work
> >> >> >                                                  jbd2_journal_start
> >> >> >                                                    start_this_handle
> >> >> >                                                      BUG_ON(journal->j_flags &
> >> >> >                                                             JBD2_UNMOUNT)
> >> >> >
> >> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> >> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
> >> >> > set. Otherwise, just fallback to an un-journaled commit.
> >> >> >
> >> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
> >> >> > during ext4_put_super() (except a running transaction that will get commited
> >> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> >> >> > outside the journal as it won't race with a journaled update (refer
> >> >> > 2d01ddc86606).
> >> >> >
> >> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> >> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
> >> >> >
> >> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> >> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> >> >> > Suggested-by: Jan Kara <jack@suse.cz>
> >> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> >> > ---
> >> >> >  fs/ext4/ext4.h      | 2 ++
> >> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
> >> >> >  fs/ext4/super.c     | 4 +++-
> >> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >> >> > index 2b7d781bfcad..d48e93bd5690 100644
> >> >> > --- a/fs/ext4/ext4.h
> >> >> > +++ b/fs/ext4/ext4.h
> >> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> >> >> >  	 */
> >> >> >  	struct work_struct s_sb_upd_work;
> >> >> >  
> >> >> > +	bool s_journal_destorying;
> >> >> > +
> >> >> >  	/* Atomic write unit values in bytes */
> >> >> >  	unsigned int s_awu_min;
> >> >> >  	unsigned int s_awu_max;
> >> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> >> >> > index 9b3c9df02a39..6bd3ca84410d 100644
> >> >> > --- a/fs/ext4/ext4_jbd2.h
> >> >> > +++ b/fs/ext4/ext4_jbd2.h
> >> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> >> >> >  {
> >> >> >  	int err = 0;
> >> >> >  
> >> >> > +	/*
> >> >> > +	 * At this point all pending FS updates should be done except a possible
> >> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> >> >> > +	 * is now safe for any new errors to directly commit superblock rather
> >> >> > +	 * than going via journal.
> >> >> > +	 */
> >> >> > +	sbi->s_journal_destorying = true;
> >> >> 
> >> >> This is not correct right. I think what we decided to set this flag
> >> >> before we flush the workqueue. So that we don't schedule any new
> >> >> work after this flag has been set. At least that is what I understood.
> >> >> 
> >> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
> >> >> 
> >> >> -ritesh
> >> >
> >> > Hey Ritesh,
> >> >
> >> > Yes that is not correct, I missed that in my patch however we realised
> >> > that adding it before flush_work() also has issues [1]. More
> >> > specifically:
> >> 
> >> Ohk. right. 
> >> 
> >> >
> >> >                      **kjournald2**
> >> >                      jbd2_journal_commit_transaction()
> >> >                      ...
> >> >                      ext4_handle_error()
> >> >                         /* s_journal_destorying is not set */
> >> >                         if (journal && !s_journal_destorying)
> >> 
> >> Then maybe we should not schedule another work to update the superblock
> >> via journalling, it the error itself occurred while were trying to
> >> commit the journal txn? 
> >> 
> >> 
> >> -ritesh
> >
> > Hmm, ideally yes that should not happen, but how can we achieve that?
> > For example with the trace we saw:
> >
> >    **kjournald2**
> >    jbd2_journal_commit_transaction()
> >      jbd2_journal_get_descriptor_buffer
> >        jbd2_journal_bmap
> >          ext4_journal_bmap
> >            ext4_map_blocks
> >              ...
> >              ext4_inode_error
> >                ext4_handle_error
> >                  schedule_work(&sbi->s_sb_upd_work)
> >
> > How do we tell ext4_handle_error that it is in the context of a
> > committing txn.
> 
> So even if we identify that the current
> jbd2_journal_commit_transaction() is coming from kjournald2(), that is
> sufficient right? Because the only other place where we call
> jbd2_journal_commit_transaction() is jbd2_journal_destroy() and that
> happens after we can set few things from ext4_put_super() and flush work
> is completed, correct? 
> 
> 
> > We can't pass down an argument all the way down 
> > cause that is not feasible. An sb level flag will also not work
> > I think. Any thoughts on this?
> 
> I was thinking if we should have a per task flag? Something like
> PF_KJOURNALD?  (Similar to how we have PF_KSWAPD or PF_KCOMPACTD)? This
> can help us identify if we are a kjournald2() kthread.
> 
> That will help prevent scheduling another work item to start a new
> transaction in case an error occurs while committing the currently
> running transaction. Correct?

Yes, I like this approach. I think this will also help us avoid the
extra checks in ext4_journal_destroy() since the journal will no longer
schecule work for updating the sb. Hence we can be sure that after the
final flush_work() noone will try to schedule more work or start a new
transaction.

I'll try to spin up a poc and test it. Does seem like we are out of flags in 
task struct though.

Regards,
ojaswin

> 
> Now I don't know if we have any free bit available in current->flags. If
> not shall we use current->journal_info pointer to have 0th bit as a
> flag? Basically override current->journal_info to also store a flag.  We
> can create a wrapper to get the journal_info from current by masking
> this flag bit and use it to dereference journal_info.

Hmm so journal_info will be holding a kernel address of the handle. Is
it possible to have it share a flag as well? I thought the address would
utilize the full 64bits?

Regards,
ojaswin

> 
> But before going down that road, it's better to know what others think?
> 
> -ritesh
> 
> 
> >
> > regards,
> > ojaswin
> >
> >> 
> >> 
> >> >   ext4_put_super()
> >> >     sbi->s_journal_destorying = true;
> >> >     flush_work(&sbi->s_sb_upd_work)
> >> >                                       schedule_work()
> >> >     jbd2_journal_destroy()
> >> >      journal->j_flags |= JBD2_UNMOUNT;
> >> >
> >> >                                         jbd2_journal_start()
> >> >                                          start_this_handle()
> >> >                                            BUG_ON(JBD2_UNMOUNT)
> >> >
> >> > So the right thing to do seems to be that we need to force a journal
> >> > commit before the final flush as well. [1] Has more info on this and
> >> > some followup discussion as well.
> >> >
> >> > [1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e
> >> >
> >> > Regards,
> >> > ojaswin
> >> >> 
> >> >> 
> >> >> > +
> >> >> >  	err = jbd2_journal_destroy(journal);
> >> >> >  	sbi->s_journal = NULL;
> >> >> >  
> >> >> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> >> >> > index 8ad664d47806..31552cf0519a 100644
> >> >> > --- a/fs/ext4/super.c
> >> >> > +++ b/fs/ext4/super.c
> >> >> > @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> >> >> >  		 * constraints, it may not be safe to do it right here so we
> >> >> >  		 * defer superblock flushing to a workqueue.
> >> >> >  		 */
> >> >> > -		if (continue_fs && journal)
> >> >> > +		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
> >> >> >  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> >> >> >  		else
> >> >> >  			ext4_commit_super(sb);
> >> >> > @@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >> >> >  	spin_lock_init(&sbi->s_error_lock);
> >> >> >  	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
> >> >> >  
> >> >> > +	sbi->s_journal_destorying = false;
> >> >> > +
> >> >> >  	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> >> >> >  	if (err)
> >> >> >  		goto failed_mount3;
> >> >> > -- 
> >> >> > 2.48.1

