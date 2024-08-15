Return-Path: <linux-ext4+bounces-3731-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D12952D45
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188871F223A3
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02911AC8B7;
	Thu, 15 Aug 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HnoC71Rn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBA1AC8A4;
	Thu, 15 Aug 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720449; cv=none; b=g1CtXdHslkEG+cRuDLhvlzwGuzK9K1pQyjhO+HcnFy488RFA9MpUc20eFZwsl6vduN1uvx4tN+1rAvYhiNFIjY2GVWaxghcW6kvehI5vecyyJP41DCjbYeNyN4if+pQ0dA6lldxGWk65K2SLCdT/3tpUUNfH3uHPTAI9a3TV958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720449; c=relaxed/simple;
	bh=rXm4l6ARRi0fjVDtarLzTvmipbBoOY8ZFyu6tjekXFY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qV1p9b23z1Tfl0iJ6E9pmr7ac3UB3BeMzZ9ATAaJkI8MTSeyrKyaAMdiuTsWNkA5Wv7TDalwKGgDMwV3G18oqolhiRDGVgleB6StaqARDuDxjNIX0OHFo7BhDUoSQ386BHq3GfylweVU7qw9e2Rxk1Vlizff1ASPcNjy7jXSzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HnoC71Rn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723720427; x=1724325227; i=markus.elfring@web.de;
	bh=IMuihew64CpO9zH34qs61AIH8JFgWpnxsZcLMjqPH68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HnoC71RnGnH1+qANvbdFSMWggQLzyk04r+RmPh4RcGB/4fBKjkRbKI2WReZ/w0Gl
	 aaPiB4XeEknhR0t+CXpCI9+Ddw+DbHGXsQXZseQSamF2tnk/QdGveYh57SKAcYEgw
	 P+xpqnBD1DC5RDJVitxGigx4+Hk6M+oGZniekPAY4lwWRUayH8V/cJ5b1q0pkE6kx
	 ZUO5scQf+YjN/FzjBj6SDTld9rSrI17pGH0Vi7qZaUyIe/UZvwmkcXjmntkIEk4Zr
	 zyEBpLsjE1zp8N9yOsIAJU1WmZLoLDJQI/Wb0tYEGKhGH3uRy7dsgUnBc5U6Am7N7
	 nGcR1Zi4wkthX648nA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1sHomT1Z1K-00xmCF; Thu, 15
 Aug 2024 13:13:47 +0200
Message-ID: <77c9258a-dce1-4cf8-8e0e-e4073902e25a@web.de>
Date: Thu, 15 Aug 2024 13:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240813120712.2592310-8-shikemeng@huaweicloud.com>
Subject: Re: [PATCH 7/7] ext4: check buffer_verified in advance to avoid
 unneeded ext4_get_group_info
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240813120712.2592310-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2b0glHSXfmbNCiYnNPhljhJc1GDxcbG6hbGiwUsB8SDkuJFznA
 LdP/PEPqhOt5GT6T98fYa4FXmeCcppOYSS6PXqoeHT5IUvR35UqQFqy+IRT4wPMK8brBT5p
 0vW5os+6WJZdOIRz1vKTzYgJc2j7ZZtPMm8YmedjirYpQg9ePxQnZ38I3ONThKVJrYDuqaE
 2dIW+38k04vl9cCr1HnZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fc7hQ0rtPAQ=;WlZNVYngpu6WsaZCkEnWXLPONoT
 uppouZeKOnaseqmkFo/VqoCYNATrTpjiUIF4b2/y0q/iPcmxuUw6Y1YLPAe9yPRyRNmEKOZow
 6YJibZCZqCOaC5w0mCGRqB4chPXCz19tTbuAZnx9iZHvOea6FXlxhqvXqeGl0d5+8su9wPUyJ
 8V8qYthdaf3MMlX2t19LW8DAKuu1vb/8qrKXiUHzrfeGJWOcE3wkGwpYVmFNHi6afW5kLwNlm
 sE4AbojuYy0MzLGtoBlkZUvg2zh9VrKG8kCjD3Z3/tGZ1AK/oPxQa8CKIdHcHYCGcD9GQHMhy
 D6e7LFeJKdfBmjtRUzw8JzB+SbzoRPyWfCn8cGf/qa3HPQ5r3q53v+0JBZuP4b7/1llY/5cP3
 FAYdk9VYoDZ1uopPqlfERFfbWWdsjjA4gKPaZksTjXIvPgsWpJAwOH2BPnK6QR16sNbCYLld1
 5epsk04ZbLE9bjwVi9U70VgzKBx7RIa/LxkcT8zQ7PcPN/50aDfvpEkOuj2Dde79i3tcMJjK2
 XmVXqbH9PxhnSh0+3xgeVMrrXzYiKU0KDU27/DwqsmUlpHlKt6kvAEtUr+njvx2nmKvZIAjqF
 fCU0fPmklbjqqFzaS5QdzRYDBOVnaufxJwesRxjoMLLVtLE75hvsgERKsDKzDlhy6sheWw9Ve
 qY0isKOapFpFSSLeLDkCt5uGGPhf+4xCoT54VhzKtb9l7biZ6QJy/gEkpAV6Lfb14IBGSNJZu
 BmvZnQKAK7Ief2lJbfg1j0xrjzcgtphQqT5qJhFGRRwjUanEsC6gJ9G9/1IVBX9rS25YBohaX
 Hfe4uZw1hXlR/Ld38b9G14Ww==

=E2=80=A6
> This could be a simple cleanup as complier may handle this.

                                    compiler?


Would you like to append parentheses to the mentioned function name?

Regards,
Markus

