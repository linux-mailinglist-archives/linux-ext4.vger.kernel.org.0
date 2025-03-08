Return-Path: <linux-ext4+bounces-6728-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81987A57A4A
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 13:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AD1188FE67
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161611BD007;
	Sat,  8 Mar 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AbTN0EEF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D58BFF;
	Sat,  8 Mar 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438678; cv=none; b=PttrcHXvzjAUdSyiOQ4xi61okpYKc8wAM4HJYBAF8q7oTEMsRrFLyqrcqD0MJk5U+uujd3Jl0e4I9XKBL+yM1o5aLzM5ZhMLlLGS7PVo9rBvHen/0cy6ppABlI+rn5BVhOxJrGnL6LTePlzA/qur2bLtfQbZVQxzejRI8FB2Urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438678; c=relaxed/simple;
	bh=oq3IXbbduE/grrkUzrFyBEfhysuVFxPsuJqjdQCbmzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTnlizWl+xKXAUFSKRs1+E+a/RY206vVNiMRHWKFK+pD5LeL4KaueTs1tE+JhfdWwRTXQIJvUAzrBB7Q7iwvsHMNIOZwzCym8pvGEyO5WdB9SztVFasIy0AwIzXF92W+JbFP7nY0kNaTOOyWH9pmox6u1i3mdlJPJ0SaFGCTNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AbTN0EEF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528CShCS002860;
	Sat, 8 Mar 2025 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kQzzmOL+CB9lMtDjickWWaEWfW2Uu1
	tam2kwk3pBs/8=; b=AbTN0EEF/P9Rlwp8OlRlKSQLMhg6nD5Y9vArCPwc2qIJ7H
	Am6sRjv+9xuvuX3Rhce0g3OtYpUe8suCKRgUYdBlY/dzgyMuvw5rHqhpEmQM8vnz
	SlDDjr82NnLFL0XIfM1pyO8Yjh+Yz2vuhryJqbQEjGANVrC1UW9TSjlCnbmp8ODB
	uFJqLeidbyLgexDK8TVMO+SfGw5wpckc+AUN9VVJpfiypHtvM7unOowegYQisXZa
	JH87xGog5pfNjV2+aQ6EgJe23PyIVeuGgxsfU7DgklmUZK8MisRF4Tmbd4t1dKFY
	gN/KSNVcAwQ8avXaqza3wqUwQ6ncSAlWnjvsR4cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458nx182sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 12:57:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528CvEWQ031766;
	Sat, 8 Mar 2025 12:57:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458nx182sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 12:57:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5289He3h020873;
	Sat, 8 Mar 2025 12:57:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454eskkw9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 12:57:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 528CvYXU59965944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 12:57:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1693620043;
	Sat,  8 Mar 2025 12:57:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4029D20040;
	Sat,  8 Mar 2025 12:57:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.97])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Mar 2025 12:57:32 +0000 (GMT)
Date: Sat, 8 Mar 2025 18:27:28 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z8w-fNNoCfIYIhlG@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z8qTciy49b7LSHqr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z8qqna0BEDT5ZD82@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e9e92601-53bc-42a2-b428-e61bff6153c5@huaweicloud.com>
 <Z8rKAsmIuBlOo4T1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e3172770-9b39-4105-966f-faf64a6b6515@huaweicloud.com>
 <Z8ssR7BtBVP1zif2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4f61a0fb-dd9f-4c0e-b872-31e5474ac799@huaweicloud.com>
 <Z8v9ZIv1m8e2fwIE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z8wUkbcgG0jcsFvF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <23b5782b-16bb-4efb-b55b-7766b97db27c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b5782b-16bb-4efb-b55b-7766b97db27c@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2VNFx0f1X09cyuTFrheSRTP6UsLJ_4pn
X-Proofpoint-ORIG-GUID: qisv-ezev97CVPu9V-P1pHBKO_2DNtLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080092

