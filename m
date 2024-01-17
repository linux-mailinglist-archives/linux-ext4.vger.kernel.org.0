Return-Path: <linux-ext4+bounces-839-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EA830D63
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AFB286B53
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A2249F1;
	Wed, 17 Jan 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="EV4z8jL+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8D249EC
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520549; cv=none; b=VeqHSb78Vquus8AkECm1LGSu2M76AfmO3x3EfN+/UbdIJjiuAnpYRB7SimHTY++a/INnrw1gjFdpU0NeuXasL+24URbHdYo/JMGWuT7ZnHwknHO195OMCsoKgFp7naYO6W4nNPeua4S4T5PNU2ZUZY52H9ROLxJ9z/gUe1UH78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520549; c=relaxed/simple;
	bh=z//yQsF+3CKeeIdzsxscIY3r/TOEKHpsqT2XzgEJfQI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 Message-Id:Content-Type:Mime-Version:Subject:Date:In-Reply-To:Cc:
	 To:References:X-Mailer; b=DTN67BhpiXdXkxJXVuRRRgXOFXPv8MzGM2Qmti1Zw4Z5qRssSidy16vae5r8z3+3PelmpaHrt4FV5Hnk+VL2bSnXolKrlzOJ/xwZf8TSiNLLJ0DLZrHJpmcXLGB27DX1K0Hgx4VR4I1TYxTr7gL31OY7/lWncUL8KyTq6srgbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=EV4z8jL+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so1742a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1705520546; x=1706125346; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FerYPbySGx9juTq0y6qUfofdxIU+9wavaJbWElBrJF0=;
        b=EV4z8jL+CBKFd6kG7niwDeIWzo5PbVPywFnyJWY9ZGgaUqBC7wqbToOAEX8atZvEz7
         +KaOOdsJvoLbG0+bFbHCQg0UmtzgMJFW1SLCIF51+On0RXzbOITHscDPok3YUc0pGWLT
         63tQNlvFG9+HtOLBjRO9O3ULUugQM+jAYtG3F8hUjqRhnYLTHQklz6n1OY6j1OG85LeP
         ioshEBhJ872PeOaGUozNQqW9K36mXhre97tZuePsHrWEPmqxobAb2+64eN0SEFXuXRUH
         Fxky0UDLoaKfq/2VPg+4ckH71e2y5qQQv4mfbxly0cdAhmhmo9syNxYAYypH4ZQAx0ln
         ao9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705520546; x=1706125346;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FerYPbySGx9juTq0y6qUfofdxIU+9wavaJbWElBrJF0=;
        b=lUNycPozZuy9FQnk4BFYwCE6zzKgxUvuvvSEz/5CROZVJmkK9jGwVYNFI0Zsnq3iv4
         v71z/3r4Um43y58m+dZlyC1VSkkWIq/gNQDt21k5ABLRUzQSHUM4DTpWaQvGGmZ5zh3i
         VPLi7jb+T1ZLaDAQsPeY4GXT0b3nxuuFxRk3rK07HrpKARse3oiRt5O6qs1EybPpaUsf
         8nKwKvim0tvZxcR8F9U+U+ztX5Lu1cAxfVASZy9LV6sXN3LlmMHu3NV5oT7GXiDuB/2c
         vAyeqevYHegoFJsUI0dblnSkh/S8Qc9NsnA1O/1s1FYfgd9lbg+OzPrRojKF9kqifMEd
         oEcg==
X-Gm-Message-State: AOJu0YwGfATo5ndeNkf05W8Y63/Bd2SSNaaAM3ip+EsQLsb2vaRLjJSo
	+LVlxzX+ZGI7P3DOWbFJPjmH2NGj7RqqwPtKMvzfvgg4tFo=
X-Google-Smtp-Source: AGHT+IFmF7OQutbra3ZoOvH/LhfzVRpaToDpwBw/BP1Rp4dyQUJuuMi00f8Bm28O7Gatk6waipWYQw==
X-Received: by 2002:a17:90b:2515:b0:28e:3189:f78e with SMTP id ns21-20020a17090b251500b0028e3189f78emr1817187pjb.42.1705520545802;
        Wed, 17 Jan 2024 11:42:25 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090acf9200b0028d3de92a08sm30892pju.48.2024.01.17.11.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 11:42:25 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <71B876F0-7E82-4D94-A2C0-DE532E75936B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E7BA1367-3B97-4086-8964-AD34A1CAA34B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e2scrub finds corruption immediately after mounting
