Return-Path: <linux-ext4+bounces-14188-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P2xIRrpoGnpnwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14188-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 01:45:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEB1B1475
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 01:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84FD13055CAF
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700B279908;
	Fri, 27 Feb 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i1OndWU+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F627381E
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153099; cv=pass; b=U1S52It6pBFMWSrtk7M3uptGfIKWMjV3hYt665e5y9qmkiDENpoHUYlrHUDrlaqhUXgu0la64Lmpgvp0KoRFSFs0BPEiH8hCMxOGc7EXokg5tBL/nL8w08/Y6gr4IOCPUFYPpC9lV2OkP6s5oL/GTmw/zJ39E8ut2qpAOHzleTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153099; c=relaxed/simple;
	bh=O+HRxgiHT2z7n5ch0TYyL93nG95Cvo9LlcSt25e21Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlCwreuzhCdUt9mQVHUvTnclYb6SnRMJabIhDis7Nl9+J0xr0VX8NCUWaqwXMItJ9OdIp6L3AKgEVIhBFEHxASajKr2NW3z4BeaKQEUifrujnagOwo/gWnhHBz9rFkYaISNxU3PdEVBR6eYseXntTzHZiBn5ftWnZ1tHFTzAzU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i1OndWU+; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R0R7iW3740540
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=X7pD
	kBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=; b=i1OndWU+3hVbPOhJLPdB
	3dZ4nSkztb1ikKbvdbatjVGkVMLfV8JFZoIoELwMzvOYxfwUR6nLGakr/qfu4h1Q
	GO8wKJ8wC4UazfM1LbiYLaf16jQ5TxOebgu7QRs3IVlvCrkOwzJVdNdZd6DNe2SA
	UyzFa/gtDwTBn+WHSFtqboptIKXNMRyDXiRy1/HJUeBhpCt4ysnry1Waeo2FSSbr
	T44fjXhU7o2QxsSczc0EG487y0F+MHbUzU5UXRAbhPw2wSNZ/rXct8p9OvNCLgVx
	J8CkKDZsIksblH1voMgwtFzQHi7YdkePQnLp9goufCO+S9tQvuISr4koC2RoM7Sx
	xw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjhx874fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:44:49 -0500 (EST)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7962f1424d2so29441097b3.2
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 16:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153089; cv=none;
        d=google.com; s=arc-20240605;
        b=ELb/sKu+9gKAmwTfG/FnB8QJyiIu1Im2G6QIqVHUy+0L98THcvGhu1H3nAEvph4WUv
         5Ei7nFarXWZyLRKoYkR9dnV+HIjrikl+CIZacjJaAkhu1m8bmctTL6mIW0wjCoEFMv3W
         yc+F65+b5Fubkhl9vpjvVwug5FxYlllNPs72x+7BXThCAQ7H/kvHWVvOhvvNNqRj1FkA
         Ak1s5OgWZck44M2KC3XPaSU6HVvQJeSeDyhBVF1MWUv5sYzwKyDVdR5c4plP5W0iw0XT
         GnY3iMHq43yKI7l+45BjDJNJ5E5ZpnvXY/A0Xdsbd/kMO4USCVBKFPQhI/3YcVefvviU
         IflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        fh=KZ/8Hcgro4mU8fMlbWBupA981bbTHrSUnKna3nBsGoE=;
        b=jwc/MvX0TWF5cP51sCJYfIxkYzyojZZT/tZdG+/wy2dXCZCEbiuG7YD5/tnoDYO4Qu
         OLb/ZdY4Q4No+5FOMiSZ2d5ZtSAiT3yHCoGs3z6SzgH0ty/8vVeBbGwBevIPUxkIkjJF
         wV+EKx0wZnC0wf4AgjdYC+vIWFb35zeHVWyHgZlm6Ai7A2s5p1kN30bq5MF13zKEA25q
         2XYLhsUjPojYNc4eeKMpgtS2l0ucrDaiHxtS4iYmNsn1WY02zU4U6RK1OxDJbJtJ5tbQ
         xfV7/y0/wOvZM+hae/ejJRLmsMztOAdsgE7MnRS1VreZQaD4t+0qkaFn2/XTgx6N3xJ2
         LbVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153089; x=1772757889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        b=dxBeDPKRQ4NFI3zBrDV9cZwHC2SyPS0bD75Uc1PSMcvR3wEw4fMIl0/qoXviAI4LHM
         dK8Ka7/+impfKcfsM+Ecr+WcMN4NII9ZDgXx4/ppVW3JbaGotWfqXCPEiMF/K5SJ2DpP
         l5qH241YujdeIhveyciGtXVxnuOLyJMFF+7SlyUfVaiYC4PBWgYupSUD3+GnfsyxBFSl
         AncX9MTydsWZVlCipit6kEC2rpx4y3Q+FxyHg6Oswv5NvrWJfEk63wmIDFGpBKu8eIBV
         kDsImM21bOkWng7CH1rDfW+oYoN6aNLlUJT5ysKmEJTTr4EynJRd4IecMdyJdHZhjh+g
         unPw==
