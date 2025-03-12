Return-Path: <linux-ext4+bounces-6774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E6A5DEEF
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBAD3B7086
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533124E002;
	Wed, 12 Mar 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qazo454u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E524635E;
	Wed, 12 Mar 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789629; cv=none; b=RLqfqUkAkRTvI4o9xMILbp08Lm/woN4lpDbEwvT5+8fFz+4wnAac972q+4XYmXimm5vh6Qfhf8/GAxva8npHjmG807JpmrOAxfhZCuXE0GW/YppZkarKNBOjEEKpDQxvlOK0d9A0vyBgRBr32gNzlzm31QH4UCa98DFKjno7mAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789629; c=relaxed/simple;
	bh=lXUv0qhUphLMzgdQBsXFT7PB35+4MECnyjEeoHsmElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2FtajYfMBUeOhqaTdeglNL5mG3xQaBx2NGBXK3fcbozlOsvA/mZ0UZDgx9V3rFAhyYGVyfr2sW/gMEA4UpTrh7Bi8ZWJERx7HfQ+pSiQL3+8O8xoW8Ir3HcDWOHCvDUtzfsP3yvgF0BojggHsyBvsEPaCFk9BeuyT+Evm6Xaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qazo454u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE3Jsh023153;
	Wed, 12 Mar 2025 14:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3TzpnW9tu4mwWylSLXsXPUoFgdlivh
	AXkTZ7HTobu1M=; b=qazo454ubysPoj5idJZoyL2UdfwVYN28OaADgc2lJppNJV
	nyK1wf4Wa7j6j+iegdSDEoTQHgESLUQBRR07/eabe9x8CocNE1r2ImfTHUDK6JQ2
	rC8CenoDjyRwXGDPizWW8O+6RtECV2GGA/MTIbp+bZVHprasvv56pwzhi22d9JDJ
	0vuiLz2XGo0DeTa8BS4M7b8nLAimm67FkavfuXbR4PyxlcpDGZg4F8Z9B1YprOBQ
	gu6Dcml2u+BHmsQcvb5PQUUG84yahyIh7v7ccaCV1YMKU1wTAreUxsl7VT9g2a23
	tGpSqO1rYkg8yJSQkvFJFmuWXVA+9BmB8DR6FbsQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppr4ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:26:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52CEMw0i014566;
	Wed, 12 Mar 2025 14:26:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppr4ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:26:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE3vNe026021;
	Wed, 12 Mar 2025 14:26:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspchva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:26:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CEQeNT41877912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:26:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF8BC20040;
	Wed, 12 Mar 2025 14:26:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE792004B;
	Wed, 12 Mar 2025 14:26:38 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Mar 2025 14:26:38 +0000 (GMT)
Date: Wed, 12 Mar 2025 19:56:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z9GZdSiDL0J80720@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
 <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87ecz7hcw0.fsf@gmail.com>
 <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87cyergyb1.fsf@gmail.com>
 <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <871pv5cx6v.fsf@gmail.com>
 <bct36ajzi6sardnmc6yz4ot4fbpr654b4k2xz54mrtyje7wofq@qpwzbtctwqnf>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bct36ajzi6sardnmc6yz4ot4fbpr654b4k2xz54mrtyje7wofq@qpwzbtctwqnf>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VHVfFhTOyW3xfH9OM1XTcOH1zMsObxP2
X-Proofpoint-GUID: qUme9U2B2cYW8JfqdwPJPAW6NPDkSeSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120100