Date: Wed, 17 Jan 2024 12:42:22 -0700
In-Reply-To: <41b3d30367b59f6dfd96181e3b3052720127b98f.camel@interlinx.bc.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
 <20240104045540.GD36164@frogsfrogsfrogs>
 <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
 <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>
 <20240109060629.GA722946@frogsfrogsfrogs>
 <20240110053135.GB722946@frogsfrogsfrogs>
 <36ab91c95ce476cdf38977c8f2a8ca4c4fdf2a47.camel@interlinx.bc.ca>
 <20240110180614.GE722946@frogsfrogsfrogs>
 <41b3d30367b59f6dfd96181e3b3052720127b98f.camel@interlinx.bc.ca>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_E7BA1367-3B97-4086-8964-AD34A1CAA34B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 16, 2024, at 6:29 AM, Brian J. Murrell <brian@interlinx.bc.ca> wrote:
> 
> On Wed, 2024-01-10 at 10:06 -0800, Darrick J. Wong wrote:
>> 
>> Huh.  Do you remember the exact command that was used to format this
>> filesystem?
> 
> I do not.  It was created quite a while ago.
> 
>> "mke2fs" still formats ext2 filesystems unless you pass
>> -T ext4 or call its cousin mkfs.ext4.
> 
> I wonder if that's what I did perhaps.
> 
> 
>> Nope.  ext4 is really just ext2 plus a bunch of new features
>> (journal,
>> extents, uninit_bg, dir_index).
> 
> Yes, that's completely understood.  I would have thought it an
> interesting "safety" measure to flag that when a user requests an ext4
> mount and the file system is actually only ext2 that a refusal to mount
> would indicate to the user that their ext* file system does not have
> the required features to be called ext4.

At this stage in the game, it _probably_ makes sense that bare "mke2fs"
default to ext4 instead of ext2 to avoid this issue?

Cheers, Andreas






--Apple-Mail=_E7BA1367-3B97-4086-8964-AD34A1CAA34B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmWoLZ4ACgkQcqXauRfM
H+CzHBAAkeO/GeNuaielk74w4BRSMPxFKnTMQY8ZfW58m4hDTkHvYzLFXSL4LreW
mDAIGX36LRzV5p7OI+8KZO1Dr/tVS0E5G/nk+OUWtjzFB2lExe/U1bCugeSFjtdL
SHw2Sblv2q5QjKB/4NrcvLyHak6acFtPqEzvSx9LHCLcI/hzH12+l3+ieonKaU+7
d/SkKTXMKll2x9QGLKoM6E3Hxl2+V53EFviGWn1+aYOL7ps7dg9wx9XK+dkklHE5
As5PP8l3f5z6J3lwrETkVbVFi6WrqrBJ77LMGGDguBX+IVvouCjYugCMURZXaWAc
NMwR2rUPQc7eCdB1lweYUsf8fP8anHthTsMDc4Djmwx4KJE1emJI4rcNqOWpTRT4
hGuK1+CvzOxNFmgIPISnnKnL4ndMbqHuws+2hQdsZ5WM9Orbj3YFir3+jweK/Ysi
5kyXD1eHCm7cPTgEmUF41SGmJXc+5YSGNH5hbJrNLxZQdaDx7N8tUqjJG6FQwTDY
pIYX+3ZdpYR1tfRgmqqzFeVCO2iOQ/dEV0iJJeoK4SRUIcwkOawNZp/o29UvOwNN
1x6fQpkManXlVWEeKk/uuI6HadWVshvtffJykGOvVrspm3U4624u/5/FyxbPpphl
w3W2QfxiedfwQ9xo5SdU9b+AUIze5E0ctVd4j1vHnVwFr8YiUso=
=5/Uw
-----END PGP SIGNATURE-----

--Apple-Mail=_E7BA1367-3B97-4086-8964-AD34A1CAA34B--