On Sat, Mar 08, 2025 at 06:10:14PM +0800, Baokun Li wrote:
> On 2025/3/8 17:58, Ojaswin Mujoo wrote:
> > On Sat, Mar 08, 2025 at 01:48:44PM +0530, Ojaswin Mujoo wrote:
> > > On Sat, Mar 08, 2025 at 10:57:16AM +0800, Zhang Yi wrote:
> > > > On 2025/3/8 1:26, Ojaswin Mujoo wrote:
> > > > > On Fri, Mar 07, 2025 at 08:36:08PM +0800, Zhang Yi wrote:
> > > > > > On 2025/3/7 18:27, Ojaswin Mujoo wrote:
> > > > > > > On Fri, Mar 07, 2025 at 04:43:24PM +0800, Zhang Yi wrote:
> > > > > > > > On 2025/3/7 16:13, Ojaswin Mujoo wrote:
> > > > > > > > > On Fri, Mar 07, 2025 at 12:04:26PM +0530, Ojaswin Mujoo wrote:
> > > > > > > > > > On Fri, Mar 07, 2025 at 10:49:28AM +0800, Zhang Yi wrote:
> > > > > > > > > > > On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> > > > > > > > > > > > Presently we always BUG_ON if trying to start a transaction on a journal marked
> > > > > > > > > > > > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> > > > > > > > > > > > stress tests, it was observed that in case of some error handling paths, it is
> > > > > > > > > > > > possible for update_super_work to start a transaction after the journal is
> > > > > > > > > > > > destroyed eg:
> > > > > > > > > > > > 
> > > > > > > > > > > > (umount)
> > > > > > > > > > > > ext4_kill_sb
> > > > > > > > > > > >    kill_block_super
> > > > > > > > > > > >      generic_shutdown_super
> > > > > > > > > > > >        sync_filesystem /* commits all txns */
> > > > > > > > > > > >        evict_inodes
> > > > > > > > > > > >          /* might start a new txn */
> > > > > > > > > > > >        ext4_put_super
> > > > > > > > > > > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > > > > > > > > > > >          jbd2_journal_destroy
> > > > > > > > > > > >            journal_kill_thread
> > > > > > > > > > > >              journal->j_flags |= JBD2_UNMOUNT;
> > > > > > > > > > > >            jbd2_journal_commit_transaction
> > > > > > > > > > > >              jbd2_journal_get_descriptor_buffer
> > > > > > > > > > > >                jbd2_journal_bmap
> > > > > > > > > > > >                  ext4_journal_bmap
> > > > > > > > > > > >                    ext4_map_blocks
> > > > > > > > > > > >                      ...
> > > > > > > > > > > >                      ext4_inode_error
> > > > > > > > > > > >                        ext4_handle_error
> > > > > > > > > > > >                          schedule_work(&sbi->s_sb_upd_work)
> > > > > > > > > > > > 
> > > > > > > > > > > >                                                 /* work queue kicks in */
> > > > > > > > > > > >                                                 update_super_work
> > > > > > > > > > > >                                                   jbd2_journal_start
> > > > > > > > > > > >                                                     start_this_handle
> > > > > > > > > > > >                                                       BUG_ON(journal->j_flags &
> > > > > > > > > > > >                                                              JBD2_UNMOUNT)
> > > > > > > > > > > > 
> > > > > > > > > > > > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> > > > > > > > > > > > destroying only do a journaled (and deferred) update of sb if this flag is not
> > > > > > > > > > > > set. Otherwise, just fallback to an un-journaled commit.
> > > > > > > > > > > > 
> > > > > > > > > > > > We set sbi->s_journal_destroying = true only after all the FS updates are done
> > > > > > > > > > > > during ext4_put_super() (except a running transaction that will get commited
> > > > > > > > > > > > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> > > > > > > > > > > > outside the journal as it won't race with a journaled update (refer
> > > > > > > > > > > > 2d01ddc86606).
> > > > > > > > > > > > 
> > > > > > > > > > > > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> > > > > > > > > > > > called from mballoc and AFAICT it would be always valid to schedule work here.
> > > > > > > > > > > > 
> > > > > > > > > > > > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > > > > > > > > > > > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > > > > > > > > > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > > > > > > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >   fs/ext4/ext4.h      | 2 ++
> > > > > > > > > > > >   fs/ext4/ext4_jbd2.h | 8 ++++++++
> > > > > > > > > > > >   fs/ext4/super.c     | 4 +++-
> > > > > > > > > > > >   3 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > > > > > > > > > index 2b7d781bfcad..d48e93bd5690 100644
> > > > > > > > > > > > --- a/fs/ext4/ext4.h
> > > > > > > > > > > > +++ b/fs/ext4/ext4.h
> > > > > > > > > > > > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> > > > > > > > > > > >   	 */
> > > > > > > > > > > >   	struct work_struct s_sb_upd_work;
> > > > > > > > > > > > +	bool s_journal_destorying;
> > > > > > > > > > > > +
> > > > > > > > > > > >   	/* Atomic write unit values in bytes */
> > > > > > > > > > > >   	unsigned int s_awu_min;
> > > > > > > > > > > >   	unsigned int s_awu_max;
> > > > > > > > > > > > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > > > > > > > > > > > index 9b3c9df02a39..6bd3ca84410d 100644
> > > > > > > > > > > > --- a/fs/ext4/ext4_jbd2.h
> > > > > > > > > > > > +++ b/fs/ext4/ext4_jbd2.h
> > > > > > > > > > > > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> > > > > > > > > > > >   {
> > > > > > > > > > > >   	int err = 0;
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * At this point all pending FS updates should be done except a possible
> > > > > > > > > > > > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> > > > > > > > > > > > +	 * is now safe for any new errors to directly commit superblock rather
> > > > > > > > > > > > +	 * than going via journal.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	sbi->s_journal_destorying = true;
> > > > > > > > > > > > +
> > > > > > > > > > > Hi, Ojaswin!
> > > > > > > > > > > 
> > > > > > > > > > > I'm afraid you still need to flush the superblock update work here,
> > > > > > > > > > > otherwise I guess the race condition you mentioned in v1 could still
> > > > > > > > > > > occur.
> > > > > > > > > > > 
> > > > > > > > > > >   ext4_put_super()
> > > > > > > > > > >    flush_work(&sbi->s_sb_upd_work)
> > > > > > > > > > > 
> > > > > > > > > > >                      **kjournald2**
> > > > > > > > > > >                      jbd2_journal_commit_transaction()
> > > > > > > > > > >                      ...
> > > > > > > > > > >                      ext4_inode_error()
> > > > > > > > > > >                        /* JBD2_UNMOUNT not set */
> > > > > > > > > > >                        schedule_work(s_sb_upd_work)
> > > > > > > > > > > 
> > > > > > > > > > >                                    **workqueue**
> > > > > > > > > > >                                     update_super_work
> > > > > > > > > > >                                     /* s_journal_destorying is not set */
> > > > > > > > > > >                              	   if (journal && !s_journal_destorying)
> > > > > > > > > > > 
> > > > > > > > > > >    ext4_journal_destroy()
> > > > > > > > > > >     /* set s_journal_destorying */
> > > > > > > > > > >     sbi->s_journal_destorying = true;
> > > > > > > > > > >     jbd2_journal_destroy()
> > > > > > > > > > >      journal->j_flags |= JBD2_UNMOUNT;
> > > > > > > > > > > 
> > > > > > > > > > >                                         jbd2_journal_start()
> > > > > > > > > > >                                          start_this_handle()
> > > > > > > > > > >                                            BUG_ON(JBD2_UNMOUNT)
> > > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Yi.
> > > > > > > > > > Hi Yi,
> > > > > > > > > > 
> > > > > > > > > > Yes you are right, somehow missed this edge case :(
> > > > > > > > > > 
> > > > > > > > > > Alright then, we have to move out sbi->s_journal_destroying outside the
> > > > > > > > > > helper. Just wondering if I should still let it be in
> > > > > > > > > > ext4_journal_destroy and just add an extra s_journal_destroying = false
> > > > > > > > > > before schedule_work(s_sb_upd_work), because it makes sense.
> > > > > > > > > > 
> > > > > > > > > > Okay let me give it some thought but thanks for pointing this out!
> > > > > > > > > > 
> > > > > > > > > > Regards,
> > > > > > > > > > ojaswin
> > > > > > > > > Okay so thinking about it a bit more, I see you also suggested to flush
> > > > > > > > > the work after marking sbi->s_journal_destroying. But will that solve
> > > > > > > > > it?
> > > > > > > > > 
> > > > > > > > >    ext4_put_super()
> > > > > > > > >     flush_work(&sbi->s_sb_upd_work)
> > > > > > > > >                       **kjournald2**
> > > > > > > > >                       jbd2_journal_commit_transaction()
> > > > > > > > >                       ...
> > > > > > > > >                       ext4_inode_error()
> > > > > > > > >                         /* JBD2_UNMOUNT not set */
> > > > > > > > >                         schedule_work(s_sb_upd_work)
> > > > > > > > >                                      **workqueue**
> > > > > > > > >                                      update_super_work
> > > > > > > > >                                      /* s_journal_destorying is not set */
> > > > > > > > >                               	      if (journal && !s_journal_destorying)
> > > > > > > > >     ext4_journal_destroy()
> > > > > > > > >      /* set s_journal_destorying */
> > > > > > > > >      sbi->s_journal_destorying = true;
> > > > > > > > >      flush_work(&sbi->s_sb_upd_work)
> > > > > > > > >                                        schedule_work()
> > > > > > > >                                          ^^^^^^^^^^^^^^^
> > > > > > > >                                          where does this come from?
> > > > > > > > 
> > > > > > > > After this flush_work, we can guarantee that the running s_sb_upd_work
> > > > > > > > finishes before we set JBD2_UNMOUNT. Additionally, the journal will
> > > > > > > > not commit transaction or call schedule_work() again because it has
> > > > > > > > been aborted due to the previous error. Am I missing something?
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Yi.
> > > > > > > Hmm, so I am thinking of a corner case in ext4_handle_error() where
> > > > > > > 
> > > > > > >   if(journal && !is_journal_destroying)
> > > > > > > 
> > > > > > > is computed but schedule_work() not called yet, which is possible cause
> > > > > > > the cmp followed by jump is not atomic in nature. If the schedule_work
> > > > > > > is only called after we have done the flush then we end up with this:
> > > > > > > 
> > > > > > >                                	      if (journal && !s_journal_destorying)
> > > > > > >      ext4_journal_destroy()
> > > > > > >       /* set s_journal_destorying */
> > > > > > >       sbi->s_journal_destorying = true;
> > > > > > >       flush_work(&sbi->s_sb_upd_work)
> > > > > > >                                         schedule_work()
> > > > > > > 
> > > > > > > Which is possible IMO, although the window is tiny.
> > > > > > Yeah, right!
> > > > > > Sorry for misread the location where you add the "!s_journal_destorying"
> > > > > > check, the graph I provided was in update_super_work(), which was wrong.
> > > > > Oh right, I also misread your trace but yes as discussed, even
> > > > > 
> > > > >      sbi->s_journal_destorying = true;
> > > > > 		flush_work()
> > > > >      jbd2_journal_destroy()
> > > > > 
> > > > > doesn't work.
> > > > > 
> > > > > > The right one should be:
> > > > > > 
> > > > > >   ext4_put_super()
> > > > > >    flush_work(&sbi->s_sb_upd_work)
> > > > > > 
> > > > > >                      **kjournald2**
> > > > > >                      jbd2_journal_commit_transaction()
> > > > > >                      ...
> > > > > >                      ext4_inode_error()
> > > > > >                        /* s_journal_destorying is not set */
> > > > > >                        if (journal && !s_journal_destorying)
> > > > > >                          (schedule_work(s_sb_upd_work))  //can be here
> > > > > > 
> > > > > >    ext4_journal_destroy()
> > > > > >     /* set s_journal_destorying */
> > > > > >     sbi->s_journal_destorying = true;
> > > > > >     jbd2_journal_destroy()
> > > > > >      journal->j_flags |= JBD2_UNMOUNT;
> > > > > > 
> > > > > >                          (schedule_work(s_sb_upd_work))  //also can be here
> > > > > > 
> > > > > >                                    **workqueue**
> > > > > >                                     update_super_work()
> > > > > >                                     journal = sbi->s_journal //get journal
> > > > > >      kfree(journal)
> > > > > >                                       jbd2_journal_start(journal) //journal UAF
> > > > > >                                         start_this_handle()
> > > > > >                                           BUG_ON(JBD2_UNMOUNT) //bugon here
> > > > > > 
> > > > > > 
> > > > > > So there are two problems here, the first one is the 'journal' UAF,
> > > > > > the second one is triggering JBD2_UNMOUNT flag BUGON.
> > > > > Indeed, there's a possible UAF here as well.
> > > > > 
> > > > > > > > > As for the fix, how about we do something like this:
> > > > > > > > > 
> > > > > > > > >    ext4_put_super()
> > > > > > > > > 
> > > > > > > > >     flush_work(&sbi->s_sb_upd_work)
> > > > > > > > >     destroy_workqueue(sbi->rsv_conversion_wq);
> > > > > > > > > 
> > > > > > > > >     ext4_journal_destroy()
> > > > > > > > >      /* set s_journal_destorying */
> > > > > > > > >      sbi->s_journal_destorying = true;
> > > > > > > > > 
> > > > > > > > >     /* trigger a commit and wait for it to complete */
> > > > > > > > > 
> > > > > > > > >      flush_work(&sbi->s_sb_upd_work)
> > > > > > > > > 
> > > > > > > > >      jbd2_journal_destroy()
> > > > > > > > >       journal->j_flags |= JBD2_UNMOUNT;
> > > > > > > > >                                          jbd2_journal_start()
> > > > > > > > >                                           start_this_handle()
> > > > > > > > >                                             BUG_ON(JBD2_UNMOUNT)
> > > > > > > > > 
> > > > > > > > > Still giving this codepath some thought but seems like this might just
> > > > > > > > > be enough to fix the race. Thoughts on this?
> > > > > > > > > 
> > > > > > I think this solution should work, the forced commit and flush_work()
> > > > > > should ensure that the last transaction is committed and that the
> > > > > > potential work is done.
> > > > > > 
> > > > > > Besides, the s_journal_destorying flag is set and check concurrently
> > > > > > now, so we need WRITE_ONCE() and READ_ONCE() for it. Besides, what
> > > > > > about adding a new flag into sbi->s_mount_state instead of adding
> > > > > > new s_journal_destorying?
> > > > > Right, that makes sence. I will incorporate these changes in the next
> > > > > revision.
> > > > > 
> > > > Think about this again, it seems that we no longer need the destroying
> > > > flag. Because we force to commit and wait for the **last** transaction to
> > > > complete, and the flush work should also ensure that the last sb_update
> > > > work to complete. Regardless of whether it starts a new handle in the
> > > > last update_super_work(), it will not commit since the journal should
> > > > have aborted. What are your thoughts?
> > > > 
> > > >   ext4_put_super()
> > > >    flush_work(&sbi->s_sb_upd_work)
> > > >    destroy_workqueue(sbi->rsv_conversion_wq)
> > > > 
> > > >    ext4_journal_destroy()
> > > >     /* trigger a commit (it will commit the last trnasaction) */
> > > > 
> > > >                      **kjournald2**
> > > >                      jbd2_journal_commit_transaction()
> > > >                      ...
> > > >                       ext4_inode_error()
> > > >                        schedule_work(s_sb_upd_work))
> > > > 
> > > >                                       **workqueue**
> > > >                                        update_super_work()
> > > >                                          jbd2_journal_start(journal)
> > > >                                            start_this_handle()
> > > >                                            //This new trans will
> > > >                                            //not be committed.
> > > > 
> > > >                       jbd2_journal_abort()
> > > > 
> > > >     /* wait for it to complete */
> > > > 
> > > >     flush_work(&sbi->s_sb_upd_work)
> > > >     jbd2_journal_destroy()
> > > >      journal->j_flags |= JBD2_UNMOUNT;
> > > >     jbd2_journal_commit_transaction() //it will commit nothing
> > > > 
> > > > Thanks,
> > > > Yi.
> > > Hi Yi,
> > > 
> > > There's one more path for which we need the flag:
> > > 
> > >     ext4_journal_destroy()
> > >      /* trigger a commit (it will commit the last trnasaction) */
> > >                       **kjournald2**
> > >                       jbd2_journal_commit_transaction()
> > > 										 	journal->j_commit_callback()
> > > 											  ext4_journal_commit_callback()
> > > 												  ext4_maybe_update_superblock()
> > > 													  schedule_work()
> > > 			/* start a transaction here */
> > > 			flush_work()
> > > 			  jbd2_journal_destroy()
> > > 				  journal_kill_thread
> > > 					  flags |= JBD2_UNMOUNT
> > > 				  jbd2_journal_commit_transaction()
> > > 					  ...
> > >              ext4_inode_error()
> > > 							schedule_work(s_sb_upd_work))
> > > 							/* update_super_work_tries to start the txn */
> > > 							BUG_ON()
> > Oops the formatting is wrong, here's the trace:
> > 
> >   ext4_journal_destroy()
> >      /* trigger a commit (it will commit the last trnasaction) */
> > 
> >                     **kjournald2**
> >                     jbd2_journal_commit_transaction()
> >                      journal->j_commit_callback()
> >                        ext4_journal_commit_callback()
> >                          ext4_maybe_update_superblock()
> >                            schedule_work()
> At this point, SB_ACTIVE should have been cleared,
> so ext4_maybe_update_superblock() should do nothing.
> 
> With this in mind, it could be the case that an
> additional flag is no longer needed.

