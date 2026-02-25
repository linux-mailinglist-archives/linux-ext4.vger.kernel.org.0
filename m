Return-Path: <linux-ext4+bounces-14016-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB8aBQV7n2lkcQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14016-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 23:43:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A419E685
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB0830347B4
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9C3451CF;
	Wed, 25 Feb 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nsrj0T6H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651433A9C6
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059393; cv=pass; b=jXavAuD10cj+RW6GQ/cuKn4Ot9hNKitC9fTXz2qrxXcOvyyQY0N6gZaTY7df9+Z/pQBAx6Jy6iGzIZEE9kdASZONfUP14J4WYFdIfYxIwbwTrnZ6+RY/oTsD/NticNkq97f0SCu7BJ8D2OZ3BthNxwDX9aRXOwr68c9fkpphUPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059393; c=relaxed/simple;
	bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzwjqhoTBS3aFWBT9+cR1snhvxhb6+t+xpLK2LAjeG20+MhhAStp7H+0zFTveBC3ke06te23eWBhGRs4YEOFvmiLQSdSo5d123Xm5RGrZ7M+J2yPzhdS3KQTVp3xCkHKttw2MHWOYHxh2AEV35QLpPD7CkwI1Cq99yshQnR17LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nsrj0T6H; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMgw9b154729
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 17:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=pDtB
	t1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=; b=nsrj0T6HCt6fbehQN3aM
	mCW3EK4O0E/cM/Qy7KmXDptiP9Si3inQNFYIQScWj2MSnIVqk1bh6Ulf2iHVeiyG
	jOkKvI97CiUm8nbFeOE8ZSU6uEg9o21CwOqyT0zDJZaulMCy+81avk/zmfLBGPpH
	8zS2au6AvembXSGV6xYbFUcUF5MKKn8LhyrXp7Sf7rQ/fIjdSv01VirEFwBfgwbZ
	WZtyfKQt0yCgnh9sFSfrI9pnPAcpLvFJNu3YOATmrfvTleq6h4woEObun258q4a+
	8GChmZaWdoX1h6JiicGPjWZ3UYKC3TK6vAzSf9/FhEcslwYYazjWijqQesgqf0ma
	CA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4chr4p773c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 17:43:11 -0500 (EST)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-797dad61de0so2928387b3.0
        for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 14:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772059391; cv=none;
        d=google.com; s=arc-20240605;
        b=ktGQO5iZs/QmJIg8HsnWX0UPGY/VCYOaaetLxmXj5ZGEpYO1pDZoLn9x6npRsBJiC1
         s3UBSYeCkCw2oqm/8TXpLhzVekhMeBkkhSmqrvSM0te2f0FfF3wgB6mf5GwFDima2tjC
         1Auott7CCilnaBDTAV2qACtmMPYb9TwWiTpxh6jTXeKyZ04Pcmxwp6H1yA9l5qCVIfMH
         R70sk8T/tadwE2c+KfOuJuMh991Rlt/mLb7My8kJ4qxIA+ixw1pE435k40+Pz6x5a4jF
         yJnPPa5XWdw/DzHXL/cUJ0jVgtqnv1Kvvr5Azl54/F7uijenOim1KYVfo5sAjHXg/kHg
         gtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        fh=VmYVuc49qXxnsweNE5YhuyMlJ0kXYmXu31F5T3zP5g0=;
        b=N/iz96xrdz/9PvJrXUrLf/UNGzhcVmh7ClncIC09dYkI0ZdxG2RzPC0bF5RDl72U/a
         lcXRcsJhAGvPd/0gRAIwRE8rfIU359d9cxlE4/zfd/7BrXYAHG2BD0pfAjnh6ec5Om/F
         DYYunViyjn1ehJAGFWQ77rX1t43ULQ32lzRK84B7fGO5VEsnxu3hvLoHTD3YtFNTPR8D
         G8ObOZOKow7aSWYnvrV4x3x2qOq3dA5fPe2w/PWvpYe4cc/uyVrb8PalKKp4zw3Jz8gl
         iMdMG9eMboFgvhLhGMewoj0F3vbUORKINcUJg+lwu/kYELfiaVEVOVLJiHScekqv0tNz
         xnKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059391; x=1772664191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        b=Ghzec9HGYVPWCCEOcEZ887qXEZoNuRng8fhC5ZcGaeP7QTEKc/qXbPWXxq12pCbLzN
         a1nt9ixmZvTsekIMNnG1vlcv4yLNT6hiCNIGjX1FG5HldzxqbDjItRzQKwvtEkN7/0PV
         cF1agYSAdEjc1czryY9ZS86KRW7aVCwt7hG1i6qqnRYeURmrMPBLam647KCHx+qAmPPx
         2wXPZVd1MylUeh8T+mU4HXcBzqjSkenRZ5f10Iags3KcQoPoenCr9ayPfwfOFHDMkus5
         vywsnDD32JHZ3i5O1MQG6SnT9zMILsmi98NGLynUd9DybmuWHVbWSmCCaEY/+8B223kI
         3o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVItGx1rJoxXKT3PlowiITl0UmvAXBoZorRj6M0pkd+61gg9Ab/eVgpEuSuyvqYYCGnBAU6SrBUkVkg@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaVF8iHVedK9s6WBfKDH75jPpa9rQwL5C1TFXyfOL19n7UK6O
	b3XQJGe8l4S6nnwtQWWacgXM7wYj8kFGwNZbutQvX++ovWeunN6eBhfplxl0X6AMR4zq8gsM9zQ
	j7G3Nns5SPM+L5vPmzIdxOqMef7Q8CuQBlcaUib4wy6/PsaRIBz9RsKOwo9Eg9SKLkRG6qnkYbI
	J6SYd0SDEneJC/Wrs96zoNt9Fs5kmKls9sWA==
