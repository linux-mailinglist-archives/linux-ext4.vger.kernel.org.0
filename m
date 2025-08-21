Return-Path: <linux-ext4+bounces-9495-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90429B2F574
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7051CC2EC3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4D3054E6;
	Thu, 21 Aug 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zzu56/8X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FC20D4E9;
	Thu, 21 Aug 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772564; cv=none; b=VaQpUXJvVQO012vrdrKV4+c1aJyX3E9PKb7iHxgHfQBg/ei8z1Si9DZ1Zh28c/s6zkfVpfEIiZnQdHNSLP3iIo4kk8G1KzGGnJpFzbHTQ4b5TY2z3wbY3NmfXJW5XafmQP+iBcCnRihHCvNFfXKM+yQAQYTyGkwvVjLXEE2pHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772564; c=relaxed/simple;
	bh=3eiXtDFL+TiNhIYNwcA17FNhl8ql+o1EmOT6uDEdQhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkNPXJihFMDa/RRts+XRDP9EHhkoLOpdhJ9YiGvZyAJZnxrOuQyjBG6nZpIRL6+n0dvX57uc+7P8yz6q+hp7qNBSUI5zFK5TWV30iRK2fhO6uAUInZftojYYVcp3+R6viiBaoLZEXSk3snsICSB5sDzZEUkA4aeXS0bhtwSyobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zzu56/8X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6WhGX007291;
	Thu, 21 Aug 2025 10:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p/B2y/2toKUTDV+0i8ur2afBFLuK9+
	7m6jozN7zkskE=; b=Zzu56/8Xd7rWEycqLXBrmMmsiSvR1Z9OP1rlzvoX1r39ou
	P7XS2SMvf6bjXL5odogK/6+hhBVL/M9sThHYV6TAhAFHvde9AaxeY/TZH6ofEmwO
	jAMi9Sb847mjGpaMo3vBNsOcaaQvybBumZ4plNRQdNN92tEmjSuDQ83Mw0T15BZ5
	O17KesFhcz+jYQSTk4tAfBpaO4VLLyj/zzr8XtckXr8dtCszqmKmVNtZDcDB2CAf
	A6n24rSF7NajU73bHz28rHBDCXIFTGWSFAIbNX/TDaa/mvHQ84HGCT9v1N2beJvp
	rzQlO+eNk5btLgXWDLT1CjK5yz1s/CKAghhy4xsQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w0092-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:35:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LAJHK4006441;
	Thu, 21 Aug 2025 10:35:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w008y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:35:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6pSOj024786;
	Thu, 21 Aug 2025 10:35:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5vyupd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:35:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAZmAN41812236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:35:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66C220043;
	Thu, 21 Aug 2025 10:35:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D16D20040;
	Thu, 21 Aug 2025 10:35:46 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 10:35:46 +0000 (GMT)
Date: Thu, 21 Aug 2025 16:05:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 01/11] common/rc: Add _min() and _max() helpers
Message-ID: <aKb2gB9WC8mdez6e@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <43f45a0885f28fd1d1a88122a42830dd9eeb7e2c.1754833177.git.ojaswin@linux.ibm.com>
 <20250813132034.6d0771de@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813132034.6d0771de@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vECXwCi-SPoW-pZk6aQNMll0Be370F7r
X-Proofpoint-GUID: bkkIkRjOvtNhHZyKpktEU6OsgE2YOM6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX2NJ2ouscLGit
 16q1JnD8uHPR7fKGC/tGNCONy/Ca8vCC32v28rvm3UvtGat3A74clzQupwwRybm0WSJf4Q8Q2vu
 QQySN1r0HyL136jGlE/j1WAmX31bC5NEJnicaIFYhaXUxqObyGEPrbs9BtwkB9Ui5TUW0VqzNAd
 1MXTwXzVj+N1MGK7A5aeQa0r7u/spcqekda1y4VCyE0d4Mczm+HVwIxyHNsgYZSBsJ3XDc/yyVu
 NgP0J4jPQX1TCZbN+LlgmrwpDyJ0PkpvRzFPix8DVwE5+xLhBMublFZFZcqPbw2+eIMWYL+Jtsn
 DIkxCpXydy4Vyi1RKvggazetOyw906Lc/H1AXCoNFh51qjBhO9h6zMX5y34iw7EuEZKMSz6CnFU
 ttSp3cQzw9edJQoWDu5TdCIpAyjUFw==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a6f688 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=TSqor-If1qTvfEId-wcA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On Wed, Aug 13, 2025 at 01:20:34PM +0100, David Laight wrote:
> On Sun, 10 Aug 2025 19:11:52 +0530
> Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
> 
> > Many programs open code these functionalities so add it as a generic helper
> > in common/rc
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 96578d15..3858ddce 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5873,6 +5873,28 @@ _require_program() {
> >  	_have_program "$1" || _notrun "$tag required"
> >  }
> >  
> > +_min() {
> > +	local ret
> > +
> > +	for arg in "$@"; do
> > +		if [ -z "$ret" ] || (( $arg < $ret )); then
> > +			ret="$arg"
> > +		fi
> > +	done
> > +	echo $ret
> > +}
> 
> Perhaps:
> 	local ret="$1"
> 	shift
> 	for arg in "$@"; do
> 		ret=$(((arg) < (ret) ? (arg) : (ret)))
> 	done;
> 	echo "$ret"
> that should work for 'min 10 "2 + 3"' (with bash, but not dash).
> 
> 	David

Hi David,

Thanks for the feedback. I agree that your way is slightly better but i
would like to keep the current patch as is since we already have some
reviews on it and I would prefer to keep the code as is (especially
since both ways are close enough). Hope this is okay.

Also, we can always do 

_min 10 $((2 + 3)) 

which is a bit more intuitive imo

Regards,
ojaswin

> 
> > +
> > +_max() {
> > +	local ret
> > +
> > +	for arg in "$@"; do
> > +		if [ -z "$ret" ] || (( $arg > $ret )); then
> > +			ret="$arg"
> > +		fi
> > +	done
> > +	echo $ret
> > +}
> > +
> >  ################################################################################
> >  # make sure this script returns success
> >  /bin/true
> 

