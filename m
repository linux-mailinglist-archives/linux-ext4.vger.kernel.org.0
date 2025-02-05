Return-Path: <linux-ext4+bounces-6333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37CA28A96
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C01888D39
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3122D4C2;
	Wed,  5 Feb 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="huUmACHb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157822CBEF
	for <linux-ext4@vger.kernel.org>; Wed,  5 Feb 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759426; cv=none; b=rQ5ssJ3I5Y3dFtCb2f2utXOyjbeDeogn4avN5IBDsQaUayUvAFaFjXcG29PZqi86c9pJyeMW3IDhVqv+DrnL0Ewl2pysoL2aRZExIWrsSsPUc4IkvtdYul6yoBzxFnM1C9m5ThY0bgEk1yki/m+7rmB6v4zRjCJkKOBYxxNnj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759426; c=relaxed/simple;
	bh=LMFdLozE4fhqci5qph2RW8vX1SybIboPjZ4nTKQinpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NpIUTX5XZcLBIcaokPnTEuyfdPNmRM0BpBg92QqO9+qbUmThS4A7iah0IfC1bKO7U+rO+XlWKQmCYx/v/o25eO8bZhNUpOXoYmQexQg9RdBnuDxgmRq7uByxb3Ayz++14xV78Q8fECKXcOCdQXzE3WNYsbUFk8jlESba0wOc1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=huUmACHb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9d9f14a74so2051159a91.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2025 04:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738759423; x=1739364223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bQvYMOUlQk9w6z1GnCFRhN0y6L5zY8vzzG7yM+js04U=;
        b=huUmACHbKh1oRS29a2X1ajAoUrhI7yzLn5bpRDPXBMVYfp1BurdY2/ua2wFYPBaLIJ
         4o8K9OEXCy6CEXwXjNzn+Vp/xDhuD8qHMvsvONu2um2XlQi5fcXhyur0qdlAfn5gaoyW
         ClW93xLlP8iPEav9BhhQ8wMcN6vISZgCrnMlIhKQQ6ACV09g+zQz29VhUxoQkrh7CTuJ
         KUFrcVmBbBNtC1rPHzo7O8IiMFysZG1gXr0DI7ZpLdZSwn6ht47K94qs55A7yCtkgWkW
         Lv8rR5f26DQK/s0qRCog8Eyt7jWDm0/mWC3a5ufZkSIgw/tZWPcIHgBIDYhMrx2kG2MW
         dReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759423; x=1739364223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQvYMOUlQk9w6z1GnCFRhN0y6L5zY8vzzG7yM+js04U=;
        b=mUk15x+v4rROqaJPqJMsb5+NZX3pMpTytCXE7sWncPqQZiPRvU+muxoPTKRWM4/xlz
         3nKUMEThc8Ur/aIC7mgE0Jezz7AMPOmPitWD3FUn9mhUI8i2DE4d43BHv/PtXNta2FAr
         QHeBP2BQIlZ8cizVy0TN4SuRVkVDNFwNKRqeWEDnWW4gikS9oEwqXY+4OfwD6uBH/BQ4
         vB7q9nkAzyjvaPwvwRFzUTXfFou7L1xRoROnCSG9ZPehktfzf9b9KsEKdC8ORx9tVhrk
         9xw9RWnxwyZ/1QpLjrAkegO9JX3WqtyYJb7j0lttjjqwcSTH8J1t6zsJgEM7RJcmfuUg
         uCIw==
X-Gm-Message-State: AOJu0Yw640B3yeYliuzEKt6cjRL5c5X6Lb2cFR5CHD6hiTtSjx6fofvH
	M7T/T4nqFWmfjQ6tN0D2bE5+YSeoSThOoKUfxdQf1yMZ2Sk4pHEtHYksxMVziGkSFdF9ydVjgqC
	PFLU6N7GDLPd4bKztCwommhAmZdDHJ1ILQfEbJw==
X-Gm-Gg: ASbGncsYknM+F4PSC+tMLgoUr5T1Kv0ZtiR2/cMsV25L6TtjgaBkCsFxkzjs0uHsmry
	11ofI/Zj+TRcRorBHvF5xhieO0TOxHqdZRwWSpQx+8O8bkfvH+KW8fV06dwEKtk/ZuApstzMKP+
	p4aT/1fmBXBw==
X-Google-Smtp-Source: AGHT+IFbxieR6ldNP7HXokaT589DlBmpQ+uhhEUqlk+qUhJbdiKmeh4NiKK4qCWN4sEfPaBusPsKVTHAyeIpqeVNZNw=
X-Received: by 2002:a17:90b:3594:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-2f9e0780376mr4182928a91.20.1738759423169; Wed, 05 Feb 2025
 04:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?56OK5p2O?= <lilei.777@bytedance.com>
Date: Wed, 5 Feb 2025 20:43:31 +0800
X-Gm-Features: AWEUYZnoqgPxN-OmFlsh5gk8_6iZx2gUnkrjUK8TSI-HQxzuZLsOL3q-lgi4EwY
Message-ID: <CAPbN7U669+wCDWDuxuY9xAg_PxhXR7_vvVXRmmD-DeyM_PGSMA@mail.gmail.com>
Subject: Inquiry about ext4 atomic write
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi  Harjani,

I tend to enable ext4 16kb atomic write on my X86 machine, and read your RF=
C.
https://lwn.net/ml/linux-kernel/cover.1709356594.git.ritesh.list@gmail.com/

From the cover patch, it seems that this feature will be successfully enabl=
ed
if I enable bigalloc on ext4, and the underlying device also supports
16kb write union.
However, after checking statx results, I found that
atomic_write_unit_max was always 4096.

This snippet below limits s_awu_max to 4096(bs) which is the max value
on my platform.

```
static void ext4_atomic_write_init(struct super_block *sb)
{
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82...
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82sbi->s_awu_min =3D ma=
x(sb->s_blocksize,
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82      bdev_atomic_write_unit_min_bytes(bdev));
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82sbi->s_awu_max =3D mi=
n(sb->s_blocksize,
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82      bdev_atomic_write_unit_max_bytes(bdev));
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82...
}
```

I am wondering if I missed something? Or if there are any other ways
that I could enable 16kb
atomic write on my platform?

Thanks!
Li Lei

