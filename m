Return-Path: <linux-ext4+bounces-9854-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F49B4A28A
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 08:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC934472AC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FA30496C;
	Tue,  9 Sep 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ayS5u/WY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674E303A24;
	Tue,  9 Sep 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400291; cv=none; b=qIBQoPUarSY3pn8L+BaABpDDWRt30SRpfGqYWXTTXTdZzzzU9xzZrxpTwMg4vFKv09uAc6jVjD1ficUmlZDepdZgKraeKxp794Dnv8q82YbcL/XkXOejEljGktYgb2+HGj8F60+jg+bMj4QL0ur7hTyrgOXsioQI/D5EyxoD+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400291; c=relaxed/simple;
	bh=BDKycTUwTBeKQKRluCkT3DPIymY/FMY43y7sb2PDs88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdIQfUORBcISiuQg26bMicC/CwqL8g9z7wpnFToMyfmiE1VqYh2q6ebf0fMi6jE8OJir917xytt0ZC4dOdeFiFDRz5F6PydNzghHkF3eUa+7P7m0Apc2hqNL4/MGY+FCdCwYjE69P0dNns5zfOMezHtui4CR/Ylv5KbUTrNKyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ayS5u/WY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5894WgNp018625;
	Tue, 9 Sep 2025 06:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uBLjCOwnHU964fvJBI7vvKbJb0b/nT
	LHEbtejXkxQzk=; b=ayS5u/WYEiqpPCx+4e4Wv7QzcKztqXyS0dm8jZfMLx3RVs
	4mDp2hXul02JCk4baAa6E9yhekPJeziWb+K1A5cOJgNXH265oxpAnLJiWWrKzn+5
	ngc0gPIWJl2DmgvZvjDTksRfI8oS8ruCtUqbfpiHprFcaYJ/A4ZcIzmCoY6PLPbk
	3apq9wAxB2G1JFmaPAQoe2HB3G/ETmMBfIrGot37KAFo4avDbFdHEGMGcV8SaBP+
	dzj7MU4g8VzYl6tE/ObZJU/hKzngL8B2niKDegNhV6p6GcQ5sXmaUI3vGRywdz+w
	Jx3g86Aih5QN4/uDRRhna+Oa2Bja6pBFiXcLtxhA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqwvy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:44:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5896hWE0020389;
	Tue, 9 Sep 2025 06:44:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqwvxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:44:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5895FeT5011447;
	Tue, 9 Sep 2025 06:44:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9u9x8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:44:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896ic5d20906318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:44:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55EC72004B;
	Tue,  9 Sep 2025 06:44:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C22DE20043;
	Tue,  9 Sep 2025 06:44:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 06:44:35 +0000 (GMT)
Date: Tue, 9 Sep 2025 12:14:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aL_M0X9Ca8LgTIR1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
 <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hlJNVGE8zaucDNy5To4XIVb1Ahby6_-n
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bfccd9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=PEgcr33_ple8PDClfvMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ze8yp7tACzv9G3BeG3yV5h3TO4P0_Pb0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX52wRCosIwHJV
 nlxFtNoqq7hN2gOo5dmtR/Slkf0BzYr1fqmcT3VZWCXT3URjafd14iGDp+NMDZFie0CAnmWr4ZH
 i0aN41d3veSfBMmFHb2yIIcps7LMgIEN+RfFVGX7Lhg+iDtFUqZHn/Um4I6M7R9ZrxttOMLsXo4
 qX6X8z1GeJXmvTuvALrhnksSb2YSFfKiFfrBIxV1RryY/Am8Zv6fwdzUREVJKQ9H6EFWi2peXWW
 dqqzW3HZDsNNKYK7UUoQvRmJ98dzvioWXfhVUl5hX2eWP/ThsdtPJ4yOMrXqZSkU9/uEilBpL0N
 SY+UG4YO/xNGxzfImakGN7QAWfTg0fEG09MXXYiafe32atDr4ILTvusaLCWcwKSLvEWmtEOptKf
 SidT8eaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 03:27:57PM +0100, John Garry wrote:
> On 05/09/2025 18:06, Ojaswin Mujoo wrote:
> > On Tue, Sep 02, 2025 at 04:49:26PM +0100, John Garry wrote:
> > > On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > > > ---
> > > >    tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
> > > >    tests/generic/1230.out |   2 +
> > > >    2 files changed, 399 insertions(+)
> > > >    create mode 100755 tests/generic/1230
> > > >    create mode 100644 tests/generic/1230.out
> > > > 

<...>

> > > > +
> > > > +	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> > > > +	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
> > > > +
> > > > +	filesize=$((bytes_written * 3))
> > > > +	echo "# Setting \$filesize=$filesize" >> $seqres.full
> > > > +
> > > > +	rm $tmp.aw
> > > > +	sleep 0.5
> > > > +
> > > > +	_scratch_cycle_mount
> > > > +
> > > > +}
> > > > +
> > > > +create_mixed_mappings() {
> > > 
> > > Is this same as patch 08/12?
> > 
> > I believe you mean the [D]SYNC tests, yes it is the same.
> 
> then maybe factor out the test, if possible. I assume that this sort of
> approach is taken for xfstests.
> 

I'm not sure what you mean by factor out the *test*. We are testing
different things there and the only thing common in the tests is
creation of mixed mapping files and the check to ensure we didn't tear
data.

In case you mean to factor out the create_mixed_mappings() helper into
common/rc, sure I can do that but I'm unsure if at this point it would
be very useful for other tests.

> > 
> > > 
> > > > +	local file=$1
> > > > +	local size_bytes=$2
> > > > +
> > > > +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> > > > +	#Fill the file with alternate written and unwritten blocks
> > > > +	local off=0
> > > > +	local operations=("W" "U")
> > > > +
> > > > +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > > > +		index=$(($i % ${#operations[@]}))
> > > > +		map="${operations[$index]}"
> > > > +

<...>

> > > > +# Loop 20 times to shake out any races due to shutdown
> > > > +for ((iter=0; iter<20; iter++))
> > > > +do
> > > > +	echo >> $seqres.full
> > > > +	echo "------ Iteration $iter ------" >> $seqres.full
> > > > +
> > > > +	echo >> $seqres.full
> > > > +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
> > > > +	test_data_integrity_mixed
> > > > +
> > > > +	echo >> $seqres.full
> > > > +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
> > > > +	test_data_integrity_writ
> > > > +
> > > > +	echo >> $seqres.full
> > > > +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
> > > > +	test_data_integrity_unwrit
> > > > +
> > > > +	echo >> $seqres.full
> > > > +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
> > > > +	test_data_integrity_hole
> > > > +
> > > > +	echo >> $seqres.full
> > > > +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> > > 
> > > what does "Starting filesize integrity test" mean?
> > 
> > Basically other tests already truncate the file to a higher value and
> > then perform the shut down test. Here we actually do append atomic
> > writes since we want to also stress the i_size update paths during
> > shutdown to ensure that doesn't cause any tearing with atomic writes.
> > 
> > I can maybe rename it to:
> > 
> > 
> > echo "# Starting data integrity test for atomic append writes" >> $seqres.full
> > 
> > Thanks for the review!
> > 
> 
> It's just the name "integrity" that throws me a bit..

So I mean integrity as in writes are not tearing after the shutdown.
That's how we have worded the other sub-tests above.

Regards,
ojaswin

