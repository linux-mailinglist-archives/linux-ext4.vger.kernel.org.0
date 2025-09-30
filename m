Return-Path: <linux-ext4+bounces-10505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A3BAD0B2
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D74A1887ABF
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AF2F6167;
	Tue, 30 Sep 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwPrpCl3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF941F428F
	for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238566; cv=none; b=gjkshrnFa7OvHyc01plTTrPTbEDBwa9Ivblr1OUEOzxgva4sFVnWiEOK4yGAEpq7j2/4JNqPkssEJuBPfB6f6gTVBkjI/wV1os4ndeADWjgse9QKhb1zMUPUQMouaK4NXaP2kG8OSiA09XOWPVVlq9o9mk1KP+ijvxdGRONcjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238566; c=relaxed/simple;
	bh=OjHp8BOHhdfTL2yztmb3YMt8kTyUBT6xDkQ/faQXA98=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tg3fvMjm+BfJ1l8svaWi6ve6xqN2MbO49weUFB4naAgb8gGflLU2Tt9YTDslIhdXv61aN/3lAnxOQIRsab6WV/kdxlSbexwnuMzC35jM2ArtwrthIzjbNrXZGAQEI9hqDCs0psPc2fgtz16b3mYTlP7LY0c+0HdjfiLQ+j0groo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwPrpCl3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso3830654a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238563; x=1759843363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGTQO+5ps6R7LMnFdeL65QPKTZRPnSMVOYXtZ2fTe4w=;
        b=kwPrpCl3JRegUwVjhjL3jTkIFNTYlpiE0edb3sR/R7ZxJ7BrEZkwAENzrfP9ARBrzk
         v2UhVlhxVQDKr/M5VYqfQoPb/JgSSi9SMxVF5RMcJVbJydZD3eJkD0r9Ef4tVJjpGJmQ
         VEspr4YsdOKcciUwe42Dn9MwRj3r2OEI1iN4apSdYmTTvYzkNly/qZDF7Ad+GFk8g+zf
         dMy5kTrbr/+J0/uniuAxNUoEidcAHQyj4YM7uleznTRHg6G5GTEXfOzb6itReEUsLeX7
         oGx9JjTAFCJuPIh3XBJ8YGVtL1PenDgD7+cwcPvlkbF5woDcn8HNHvR1F5HeaGqafOHE
         XQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238563; x=1759843363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGTQO+5ps6R7LMnFdeL65QPKTZRPnSMVOYXtZ2fTe4w=;
        b=dnTg9i23qcYL8J3fr6+jefbIDsVj9mbsyOl9U4tQ9Yu0T1AZTld50+lrUDmZlEU3Zp
         OGaiuv7+BzjTd6mraAQ1oYvpsCwsyWkC/2tG9mHEzXMkBsZdSIh8C1qp5l/TSdwXzGpW
         ewBRxC+Uu7oDnjqJIcx+1wQLL4RWulHGuilYKUjg81oGV2/koI2jLfL5/vWBqWm5iesR
         FPp6veiUwOm9eNCSt8ifVSkk4CjA2/lgW6bfV6gaFB9nx+38iz5RzNh6tm2GJCsqoEDM
         3khjzmIz7NSt7bdbT0uJRYTfW+lQawJOr3Hs4oXeVrwSygXeU5jxt3AQAx0rfAhaTKyM
         QYPw==
X-Gm-Message-State: AOJu0YxMuI7UcLxWKtVpSXVuyrSg90gcmmnlxVrnCa/LEcS8FX2a8ePJ
	4rVH/2Qq/6iVAb0QKJF+q9+BQC1zubCoGHcoqBTJZCxGsDrWK5z5f58a3PqetJoOC9ejRq4La2S
	RlU9eVyKCv793wJvyjIilR1/8I1OO+5IWnf+hkA8=
X-Gm-Gg: ASbGnctpD7qMf8Q9T+4wjC4uRTxjRzVWRQoNscpq5qCeb68v3GZnDsMKTxbajBt86N8
	QeRuwSrmqDVbb/lCrC87q62HY/IY0vcVUC6IX/TH7JYw/JqKt9HTnJR/hsqewvTo1MvOULIMw+K
	KYgvbIchmblGffzbFmy9+Yk8IjgFH53U0+1x/56Ob1xcVMFhfivr9lWUYF2j6FBGSvrRht2PFq9
	DiXTx4oaX2rAOZaY03U6LsODkn8pWkg0+63JMeR4DnkJ9AQ5DXKthQ+yB/hpLXS6kWVD3nf
X-Google-Smtp-Source: AGHT+IG1eLevC4fkI4fs+4wvRKbBsgAzoMb9CebbFjoidC5t5TEKuVEilZHe3TR+JTJVUk4LjJ3r6c3/V7V4hMLugeg=
X-Received: by 2002:aa7:d842:0:b0:61c:b23f:417e with SMTP id
 4fb4d7f45d1cf-6365c986e93mr2915788a12.2.1759238563338; Tue, 30 Sep 2025
 06:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date: Tue, 30 Sep 2025 16:22:32 +0300
X-Gm-Features: AS18NWCQn6oeJINkNEsg3DXzVKB7k36OSIyj8MImy6xGoG6HVl8SfedMB6GtWBI
Message-ID: <CAHxJ8O_WWRGmJp6t2_-BERc99RohpNmhcOtP=xMqJKakJouPFg@mail.gmail.com>
Subject: =?UTF-8?B?W2V4dDRdIGV4dDRfZXh0X2NvcnJlY3RfaW5kZXhlcygpIFRPRE8gYWJvdXQg4oCcYm9yZA==?=
	=?UTF-8?B?ZXIgaXMgc21hbGxlcuKAnSDigJQgc3RpbGwgdmFsaWQ/?=
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

In fs/ext4/extents.c, ext4_ext_correct_indexes() has:

    /* TODO: we need correction if border is smaller than current one */

Is this TODO outdated? My understanding is parent ei_block should be update=
d
whenever the leaf=E2=80=99s first extent border shrinks.

I implemented the TODO literally (only-lower) and kvm-xfstests smoke
started failing (generic/475, 476).

Would you please let me know if it's stale?

Thanks,
Ahmet Eray

