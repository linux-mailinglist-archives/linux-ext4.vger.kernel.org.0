Return-Path: <linux-ext4+bounces-6712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6448A56E84
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ED33AA4F4
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC71C1F21;
	Fri,  7 Mar 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HCdn3gZu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D11E1E0B;
	Fri,  7 Mar 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366942; cv=none; b=hxggCao2yz8SYkCY3ZyXGIoUUylE075LeTXl3FyQ3klL7XvvgX6T6ZXbpMtuBZZD2p9I+6sDwb9dLagNI150QVhCYEcLK3khqp4D5laCZGaYa0MDjQuNDxc1cb0U2tvVbRCTHcVCvTvSyRgDSwOJ+G6wsYYtL6alJ+gw5WRxTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366942; c=relaxed/simple;
	bh=fg7wS7b/pxhwCOe8+ARV+FwrjPTuaUgC822GtOMszZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmw9PGDJvK+z6QRVU9sOFTdDLeeKyVT6/AtZhY+wZgn5t5ZhwiMjGMrkFxW1OHDWqeLPVITuH8xzKsOwyq3rBIoEHG48gsKca5QqleLNXJfZko080UCnwfwm+Oj8B3Gka0BmHcRVHTtKaUU5/8Bcn1T9ecfeSAYvk8QNWkpgfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HCdn3gZu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527CS3l7009129;
	Fri, 7 Mar 2025 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YLQ3+gDhUCP+A9SMdAOvSGG9nbHolx
	AGKHxmAO+vUmQ=; b=HCdn3gZuCfnZuLTSNjl1cyejF7SLmATHaLMiMbbMG5UUla
	Lf+qV/rBIcYiFEZZD7qiUnZU7sCqkUvoi5fuYF5yqRM+8dz4pZIoep6LZXNzjQie
	fCXqAFGgdtiAbNM3iuZ7btwOmFshi7VZoTFI97UqaZxUFHkdPJQLbxiZsk44IMNK
	SJCFMru6uPDZYDq5rfmRTl1ahEe72W5Sh4/atEHPU9B+zZVDuAain164mQLXmW9Z
	tArOle/M09FpYouT0Yfp/m2tt/36lLiPBFjIM8WQDiH70epwLJ31VROIgnyfugdW
	F8xsaUIuJ3ui5/SJIDh2sbQkM80CYUF6Wwmfv2Gg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4580u2semk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:02:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 527GnPoY025387;
	Fri, 7 Mar 2025 17:02:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4580u2semg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:02:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527FEIIf009012;
	Fri, 7 Mar 2025 17:02:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cy00392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:02:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527H29RN18284980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 17:02:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239342006A;
	Fri,  7 Mar 2025 17:02:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B942004F;
	Fri,  7 Mar 2025 17:01:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 17:01:16 +0000 (GMT)
Date: Fri, 7 Mar 2025 22:30:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z8sl-omWWA58NVxy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <3y7za2sfohzeifijsnlxdp7zb7vfkltjgeqcca57tw6uqzlxtt@hngy3b6up3ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3y7za2sfohzeifijsnlxdp7zb7vfkltjgeqcca57tw6uqzlxtt@hngy3b6up3ch>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MNAqGI-9qaxFGVpcRh0K6Bjgo5kD8ZJ0
X-Proofpoint-GUID: pfAruYkaQT7plc2eQ3iKA_7f0GErk8vB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070126

On Fri, Mar 07, 2025 at 03:26:54PM +0100, Jan Kara wrote:
> On Thu 06-03-25 19:58:33, Ojaswin Mujoo wrote:
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
> 
> Not that it would matter much but why not make this a flag in
> sbi->s_mount_flags?

Noted.

> 
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
> > +
> 
> So as you already uncovered with Zhang Yi, this does not work. What I meant
> was that we move flush_work(&sbi->s_sb_upd_work) into
> ext4_journal_destroy() and set s_journal_destorying *before* calling
> flush_work(). By the time ext4_journal_destroy() gets called, the
> filesystem is quiescent, there cannot be new handles started (except for sb
> update itself from the workqueue) and thus if we hit some error, the
> journal will be aborted anyway and in that case non-journaled sb update is
> safe.

I missed that in my patch, however as in the discussion [1],
even:

ext4_journal_destroy
  sbi->s_journal_destroying = true
  flush_work()

sequence is not enough. Zhang and I were discussing that we might need
to force and wait for commit as well before flushing the work.
Hopefully, with that, we should be covering all the possible edge cases.

[1] https://lore.kernel.org/linux-ext4/cover.1741270780.git.ojaswin@linux.ibm.com/T/#mc8046d47b357665bdbd2878c91e51eb660f94b3e

Regards,
ojaswin

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

