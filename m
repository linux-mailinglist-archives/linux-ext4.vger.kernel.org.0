Return-Path: <linux-ext4+bounces-8911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21909AFFB92
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEE2188FA8F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD228B7EE;
	Thu, 10 Jul 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crrnuyG4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D74A0C;
	Thu, 10 Jul 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134479; cv=none; b=psHZsWHbsSx2mL7FrMJmStBUGslhAdLPVNLwCr6cstkhCwqjzFVp6M/4vor+wpGjAblukdo2QWwGvoZ1ym30QTR9gYLRjYRIwttAILp/P8DyXBAZ2ioTBte1fq7h/JJ0vDL3rdHWk/gG2ZTGsjXcs8na4eKdbtYwm9HCZDCinvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134479; c=relaxed/simple;
	bh=0PusPnpFnTlbrblpYcCcHC6N4Y/b1hVkCXLxbwboymE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r0Wdof89xZDZzjwBxOmAxlTprVilDbJZJ/cgHNrJc778OP097fpS2QEaIY18eN4hprxEjfcBt+Ck9lvvTAw/NiIfGnWAwMoR9vLTF9gqEuiDwq0M4mv+3RvJPk/UADAe6RgItjIZfr0UbPGClz6FVv17CxDRel07iCjsPHJ9upQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crrnuyG4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e75f30452so5361127b3.2;
        Thu, 10 Jul 2025 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752134477; x=1752739277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zytixeyOaVsZsVPxMl3VgZGoSUYVIoQIYSgbcQtVoXQ=;
        b=crrnuyG4gFQr9vvs/1EWKdh2sLX0lg5I/aUHSllId/p55hZvIItBPnId7hZlUORI+w
         13N0k+HQiq5aPJv8GujyjfB3c5Ba8Y/y3cMZm2P2yo3oCsAc1H24S1KVerrbfFat1eJv
         diUhA8q71ilTLUQlbEQKd/G8Iw3xQeIlfhNU99ki8YCyNCOoAhOCa8DlienEKD3/Rt1S
         bGJ5OfUE5/7OrducZm+Udm9Ge8/a1CB77GADeWozQqEOsCo3FKurJOghXl+8BhekbN94
         C3kdhgx2RzQAK90ya0sx+ufUiUVYkJS/N+LP8cT9jWwpScPsJor+Jgm5w3RI8n3iHwSq
         OlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752134477; x=1752739277;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zytixeyOaVsZsVPxMl3VgZGoSUYVIoQIYSgbcQtVoXQ=;
        b=iVDxCFBBcuiLYy5kLlqpg2wEGcuWJjzDGeGOe9Fq1rkv9rbq2UmXzts+em93bQKOvK
         /nj7ThH2VxE0WCElVMVtNxgN7n2oL9L97WNnI/CjkjhqNYZDbg5Vrf8xb+GL1MgsvKlG
         H/cPhf5CDBq71qpZfJrU65UCIfAdcz74iqL8agiRktiPbgRK5HzZzRfbdpXjFC4VtWGE
         CWi4hHFQ4NwwZseZGgip4hQiQqXZg0SfYfkuzOP0+gJ0mdEiIOz3rdaH/5hDUwac27+F
         nLy5Jg6PcQoAkpJFCt0oj1fpeoVcbAsgharv2R2hyv3FGiuVE5Mb3DdcE/FpSXKQbd4y
         MTHA==
X-Forwarded-Encrypted: i=1; AJvYcCUhlqTiMBVi/RlxIThVvKVmrFFkfRFp/s3a5BCYquD6B0cs75tEi39Zn53iubh2a8lUHPIQAVpNIqUE@vger.kernel.org, AJvYcCVqgWd6FJ8RJ2tid1fyh4QAvuMGI5CJT1oIjPXDmB5joLzSsR8nT6n/eitElKsYt+nw3xlp8SLNHtMtWvM5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxot6vdksBRvsQ+HG9wWciEleSd2X48KJx1gvMednggB8EKgB8
	x9oGv67Hy+fDnUKagA/4P+CTbAl4lzxP6nbrs3esaKNsNZlIh5vjWa7+Xfx51QsdV/VttKJ1HdM
	xpZXlkfLUEfvLuXY5xs+xU9zLjWFztKjL+Rxg
X-Gm-Gg: ASbGncvIOLU+7HQrSIm/zvCPKJc4APbxsGL1UdbtY1Co7GhOue2+5fTvx2FC9+HC9QW
	sb+7vHZ59yvabJlyOhcm+ppUmF1DEN93eVsOfpz+Y1V3771paeJHMuc/LRgXTCaBJ8q7ZbvyIQe
	ut9JD+E4bf2VkJQA3GLT8aaIbw9pVWkCZd9B4HG+ITDa2F0kuQhk5YDwdblwt+rZ8bqlpJJTTCQ
	A==
