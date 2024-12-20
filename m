Return-Path: <linux-ext4+bounces-5812-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE49F92FE
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2991884755
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9B2156E7;
	Fri, 20 Dec 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ebRmYwPQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3021518E;
	Fri, 20 Dec 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734700857; cv=none; b=GksKEl/JsHm8Iox6YKldVOFUXGqU/ufBDH72fx/Acq0OAJdaL125SblbVy+Mfp8+98lmAHCwb//+TiRD1UieftnCYWaik4HA8hSFMzkvazY3MdQn6tTz2DRroT+pK0l5SaQOkY8nYQNLI7EFHDrGO6lasM6Z8OrUkMsFrVwCoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734700857; c=relaxed/simple;
	bh=G8cc1wy+lildK6gwPcCwoLFCCo7QTN1GhR8RtkgX16E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KIJ19lXk5iqm6jhbyUdoji5z/mxgze43zMekVqr2fI6Yn9vPUzk+dZT8ld/qXd6oiI55yy8w2xAF96FHXkyvkFo7wsRfaLMSubdUP+yu3nbAGwBykPTtV4PObtcy7/A36lbf01kR8cFKzjDMkrwCn1JDdFLbviDpvGS+6Y7aeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ebRmYwPQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734700542; x=1735305342; i=markus.elfring@web.de;
	bh=DTDJjcI8PHu9bE0TH8c8cUwf31WQRGWOCjhYKu9MI3k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ebRmYwPQwGRTrw2lP1OZdeMWWpdDZ+7n2OLMuxxBCDjT35fCLiJD1UxRl8bOtwcl
	 moE/z5P/ff8e8cCn5ELg8XznslNB+VeWjolzphkW0l0ro14n9+zV7yVTalLssTsfa
	 F0+vjMfPmdR1TLkQ/aegF9toUulbI02XK2DJ2XgbN1HZZoIOjPaTdbmSBwc2mHrum
	 zoFKnFXEYYICqZ9Cz2i3++JANwcow9Dip6u+GHhxFw71E4E0hdtEqf5r1aY1CaK6i
	 06de3g6zSpY8MAMrAfVeeU4Dg38lMJcY1JOiIoRDjt0IQMWL/TdIMk+7ydAOxDxAz
	 5we2Emg6EU7gzCH8uA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVKI-1tgqQW0ejy-00yswz; Fri, 20
 Dec 2024 14:15:42 +0100
Message-ID: <2474b3df-1e58-49f5-a3b3-6cfd6e57372d@web.de>
Date: Fri, 20 Dec 2024 14:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
Subject: Re: [PATCH 1/6] ext4: add missing brelse for bh2 in ext4_dx_add_entry
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m//qz9ER2Hv6X4f8txHKIOL2VEGoizb68T3ERf4lqMKmt2vEab3
 nXhei9FkdVR9B4+YpJKag4QOLoL2vWJd9wJ1Qurdpfcvmll46+I71MMinLDwsLBNjwVaaKb
 HElV3f+JlRiZGA4CTbid+cIWObuUhMGnHqn0p8nEZ1QuOukhogM9XR9xFcDpJMtH4xHSmd1
 F1YrfTYzN5405JjHza7Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TY5T+rrZS40=;Ky00ImIJc14l1X2NV/qRHLMCHji
 GMfOHTw19o51ALQgN26XME+MgECc5ov9VWeM3x8Ei3DwL31l5CyPBq0OkbUQIZCFARmXiNLBR
 avWW1Xj0U8+KVeNmd3C3tH2EfoufFZuU7vmhHr3fI5nXloTXXc5ziDUIAgav4C58IJlO0a6Rb
 KGT9pKuI2kW/PgcAVCgHaeGRBWm/9PmztfnQfPTbsQ12fAJ0ToNY4BzyKi7fpo2lUSe4npZc/
 0w1FxwMpOP47qV2/FJu1p79gH2mNU/Pb/zWCj66/+cOpjz2zXPvI7JKJsi9oEm05PK5tdPkvY
 +jivkeXajKR0omTfy7cyh5SSSjVLYHsa+IFoijJHLgYxYsfCDLTktvLcdnhi7bsEgJXWF9vcX
 Ggles9UzpghgOiSx1MjgX1pPG4P7EYC6TJPqlsbVFjVldyOsAQKYLYVUE1UKGkKedPpXZ6tfP
 USMZUlBAa2myqv6vDSyvDD3UFrnfnD5u7XgBrK+wlotYQJyPlFNQq8LUuzmTlYtA8Rw/1Sl6E
 vP1rSm5nuE6LLQD0SnWVAZbSDpWAFV99R6mc/2bD3F/EQINcJJ9JcQvGilko7wkA0OcCrzVmu
 MDW1wF+ePhQ+ABxJY5zmnVxDfJRkuOnWntOZXNLtc5euIxO1VDKeCDpRJu0JPBQBBge3xV9U1
 HUsfDM+QRXRsmN8R2rm3HxjFCUlee/lYLddQciChLjO8uJkgGfxwlvq0BEvdyhVMt+pp+/yn+
 hmNsWJxnBSA+/aO/OC0pYvtYDwznHyax0lV2ertK4EolqHEf30IM8uEW9fgFTweZ5ZQBTFXR1
 bpV9Jro7XMqViMJ7Vfolw6QT+qBh5xXY2kgsvDjMefskyL1rPLCOhhKr4QjXUjcQZojQdaab4
 OPwpKDg+Z4vbRwXsLvK8fXMT1GS5dV7IMK96SEpsSXxixJqtr6GmIEf0J453dUU4euN7sbcqE
 W0AtuJ3uiM0nD6dAxoiD5hXA56F5fMVO35LASAfP7TGPtIzM3AJ3iRz5YoIq6S56QQu9vW9pI
 mpvId9kgaTyBLrkgUEsgNm6GO9yMwbrF9t0cx9ugdNcg0ozugFi3SeJp4WGELvaQXB7pI0NmF
 ub9Ed+keY=

> Add missing brelse for bh2 in ext4_dx_add_entry.

* I propose to append parentheses to function names.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n145


=E2=80=A6
> +++ b/fs/ext4/namei.c
> @@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, st=
ruct ext4_filename *fname,
>  		BUFFER_TRACE(frame->bh, "get_write_access");
>  		err =3D ext4_journal_get_write_access(handle, sb, frame->bh,
>  						    EXT4_JTR_NONE);
> -		if (err)
> +		if (err) {
> +			brelse(bh2);
>  			goto journal_error;
> +		}
>  		if (!add_level) {
=E2=80=A6

I suggest to add another jump target instead so that a bit of exception ha=
ndling
can be better reused at the end of this function implementation.

Regards,
Markus

