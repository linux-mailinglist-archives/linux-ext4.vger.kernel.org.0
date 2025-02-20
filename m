Return-Path: <linux-ext4+bounces-6521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E45A3E5E4
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC9E4206A8
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995E213E72;
	Thu, 20 Feb 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="g+vxpnER"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2C1DE896
	for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083648; cv=none; b=JBgt6QHoMGKWKoLTUu3gwIYvKXeDlS+6C8clgNn7O5kMDMzplGM8yhnKCb/x6a8Gvcn77QyHN/b5IcJYQLVJUzycpZUUdHg1J/+ighxlKVGK5B8TUxnAshvo0AHTK3NGw/G8waljBzj2UUYcOS3XWwPwCljHI0DOSuROkWpXLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083648; c=relaxed/simple;
	bh=rp/bUodRDCtNAUIjG86ODDhaI3Egan738hnO5mHlwuU=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=iCNqXJEridn7xziWm7ykEKbxLQILGEqlV3oomTJmp/AFKBJK68IHc9Y/lI+yhLodLYOIUsK26TwzkC2GaswI+8Yhrv9F0G9pcJZ77g8vMyMjmkT6adRAGD0303PXnzMerpTOaJwXI7K0c1sqUkJ9jFQKtBjeeQnuox0VzOqTrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=g+vxpnER; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2210d92292eso40117295ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1740083644; x=1740688444; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKUvIW7DfweJrlkTNSBQMzwHoV9aTzVu2l7WpxUn9TY=;
        b=g+vxpnERpHpGzgI6qRzxsI8Pe2oca63EhePa1OoCvgUsdqxFexBiikwoulj8/LWGQR
         RHUEImy16NuvcDh5QFi/DHg1r8znrrlSDCX+I7FHzB30x0jq5IGcSoV7gM5jzOG14AcP
         BGhCDkqOD33g4tHuGQF8HyvfdfXLGaqr3EBLME6myDeIGk0/T8xvucjDuvrpCYrfOTDo
         PqGHL1bdToHqNAEmkoRhGM8co3fF4IEpsjdEyrcIGAksZbBc+GlfE0tx7RDD6+a0vlq1
         f/7yHLCqT2HroY1cbyLJ+MK53N3X8eKTwNZ6avwBmSZN/qzGBiFSRCJyRlLPTPcP1MYw
         /8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083644; x=1740688444;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKUvIW7DfweJrlkTNSBQMzwHoV9aTzVu2l7WpxUn9TY=;
        b=KC91mpF7PDrLn0rfk4sac+FOf9NbGRgN22hZAPy2kZHSFHxH1Pk+vLGBZlXnIj2w1T
         Wf9+X3YH6Pm0JNPpSON1XwNb/nGI4LFGpvgsjiYA4DS1wUA4HQdBsZ5gm7EWefc7809H
         zhlbPcSKdWZZ3Ao3waXZE1wJD1JzPtpNzrhF+P44YZbLVSvYgL3vdqPQwLLt0zPlV4dR
         tBMZ8XOvVU/8Mjbk+C71W1bmLxHeAarDx8BJ3Z2Oc1ZzlyRudHnG9wYbTerUifhb6w46
         5Ki+7QjoAlAoVpMTpefqZ/YzizUOVUNh0p5o3ANHz/3gnrAu2XhGMfC4aQpqveKfHPKR
         rdmg==
X-Forwarded-Encrypted: i=1; AJvYcCXGQ1SHzEWJRPiwDzK+dUjBQ/Z3LomL7NKvapTVQCljjeM+ClUe7I8omcSeiHKrGEKo0VFLr3t6K9Hm@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2q4k7EXZqTFo5P7vQLuhzaCrPbnk8YXfWCJdol8nmLoiccLF
	3q5qCSCeLnF0ObwATzgu8dbFeatcn2OhpK0e1EKFAFI94O9t/4d5edt4CRSPECs=
