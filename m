Return-Path: <linux-ext4+bounces-7003-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50BA743B6
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 07:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D7E3B1EB8
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469321129A;
	Fri, 28 Mar 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dK1gfwdT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753311B042F;
	Fri, 28 Mar 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743142371; cv=none; b=Fd+/+xnN3UkBqkdZlFBsh9iDMBoZImgYztziFSaeWR7PcQ5zvFZ7cPUTP7uJqGMvLlxapM079Cml/Z7JesUuumP0VS0596XQJCiTs627XqfJgJ5tgbDyApLZTdvH8ZQDC3kGyJkP4nsUD7Dvkx02AiBwRs5Yjlw8I7d8T7RtqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743142371; c=relaxed/simple;
	bh=ML/XOyq+k4NXlEgpE7lhlgVlKFCzoc+adbIbGtPVlQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVMVBMKxMyagqmDd6uTrwcL28E1FYx7ixtL+TW/X+ChCwk2j/BBEYIXsdfm3T7JBKJBxy+SBYBE976wLj88Zt4FQ6gw4vFyaMmIj3n6Q9OrfoIPtrxB28A4PdcXrptev6NqlDbXX5AE23oeJb01Ih+dVzNvlHmBivGqu6+ZtCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dK1gfwdT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S49Wdb001569;
	Fri, 28 Mar 2025 06:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Txi0Yz8axLjjoekIbViYXr/aOQbGlb
	iRWafPypI0nJU=; b=dK1gfwdT0xr71w6EMVRhynp/SD+4zRJdztFnSiFoZBQavr
	qfs7eKMU89NqJxm6lUoQvXF4Ah619OfXAXb5KK5VK4uq5NUkroiSc9PglTofcT6H
	n4GQFo+ZMef+VIzwg03ghIByZkAd5q9n+W/D0lw2+CsAmIwtcB3wEXpSA9q2ytEG
	n3GUo2CD1RabmIfS/YKwY6XL1J9muZKpGIPQRLVukVQSL/SlHD4JZUN5syAarEuw
	Wp89ImjqEOrxKeIRaXCFdjVhNDPQZsvZqpxLMDBNMlpcfo0bvQYTnAawqJ43l5FT
	0HAzT4mmOhbJ8PjCs8ar0PyMrXKeyQvSuX7MMpng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45naux325s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:12:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52S6CZld020786;
	Fri, 28 Mar 2025 06:12:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45naux325p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:12:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5UZOi005838;
	Fri, 28 Mar 2025 06:12:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82rsu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:12:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52S6CXrE39059826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 06:12:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46DF420043;
	Fri, 28 Mar 2025 06:12:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B6020040;
	Fri, 28 Mar 2025 06:12:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.221])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 06:12:31 +0000 (GMT)
Date: Fri, 28 Mar 2025 11:42:28 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Make block validity check resistent to sb bh
 corruption
Message-ID: <Z-Y9zO0GnMVLDdUJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
 <4pgphzbzkwdkr5dwjhignsvbhwspavmz7ursalyy5nv7gjmztw@ebzz3sjiqxg4>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4pgphzbzkwdkr5dwjhignsvbhwspavmz7ursalyy5nv7gjmztw@ebzz3sjiqxg4>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yVrm9dP6VptoFt-15UKKzLWDX0OyWLyY
X-Proofpoint-ORIG-GUID: 0NHXdvfP-hDo_SBdlDtjt9lamS9jYcou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280039

On Thu, Mar 27, 2025 at 07:25:30PM +0100, Jan Kara wrote:
> On Thu 27-03-25 23:18:09, Ojaswin Mujoo wrote:
> > Block validity checks need to be skipped in case they are called
> > for journal blocks since they are part of system's protected
> > zone.
> > 
> > Currently, this is done by checking inode->ino against
> > sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
> > buffer head. If someone modifies this underneath us then the
> > s_journal_inum field might get corrupted. To prevent against this,
> > change the check to directly compare the inode with journal->j_inode.
> > 
> > **Slight change in behavior**: During journal init path,
> > check_block_validity etc might be called for journal inode when
> > sbi->s_journal is not set yet. In this case we now proceed with
> > ext4_inode_block_valid() instead of returning early. Since systems zones
> > have not been set yet, it is okay to proceed so we can perform basic
> > checks on the blocks.
> > 
> > Suggested-by: Baokun Li <libaokun1@huawei.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> One style nit below:
> 
> > diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> > index 87ee3a17bd29..e8c5525afc67 100644
> > --- a/fs/ext4/block_validity.c
> > +++ b/fs/ext4/block_validity.c
> > @@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
> >  {
> >  	__le32 *bref = p;
> >  	unsigned int blk;
> > +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> >  
> > -	if (ext4_has_feature_journal(inode->i_sb) &&
> > -	    (inode->i_ino ==
> > -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> > +	if (journal && inode == journal->j_inode)
> >  		return 0;
> >  
> >  	while (bref < p+max) {
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 365d31004bd0..8b048be14008 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
> >  				unsigned int line,
> >  				struct ext4_map_blocks *map)
> >  {
> > -	if (ext4_has_feature_journal(inode->i_sb) &&
> > -	    (inode->i_ino ==
> > -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> > -		return 0;
> > +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> > +
> > +	if (journal && inode == journal->j_inode)
> > +			return 0;
> 
> Bogus indentation here.

Thanks for the review Jan and for catching this. My bad, i missed
running checkpatch on this and somehow this looked okay in vim.

I'll fix this and quickly send a v3.

Regards,
ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

