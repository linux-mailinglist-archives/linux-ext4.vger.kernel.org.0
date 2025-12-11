Return-Path: <linux-ext4+bounces-12289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FDCB549F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDE93026B07
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F927BF93;
	Thu, 11 Dec 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bizzio.pl header.i=@bizzio.pl header.b="LC+amPY7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.bizzio.pl (mail.bizzio.pl [149.202.41.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31B23BD06
	for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.202.41.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443604; cv=none; b=HT6fe+d+T3ZGrZ7LBx7O/eMUmSaxSezbSGjWiONr8p6mWV6Z8LObCkzOS4Dce4fqGrn6czP0FspDFElRVTlSvr5BzPOalSbbwdperoTxNoNNL3J1VFSkKC2ETACMlqQ6wquo0rLGAnHjjiKVkA3xOQHbFbonwzxRrAcTCO8iTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443604; c=relaxed/simple;
	bh=emtNukB0ycq9ym2nAqltSyV6PRs1Wc7VUTOuKpVmMAw=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=t8Mk4Z/Sc6WJNgDYxr8fbh1yna0ZuGK1tcnOUZ6wkxkirrVGIQNHbKv8BUbg63LY4saJ3lXc2vwpsAIZJq6d6cK9LtvjFOMXF3xtzNwYqcrcVx7t7fGYHpRxseHP5D1fNsrI3SsI7I4iAVzLY8NjjQBTCcMQJf4StnWt6J0B+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizzio.pl; spf=pass smtp.mailfrom=bizzio.pl; dkim=pass (2048-bit key) header.d=bizzio.pl header.i=@bizzio.pl header.b=LC+amPY7; arc=none smtp.client-ip=149.202.41.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizzio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bizzio.pl
Received: by mail.bizzio.pl (Postfix, from userid 1002)
	id 84EC62581C; Thu, 11 Dec 2025 08:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizzio.pl; s=mail;
	t=1765443450; bh=emtNukB0ycq9ym2nAqltSyV6PRs1Wc7VUTOuKpVmMAw=;
	h=Date:From:To:Subject:From;
	b=LC+amPY7Zgat/p/2+vktPjo2V0hVc0tUWh607yVh/iEToCIYmCvSFweQfEIK+AqH4
	 XmPaloZJE1dfaBkUTuuGqwWw2zpOL/nsffkFOziMwmdUn6uG0gf5cwxR6OZDXngytW
	 0oNsF34hyzmI8ToTlhlSHtCNJqxXSupPStxvNQUOfT8hOae+CJWd9yiB4YdSvANYVd
	 qZ7qiWEQxG0zRGVkwBx5ANaD23NbHyLRBRCGx/vU+xvhyGLnEDpe6feO40Lj/ZbOv0
	 y1xLNJSUJen37RRD86JA6igzkVXPyKlDEqsP+0Z1dZZEGdkTOPUjslIJWigLN+yCX5
	 2q2lkS0Ug4aWQ==
Received: by mail.bizzio.pl for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 08:55:50 GMT
Message-ID: <20251211074500-0.1.4h.193i3.0.y3am2g4ket@bizzio.pl>
Date: Thu, 11 Dec 2025 08:55:50 GMT
From: "Justyna Prokop" <justyna.prokop@bizzio.pl>
To: <linux-ext4@vger.kernel.org>
Subject: =?UTF-8?Q?Ulga_na_sk=C5=82adki_ZUS?=
X-Mailer: mail.bizzio.pl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,=20

chcia=C5=82abym wskaza=C4=87 Pa=C5=84stwu mo=C5=BCliwo=C5=9B=C4=87 zarz=C4=
=85dzania benefitami w =C5=82atwy spos=C3=B3b, poprzez nasze intuicyjne n=
arz=C4=99dzie, jakim jest karta lunchowa.=20

Nasze karty oferuj=C4=85 wygod=C4=99, oszcz=C4=99dno=C5=9Bci i zdrowe wyb=
ory =C5=BCywieniowe. Dofinansowanie posi=C5=82k=C3=B3w jest korzystne dla=
 obu stron. Karty lunch to dla pracodawcy realne oszcz=C4=99dno=C5=9Bci w=
 postaci zwolnienia z ZUS do 450 z=C5=82 miesi=C4=99cznie na pracownika.=20

Kart=C4=99 mo=C5=BCna do=C5=82adowa=C4=87 dowoln=C4=85 kwot=C4=85, a niew=
ykorzystane =C5=9Brodki nie przepadaj=C4=85, lecz przechodz=C4=85 na kole=
jny miesi=C4=85c.=20

Mog=C4=99 przedstawi=C4=87 ofert=C4=99, kt=C3=B3ra pozwoli zoptymalizowa=C4=
=87 koszty i zapewni=C4=87 pracownikom po=C5=BC=C4=85dany benefit?


Pozdrawiam serdecznie
Justyna Prokop

