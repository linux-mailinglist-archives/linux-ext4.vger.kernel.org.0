Return-Path: <linux-ext4+bounces-12916-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BAD2C08D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 06:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E531030139B5
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE134320A;
	Fri, 16 Jan 2026 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tro5ZM12"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6422CBE6;
	Fri, 16 Jan 2026 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541867; cv=none; b=fmShOw8jHXJRy3GXJbJPqEYGSZzrHxh7CON3Hno+VDFvtqsik05QDE83rQKOHgD7i0WjbuNOL7AO2M+t4xDVQUR4difxGdXjLqQ2pYNuPowrSnHHw5XBKaVez/GMohcbOasRZJz9l4GUhsPQ2ITyA29PyexIBQhTcBm4EbD+2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541867; c=relaxed/simple;
	bh=+FWWdPB9Mw8cHEHvrnrSNEhjhaS1eJAf0SLivLfEWrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfGid0WOQl4l9jpA+0DjaBB6DydfuqVjSzsBx7cFttoB/v5FA7SbrVOKuQQ3aLuWB7Fa2C0eC/2zqP0LcqXLKu9O9KeXqEkGVzLw+iHI2RtVelAc6PwPE0IGlG8G3Jd6OPdGV+TETdH+fzgCM+bPsj7lVOJ6Qah7yM73/3rnoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tro5ZM12; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMtGEf013457;
	Fri, 16 Jan 2026 05:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=reULewHPbFdjt2J135jArvaXxFS2TB
	tfhMP7AT2GDZ4=; b=Tro5ZM12cDYhG16JW/Q5dxK+G06HAOh8BAjyvlfx6C3o6Q
	id3JZCNCWl4V37d4jyJSf01o03WK9QHhy7yh1baDUy6az4SYnMY2WwvmhW5s3nK1
	23xxmhsDmhdp9N095YVgkSqMi+dylKWEI+yuXBVtPDL4Sf2kj4pdFvb/W50k/PjW
	kwiYA6QR8M1QwP2/2JZedTJCbiLlUDhMJ2gA69pw85EOGTaNvPgwmuC1Cv8t5aD/
	PZBn08Pzf7k2wqk8kZll33afy8nNJfd4PDHl2cbh6ZQ6n8Kbneq1fpBkR1BMboRg
	yczVDqBSdSpo2EiJEfG6rOCePRDdVXyjv6PPOxfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:37:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60G5WehE018660;
	Fri, 16 Jan 2026 05:37:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:37:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60G4WkoP025566;
	Fri, 16 Jan 2026 05:37:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23nm9as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:37:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60G5bUKL32375104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 05:37:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71EB120043;
	Fri, 16 Jan 2026 05:37:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278A720040;
	Fri, 16 Jan 2026 05:37:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Jan 2026 05:37:27 +0000 (GMT)
Date: Fri, 16 Jan 2026 11:06:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] ext4: kunit tests for extent splitting and
 conversion
Message-ID: <aWnOZdOqDTFc8ZlV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <da910e221a92a16601654ced8df50348bdff6f31.1768402426.git.ojaswin@linux.ibm.com>
 <735xahhes7x62f2yuhpfgoojerfclo2kdwf5d7h2lgxtuq57ew@jt4ijbxfpocq>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <735xahhes7x62f2yuhpfgoojerfclo2kdwf5d7h2lgxtuq57ew@jt4ijbxfpocq>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KvJAGGWN c=1 sm=1 tr=0 ts=6969ce9d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=8MwYaPzByeExMCzXzX8A:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0MSBTYWx0ZWRfX2xQ3R7/GxQ57
 sO+Bi5dxl9hKPNKfLdUk6p1C62hduE0fqpjizIU9/mt9bI32xp/+CuM7XPtdcC31AhwI2iBb7ss
 ZFg9aNWF0pgGaW8iCzn+2ISIVt+uNVI8bOW3cZEtp0RWyLNwMbMM7CF1NfjRuF5E3dW2eSQeTJq
 K5txgyOFBOt/r9vzFhuQIR4PrUg67u8bqUYJ2Pkp8d/5gWHAQVRLxqS0y75u8hM23o82VuaZAc1
 u6z4TuKz3kYgMUKS4/8dGkMTjCVBGcU7xUwy3TskUUxqndp4VfG2w9ZSBQ9mrNLYtCU4tk1dcbU
 twLMaX5HfzFVwWrQFb60yemc85UjmazdLIbipqxIRK9+l2sw+ZtTMdrx+/BrZNKg6M/oXud2ytV
 GmzP7X6iBLUYPxcA+Mw3cpxy8IhK1y8idaRSjnw7HP2kV58D9qqTM8SiPHmN7Sg5N6mR0ihMC7x
 AuTjordxM3EW9+Aei7Q==