On Wed, Mar 12, 2025 at 11:51:03AM +0100, Jan Kara wrote:
> On Mon 10-03-25 10:13:36, Ritesh Harjani wrote:
> > Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
> > >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > >> > On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
> > >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > >> >> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> > >> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > >> >> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
> > >> >> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> > >> >> >> > stress tests, it was observed that in case of some error handling paths, it is
> > >> >> >> > possible for update_super_work to start a transaction after the journal is
> > >> >> >> > destroyed eg:
> > >> >> >> >
> > >> >> >> > (umount)
> > >> >> >> > ext4_kill_sb
> > >> >> >> >   kill_block_super
> > >> >> >> >     generic_shutdown_super
> > >> >> >> >       sync_filesystem /* commits all txns */
> > >> >> >> >       evict_inodes
> > >> >> >> >         /* might start a new txn */
> > >> >> >> >       ext4_put_super
> > >> >> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > >> >> >> >         jbd2_journal_destroy
> > >> >> >> >           journal_kill_thread
> > >> >> >> >             journal->j_flags |= JBD2_UNMOUNT;
> > >> >> >> >           jbd2_journal_commit_transaction
> > >> >> >> >             jbd2_journal_get_descriptor_buffer
> > >> >> >> >               jbd2_journal_bmap
> > >> >> >> >                 ext4_journal_bmap
> > >> >> >> >                   ext4_map_blocks
> > >> >> >> >                     ...
> > >> >> >> >                     ext4_inode_error
> > >> >> >> >                       ext4_handle_error
> > >> >> >> >                         schedule_work(&sbi->s_sb_upd_work)
> > >> >> >> >
> > >> >> >> >                                                /* work queue kicks in */
> > >> >> >> >                                                update_super_work
> > >> >> >> >                                                  jbd2_journal_start
> > >> >> >> >                                                    start_this_handle
> > >> >> >> >                                                      BUG_ON(journal->j_flags &
> > >> >> >> >                                                             JBD2_UNMOUNT)
> > >> >> >> >
> > >> >> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> > >> >> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
> > >> >> >> > set. Otherwise, just fallback to an un-journaled commit.
> > >> >> >> >
> > >> >> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
> > >> >> >> > during ext4_put_super() (except a running transaction that will get commited
> > >> >> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> > >> >> >> > outside the journal as it won't race with a journaled update (refer
> > >> >> >> > 2d01ddc86606).
> > >> >> >> >
> > >> >> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> > >> >> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
> > >> >> >> >
> > >> >> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > >> >> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > >> >> >> > Suggested-by: Jan Kara <jack@suse.cz>
> > >> >> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > >> >> >> > ---
> > >> >> >> >  fs/ext4/ext4.h      | 2 ++
> > >> >> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
> > >> >> >> >  fs/ext4/super.c     | 4 +++-
> > >> >> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
> > >> >> >> >
> > >> >> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > >> >> >> > index 2b7d781bfcad..d48e93bd5690 100644
> > >> >> >> > --- a/fs/ext4/ext4.h
> > >> >> >> > +++ b/fs/ext4/ext4.h
> > >> >> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> > >> >> >> >  	 */
> > >> >> >> >  	struct work_struct s_sb_upd_work;
> > >> >> >> >  
> > >> >> >> > +	bool s_journal_destorying;
> > >> >> >> > +
> > >> >> >> >  	/* Atomic write unit values in bytes */
> > >> >> >> >  	unsigned int s_awu_min;
> > >> >> >> >  	unsigned int s_awu_max;
> > >> >> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > >> >> >> > index 9b3c9df02a39..6bd3ca84410d 100644
> > >> >> >> > --- a/fs/ext4/ext4_jbd2.h
> > >> >> >> > +++ b/fs/ext4/ext4_jbd2.h
> > >> >> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> > >> >> >> >  {
> > >> >> >> >  	int err = 0;
> > >> >> >> >  
> > >> >> >> > +	/*
> > >> >> >> > +	 * At this point all pending FS updates should be done except a possible
> > >> >> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> > >> >> >> > +	 * is now safe for any new errors to directly commit superblock rather
> > >> >> >> > +	 * than going via journal.
> > >> >> >> > +	 */
> > >> >> >> > +	sbi->s_journal_destorying = true;
> > >> >> >> 
> > >> >> >> This is not correct right. I think what we decided to set this flag
> > >> >> >> before we flush the workqueue. So that we don't schedule any new
> > >> >> >> work after this flag has been set. At least that is what I understood.
> > >> >> >> 
> > >> >> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
> > >> >> >> 
> > >> >> >> -ritesh
> > >> >> >
> > >> >> > Hey Ritesh,
> > >> >> >
> > >> >> > Yes that is not correct, I missed that in my patch however we realised
> > >> >> > that adding it before flush_work() also has issues [1]. More
> > >> >> > specifically:
> > >> >> 
> > >> >> Ohk. right. 
> > >> >> 
> > >> >> >
> > >> >> >                      **kjournald2**
> > >> >> >                      jbd2_journal_commit_transaction()
> > >> >> >                      ...
> > >> >> >                      ext4_handle_error()
> > >> >> >                         /* s_journal_destorying is not set */
> > >> >> >                         if (journal && !s_journal_destorying)
> > >> >> 
> > >> >> Then maybe we should not schedule another work to update the superblock
> > >> >> via journalling, it the error itself occurred while were trying to
> > >> >> commit the journal txn? 
> > >> >> 
> > >> >> 
> > >> >> -ritesh
> > >> >
> > >> > Hmm, ideally yes that should not happen, but how can we achieve that?
> > >> > For example with the trace we saw:
> > >> >
> > >> >    **kjournald2**
> > >> >    jbd2_journal_commit_transaction()
> > >> >      jbd2_journal_get_descriptor_buffer
> > >> >        jbd2_journal_bmap
> > >> >          ext4_journal_bmap
> > >> >            ext4_map_blocks
> > >> >              ...
> > >> >              ext4_inode_error
> > >> >                ext4_handle_error
> > >> >                  schedule_work(&sbi->s_sb_upd_work)
> > >> >
> > >> > How do we tell ext4_handle_error that it is in the context of a
> > >> > committing txn.
> 
> So I was thinking about this. It is not a problem to determine we are
> running in kjournald context - it is enough to check
> 
> 	current == EXT4_SB(sb)->s_journal->j_task

Oh, right :) 

