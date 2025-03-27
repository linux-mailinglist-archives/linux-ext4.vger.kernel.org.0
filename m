Return-Path: <linux-ext4+bounces-6989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67215A72A21
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 07:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8701764FF
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F161A23BB;
	Thu, 27 Mar 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kZ5KnYMX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5C17E4;
	Thu, 27 Mar 2025 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743056746; cv=none; b=CXHcMuS/kpm2V/RckEg7dLtavxPRTWtxYx/ah7nhXpHiz5WuttxK+rKsAHA5g0OH9B8IH0N/rPnJ0aA0QHw2SpV5QWy5Uv3nBDnnCz5eW+ooZnmNOSYn1EUADb+lM2jWS3ia2Nr0VLsy4YMmvtT2Vd/lQlSeH3WwXqZDYmrHEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743056746; c=relaxed/simple;
	bh=KZO3N2Uvz9Ghe078oOPi0HpqkHRzzDXT24t0z/RgMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz3WglPxfCmcoO+iAwuNI+5QEr8WDWgM2zZLNIRapTO+ly0A73yVja6H57eRuWptxK6ldaLAIreQ/hmTCldMqzAFu93txju3/0ienRehatkLwunDBnAF0Ul1dhyssXmmRl01IVQSv68+En7ssxAADZ5bremlrmBzeiISaIuOmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZ5KnYMX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R05fAM007904;
	Thu, 27 Mar 2025 06:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fx4Aur
	AKfAxISiwTJPeB4MF4GFDgRSevxngPfSG6gIg=; b=kZ5KnYMXCFNvgakka2JaK+
	5WQbW+ir0NpSByAeJvHEf4FEtMyGJ5ojwzSumjf9Hu6hnIfSZb6Iz+T9gzPL6ZNR
	MazupmXGcNPOYguJ8iMqjhNAGUP9m/mi1Q6a+6peQ8KcWTVwBNn26+ApdDTpS7TD
	OkMAClu9nKhqQJUOIbpf20FUtJn58vtfdavWFByh+RdjhutrWKyUf1hECqT5dDeV
	I1bP4ZMgb1sdZtwjIc1dqkG8vdbIW9/pE7YIuV/t1F7TSEZSKcaRWDfgyg1pUCi+
	rxiMSi+pc1eRhLzHRw8+3Pf8jamZF9fdZbVgb+v40E6P0/eo2BIO2XANSaoAAOqA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mk0qc67j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 06:20:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52R69JZB002965;
	Thu, 27 Mar 2025 06:20:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mk0qc67e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 06:20:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52R1gJV2025455;
	Thu, 27 Mar 2025 06:20:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0c792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 06:20:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52R6KG3K60227976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 06:20:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2E7020043;
	Thu, 27 Mar 2025 06:20:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F42920040;
	Thu, 27 Mar 2025 06:20:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Mar 2025 06:20:13 +0000 (GMT)
Date: Thu, 27 Mar 2025 11:50:11 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Message-ID: <Z-TuGxHT5gzXhCU-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
 <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
 <be35b86c-1e64-4593-8f68-fbd1f6b61eef@huawei.com>
 <Z-OhNOVEcQNkYc18@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <68b490b1-2c48-46e4-aa8a-a74f3547e063@huaweicloud.com>
 <74139de7-4194-46b9-aeea-702bdd5b432a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74139de7-4194-46b9-aeea-702bdd5b432a@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NbA9HwnFvE6RwPrrhQsT5j3uafhdLVuX
X-Proofpoint-ORIG-GUID: gT4X3LUG8jGMteyshBaEfqgNediDZR2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270037

