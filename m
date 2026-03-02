Return-Path: <linux-ext4+bounces-14325-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLrhAxWkpWngCwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14325-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:52:05 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA41DB310
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3626304F037
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5193E5581;
	Mon,  2 Mar 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EqtswfIA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387238757A
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462643; cv=none; b=bBa1H1KE0ptZ9/bHyI2iNqv1C/uNkNvKGegZcEfXfDl0qccjgibA/sXlnoiJ+9nZCTIU9QfweFkcvBHoeiVjAvfpHl819RwD5EkTEu26og0xpxFmLDZHyd+Pd/8Nqd42o7GJ1+M2pFvPYXp6l5NCndQ2CkoRQD0Vkuv/cSi/cSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462643; c=relaxed/simple;
	bh=PLFBdraeXBewTQ1A2F39V1fT+sff4tMtoyMx5Rm05FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvqofI6VAqO4KKWPfgnmIcPjYaszDxq+qtHDoUTbSC6VZNvWKCLM6zmNWtThtjMGj//Ym4wjvPO09+i4a/D+TJ8wmFFbsoAI2rLRBGmjDc1GCPNzc1l4TFnu/qwjwXwbHK01fTcWJTpjNzCPlTDHD6RODekakwnFgtCpBVpAekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EqtswfIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ApVYI1171368;
	Mon, 2 Mar 2026 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AqshvY72kqu0f3Rnsn+mzfB4RR17UH
	aZRu1cxNTrRMU=; b=EqtswfIAt69B/YwHbME+rm27XKp6kLIw2aTz1tg0vfmaVV
	E+IkBMOF2sLIzrOesmIgAYUedDrFF8eKjUNLhgVU8dsoX0KcQmrsk1HcWul5SNAN
	wLDAJRq2g67QR/qNrKXgJvLPovjaPwpy+Yz8RjO4ugEXZBVeoUyhcKLewgEf2dGt
	XiuLEmzAzQzMFhBIXAIBBlBB8P/FcvzHFUaC/G7zjVg7MojUkJ+XugX0NZnFP5ov
	Bqr3WpG5MhOxRo+/NN0cnqVQ/WG5WeJUX/fCm+4I78f3FxTgAVG+ht6Tv+ACU2BK
	p9hQAZtGe3M72YWd0/Bmi7t8cs79P8Bb3GPPoOCw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3pvrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:43:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622E1xYw027658;
	Mon, 2 Mar 2026 14:43:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj69hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:43:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622Ehr7543319552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 14:43:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 424C72004B;
	Mon,  2 Mar 2026 14:43:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E26520040;
	Mon,  2 Mar 2026 14:43:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 14:43:51 +0000 (GMT)
Date: Mon, 2 Mar 2026 20:13:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2] generic/108: fix test hand upon failure to create LV
Message-ID: <aaWiJUusrRXYFbpc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2XZUNHrIRByuUWq-k0pR5xfMwAD6OigD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEyMyBTYWx0ZWRfXx/OUFtHJ1pWy
 t7k2GM0alTtLIiD9r0g4OeI+sbkuJnrMq1Z79BAf3zlxuXet7GabkQVQlCqB3+/PtSvOgw3WfHL
 DNl+rBtV0X0JytdqItzEWEKW2p35kQzZ/tg+iJbRozQv7U9+KXGiM6KaT5zlrbANqB0QOAk/LNS
 WpLOgYdyMTCVOVMl3J/M4cKORw9DnMgvQuXK7mCe/sFGfu+8hitrluuqZ2Um6rfbYUQQOsuQKHL
 QU1bbrCsHaZRgQumUMEG2Fgv45FV0KHJWSy2ENoM5HQGA4HCYwAqkvumvp7JJrqv3OxaoiuYEQh
 DAhmupM1EnAQtNbE7QuQtRiwLfd6AVecExIWcPxrtCIDB0ns/u872ay2PcqB8GonrBYQi9DQfBA
 GZy9z9+wwjii3KGD7Znzkg0zsfGC3Dy5USFYl6SlRpjQ8Pbf7VaVTu9H3Es7RP1YiO9NDXTZVew
 vvkW3AgbmtgYDJ4i9Bw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a5a22e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9_0FYjCam0eNCYvqFBIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 2XZUNHrIRByuUWq-k0pR5xfMwAD6OigD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020123
X-Rspamd-Queue-Id: 0FFA41DB310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14325-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:07:24PM +0530, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> To fix this:
> 1. Add a check to ensure SCSI_DEBUG dev is of required size
> 2. Additionally, fail if there are errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.

Hey sorry I accidentally sent the wrong patch via git send-mail. Please
ignore :/

Regards,
Ojaswin