> 
> But I'm not sure checking this in ext4_handle_error() and doing direct sb
> update instead of scheduling a journalled one is always correct. For
> example kjournald does also writeback of ordered data and if that hits an
> error, we do not necessarily abort the journal (well, currently we do as
> far as I'm checking but it seems a bit fragile to rely on this).

Okay so IIUC your concern is there might be some codepaths, now or in
the future, where kjournald might call the FS layer, hit an error and
still decide to not abort. In which case we would still want to update
the sb via journal.

Im having some difficulty imagining when this can happen but I'm okay
with the alternate approach of hardening the umount path as well. Fwiw
this approach did feel a bit more cleaner as we could avoid the journal
commit and flushing dance in ext4_journal_destory()

> 
> So I'd rather keep the solution for these umount issues specific to the
> umount path. What if we did:
> 
> static void ext4_journal_destroy(struct super_block *sb)
> {
> 	/*
> 	 * At this point only two things can be operating on the journal.
> 	 * JBD2 thread performing transaction commit and s_sb_upd_work
> 	 * issuing sb update through the journal. Once we set
> 	 * EXT4_FLAGS_JOURNAL_DESTROY, new ext4_handle_error() calls will not
> 	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
> 	 * ext4_handle_error() calls from the running transaction commit are
> 	 * finished. Hence no new s_sb_upd_work can be queued after we
> 	 * flush it here.
> 	 */
> 	set_bit(EXT4_FLAGS_JOURNAL_DESTROY, &EXT4_SB(sb)->s_ext4_flags);

Offtopic, how are s_ext4_flags different from s_mount_flags, since in a
draft patchset for this, I am using:

	ext4_set_mount_flag(sbi->s_sb, EXT4_JBD2_DESTORYING);

so just curious.

> 	ext4_force_commit(sb);
> 	flush_work(&EXT4_SB(sb)->s_sb_upd_work);
> 	jbd2_journal_destroy(EXT4_SB(sb)->s_journal);
> }
> 
> And then add the check to ext4_handle_error():
> 
>                 /*
>                  * In case the fs should keep running, we need to writeout
>                  * superblock through the journal. Due to lock ordering
>                  * constraints, it may not be safe to do it right here so we
> -		 * defer superblock flushing to a workqueue.
> +		 * defer superblock flushing to a workqueue. We just need
> +		 * to be careful when the journal is already shutting down.
> +		 * If we get here in that case, just update the sb directly
> +		 * as the last transaction won't commit anyway.
>                  */
> -		if (continue_fs && journal)
> +		if (continue_fs && journal &&
> +		    !test_bit(EXT4_FLAGS_JOURNAL_DESTROY,
> +			      &EXT4_SB(sb)->s_ext4_flags))
> 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
> 		else
> 			ext4_commit_super(sb);
> 
> What do people think about this? Am I missing some possible race?

This approach looks good Jan, I think its similar to what we were
discussing previous to the dont-schedule-if-kjournald alternative.

I was working on a similar patchset as this, I'll borrow your wording
for the comments and run some more tests on this. Thanks for the review.

Regards,
ojaswin

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