X-Gm-Gg: ATEYQzxJyXEFX3be4YJNk6R9k1obAusb9zThiPn8V7aoTS8oQJvunfXYTR3ZIgD/e4R
	rXH1EBDwAg3Kb5Pd07m+5lpszU+sI93lFIhtSLJS9Drn4cVTm1GhUgPIUhzGxDVQcN1mbN0o86x
	DSlXNQNGBH4CGsWiJVyzNpSOdXQssthjtmOVuEsbUc6L3lfrv6LB2W7hYq94AtSejKuL06FThF4
	aAFCipn
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id 00721157ae682-7986ff6368dmr23925637b3.60.1772059391035;
        Wed, 25 Feb 2026 14:43:11 -0800 (PST)
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id
 00721157ae682-7986ff6368dmr23925517b3.60.1772059390662; Wed, 25 Feb 2026
 14:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu> <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
In-Reply-To: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 17:42:59 -0500
X-Gm-Features: AaiRm51munUdTrnZZ7c7FkAWOz4juVf_xR9vg2o7Xlz46s_YpnQLMylaXhWKvd8
Message-ID: <CAKha_so5z7S6vD-betDLr=GREewxnWxeK9qawhZq8yKt=TD2XA@mail.gmail.com>
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNyBTYWx0ZWRfXxOG1Zl0i0m4A
 d/VRziOqUssIh6TSAjeIzkk731edZ6LqB41ovTxE0Kxjr8TN6Em1Wu0vK+CBMzC/faCaFZ+qG1O
 b+yGNDYUo2HTJBqaSFZ/DsUfpNQa37RiLxR1TEnylpoGBWU2KHg8zhEveuw4SlaDEBo81Ix6UHN
 1u2HYUw25YhWa9hdYQTN7niir2oPbYIiV0EQSslfRjjoOmFfskIxHfrRObiRzimSEYMt06uqxP/
 Bx4YbhiVjJOhZNXh5MxQ5e/Y1o9WpEtO9KltNocbignG2tBuxqqG7A4Fg6AK3Vbn6bWNOa4NRlr
 zSsevusrlR0v5AC3nuad2DFTxkYloKdRI2mQxBLd9tgVyRAz6Sfbg7x5Xb6rAXmr6rjtVipEgfO
 SPLLXU1s8caXmQHwZIWSsFzUIOQSMDH7e4nFcA6GhbwgA4YJ0qhV188tKVpaqHMfZ23eoSRFIP1
 PS+QNDEq2lrTK8w2QzQ==
X-Authority-Analysis: v=2.4 cv=IYGKmGqa c=1 sm=1 tr=0 ts=699f7aff cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=jHxIr1HyPKZ_Q5_91PL3:22 a=VwQbUJbxAAAA:8 a=VNoZ5ujv9kIkDPz7VAoA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: w7QrXX32oG9-m79YWY4gdbcLye0OqF87
X-Proofpoint-GUID: w7QrXX32oG9-m79YWY4gdbcLye0OqF87
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=10 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14016-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[columbia.edu:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,columbia.edu:dkim]
X-Rspamd-Queue-Id: 7A6A419E685
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:24=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 2/18/26 2:13 PM, Tal Zussman wrote:
> > Block device buffered reads and writes already pass through
> > filemap_read() and iomap_file_buffered_write() respectively, both of
> > which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device file=
s
> > by setting FOP_DONTCACHE in def_blk_fops.
> >
> > For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> > block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> > behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery=
)
> > pass NULL, which preserves the existing behavior.
> >
> > This support is useful for databases that operate on raw block devices,
> > among other userspace applications.
>
> OOO right now so I'll take a real look when I'm back, but when I
> originally did this work, it's not the issue side that's the issue. It's
> the pruning done from completion context, and you need to ensure that's
> sane context for that (non-irq).

Thanks for taking a look! That was very helpful feedback.
I sent out a v2 hopefully addressing that here:
https://lore.kernel.org/lkml/20260225-blk-dontcache-v2-0-70e7ac4f7108@colum=
bia.edu/

> --
> Jens Axboe

