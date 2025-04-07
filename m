Return-Path: <linux-ext4+bounces-7086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB80A7D986
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6945317B673
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E0237705;
	Mon,  7 Apr 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KT/DDOs5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966B237194
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017556; cv=none; b=k2AYZT3UWoTIZVsu43IYmmUgzEfU+sXicM4ueM/1d6PDSLgZs1w9J3uoX5s61yJtExMK7XkNeM9x8ZnZExfDC/CosfLrkS7kT4I9o3c+ZlCTewIuI2YLyxFaIaVx7GJlsYyMEZh1EpC1QxkxUjal/W+mTin8/bf6vLSIacd2aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017556; c=relaxed/simple;
	bh=Tkr+VkgfcatvOGK2CcI4k8Lgblz5OGwYpc4Rt8EzxPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJshUowuaSwwaFWNYIEPnsA+tO005CUz5PxpMtPLZ0wxhBTgpI1EqzTEc9frcnt6EocQXLA1gl1iVaJH/v2zLuHkqGH17zCUaUyA2V59+eSUFIDDDSJP3u75n1STbm1uMiPqENV/CbscCugaagcN8XQTe1v80C+TR8MY/98f9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KT/DDOs5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c592764e54so536428885a.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Apr 2025 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744017552; x=1744622352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ds8ZeR6+lvLMS3Q8LQ2S5216HWjNwnvoE8o9qfIJEc=;
        b=KT/DDOs5ObFJ1RiCja3/K39RGIULizsBhCvr7ew+0PaiDVciyX57/8oYh5EdQGyloQ
         JtLLXz8yIWj6/Bw9atfneqjkcTUxwgq6kz/rmLYh984/1MoTtCl3FQU8gmQEqS88X9CC
         DubvkZeReCCkG8RvM9G+L6YQpEc90Ej7/xVUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017552; x=1744622352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ds8ZeR6+lvLMS3Q8LQ2S5216HWjNwnvoE8o9qfIJEc=;
        b=lVbbc/ZH3vc34TnJfCDvnZXO/v1EyH1LHkejXSMv3nz1bI7zjinfrdR1JSckNTGmCN
         oJBN3YW2wAZgihggX3vcVb2mIHtDYZoNcSTY/UOO5XUrIzW5chKHF5rDRupm3GSF2Zq+
         PnDNnFHKe7p03W1bprC5K+zKtQ7x1FxSyLX/njTe7Dkz63zTlADhwGTME65ZbcJwqTbY
         4dRveJWqdOcWSHkbzE/n3OtXrW+rz2/a4ASBMtyVk4Nkh7cqUsmgmp/wzCB/wt+Wg1Du
         anKGhCGGMe6qLN64IHNdqXt47zOwt+bDePwhe66pliO4qRZJmMkKweIjiXj/nNDCzXxf
         0JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKyjcqZbYDMueDK5hxaPAPQYREgsGVZbKqu94Np7Y0EEu8k3UNUuf9CResmAagjCX/f0xb1rDj8v3K@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+EQTVMy3yZ+toTV3LSwV2WL6aXILtJo879Yi8323iLX4yhyy
	HHv1Dlr/aFyXmosSLcyl4RDEH+rz2ixRVTBRbOQ9SRwfNYkqwyl9/cHICM1DRq5HyKs2Gtf2NSW
	gpqi7MeUShyV2g3i7GY1ohmP5GY8vJuzI+ft9iQ==
X-Gm-Gg: ASbGncsnVqZYzIYHjCmFEgtgdiw3g8PXEOrDBt3t3wAsSYnCRKpSbGbBJcJyOPH/hlz
	9HpFeQYEj9ODDeIHO1EiOuB2ayz2Em+L5Zqe0XhM3JvTRLGrwsp7e5a8mnmJJlxNU+52kxuHV7H
	vZYque9IuhMMbCBEB0ccr56q7Qbxc=
X-Google-Smtp-Source: AGHT+IFCtLA+gZhyiLnF3PJgKmfPCouEKwTHmWyX/EjhKM6lZbWo0pjzfhlBNMSDCtBMubAuWZYFO3GyBdpYEiWKScw=
X-Received: by 2002:a05:620a:450a:b0:7c5:5a51:d2c0 with SMTP id
 af79cd13be357-7c775b17e0cmr1707617685a.52.1744017552449; Mon, 07 Apr 2025
 02:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67f34d24.050a0220.0a13.027c.GAE@google.com>
In-Reply-To: <67f34d24.050a0220.0a13.027c.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Apr 2025 11:18:59 +0200
X-Gm-Features: ATxdqUGPjYEhmO3guEkv_Uk_UNgq-v6h_uBbWK9b9Dl-HBK2d9h-7340TMg9-Is
Message-ID: <CAJfpegvsi9SaeVdykBFhhwoOrsNQzy3C8HcJjn16uHdkzZ-EVQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] [overlayfs?] WARNING in file_seek_cur_needs_f_lock
To: syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, amir73il@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: multipart/mixed; boundary="000000000000b2665406322cbac6"

--000000000000b2665406322cbac6
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 05:57, syzbot
<syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16cd1c265776 Merge tag 'timers-cleanups-2025-04-06' of git..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e7923f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c79406130aa88d22
> dashboard link: https://syzkaller.appspot.com/bug?extid=4036165fc595a74b09b2
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f9bd98580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571c7e4580000


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
v6.15-rc1

--000000000000b2665406322cbac6
Content-Type: text/x-patch; charset="US-ASCII"; name="ovl-dont-seek_cur-on-realfile.patch"
Content-Disposition: attachment; 
	filename="ovl-dont-seek_cur-on-realfile.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m96uyqc70>
X-Attachment-Id: f_m96uyqc70

ZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9maWxlLmMgYi9mcy9vdmVybGF5ZnMvZmlsZS5jCmlu
ZGV4IDk2OWI0NTgxMDBmZS4uNTQ4ZjBlNmFlZDU0IDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMv
ZmlsZS5jCisrKyBiL2ZzL292ZXJsYXlmcy9maWxlLmMKQEAgLTI3Myw2ICsyNzMsMTIgQEAgc3Rh
dGljIGxvZmZfdCBvdmxfbGxzZWVrKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0LCBp
bnQgd2hlbmNlKQogCW92bF9pbm9kZV9sb2NrKGlub2RlKTsKIAlyZWFsZmlsZS0+Zl9wb3MgPSBm
aWxlLT5mX3BvczsKIAorCS8qIFByZXZlbnQgV0FSTklORyBpbiBmaWxlX3NlZWtfY3VyX25lZWRz
X2ZfbG9jaygpICovCisJaWYgKHdoZW5jZSA9PSBTRUVLX0NVUiAmJiBvZmZzZXQpIHsKKwkJb2Zm
c2V0ICs9IGZpbGUtPmZfcG9zOworCQl3aGVuY2UgPSBTRUVLX1NFVDsKKwl9CisKIAlvbGRfY3Jl
ZCA9IG92bF9vdmVycmlkZV9jcmVkcyhpbm9kZS0+aV9zYik7CiAJcmV0ID0gdmZzX2xsc2Vlayhy
ZWFsZmlsZSwgb2Zmc2V0LCB3aGVuY2UpOwogCW92bF9yZXZlcnRfY3JlZHMob2xkX2NyZWQpOwo=
--000000000000b2665406322cbac6--

