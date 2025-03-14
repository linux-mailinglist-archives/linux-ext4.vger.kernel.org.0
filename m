Return-Path: <linux-ext4+bounces-6803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90BA61046
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54007177210
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 11:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED51FDE08;
	Fri, 14 Mar 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XAOPpJvC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2B1E5B95;
	Fri, 14 Mar 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952680; cv=none; b=Y4ZPP+y2EC7g51w/Ssz2i4yE8vHSQj/wHZpfFFWpsmjsCo5+/avn3T2HsK/3XvQBT3gO34MCiyTDqcjXitRblEyKmgL5qMd9vhTAXI0tYjfLOrYwLyxzjDQ0llQ6ygNhaxQQK8DdcWJyqLwiFVtpVTdPiuab3SaRatu4HzffZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952680; c=relaxed/simple;
	bh=si/W3rEWH897DB0tuptSznUTonegIlQbTQX/UsPHkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0c1RkJHHD9WmxSU6DYRERSIAXstqrIzK1S7uND/5Ob+2XiEgtzr07TjRFdVRGvDmFe2MwcwZRJeNTtgvmyGZHbQgjnSS7q7V2GYeOzRynANCeu2upSSBkp2lgEBzmK4LkRk40QNSfTIf4D813Qn/5G3Qc09dOYXWahCZisp5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XAOPpJvC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBXdVR032452;
	Fri, 14 Mar 2025 11:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=f7wJvJUszs66a4IwCFK7QQJA6hcRmp
	s5Qbe3WXt582Q=; b=XAOPpJvC1AKJ26b3rRPk6oj/LHdxmrRdJYetuJn9IvSgNh
	oWeGSTwabCmQlVZ1pl4S+yPPcAlPD7udo9sRajJ2nuB5lLM6+easRfuRVio/sC3K
	3bSenkCiNvD4gDcoTdDdkIzttlspLvm6ILUygoCge4lKDa5mAQ8Y3KBQrNVoEOBE
	SV6dWuIuGGSiZEjc3YnGnXLAbF8cFq/QCe8DByLqllV2437DO4PCom8HuQE0yuEI
	8g0GHPI2iHN9mw/UW/pYihQzUqQXb0DdvcxRozyw7BLUAa6YkYVA0nph/X4fgf8W
	q59GP/6+HqFsmlxE9qoOO2dLmW9ijb7jloknFBkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:44:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBiRqY016764;
	Fri, 14 Mar 2025 11:44:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:44:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8VUXf015380;
	Fri, 14 Mar 2025 11:44:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsppq4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:44:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBiOhL45809980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:44:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A857A20043;
	Fri, 14 Mar 2025 11:44:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD69C20040;
	Fri, 14 Mar 2025 11:44:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Mar 2025 11:44:22 +0000 (GMT)
Date: Fri, 14 Mar 2025 17:14:20 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v3 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z9QWlMFQl9oL9Zen@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741938027.git.ojaswin@linux.ibm.com>
 <b8e529f340a9c25c270a77733c79ffc590a9935c.1741938027.git.ojaswin@linux.ibm.com>
 <2ptbzrdbw2ttnd2ik5y4qq5py7ho7kusescdhtfzwg4ft7ldgs@qnkbcdoxvpfs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ptbzrdbw2ttnd2ik5y4qq5py7ho7kusescdhtfzwg4ft7ldgs@qnkbcdoxvpfs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: obPM_2rq86sltTex7_t5ldC1PINA_Oig
X-Proofpoint-ORIG-GUID: In6SYCBXjhjivbnHEm3vfMAYW1BONzrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140091

On Fri, Mar 14, 2025 at 11:10:40AM +0100, Jan Kara wrote:
> On Fri 14-03-25 13:14:10, Ojaswin Mujoo wrote:
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
> > Hence, introduce a new mount flag to indicate journal is destroying and only do
> > a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
> > fallback to an un-journaled commit.
> > 
> > Further, in the journal destroy path, we have the following sequence:
> > 
> >   1. Set mount flag indicating journal is destroying
> >   2. force a commit and wait for it
> >   3. flush pending sb updates
> > 
> > This sequence is important as it ensures that, after this point, there is no sb
> > update that might be journaled so it is safe to update the sb outside the
> > journal. (To avoid race discussed in 2d01ddc86606)
> > 
> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> > called from mballoc and AFAICT it would be always valid to schedule work here.
> > 
> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Mostly looks good. Couple of small comments below:
> 
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1179,6 +1179,7 @@ struct ext4_inode_info {
> >  #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
> >  #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
> >  #define EXT4_FC_REPLAY			0x0020	/* Fast commit replay ongoing */
> > +#define EXT4_JOURNAL_DESTORY		0x0040	/* Journal is in process of destroying */
> 
> This should be defined as part of the following enum:
> 
> /*
>  * run-time mount flags
>  */
> enum {
>         EXT4_MF_MNTDIR_SAMPLED,
>         EXT4_MF_FC_INELIGIBLE   /* Fast commit ineligible */
> };

Right, I'll fix that
> 
> Also you have a typo in the flag name. I guess it should be
> EXT4_MF_JOURNAL_DESTROY.

I ended up making the same typo as before :) 
> 
> > @@ -4957,8 +4961,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
> >  	return 0;
> >  
> >  out:
> > -	/* flush s_sb_upd_work before destroying the journal. */
> > -	flush_work(&sbi->s_sb_upd_work);
> >  	ext4_journal_destroy(sbi, sbi->s_journal);
> >  	return -EINVAL;
> >  }
> > @@ -5648,8 +5650,6 @@ failed_mount8: __maybe_unused
> >  	sbi->s_ea_block_cache = NULL;
> >  
> >  	if (sbi->s_journal) {
> > -		/* flush s_sb_upd_work before journal destroy. */
> > -		flush_work(&sbi->s_sb_upd_work);
> >  		ext4_journal_destroy(sbi, sbi->s_journal);
> >  	}
> >  failed_mount3a:
> 
> These are good. I would also move the flush_work() in ext4_put_super()
> into else branch of:
> 
> 	if (sbi->s_journal)

Right I thought of that but then let it be for simplicity. But sure I'll
add this in the next revision.

Thanks for the review Jan.
> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

