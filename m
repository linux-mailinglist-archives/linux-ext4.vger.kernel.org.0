Return-Path: <linux-ext4+bounces-11910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF920C6D894
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36C7A3403DE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59532E6A7;
	Wed, 19 Nov 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="Ui5DyWjs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA423308F36
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542603; cv=none; b=WaAGWXgvP070sM32WKhTVXFpSpxyyfv+7XqExeaQXzpEBILxHvgRoIQkfa+dUYpcmObn966I6AdXMCSSUtEAnhdFE7sMY7cKvlABMIDBsWLiO8qVUA9KRWKpgqT8SL7TMIFPVKJ0m3u2uUWWXP8en5xWreT4ZY5S4O/gTIB4h38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542603; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=UTHwZxzpk8H394lnfZV8OKVxHH8oVmTACPHE/Yov8znM2FDs8RhBsVLAVe1FithC+3uAmB89hWsi7BfviUDle+WflwKOVUzrIFQvp+IQM6vNbefx6XEO4TE/IRH61Z3d6XBOI/XqwIBxII+aJeUlGIHY1KARPE0Vri6fvj1SbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=Ui5DyWjs; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id 38F5F23BB7; Wed, 19 Nov 2025 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542600; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=Ui5DyWjsbrNwLETvMNaF6ae9tAhpEWik2muiMT7cvFMsTpfxhIoLYEC60FXRzWSzL
	 j0hXAVFgS5HWfwPAqtPqo+wGmnKIUAnRNrLT2k0Ac+hV+JkaUwcMEt4H3z5eApZXc/
	 x7YIv9LnGcW14D0j34dUehgKWx7gPo9ceoNzY98MtZcwTz6ydYoEwErH1C9xJAK94+
	 qr9yMD6WYv3GQ4NQKJ6F/MT6XtjTunDO0moYGkCEErIoi7RAMUh24tkbsdeGJtZq8m
	 dO197T8hfOwH4xZKFISJsa5n8dt57pWiSDWd7AjmhzqKoBW5EJnV4zLVKPLbApRRJt
	 /Miko5lz4+F/g==
Received: by mail.novencio.pl for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 08:55:55 GMT
Message-ID: <20251119074742-0.1.5y.z37n.0.4bnk6jpk2m@novencio.pl>
Date: Wed, 19 Nov 2025 08:55:55 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-ext4@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