X-Forwarded-Encrypted: i=1; AJvYcCVB8l+Iwmg4lX1nfbf48QRlCxL1EUr2IM55m+onlEIigXA3z9cZjB9VOiZxmq+jH6s6UrBKvS0NS6LG@vger.kernel.org
X-Gm-Message-State: AOJu0YxdewLzzqWxgJfBikusSejz2qfswPp/HeVCQgfjzzin9E+7g2Lg
	lwKhQp7Jo1ik8wSi1spywHUt0iQZvZl9ThqjFFOjTjz0WqbE3IDb5pbmdTpYlpIpeQR0XAno/YJ
	NES+ujsuZ6NlzY6lm0j80yo7fA81CSBLEQsI1XaTEELh9Q3YwVJiA1qHDtBdUg4+IRK2Xe2+O4c
	OMFXQ3SEoBmifBP/xZf0fSG+DnSOEpnoBQJQ==
X-Gm-Gg: ATEYQzy1QUmUYd8Yfmj1Fbp57xUUOVrLsl8tlt+h5SBbMkfLMJynPSe5s6iuHP1lhdC
	6qWZ1fyKfF5wtBc0M7GYdaRFD4vePo+zXWfSMIEXcEXmzqu6sRl/6eh9r0+FSlqk0Z/lrDaOTWz
	6j4Kc2SCPDiOYwE0zwkwiBnLhrPJq5W0blUmfKgBscwTc8oxUI4oA5Z2N8uKCjKH4JoFNVkwP1Z
	dmSdw==
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id 00721157ae682-798854a7e4emr11636227b3.14.1772153089306;
        Thu, 26 Feb 2026 16:44:49 -0800 (PST)
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id
 00721157ae682-798854a7e4emr11635807b3.14.1772153088806; Thu, 26 Feb 2026
 16:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-2-70e7ac4f7108@columbia.edu> <aaDEEjVKBKrLxsht@infradead.org>
In-Reply-To: <aaDEEjVKBKrLxsht@infradead.org>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 26 Feb 2026 19:44:38 -0500
X-Gm-Features: AaiRm52uN73WQ1q0q0Bsy0nLJ7MoTUQc88yWQcbleL3GQlPfTUc323g8dJKyM6s
Message-ID: <CAKha_sonOvAGriyromHtyRc-VY6Zyg3J3zd9UJPfBOAt1a522A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: z40GtPf6kCWRyFhjQI01kQwLP2parUdY
X-Proofpoint-GUID: z40GtPf6kCWRyFhjQI01kQwLP2parUdY
X-Authority-Analysis: v=2.4 cv=KeffcAYD c=1 sm=1 tr=0 ts=69a0e901 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=BpGzv1V74M3SfeTrGa8v:22 a=JfrnYn6hAAAA:8 a=lVyRQGvDAGr_LZokY8wA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAwNCBTYWx0ZWRfX8m6eKZRdddED
 HsAGQl4CpLIg4ydg+8Maa4mmWx8lq9bd1o/jZqGDbD0hPW7rQvHAUldJDOUvSdYoISFArBm7kPU
 yvCBVasR4St1Mv0/GuTn9QQ9ObONxSwI6G51RgGWAe/8+GpkuHqN6erlqqNt7NREOcitijT+t4M
 1zqsw7s4gaSa+z/VVhi9At9m/gys8l+JBRf1ptq9e25uARtvf2t9jxcsOPtd1/mQFMReIiIplud
 4t6FMNNlLautt2jaNpyzxhpHrDRJqFEZWbkmt3LENTdNqpm+C3eSvC4D+xkQvTQ6mNBU3UsJ6zH
 siHRoiSuZhBnF3uYJodHpifs8AgUhJV8jPvD4QNFLQrH6ANPe3uAS4wZ2rLIdbMPYmPFrTFhnAn
 LflMk7/uiPnGGbdX3VT5mzmcqzmfdFoFcTcyDZxH/+BtK65c6OpCwUX/qA7PsHn4ZxVpmAwHx0c
 y+bx5Cz1a5vGgSTLGAg==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=10 bulkscore=10
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14188-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[columbia.edu:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EEEB1B1475
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 5:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> > --- a/fs/bfs/file.c
> > +++ b/fs/bfs/file.c
> > @@ -177,7 +177,7 @@ static int bfs_write_begin(const struct kiocb *iocb=
,
> >  {
> >   int ret;
> >
> > - ret =3D block_write_begin(mapping, pos, len, foliop, bfs_get_block);
> > + ret =3D block_write_begin(iocb, mapping, pos, len, foliop, bfs_get_bl=
ock);
>
> Please don't change the prototoype for block_write_begin and thus
> cause churn for all these legacy file systems.  Add a new
> block_write_begin_iocb, and use that in the block code and to implement
> block_write_begin.
>
> And avoid the overly long line there to keep the code readable.

Will do.

>
> Note that you also need to cover the !CONFIG_BUFFER_HEAD case.
>

I don't think there is a !CONFIG_BUFFER_HEAD case. The only user of
block_write_begin_iocb() would be blkdev_write_begin(), which is only
defined under CONFIG_BUFFER_HEAD. !CONFIG_BUFFER_HEAD paths use iomap which
doesn't use it. And buffer.c is only compiled for CONFIG_BUFFER_HEAD. Unles=
s
I'm missing something?

Thanks,
Tal

