Return-Path: <linux-ext4+bounces-2530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428138C6F8A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 02:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84CD1F21676
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 00:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCAEBB;
	Thu, 16 May 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibno+YeB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226E3620;
	Thu, 16 May 2024 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819628; cv=none; b=pPGPixSDIi5ggVcItSN59BR8ERKAoI0WzvUm/re7HTQQO3Lj8WhpDVPn/75xON9iH7TOUYVGege6eve1KgEn3DbKb2H1SqUt6dfcMPjxjIIWjSN8KqsR0OI5PjY3lSBaUWwQ0Edc05QrN+vROYeGMUSp0aegwkhAnuj/O2bJYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819628; c=relaxed/simple;
	bh=EN9plsmwACHgXkbMKx+IVZKYo3CNhx7HHKOBfiGzO14=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iDu55NxQqxiekt0WLKlpE27RbrL/NFdHNgQgU2gw7xyZDNtOKu28Zzu09jUTP5TVqQUiu4AVG/MMKe8VTDk0Q9zi5ad2uoH7SPCi72dQb1bY+0rec62v4mMKwT18laWM7PIhEvZM6BTD2mk6lCBidQ8VNLoXHgVoURkr7F1Z5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibno+YeB; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-6a071595d22so30136146d6.3;
        Wed, 15 May 2024 17:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715819626; x=1716424426; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5sidTUddXfpi2LHAtDx9zikhDWNEYE/1JDeYKEgcis=;
        b=ibno+YeB/y/tUk3gSBKEIptb9FtNE/tGX9uoATlD5xAFY16gWEacncFzFu83VUQv+d
         HRtSPHz6Rbe17360psAIv/dxDVUVcwkqmLiAOOxl4qdVu7LJ8HvR/Yt39wKigmDKf8ZY
         NFZkC0kheFMFfIzJcXjFetQsxpH/GiVcXLroCVa0a1x8EOWpPIUhIJDzfWnIkXk4Ga+a
         ukFFz4sCTf5AuTCcSR3jgB6MfAuTvCCYXILmgRaM5s0bJgJbznFKn0T2fBDpbxkAzIi1
         ibCKj0ifW7QiiFDVxE8WFAkuG0nhFr+bcsSWlM5lWDA/GlR8P9HpYKMMSuY+zePNLdFv
         ySww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715819626; x=1716424426;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5sidTUddXfpi2LHAtDx9zikhDWNEYE/1JDeYKEgcis=;
        b=dq8dylTifLM642iycS4eXyRVfCooH7olnux8L//la48EQ/viLaQaJ4/xze7jz1TjZW
         fEOIyV2mEegpYZTmBsokcA+eAYWAOzvostzaJm+SuqVz0e0WCfuek3SPWW/MIAGB+njM
         omZvTJwZq6JXwDPoKkkcVQWo/Vh4qGECl+l+yGjbOFW0wKJza1tENW+cuAun71C4bsQP
         /gS2utg9UA3d/++ay+uixPLYqpY8boJ1Hc6f/ystFvdputI1cCoZHGS9rxvazBVzYM4e
         wiOVI6mUcJEteEKAqX8YJqL9bQYsu5gBffdAQHPrGQ7NA4rSLhsgLY8vKtPsba4KlnIy
         nuug==
X-Forwarded-Encrypted: i=1; AJvYcCUMR4Xn64Nx8Bx44vNlblAnMjU5nOdZFBfiLsShBa7ETR+tfgHk0v1mOu2qSdPgYdsJoCz46BIIJOPNlRDbgP7cmQp35zwfl6Rx7KxE
X-Gm-Message-State: AOJu0YzOWzR/tqN4xGc2i9KUX2Z58S/AgMR9SAXzC5IBaMJsgzhwcbYO
	vtYeA78ArGEB1LI04Z12lxU087fQnBrmIdwJXpo1vOTM6M7MCCkItooSagwDrNs=
X-Google-Smtp-Source: AGHT+IGX4ISSqNbd9oXgSUgfybUHoui62YoQ2Y59eK4Jy2dYz+5FKzM8IXvpI4pClTwvRcmFQO1k0g==
X-Received: by 2002:a05:6214:428f:b0:6a0:d298:e04e with SMTP id 6a1803df08f44-6a168259307mr231293756d6.43.1715819625850;
        Wed, 15 May 2024 17:33:45 -0700 (PDT)
Received: from smtpclient.apple ([2601:98a:4102:7e80:e978:2977:f486:8f27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd245sm69464846d6.77.2024.05.15.17.33.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2024 17:33:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: KASAN: use-after-free in ext4_find_extent in v6.9
From: Shuangpeng Bai <shuangpengbai@gmail.com>
In-Reply-To: <20240515224932.GA202157@mit.edu>
Date: Wed, 15 May 2024 20:33:33 -0400
Cc: linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2184C9DB-DDC2-484B-A1B2-A1E312B62D54@gmail.com>
References: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>
 <20240515224932.GA202157@mit.edu>
To: Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Ted,

Thanks for your reply!=20

You are right. I disabled CONFIG_BLK_DEV_WRITE_MOUNTED and found this =
bug can not be triggered anymore.=20

I am wondering if there is any suggested way for me to check whether a =
bug is reproduced under a reasonable environment (such as compiling =
config) or not? If so, that would be very helpful.


Best,
Shuangpeng


> On May 15, 2024, at 18:49, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Tue, May 14, 2024 at 08:40:36PM -0400, Shuangpeng Bai wrote:
>> Hi Kernel Maintainers,
>>=20
>> Our tool found a kernel bug KASAN: use-after-free in =
ext4_find_extent. Please see the details below.
>>=20
>> Kernel commit: v6.9 (Commits on May 12, 2024)
>> Kernel config: attachment
>> C/Syz reproducer: attachment
>>=20
>> We find this bug was reported and marked as fixed. =
(https://syzkaller.appspot.com/bug?extid=3D7ec4ebe875a7076ebb31)
>>=20
>> Our reproducer can trigger this bug in v6.9, so the bug may have not =
been fixed correctly.
>=20
> The reason why it was marked as fixed is because the reproducer no
> longer reproduces with CONFIG_BLK_DEV_WRITE_MOUNTED disabled.
> Upstream syzkaller unconditionally disables this config, and we don't
> consider reproducers that have CONFIG_BLK_DEV_WRITE_MOUNTED enabled to
> be a bug.
>=20
> If the reproducer is actively modifying the block device (or the
> underlying file for a loop device) while it is mounted, we don't
> consider this a bug.  This is requires root, and it's no more a
> "security bug" than someone complaining that root can execute a
> reboot(2) system call and calling it a "security bug".
>=20
> I've looked at your "reproducer" and it does appear to be modifying
> the block device while it is mounted, and the config does have
> CONFIG_BLK_DEV_WRITE_MOUNTED enabled.  So I don't care (tm).  If you
> want to put an engineer to work on addressing the bug, and the patch
> is a clean and maintable code fix, I'll certainly consider the change.
> But it's not something that upstream will work on a volunteer basis;
> no company I am aware of is willing to pay for engineers to work on
> this sort of issue.
>=20
> Cheers,
>=20
> - Ted