Yes got it now, all the backtraces are confusing me haha

Alright then, I feel we can take 2 approaches now. 

- Without the flag, (flushing sb update wq 2 times):

This approach looks like how Yi has described here [1] however
this relies on the fact that the last update_super_work is only
called in journal is aborted and hence will never start a txn.

This is possible because we flush the sb 2 times:

  ext4_put_super()
    flush_work(s_sb_upd_work) // 1st flush, clears all pending updates
    ext4_journal_destroy
      /* commit & wait for txn */
      flush_work(s_sb_upd_work) // 2nd flush, only has work if journal is aborted */

The first flush flushes all pending updates and 2nd one is only invoked
when the journal commit faces an error and hence never starts a new
txn. Thus everything works.

[1] https://lore.kernel.org/all/cover.1741270780.git.ojaswin@linux.ibm.com/T/#m3de5dcae6afa979d01281f64b0c088131e72fc92

- With the flag. (single sb flush).

This is an alternate approach where we remove the flush_work() from
ext4_put_super() and only keep 1 in ext4_journal_destroy(). With this
we need to explicitly rely on a sbi/mount flag because the flush can
actually start a txn. WITHOUT the flag we can run into this:

                         **kjournald2**
                         jbd2_journal_commit_transaction()
                          journal->j_commit_callback()
                            ext4_journal_commit_callback()
                              ext4_maybe_update_superblock()
                                schedule_work()

  ext4_put_super()
    ext4_journal_destroy
      /* commit & wait for txn */
      flush_work(s_sb_upd_work) // This will have sb updates even if journal not aborted
        /* update_super_work starts a txn */
      jbd2_destroy_journal
        flags |= JBD2_UNMOUNT
        jbd2_journal_commit_transaction
          /* error */
          ext4_handle_error
            scheduled_work()
              /*update super work hits BUG_ON */

Hence the flag is needed in this approach.

I actually prefer the 2nd approach with the flag because it seems easier
to maintain in the long run than relying on the fragile
flush-commit-flush sequence, which might get silently broken as new code
is added.

I hope I didn't miss something this time. Thoughts? :) 

Regards,
ojaswin
> 
> 
> Regards,
> Baokun
> > 
> >      /* update_super_work starts a new txn here */
> >      flush_work()
> >      jbd2_journal_destroy()
> >        journal_kill_thread
> >          flags |= JBD2_UNMOUNT
> >        jbd2_journal_commit_transaction()
> >          ...
> >          ext4_inode_error()
> >            schedule_work(s_sb_upd_work))
> >            /* update_super_work_tries to start the txn */
> >            BUG_ON()
> > 
> > > I think this to protect against this path we do need a flag.
> > > 
> > > Regards,
> > > ojaswin
> 
> 