X-Proofpoint-GUID: L1eaGT-v6_6WJqQ4MKAIssxHJPGQWSvg
X-Proofpoint-ORIG-GUID: obDdbPkH48nAXO-cFp-ZMHpRj_BiLxeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160041

On Thu, Jan 15, 2026 at 11:20:25AM +0100, Jan Kara wrote:
> On Wed 14-01-26 20:27:45, Ojaswin Mujoo wrote:
> > Add multiple KUnit tests to test various permutations of extent
> > splitting and conversion.
> > 
> > We test the following cases:
> > 
> > 1. Split of unwritten extent into 2 parts and convert 1 part to written
> > 2. Split of unwritten extent into 3 parts and convert 1 part to written
> > 3. Split of written extent into 2 parts and convert 1 part to unwritten
> > 4. Split of written extent into 3 parts and convert 1 part to unwritten
> > 5. Zeroout fallback for all the above cases except 3-4 because zeroout
> >    is not supported for written to unwritten splits
> > 
> > The main function we test here is ext4_split_convert_extents().
> > Currently some of the tests are failing due to issues in implementation.
> > All failures are mitigated at other layers in ext4 [1] but still point
> > out the mismatch in expectation of what the caller wants vs what the
> > function does.
> > 
> > The aim is to eventually fix all the failures we see here. More detailed
> > implementation notes can be found in the topmost commit in the test file.
> > 
> > [1] for example, EXT4_GET_BLOCKS_CONVERT doesn't
> > really convert the split extent to written, but rather the callers end up
> > doing the conversion.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Overall this looks good to me so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Couple nits below:
> 
> > +static void test_split_convert(struct kunit *test)
> > +{
> > +	struct ext4_ext_path *path;
> > +	struct inode *inode = &k_ctx.k_ei->vfs_inode;
> > +	struct ext4_extent *ex;
> > +	struct ext4_map_blocks map;
> > +	const struct kunit_ext_test_param *param =
> > +		(const struct kunit_ext_test_param *)(test->param_value);
> > +	int blkbits = inode->i_sb->s_blocksize_bits;
> > +
> > +	if (param->is_zeroout_test)
> > +		/*
> > +		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
> > +		 */
> > +		kunit_activate_static_stub(test, ext4_ext_insert_extent,
> > +					   ext4_ext_insert_extent_stub);
> > +
> > +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> > +	ex = path->p_ext;
> > +	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
> > +	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
> 
> Shouldn't we use EX_DATA_LBLK and other constants instead for numbers?
> 
> ...
> 
> > +static const struct kunit_ext_test_param test_split_convert_params[] = {
> > +	/* unwrit to writ splits */
> > +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> > +	  .nr_exp_ext = 2,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> > +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> > +	  .is_zeroout_test = 0 },
> > +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> > +	  .nr_exp_ext = 2,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> > +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 0 },
> > +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> > +	  .nr_exp_ext = 3,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> > +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> > +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> > +	  .is_zeroout_test = 0 },
> > +
> > +	/* writ to unwrit splits */
> > +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> > +	  .is_unwrit_at_start = 0,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> > +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> > +	  .nr_exp_ext = 2,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> > +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 0 },
> > +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> > +	  .is_unwrit_at_start = 0,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> > +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> > +	  .nr_exp_ext = 2,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> > +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> > +	  .is_zeroout_test = 0 },
> > +	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> > +	  .is_unwrit_at_start = 0,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> > +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> > +	  .nr_exp_ext = 3,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> > +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
> > +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 0 },
> > +
> > +	/*
> > +	 * ***** zeroout tests *****
> > +	 */
> > +	/* unwrit to writ splits */
> > +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> > +	  .nr_exp_ext = 1,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 1,
> > +	  .nr_exp_data_segs = 2,
> > +	  /* 1 block of data followed by 2 blocks of zeroes */
> > +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> > +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> > +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> > +	  .nr_exp_ext = 1,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 1,
> > +	  .nr_exp_data_segs = 2,
> > +	  /* 1 block of zeroes followed by 2 blocks of data */
> > +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> > +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
> > +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
> > +	  .is_unwrit_at_start = 1,
> > +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> > +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> > +	  .nr_exp_ext = 1,
> > +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> > +	  .is_zeroout_test = 1,
> > +	  .nr_exp_data_segs = 3,
> > +	  /* [zeroes] [data] [zeroes] */
> > +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> > +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
> > +			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
> > +
> > +};
> 
> Also in these definitions of split_map and exp_ext_state I think it would be
> cleaner to use EX_DATA_LBLK and EX_DATA_LEN...

Got it, will make the change. Thanks for the review.

Regards,
ojaswin

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