X-Gm-Gg: ASbGncv4xjDrqdi/ZqFTQZx0ywFuD8CY4x1aSF5iWs337d0AffWzcVs+SBeVv+Cu9k+
	27bdMv5kGzpd9W1JK/+Qpm4cd34Cfzn0fcyuPqa7YjTb4Js2f2lIv5U0PW54QU8Z1JLmveoNizS
	cHHwt4sLnJmnmaXU+/Lpv/pz9885PZGTYoLpQhNggrklNshWU59s9bLpMjFIkDPQOLtwt8hp90v
	xb64aJ9bdFJFlCC25bKJYHOEeclQ7xergT/oommgQpKhaVNWjpJ6cj6U32WyWQ2ku8y7isR0CcT
	PFwgLc/IvUJ64Hqog7T8AlfZCZs+j2IP5L5zGTo3LnvdtWqMPw1k7dZJTcdFTxBgVEYaVihyxMH
	EAQ==
X-Google-Smtp-Source: AGHT+IEY4F6rIkdvP5H+P3OjExz9mCClJemyjUnZrGX4J1m/d1/Zact1mNRG8uKi+ribOjqGJjYtsw==
X-Received: by 2002:a17:902:f710:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2219ff3119emr6433445ad.6.1740083644233;
        Thu, 20 Feb 2025 12:34:04 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558527dsm125691925ad.219.2025.02.20.12.34.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:34:03 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <BEC1A623-9A99-44C5-ABB4-2C3B2FE1E963@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_47906913-94D3-4D2C-8440-AA2E666D0258";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Date: Thu, 20 Feb 2025 13:34:00 -0700
In-Reply-To: <20250220145215.GB2150479@mit.edu>
Cc: Adithya.Balakumar@toshiba-tsip.com,
 linux-ext4@vger.kernel.org,
 Shivanand.Kunijadar@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp,
 nobuhiro1.iwamatsu@toshiba.co.jp
To: Theodore Ts'o <tytso@mit.edu>
References: <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>
 <20250220145215.GB2150479@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_47906913-94D3-4D2C-8440-AA2E666D0258
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 20, 2025, at 7:52 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> Andreas,
> 
> FYI, for context, this discussion has also came up on a github issue,
> by Adithya.  I told Adithya many of the same things that you did, and
> more besides:
> 
>     https://github.com/tytso/e2fsprogs/issues/214

Sigh, I'd seen this still sitting in my inbox without a reply when I got
back from vacation and work travel.

Cheers, Andreas






--Apple-Mail=_47906913-94D3-4D2C-8440-AA2E666D0258
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme3kbgACgkQcqXauRfM
H+B56RAAmtHyoNih8kjAoq4G97TbF2xinsVD8kU5/+lHZV2NyrEJ30NPkWQ1TLlt
P8pm4Jc+Va/IS5I9ASxBhZ55sI76rxExkUtdAHvFgFZj8BLgOFO8k4yA/Fi8n9H0
d9XTHmlRLQG+2MzJEJJO9SDv2tjC+19XrYO0tMvQReBNmKW+Iy4ORlScf9XkLjxH
B7aGmVMrS19XaTiS994qRsz2vmeoXYbKTZjCEdtzNhQm5f9feac0JfP3RoOMaVDr
8PguyVShRKCwOYdHqGbhZ8E/1hE2yntOWwXNth+4REdvM0xMvOdhAznhS0QwGB1o
wxgRHs7u2ihw26Rwlscfmj9G07Ip+0Gdf2sV0yUFhHvX6IWZHkwwOm1hnleqZMhZ
YRSxdjf2zTMX8a1ctx4O39f4EXEyud7uIkUBYLg7qTm+cFEEKVyIAUvSlHRVuye3
/lGId/eG2uOvvRWaYyJviqBCEMgR4wcCWAP4G2Vhr/iYRWCO55ABWET7Ux9R7uly
Q3h0E7JVGaRdhxoxyUp+l2PV+yUVQEQs26UWJBkeR6/rTs1fO6VvlwlGEdFA+KLL
h6WAjY5Uiw7R9h38arKeP4L+5ieu2ufqsNB6b0mEzg9MCtBXJoqzzLlCo/v5E+gn
ybCoudPUzNb14mturjYrIIv/Snjishapv665sCw1QFUzzey5fVQ=
=SUth
-----END PGP SIGNATURE-----

--Apple-Mail=_47906913-94D3-4D2C-8440-AA2E666D0258--