On Wed, Mar 26, 2025 at 05:26:19PM +0800, Baokun Li wrote:
> On 2025/3/26 16:33, Zhang Yi wrote:
> > On 2025/3/26 14:39, Ojaswin Mujoo wrote:
> > > On Wed, Mar 26, 2025 at 12:01:45PM +0800, Zhang Yi wrote:
> > > > On 2025/3/26 10:16, Baokun Li wrote:
> > > > > On 2025/3/26 1:57, Ojaswin Mujoo wrote:
> > > > > > On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
> > > > > > > On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
> > > > > > > > > So this is something we need to do if the journal is actived, and if
> > > > > > > > > it's active, then sbi->s_journal will be non-NULL, and so we can just
> > > > > > > > > check to see if inode == sbi->s_journal instead.  This will simplify
> > > > > > > > I believe you mean inode == sbi->s_journal->j_inode here right?
> > > > > > > Yes, that's what I meant; sorry for the not catching this before I
> > > > > > > sent my reply.
> > > > > > > 
> > > > > > > Cheers,
> > > > > > > 
> > > > > > >                      - Ted
> > > > > > Hi Ted, Baokun,
> > > > > > 
> > > > > > I got some time to revisit this. Seems like checking against
> > > > > > s_journal->j_inode is not enough. This is because both
> > > > > > ext4_check_blockref() and check_block_validity() can be called even
> > > > > > before journal->j_inode is set:
> > > > > > 
> > > > > > ext4_open_inode_journal
> > > > > >     ext4_get_journal_inode
> > > > > >        __ext4_iget
> > > > > >            ext4_ind_check_inode
> > > > > >                ext4_check_blockref  /* j_inode not set */
> > > > > > 
> > > > > >     journal = jbd2_journal_init_inode
> > > > > >        bmap
> > > > > >            ext4_bmap
> > > > > >               iomap_bmap
> > > > > >                 ext4_iomap_begin
> > > > > >                     ext4_map_blocks
> > > > > >                         check_block_validity
> > > > > > 
> > > > > >     journal->j_inode = inode
> > > > > > 
> > > > > > 
> > > > > > Now, I think in this case the best solution might be to use the extra
> > > > > > field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
> > > > > > sufficiently early.
> > > > > > 
> > > > > > Thoughts?
> > > > > Because system zone setup happens after the journal are loaded, I think we
> > > > > can skip the check if the journal haven't been loaded yet, like this:
> > > > > 
> > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > index d04d8a7f12e7..38dc72ff7e78 100644
> > > > > --- a/fs/ext4/inode.c
> > > > > +++ b/fs/ext4/inode.c
> > > > > @@ -383,9 +383,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
> > > > >                                  unsigned int line,
> > > > >                                  struct ext4_map_blocks *map)
> > > > >   {
> > > > > +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> > > > > +
> > > > >          if (ext4_has_feature_journal(inode->i_sb) &&
> > > > > -           (inode->i_ino ==
> > > > > - le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> > > > > +           (!journal || inode == journal->j_inode))
> > > > >                  return 0;
> > > > >          if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
> > > > >                  ext4_error_inode(inode, func, line, map->m_pblk,
> > > > > 
> > > > > If any part of the journal area overlaps with the system zone, we'll catch
> > > > > it when we add the journal area to the system zone later.
> > > > > 
> > > > > 
> > > > Since the creation of the system zone relies on the journal being
> > > > loaded, I think there is no risk in proceeding to call
> > > > ext4_inode_block_valid() to perform a basic block range check for
> > > > the journal inode, or even better.
> Indeed, performing some basic anomaly checks in advance can prevent
> journal replay from worsening the situation in abnormal cases. Moreover,
> since s_journal is NULL at this point, we won't schedule s_sb_upd_work
> even if the check fails, which is safe.
> > > > 
> > > > Thanks,
> > > > Yi.
> > > Got it Yi, makes sense to me. So I believe you are suggesting something
> > > like:
> > > 
> > > @@ -384,9 +384,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
> > >                                  unsigned int line,
> > >                                  struct ext4_map_blocks *map)
> > >   {
> > > +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> > > +
> > >          if (ext4_has_feature_journal(inode->i_sb) &&
> > We are going to check ->s_journal, so I suppose we could drop this
> > feature check as well. Others looks good to me.
> Seconded.
> > 
> > > -           (inode->i_ino ==
> > > -            le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> > > +           (journal && journal->j_inode == inode))
> > >                  return 0;
> > >          if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
> > >                  ext4_error_inode(inode, func, line, map->m_pblk,
> > > 
> > > So that even if it is a journal inode we can go ahead and perform some basic checks
> > > as the system zone rbtree will anyways be NULL at this point. From a cursory look,
> > > it seems that __ext4_iget(..., journal_inode) -> ext4_ext_check_inode() already relies
> > > on the fact that system zone is NULL, so we should be okay here as well.
> > Yeah, that's right. :)
> > 
> > Cheers,
> > Yi.
> > 
> > > If this looks good, I'll send a v2 with the suggested changes.
> > > 
> > > Thanks,
> > > ojaswin
> 
> Please mention in the commit message that we're now doing some basic
> checks on the journal area.
> 
> 
> Cheers,
> Baokun

Got it, I'll send a v2 with the changes. Thanks Baokun, Yi

Regards,
ojaswin
> 