X-Google-Smtp-Source: AGHT+IEHfohL6BddQFCBJF5UdoqN6sZoJbkktMXmVdH4C9V5wC78TIMDtZQ+tnpi8LTtBVs4kPjzw6NBsx8RBlPmAsg=
X-Received: by 2002:a05:690c:ec8:b0:70c:b983:f058 with SMTP id
 00721157ae682-717b17a72admr87661067b3.14.1752134476376; Thu, 10 Jul 2025
 01:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 10 Jul 2025 01:01:04 -0700
X-Gm-Features: Ac12FXzd66TvqRlXuJxrYkqpUCznGITKmdrCgldXHCafXfCAIXhLgs89LXS0nRs
Message-ID: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_update_inline_data
To: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: multipart/mixed; boundary="00000000000010610706398e9916"

--00000000000010610706398e9916
Content-Type: text/plain; charset="UTF-8"

#syz test

--00000000000010610706398e9916
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ext4-bail-out-when-INLINE_DATA_FL-lacks-system.data-.patch"
Content-Disposition: attachment; 
	filename="0001-ext4-bail-out-when-INLINE_DATA_FL-lacks-system.data-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcx3hgod0>
X-Attachment-Id: f_mcx3hgod0

RnJvbSA0YzkxMGFjOTg5ZTdhNmQ5NzU2NWE2NzY3N2ExZWU4OGUyZDFhOWFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogVGh1LCAxMCBKdWwgMjAyNSAwMDozNjo1OSAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IGV4dDQ6IGJhaWwgb3V0IHdoZW4gSU5MSU5FX0RBVEFfRkwgbGFja3Mgc3lzdGVtLmRhdGEgeGF0
dHIKCkEgc3l6Ym90IGZ1enplZCBpbWFnZSB0cmlnZ2VyZWQgYSBCVUdfT04gaW4gZXh0NF91cGRh
dGVfaW5saW5lX2RhdGEoKQp3aGVuIGFuIGlub2RlIGhhZCB0aGUgSU5MSU5FX0RBVEFfRkwgZmxh
ZyBzZXQgYnV0IHdhcyBtaXNzaW5nIHRoZQpzeXN0ZW0uZGF0YSBleHRlbmRlZCBhdHRyaWJ1dGUu
CgpleHQ0X3ByZXBhcmVfaW5saW5lX2RhdGEoKSBub3cgY2hlY2tzIGZvciB0aGUgcHJlc2VuY2Ug
b2YgdGhhdCB4YXR0cgphbmQgcmV0dXJucyAtRUZTQ09SUlVQVEVEIGlmIGl0IGlzIG1pc3Npbmcs
IHByZXZlbnRpbmcgY29ycnVwdGVkIGlub2Rlcwpmcm9tIHJlYWNoaW5nIHRoZSB1cGRhdGUgcGF0
aCBhbmQgdHJpZ2dlcmluZyBhIGNyYXNoLgoKUHJvb2YgZnJvbSBlMmZzY2sgb24gdGhlIGZ1enpl
ZCBpbWFnZToKCiAgICAkIGUyZnNjayAtZm4gbW91bnRfMAogICAgZTJmc2NrIDEuNDcuMCAoNS1G
ZWItMjAyMykKICAgIE9uZSBvciBtb3JlIGJsb2NrIGdyb3VwIGRlc2NyaXB0b3IgY2hlY2tzdW1z
IGFyZSBpbnZhbGlkLiAgRml4PyBubwoKICAgIEdyb3VwIGRlc2NyaXB0b3IgMCBjaGVja3N1bSBp
cyAweDgyNDUsIHNob3VsZCBiZSAweDM1M2EuICBJR05PUkVELgogICAgUGFzcyAxOiBDaGVja2lu
ZyBpbm9kZXMsIGJsb2NrcywgYW5kIHNpemVzCiAgICBJbm9kZSAxMiBoYXMgSU5MSU5FX0RBVEFf
RkwgZmxhZyBidXQgZXh0ZW5kZWQgYXR0cmlidXRlIG5vdCBmb3VuZC4gIFRydW5jYXRlPyBubwoK
ICAgIElub2RlIDE2LCBpX2Jsb2NrcyBpcyAzMjk4NTM0ODgzMzQ2LCBzaG91bGQgYmUgMTguICBG
aXg/IG5vCgogICAgSW5vZGUgMTcsIGlfYmxvY2tzIGlzIDE3NTkyMTg2MDQ0NDE2LCBzaG91bGQg
YmUgMC4gIEZpeD8gbm8KCiAgICBQYXNzIDI6IENoZWNraW5nIGRpcmVjdG9yeSBzdHJ1Y3R1cmUK
ICAgIFN5bWxpbmsgL2ZpbGUwL2ZpbGUxIChpbm9kZSAjMTQpIGlzIGludmFsaWQuCiAgICBDbGVh
cj8gbm8KCiAgICBFbnRyeSAnZmlsZTEnIGluIC9maWxlMCAoMTIpIGhhcyBhbiBpbmNvcnJlY3Qg
ZmlsZXR5cGUgKHdhcyA3LCBzaG91bGQgYmUgMCkuCiAgICBGaXg/IG5vCgogICAgRGlyZWN0b3J5
IGlub2RlIDExLCBibG9jayAjNSwgb2Zmc2V0IDA6IGRpcmVjdG9yeSBjb3JydXB0ZWQKICAgIFNh
bHZhZ2U/IG5vCgogICAgZTJmc2NrOiBhYm9ydGVkCgogICAgc3l6a2FsbGVyOiAqKioqKioqKioq
IFdBUk5JTkc6IEZpbGVzeXN0ZW0gc3RpbGwgaGFzIGVycm9ycyAqKioqKioqKioqCgpTaWduZWQt
b2ZmLWJ5OiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNvbT4KLS0tCiBmcy9l
eHQ0L2lubGluZS5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9leHQ0L2lubGluZS5jIGIvZnMvZXh0
NC9pbmxpbmUuYwppbmRleCBhMWJiY2RmNDA4MjQuLmQ5ZGNiMGIwOWU1YyAxMDA2NDQKLS0tIGEv
ZnMvZXh0NC9pbmxpbmUuYworKysgYi9mcy9leHQ0L2lubGluZS5jCkBAIC0zOTksNiArMzk5LDEz
IEBAIHN0YXRpYyBpbnQgZXh0NF91cGRhdGVfaW5saW5lX2RhdGEoaGFuZGxlX3QgKmhhbmRsZSwg
c3RydWN0IGlub2RlICppbm9kZSwKIHN0YXRpYyBpbnQgZXh0NF9wcmVwYXJlX2lubGluZV9kYXRh
KGhhbmRsZV90ICpoYW5kbGUsIHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJCQkJICAgIGxvZmZfdCBs
ZW4pCiB7CisJc3RydWN0IGV4dDRfeGF0dHJfaWJvZHlfZmluZCBpcyA9IHsKKwkJLnMgPSB7IC5u
b3RfZm91bmQgPSAtRU5PREFUQSwgfSwKKwl9OworCXN0cnVjdCBleHQ0X3hhdHRyX2luZm8gaSA9
IHsKKwkJLm5hbWVfaW5kZXggPSBFWFQ0X1hBVFRSX0lOREVYX1NZU1RFTSwKKwkJLm5hbWUgPSBF
WFQ0X1hBVFRSX1NZU1RFTV9EQVRBLAorCX07CiAJaW50IHJldCwgc2l6ZSwgbm9fZXhwYW5kOwog
CXN0cnVjdCBleHQ0X2lub2RlX2luZm8gKmVpID0gRVhUNF9JKGlub2RlKTsKIApAQCAtNDA5LDYg
KzQxNiwxOSBAQCBzdGF0aWMgaW50IGV4dDRfcHJlcGFyZV9pbmxpbmVfZGF0YShoYW5kbGVfdCAq
aGFuZGxlLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCWlmIChzaXplIDwgbGVuKQogCQlyZXR1cm4g
LUVOT1NQQzsKIAorCXJldCA9IGV4dDRfZ2V0X2lub2RlX2xvYyhpbm9kZSwgJmlzLmlsb2MpOwor
CWlmIChyZXQpCisJCWdvdG8gb3V0OworCisJcmV0ID0gZXh0NF94YXR0cl9pYm9keV9maW5kKGlu
b2RlLCAmaSwgJmlzKTsKKwlpZiAocmV0KQorCQlnb3RvIG91dDsKKworCWlmIChpcy5zLm5vdF9m
b3VuZCkgeworCQlyZXQgPSAtRUZTQ09SUlVQVEVEOworCQlnb3RvIG91dDsKKwl9CisKIAlleHQ0
X3dyaXRlX2xvY2tfeGF0dHIoaW5vZGUsICZub19leHBhbmQpOwogCiAJaWYgKGVpLT5pX2lubGlu
ZV9vZmYpCkBAIC00MTcsNiArNDM3LDggQEAgc3RhdGljIGludCBleHQ0X3ByZXBhcmVfaW5saW5l
X2RhdGEoaGFuZGxlX3QgKmhhbmRsZSwgc3RydWN0IGlub2RlICppbm9kZSwKIAkJcmV0ID0gZXh0
NF9jcmVhdGVfaW5saW5lX2RhdGEoaGFuZGxlLCBpbm9kZSwgbGVuKTsKIAogCWV4dDRfd3JpdGVf
dW5sb2NrX3hhdHRyKGlub2RlLCAmbm9fZXhwYW5kKTsKK291dDoKKwlicmVsc2UoaXMuaWxvYy5i
aCk7CiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi40My4wCgo=
--00000000000010610706398e9916--

