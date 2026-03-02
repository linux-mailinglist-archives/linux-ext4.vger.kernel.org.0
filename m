Return-Path: <linux-ext4+bounces-14297-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH5fFgRnpWmx+wUAu9opvQ
	(envelope-from <linux-ext4+bounces-14297-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 11:31:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE91D68CA
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C833302D1AC
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F321F872D;
	Mon,  2 Mar 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiYCJgeu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3339B975
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447407; cv=pass; b=jsHdVsdP5fAON4JUBOVrTAMOMJHFdDYRIEjpXegupGbi0D/eiuTcW4+nFBcHrd6hvKMos41HPYjw+oFdv8Q4molzQfEZRx9sjZy1rOipQoE4uouhSUAaEU0C36nMI7uP5NLEpSPycEGdlEG4dJ40qb1NoWPDRQMbxd4rcupA0Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447407; c=relaxed/simple;
	bh=GraiEq+bNHvfKEPwaJ1sKoWfl+mHRLLhJ4TRbJfPdoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLW9q7PYQSe8+y+fg8DRhSbbsypP6lH1t71/a/9y++PCQr1sdbqp+7cnTmpOK1LgZPuL/nuWNPKfl3S2Sj7IFTbQPCrR43tK7Ko8mO6gaGBcgq4PhoLE02RUo3GEL6nj/XlUwo8vRuRMkFS5swJH7x7yHJj8CVlPGwFmBkhZAws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiYCJgeu; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79868cde1eeso44260147b3.2
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 02:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772447405; cv=none;
        d=google.com; s=arc-20240605;
        b=g6oRqV/OvmBiGaMDGRCY4lq6QlWo49414eSOu0SSBBBRFlbbNxqqZTnfEmVsXOAqJT
         UmLkXzZvz1onosuaHsx9NEgLaQdtxDU2RCJE/SR2e2z6aBurzMSzM+gBNLUV4vxVNk0b
         iJ843yG54zrdTCpE2YPGl/QWU4OrWQgJO0wbT719y07zvjSLdZXO6nNOBurNJ/XrfPqC
         faO7SP2u8IxesTukv05JgGN88LwPUpPfxyRAJCPOv/LYpEESzHCNgt0UPzm8gZNyduM8
         6m4j2BIafa+VjnvU4wlwnKfxzfpHquVzPCJNoduRNdZtAAb+aeS40k0XmsI8pqO6R9Am
         L+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GraiEq+bNHvfKEPwaJ1sKoWfl+mHRLLhJ4TRbJfPdoU=;
        fh=w4W88BrvyCsaYSz5+hGbhL/+W9CPfM4JCUWP3gjGXfY=;
        b=agqFmXdTG0n3HD7yuTpFBOe3+Xy2Sjwd4EA/A1QItv6LprzRvZmRvEV1bOyv3eUSb/
         p056evHuhT31bcUeOXgsZxnvCr6s9NHcsquRwnfvQ0BRyGu4j4DNANmJdpJg6XUsrf6f
         lIEoC8z01mx8/vmh/6Yl93F+ii0xl2EsZHsVS1xzsDh+GemmK0JudGNCUPvw3bNUC0nW
         WTEUBaFu93epXMIrSXUGqKG/d6aVxAWdTfs2h5DTqOt1zjCV3XKbDbvlOH13gbzuyDhq
         A/FQuLhy2y9Ju4r8QUgmC5QqV/IWpLz+y/i7pPHAOggwvUdywZ2Tm6DPBj5btsTMUzet
         3gAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772447405; x=1773052205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GraiEq+bNHvfKEPwaJ1sKoWfl+mHRLLhJ4TRbJfPdoU=;
        b=HiYCJgeutsxgUmplbsvq1EvXCJcZuSarCIw16BHo9BKJQ0QsQcLDNMbn1egSDTO2x9
         3SuLmBMCNS0qmi9WIgqVUdYjL7FqTv//iSMrto7/7+2fY5GQZ2MNVo5CWN1g47rcwuJP
         dLi7SNUENfDmROAs8ptHnRbLsuuO0NvXAMOxH/GFfoVknUrF2MtvuwzS5H4oBT75BXLg
         qvY9ZHI3Zj2qZnkTB9tKS3Bqlop+lN2/TrGAZIt2vrNpEyav/tSWJSq9Ru4iXgG6xZaG
         TUOEC0YBs2wgWpTe7ys51sNINk3PmzsQo5Cbfei8hdLRZBkC+minrK+cPG2gEV3i+4Nw
         hQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447405; x=1773052205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GraiEq+bNHvfKEPwaJ1sKoWfl+mHRLLhJ4TRbJfPdoU=;
        b=Mu2nVarJNuJLASOZWoDMhIlXT5V2pSbqUvwIDToubSNn9UWBngm3uhrruOUG8O88N6
         gotuTwVxoaFMvL9odI3G7NLZvQtTwPVXSnavnY0O51rX5ZArKYs7vU3d5yoeHfSsXe2I
         /Lyi27sXdWdhopW/6PO6sSAfXjvk18w9FNbVRdhDjTVKrkMFp8m80D1nqRwiEwob+jMH
         Ikb2+hsYi/oQhuplFS2O2P0rPyhNXiq99HvukMLCeaptmE1Twju4HetWmoCRRnCt048L
         wXn3VhF6YeMn3ozMFW6gD6OUnyYfLwvdqXAGUmK24hhFZd5Wh1fBf5rTrxWDbgdNnWlJ
         YYzw==
X-Forwarded-Encrypted: i=1; AJvYcCWDYvchvWcrbQ3j79iyqHq8Gy/Xre+r17RtoASBDFTUN42CHMhL5M8cME03qjSfnpruiRSiJBxmGwC7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ifos4fIvWisdrWA/5ODoLPasgwMweL70+pP7Yy84V2cqcYCw
	fVgBYVJcxREEe3fO5Yuj/U86jqicg494HLV7F1r2W2mDZ3UxJfnFPyR4fTk9tk8uni4AoV8bLcT
	lDuUssXvs2vs2NRZR9CfTYIMDHRDMYs242HoWuZs=
X-Gm-Gg: ATEYQzydqwht0kzZPkaymrIZCGkUaGsQoVX7ut0h7ZsDbSQOUfvgDjGq+FI9C470AQ+
	GFhW3wvxxS9cQ5c2kkIzxUkHl9Sfemwfoj/QE+aj+QxHTPoL2q50T6zna2IJMeDJIttBkuo7Oyr
	PJ1vX6CNYEJNappUH/8A8f+d/ihGwV2mlZIfwrf3bEQl5FWr61Kd/HOBr3Rfa8c1V8Q87lH/Azv
	5D+sJySCoyxb0DPp8HcmZI9/XK86+ra9lbLxVi2xxIJbW2GdzZVPeVs5pCzFra3Rm3ZnF78lv9g
	VzhQjOGSBiYEte7pZM1B10CO5eTVFLVUp/bqscDeXZiPUpoETME8
X-Received: by 2002:a05:690c:e3e4:b0:797:4722:f8a7 with SMTP id
 00721157ae682-798856152femr107486787b3.61.1772447404969; Mon, 02 Mar 2026
 02:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226201334.3260754-1-alexander.zarochentsev@hpe.com>
In-Reply-To: <20260226201334.3260754-1-alexander.zarochentsev@hpe.com>
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
Date: Mon, 2 Mar 2026 10:29:53 +0000
X-Gm-Features: AaiRm53_IycZat2tUvCqxo_hPIHp18I2VauAu6sW5zMpdfMnHS3vs68ShC9B9qQ
Message-ID: <CA+rD4x87L0F-FtzaAuE0TyYAVAGW3FdU3uyy_nPkO5X1OjTxyw@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: large dir rehash fix
To: Alexander Zarochentsev <zamenator@gmail.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alexander Zarochentsev <alexander.zarochentsev@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14297-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[artemblagodarenko@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1BDE91D68CA
X-Rspamd-Action: no action

We discussed this patch with Alexander in detail before submitting it.
I agree that it is useful and properly done.

Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

