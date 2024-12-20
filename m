Return-Path: <linux-ext4+bounces-5803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE89F9021
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939511647F4
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1091C07D8;
	Fri, 20 Dec 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u9tnnjqA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADF1A8402;
	Fri, 20 Dec 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690181; cv=none; b=oM/kssrfXl6sYsaCnkf42Oj5+bj0kq2L9VuA3/5opm14TNrQ2eH1jPjJi5XBTMR7pUjq60bkLbj0kK2WmHiQAX54s6zLyFnGYtwlb80bXvave0FDarLoE1urdtMM8/c3zokiomXmzv7mgEy14Z8GCYn9+XdLbLWOXXMLkarzhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690181; c=relaxed/simple;
	bh=fDt+13+EG+cwB+IpDZbQnHO8Eou9OkYlLgdtNSstmdk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B8urC/Sj/ipq1Ceyz9jTb3tBLrl2rz5iPgilmtXMO4yjTqcEdNfAjK+PSyOyjglra7B7GEDkHNAodiXxsSiVyjK19yJ5Yjfd2wnwudAsrJj8Nx+2cL/3YmSIn+R5sg8FAKhrh67uCuNBt9CkTugKXQG3CU2O0bxSlU/qAGZwV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u9tnnjqA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734690176; x=1735294976; i=markus.elfring@web.de;
	bh=fDt+13+EG+cwB+IpDZbQnHO8Eou9OkYlLgdtNSstmdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u9tnnjqAv77nnXHdli8OgjDQ6eB5CnQDbn6997dNNjSGe3v1wkI8PFJUtBhE7kkH
	 BNlIVnZqHDzO4h/WMN2s5KXrYVgPxUfOHzHSXYRil5TviOVc1ODpkwinLkq1j5dS4
	 rbCRNawDeoondLo/cwnhR+FSampTG3a43dJMNU6AgfoScdIjnuQrIsVgmZmbd2JL0
	 8a1yFUUviPUzN3XjWY0gfqZ0EZvq5qffSGK44quiLfwtv3T2a+sUz10sr79VIRK/S
	 E7OwB+2LMtjPprbRaZFpovoKLYkngQl3zaNlOMvC3q/i+yZc+0cf+DjFTIsN042Sk
	 AKrOietcsKwZ0A6wPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1u0xBV3Aph-00c0Zh; Fri, 20
 Dec 2024 11:22:56 +0100
Message-ID: <12e75d9d-1706-4ee8-b0b8-98a971d6534e@web.de>
Date: Fri, 20 Dec 2024 11:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc: yi.zhang@huawei.com, LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Yang Erkun <yangerkun@huawei.com>
References: <20241220060757.1781418-2-libaokun@huaweicloud.com>
Subject: Re: [PATCH 1/5] ext4: replace opencoded ext4_end_io_end() in
 ext4_put_io_end()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220060757.1781418-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N1f9fqzlpGpyix/0MrVQBU5tq+lg9MhTL1i8DH3BZfyoSfRc3/+
 kYLGTBPnilvEcc1byDuhJxYd7JAPyXfFb05kwe4CAzoiAoqiFCnFtu91YLW6IDpBOrEm/eW
 1OwaGAx5OviC8DKjTupDuOPlihGboZi4xagA0yTtytwJ7cemwo24JNxLol+API48/Ctg5fB
 kkM/i91zfL5XvqMiRimqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zCV6r0oevu0=;xLVbY1OpiWrE6n++ct2/NmhZOlB
 oHMFEIHbzLMoVsZCcRqdPBfjRtwTijt69ebUXe/nIpn9UedWXOcSDjgtZ0X3NuSRXDc4IcxoD
 sG6bqibxsamHca7CqWVSLjZj3dCTn/s0ToSvmH5Yjw4iB55aKafF7Vp1RDqlwPnF+xUZemBrO
 IZK+i0gHXJc2XKar30Lu/TFi/96U2tCDPgkfbT5sAfroYMrQbzMG6AraKtw+vFtDYa59P5TqF
 uGmFbGRz4/QjEWmfgrD93dn4moBnDtWLoynGy3GDPLiLdbvauvT+EVLfBf+m5dF8UAYbbPV21
 Ksdn3aGIpLD2SN4Xumia7Y7vF8SYNvvWisOgVFJED5+hfq56LBS6fQY1BCjoSSrVuujHSV82k
 C+VxmPWmZF9KcofuPZt3AQ/i3cNFvQ/nk857bmVEkdgQejQ2qJJBFzRKnc+nkdZlJJQpItbwn
 XMV3i+uorT7iyPDrntKCskX6f0yJSaAMcFZf6cbmJjm9bAi77XYo6FmH1hpT22WNNobePMhVJ
 sNxiloMVPa94K/pqqkE3r+VaGRfN4GTcWZxZuP3LxAztHp18qBjLwYvxHu4hqCJIWPRBndPTz
 rS+9JgrQBI7nyDg3w87dU+kv/XaAl82nJkjeH1h2balNL7MX+44wX/dsn5KPuKVoYirelcZ6X
 OaLi2lQc1oxmFiZAEvpuisKDLNobPPPx3BqnSGF6hI1bLFcW4CwbGITxtAPXySBuRqVjHXtmJ
 HHeNPCiOoY/F5FMnXoKOqbOXfUmvEAJ08iHHe+WcUSIKQW7T+wAFu+AhCuwB+XCxVBLoREtO2
 wDBZRgekzFPs3VGBrS97bKj8JOehljXVtih0NtmJc3qzkamBlxs7CCO9BQpSpy8cFP0UtLl5R
 6KGpkiiAmcGw/GhwyE7FM+9PaUfetm2vtkraciNfBwRPs0gmoGznzgDkAsXcDuQ0UNqlqqb0/
 9PbIs1glpVutBe6jM0DT/XBDWVcU+D9MNkcX6ryYwmNGyodt1w5xtKPlP0mVAdeonFzJvollw
 1a3BF0L/sKBC68eKf922jsTi0QXqvsMSmdFTbwdNy7Jsz06mcNqoGIrnU67RlriTT+48E5TOh
 G1dkWkWcE=

> This reduces duplicate code and ensures that a =E2=80=9Cpotential data l=
oss=E2=80=9D
> warning is available if the unwritten conversion fails.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n94

Regards,
Markus

