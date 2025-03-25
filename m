Return-Path: <linux-ext4+bounces-6974-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4859A708C9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Mar 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1EB3A454A
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Mar 2025 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06A26463C;
	Tue, 25 Mar 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RsIOhEBj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7E264633;
	Tue, 25 Mar 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926044; cv=none; b=OvUE4yeRC1OlurKmmmEZge/g1MRGYud6cWmpr2iFgVvNu/W6IJx0x81Dyyu/YIU1q7twqT+bHHNbmODqjSZKoyVv1ttWhc4zkjWMVmWz2j1sZrn0PvcOE2RdeQqoD4Q73XeL2bjRivrBBQEJaTP/R2KgkoP3igBftuZ2IbdOuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926044; c=relaxed/simple;
	bh=Twjcgia1kl1JBpQ1+WFzTi0fh1hTe/8jMqsC+Tie0Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRp/NXoFNDGvTOMvr6+WSemOoZHkHmqUy/2Ola+nEb5CBOQSdgLtcFUELF1DKYew8NCxu+GmOb6WIdcrpNRKdIasLx48UpTQZsZ+E1tlJ5xAD9Ry2+CkKmPZSmz9o22QC3GUcQoJbpN71nnWj5eFs/CBPVcBpcH/IDpijGooPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RsIOhEBj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PE3KDS026760;
	Tue, 25 Mar 2025 18:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mh3ohw+njVlf9wH6/xxNFl6yPEkERp
	31on0advkcpig=; b=RsIOhEBjoHSNN6d5Q/nF7XaWYlccuwR71z3cCN5uDOFx8s
	qn6lAMp/HsCwBlTkS/+PqPDK3V+gNBZibgZ0mXxaNZYsXru9KxdspBu1Rh8FzYA6
	miOdTt7Hq8Bur3fEbJkpZK/qEMWV1oPuUnfMc03zikPxPXio/bJoIUproPl2tAyP
	ayWz6qRapHvnhdNBXh3jf/FlrQgvEoO7L5CuK3HIG74sINiS0MECwEJA/CCPdkXh
	KBAss607aYWERTQF9GyG7soXQLXQ4tp3L/SQOKNEW4Ikq2E73eRLDkhD3yG9oJSH
	IYCn+OqCdR7GF0ZxXRDu8kFR9JK1/uRsWb9YaSag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwq9cfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 18:07:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGkvq3019995;
	Tue, 25 Mar 2025 18:07:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnvng5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 18:07:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PI75x854395236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 18:07:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E87CE20043;
	Tue, 25 Mar 2025 18:07:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E15220040;
	Tue, 25 Mar 2025 18:07:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 18:07:02 +0000 (GMT)
Date: Tue, 25 Mar 2025 23:37:00 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Tom Vierjahn <tom.vierjahn@acm.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, dirk.gouders@w-hs.de,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ext4: Add fields to ext4_super_block
 documentation
Message-ID: <Z-LwxGyxp-f_QhET@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250324221004.5268-1-tom.vierjahn@acm.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324221004.5268-1-tom.vierjahn@acm.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MSAa_6RKT-qeg86VqkQCChHDUCjUwLW3
X-Proofpoint-ORIG-GUID: MSAa_6RKT-qeg86VqkQCChHDUCjUwLW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=981 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250122

On Mon, Mar 24, 2025 at 11:09:30PM +0100, Tom Vierjahn wrote:
> Documentation and implementation of the ext4 super block have
> slightly diverged: Padding has been removed in order to make room for
> new fields that are still missing in the documentation.
> 
> Add the new fields s_encryption_level, s_first_error_errorcode,
> s_last_error_errorcode to the documentation of the ext4 super block.
> 
> Fixes: f542fbe8d5e8 ("ext4 crypto: reserve codepoints used by the ext4 encryption feature")
> Fixes: 878520ac45f9 ("ext4: save the error code which triggered an ext4_error() in the superblock")
> 
> Signed-off-by: Tom Vierjahn <tom.vierjahn@acm.org>

Looks good, thanks for updating the docs.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  Documentation/filesystems/ext4/super.rst | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
> index a1eb4a11a1d0..1b240661bfa3 100644
> --- a/Documentation/filesystems/ext4/super.rst
> +++ b/Documentation/filesystems/ext4/super.rst
> @@ -328,9 +328,13 @@ The ext4 superblock is laid out as follows in
>       - s_checksum_type
>       - Metadata checksum algorithm type. The only valid value is 1 (crc32c).
>     * - 0x176
> -     - __le16
> -     - s_reserved_pad
> -     -
> +     - \_\_u8
> +     - s\_encryption\_level
> +     - Versioning level for encryption.
> +   * - 0x177
> +     - \_\_u8
> +     - s\_reserved\_pad
> +     - Padding to next 32bits.
>     * - 0x178
>       - __le64
>       - s_kbytes_written
> @@ -466,9 +470,13 @@ The ext4 superblock is laid out as follows in
>       - s_last_error_time_hi
>       - Upper 8 bits of the s_last_error_time field.
>     * - 0x27A
> -     - __u8
> -     - s_pad[2]
> -     - Zero padding.
> +     - \_\_u8
> +     - s\_first\_error\_errcode
> +     -
> +   * - 0x27B
> +     - \_\_u8
> +     - s\_last\_error\_errcode
> +     -
>     * - 0x27C
>       - __le16
>       - s_encoding
> 
> base-commit: d5e206778e96e8667d3bde695ad372c296dc9353
> -- 
> 2.49.0
> 

